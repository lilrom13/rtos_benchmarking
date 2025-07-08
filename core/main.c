#include "SEGGER_SYSVIEW.h"

#include "SEGGER_SYSVIEW_FreeRTOS.h"
#include "FreeRTOS.h"
#include "task.h"

#include "stm32f4xx_nucleo_144.h"

#include "app_config.h"

#define PRINT_SYSTEM_INFO 1

#ifdef APP_DEBUG
	#include "SEGGER_RTT.h"
#endif

// Stack and TCB for the task
#define STACK_SIZE 128

static StackType_t xTaskStack[STACK_SIZE];
static StaticTask_t xTaskBuffer;

void vBackgroundTaskFunction(void *pvParameters);

int main(void)
{
	HAL_Init();                       /* Init HAL & FPU, set up SysTick          */
    __HAL_RCC_GPIOB_CLK_ENABLE();     /* 1. Enable GPIOB peripheral clock        */

    GPIO_InitTypeDef io = {0};
    io.Pin   = GPIO_PIN_7;            /* 2. Select PB7 (LD2 – blue)              */
    io.Mode  = GPIO_MODE_OUTPUT_PP;   /* push–pull output                        */
    io.Pull  = GPIO_NOPULL;           /* no internal pull-up/down                */
    io.Speed = GPIO_SPEED_FREQ_LOW;   /* slew rate → don’t care for an LED       */
    HAL_GPIO_Init(GPIOB, &io);

    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_7, GPIO_PIN_SET);  /* 3. LED ON          */

	SEGGER_SYSVIEW_Conf(); /* Configure and initialize SystemView */

	xTaskCreateStatic(vBackgroundTaskFunction, "tBackground", STACK_SIZE, NULL, tskIDLE_PRIORITY, xTaskStack, &xTaskBuffer);

	xPortStartScheduler();

     while (1) { /* nothing */ }
}

void vBackgroundTaskFunction(void *pvParameters)
{
	// This is a placeholder for the background task function
	// Implement your background task functionality here
	pvParameters = NULL;

	while (1)
	{
		// Simulate some work in the background task
		// For example, toggle an LED or read a sensor
		// This is just a placeholder; replace with actual functionality
		#ifdef APP_DEBUG
			SEGGER_RTT_WriteString(0, "Background Task Running\r\n");
		#endif
	}
}
