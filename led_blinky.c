/*
 * Copyright 2019 NXP
 * All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include "board.h"
#include "app.h"
#include <stdio.h>
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MCXN947_cm33_core0.h"
#include "fsl_debug_console.h"
#include "fsl_lpi2c.h"
#include "oled.h"




typedef struct {
	GPIO_Type *gpio;
	uint32_t pin;
} LED_TypeDef_t;

//Define an array of LEDs

LED_TypeDef_t LEDs[] = {
		{GPIO4, SHIELD_LED1_GPIO_PIN},
		{GPIO0, SHIELD_LED2_GPIO_PIN},
		{GPIO0, SHIELD_LED3_GPIO_PIN},
		{GPIO0, SHIELD_LED4_GPIO_PIN},
		{GPIO2, SHIELD_LED5_GPIO_PIN},
		{GPIO2, SHIELD_LED6_GPIO_PIN},
		{GPIO2, SHIELD_LED7_GPIO_PIN},
		{GPIO2, SHIELD_LED8_GPIO_PIN},
};


//Define global variables
const uint8_t num_leds = sizeof(LEDs) / sizeof(LED_TypeDef_t); //Calculate the number of LEDs
uint8_t current_led = 0; //LEDs are zero indexed so LED1 = 0, LED2 = 1 etc.
uint8_t old_led = 0;  //to store all LED and turn off when updated current LED
bool timer_start[2]={0};
bool stateAa;
bool oledScreenInitialized[4]={0};


// Define variables for interrupts
volatile bool direction=0,ok;	//direction = 0 -> left to right
					//direction = 1 -> right to left
volatile bool timer_flag[4]={0};
volatile bool stateB,stateAb;


/*
 * Interrupt Handler Definition
 */
/* GPIO40_IRQn interrupt handler */
void GPIO4_INT_0_IRQHANDLER(void)
{
  /* Get pin flags 0 */
  uint32_t pin_flags0 = GPIO_GpioGetInterruptChannelFlags(GPIO4, 0U);

  /* Place your interrupt code here */
  direction = !direction; //change direction


  /* Clear pin flags 0 */
  GPIO_GpioClearInterruptChannelFlags(GPIO4, pin_flags0, 0U);

  /* Add for ARM errata 838869, affects Cortex-M4, Cortex-M4F
     Store immediate overlapping exception return operation might vector to incorrect interrupt. */
  #if defined __CORTEX_M && (__CORTEX_M == 4U)
    __DSB();
  #endif
}

/* GPIO00_IRQn interrupt handler */
void GPIO0_INT_0_IRQHANDLER(void) {
  /* Get pin flags 0 */
  uint32_t pin_flags0 = GPIO_GpioGetInterruptChannelFlags(GPIO0, 0U);

  /* Place your interrupt code here */
  timer_flag[2] = 1; //set flag to indicate button press
  /* Clear pin flags 0 */
  GPIO_GpioClearInterruptChannelFlags(GPIO0, pin_flags0, 0U); 

  /* Add for ARM errata 838869, affects Cortex-M4, Cortex-M4F
     Store immediate overlapping exception return operation might vector to incorrect interrupt. */
  #if defined __CORTEX_M && (__CORTEX_M == 4U)
    __DSB();
  #endif
}

/* GPIO31_IRQn interrupt handler */
void GPIO3_INT_1_IRQHANDLER(void) {
  /* Get pin flags 1 */
  uint32_t pin_flags1 = GPIO_GpioGetInterruptChannelFlags(GPIO3, 1U);

  /* Place your interrupt code here */
  stateAb=GPIO_PinRead(SHIELD_ROTARY_1_GPIO, SHIELD_ROTARY_1_GPIO_PIN);
  stateB=GPIO_PinRead(SHIELD_ROTARY_2_GPIO, SHIELD_ROTARY_2_GPIO_PIN);
  timer_flag[3]=1;
  /* Clear pin flags 1 */
  GPIO_GpioClearInterruptChannelFlags(GPIO3, pin_flags1, 1U); 

  /* Add for ARM errata 838869, affects Cortex-M4, Cortex-M4F
     Store immediate overlapping exception return operation might vector to incorrect interrupt. */
  #if defined __CORTEX_M && (__CORTEX_M == 4U)
    __DSB();
  #endif
}

void ctimer1_match_callback(uint32_t flags)
{
	timer_flag[0] = 1; // Placeholder for timer1 match callback
}

void ctimer2_match_callback(uint32_t flags)
{
	timer_flag[1] = 1; // Placeholder for timer2 match callback
}

/*
 * @brief   Application entry point.
 */
int main(void) {

    // Init board hardware
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitBootPeripherals();

	

#ifndef BOARD_INIT_DEBUG_CONSOLE_PERIPHERAL
    // Init FSL debug console
    BOARD_InitDebugConsole();
#endif
    //Init board and shield LEDs and buttons
    BOARD_InitLEDsPins();		//Initialise the on-board LEDs
    BOARD_InitBUTTONsPins();	//Initialise the on-board buttons
    SHIELD_InitLEDsPins();		//initialise the shield LEDs
    SHIELD_InitBUTTONsPins();	//Initialise the shield buttons

	SHIELD_DIPSwitchPins(); //Initialise DIP switch pins
	SHIELD_RotaryPins(); //Initialise Rotary Encoder pins
	SHIELD_NAVSwitchPins(); //Initialise NAV Switch pins

	/* Attach FROM 12M to FLEXCOMM2 for I2C */
	 CLOCK_SetClkDiv(kCLOCK_DivFlexcom2Clk, 1u);
	 CLOCK_AttachClk(kFRO12M_to_FLEXCOMM2);
     SDK_DelayAtLeastUs(100000,SystemCoreClock); //delay for clock to stabilise
    initOLED();

	sendOLED(frame,1024,OLED_DATA); //clear display
	//OLED initialisation done
	SDK_DelayAtLeastUs(2000000,SystemCoreClock); //delay for OLED to stabilise
	resetOLED();
	SDK_DelayAtLeastUs(1000000,SystemCoreClock); //delay for OLED to stabilise
	


	ctimer_match_config_t matchConfig=CTIMER0_Match_0_config;

	while(1)
	{      
		uint8_t app=(!GPIO_PinRead(GPIO2,SHIELD_DIP_1_GPIO_PIN))| (!GPIO_PinRead(GPIO1,SHIELD_DIP_2_GPIO_PIN)<<1) 
				| (!GPIO_PinRead(GPIO0,SHIELD_DIP_4_GPIO_PIN)<<2) | (!GPIO_PinRead(GPIO0,SHIELD_DIP_8_GPIO_PIN)<<3);
	    lpadc_conv_result_t result;
		if(app==0)
		{
			if(!oledScreenInitialized[0])
			{
				oledScreenInitialized[0]=1;
				resetOLED();
				printfOLED("App1: DP1\nApp2: DP2\nApp3: DP4\nApp4: DP8");
				
			}
			for(int i=0;i<4;i++)
			{
				timer_start[i]=0;

			}
			for(int i=1;i<4;i++)
			{
				oledScreenInitialized[i]=0;
			}
			CTIMER_StopTimer(CTIMER0);
			CTIMER_StopTimer(CTIMER1);
			for(int i=0;i<num_leds;i++)
			{
				GPIO_PinWrite(LEDs[i].gpio, LEDs[i].pin, 0); //turn off all LEDs
			}
		}
		else if(app==1)
		{
			if(!timer_start[0])
			{
				timer_start[0]=1;
				oledScreenInitialized[0]=0;
				oledScreenInitialized[3]=0;
			    CTIMER_StartTimer(CTIMER0);
				resetOLED();
				printfOLED("Press SW1 to change LEDs direction.\nReset the switch to go back to the main menu.");
			}
			if(timer_flag[0])
			{
				LPADC_DoSoftwareTrigger(ADC0,1);
				LPADC_GetConvResultBlocking(ADC0, &result,0);
				if(result.convValue<=100)
				{
					result.convValue=50;//minimum speed,altfel riscam sa inregistram 0 si matchvalue sa fie 0 si led urile sa se aprinda extrem de rapid
				}
				matchConfig.matchValue=(result.convValue>>3)<<12; //scale to appropriate value
				CTIMER_SetupMatch(CTIMER0_PERIPHERAL,CTIMER0_MATCH_0_CHANNEL,&matchConfig);//set new match value using potentiometer reading
				GPIO_PinWrite(LEDs[old_led].gpio, LEDs[old_led].pin, 0); //turn off old LED
				GPIO_PinWrite(LEDs[current_led].gpio, LEDs[current_led].pin, 1); //turn on current LED
				old_led=current_led;
				if(direction)
				{
					current_led=(current_led+1)%num_leds;
				}
				else
				{
					current_led=(current_led==0)?(num_leds-1):(current_led-1);
				}
				timer_flag[0]=0;//timer flag setat de intreruperea timerului
			}
		}
		else if(app==2)
		{
			if(!timer_start[1])
			{
				oledScreenInitialized[0]=0;
				oledScreenInitialized[3]=0;
				timer_start[1]=1;
			    CTIMER_StartTimer(CTIMER1);
			}
			if(timer_flag[1])
			{
				resetOLED();
				int16_t result_th,result_light;
				LPADC_DoSoftwareTrigger(ADC0,2);
				LPADC_GetConvResultBlocking(ADC0, &result,1);
				result_th=result.convValue;
				LPADC_DoSoftwareTrigger(ADC0,4);
				LPADC_GetConvResultBlocking(ADC0, &result,1);
				result_light=result.convValue;
				printfOLED("Temp: %d C\nLight Intensity: %d\nReset the switch to go back to the main menu.",result_th,result_light);
				timer_flag[1]=0;
			}
		}
		else if(app==4)
		{
			if(!oledScreenInitialized[1])
			{
				oledScreenInitialized[1]=1;
				oledScreenInitialized[0]=0;
				oledScreenInitialized[3]=0;
				resetOLED();
				printfOLED("Rotary Encoder\nUse the rotary encoder to change the direction of LED blinking.\nReset the switch to go back to the main menu.");

			}
			if(timer_flag[2])
			{
				for(int i=0;i<num_leds;i++)
				{
					GPIO_PinWrite(LEDs[i].gpio, LEDs[i].pin, 1);
				}
				current_led=1;
				ok=1;
				timer_flag[2]=0;
			}
			else if(timer_flag[3])
			{
				if(current_led<num_leds && ok)
				{
					GPIO_PinWrite(LEDs[current_led].gpio, LEDs[current_led].pin, 0);
					current_led++;
					timer_flag[3]=0;
				}
				else
				{
					if(ok==1)
					{
						stateAa=GPIO_PinRead(SHIELD_ROTARY_1_GPIO, SHIELD_ROTARY_1_GPIO_PIN);
					}
					ok=0;
					if(current_led==num_leds)
					{
						current_led=0;
						old_led=0;
					}
					if(stateAb != stateAa)
					{
						if(stateAb==stateB)
						{
							direction=1;
						}
						else
						{
							direction=0;
						}

					}
					stateAa=stateAb;
					if(direction)
					{
						current_led=(current_led+1)%num_leds;
					}
					else
					{
						current_led=(current_led==0)?(num_leds-1):(current_led-1);
					}
					GPIO_PinWrite(LEDs[old_led].gpio, LEDs[old_led].pin, 0); //turn off old LED
					GPIO_PinWrite(LEDs[current_led].gpio, LEDs[current_led].pin, 1); //turn on current LED
					old_led=current_led;
					timer_flag[3]=0;
				}
			}
		}
		else if(app==8)
		{
			if(!oledScreenInitialized[2])
			{
				oledScreenInitialized[0]=0;
				oledScreenInitialized[3]=0;
				oledScreenInitialized[2]=1;
				resetOLED();
				printfOLED("Joystick\nThe LEDs will light up according to the joystick direction.\nReset the switch to go back to the main menu.");
			}
			volatile bool up=GPIO_PinRead(SHIELD_NAV_C_UP_GPIO, SHIELD_NAV_C_UP_GPIO_PIN);
			volatile bool down=GPIO_PinRead(SHIELD_NAV_D_DOWN_GPIO, SHIELD_NAV_D_DOWN_GPIO_PIN);
			volatile bool left=GPIO_PinRead(SHIELD_NAV_A_LEFT_GPIO, SHIELD_NAV_A_LEFT_GPIO_PIN);
			volatile bool right=GPIO_PinRead(SHIELD_NAV_B_RIGHT_GPIO, SHIELD_NAV_B_RIGHT_GPIO_PIN);
			if(!up)
			{
				GPIO_PinWrite(LEDs[old_led].gpio, LEDs[old_led].pin, 0); //turn off old LED
				GPIO_PinWrite(LEDs[0].gpio, LEDs[0].pin, 1); //turn on current LED
				old_led=0;
			}
			else if(!down)
			{
				GPIO_PinWrite(LEDs[old_led].gpio, LEDs[old_led].pin, 0); //turn off old LED
				GPIO_PinWrite(LEDs[4].gpio, LEDs[4].pin, 1); //turn on current LED
				old_led=4;
			}
			else if(!left)
			{
				GPIO_PinWrite(LEDs[old_led].gpio, LEDs[old_led].pin, 0); //turn off old LED
				GPIO_PinWrite(LEDs[6].gpio, LEDs[6].pin, 1); //turn on current LED
				old_led=6;
			}
			else if(!right)
			{
				GPIO_PinWrite(LEDs[old_led].gpio, LEDs[old_led].pin, 0); //turn off old LED
				GPIO_PinWrite(LEDs[2].gpio, LEDs[2].pin, 1); //turn on current LED
				old_led=2;
			}
		}
		else
		{
			if(!oledScreenInitialized[3])
			{
				oledScreenInitialized[3]=1;
				resetOLED();
				for(int i=0;i<3;i++)
				{
					oledScreenInitialized[i]=0;
				}
				for(int i=0;i<4;i++)
				{
					timer_start[i]=0;
				}
				CTIMER_StopTimer(CTIMER0);
				CTIMER_StopTimer(CTIMER1);
				for(int i=0;i<num_leds;i++)
				{
					GPIO_PinWrite(LEDs[i].gpio, LEDs[i].pin, 0); //turn off all LEDs
				}
				printfOLED("Invalid DIP switch setting.\nPlease select a valid application.\nDP1, DP2, DP4 or DP8.");
			}
		}
}
	return 0 ;
}
