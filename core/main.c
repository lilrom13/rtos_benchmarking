
#include <stdint.h>
#include <stdbool.h>

#include <stm32f4xx.h>

#include "app_task.h"

#include "config/app_config.h"

#ifdef APP_DEBUG
	#include "SEGGER_SYSVIEW.h"
	#include "SEGGER_RTT.h"
#endif

static AppTaskInfo backgroundTask = {
	.taskId = 1,
	.name = "Background Task",
	.taskFunction = NULL, // Define your background task function here
	.priority = APP_TASK_PRIORITY_LOWEST
};

int main(void)
{
#ifdef APP_DEBUG
	// Initialize SEGGER SystemView for debugging
	SEGGER_RTT_ConfigUpBuffer(0, NULL, NULL, 0, SEGGER_RTT_MODE_BLOCK_IF_FIFO_FULL);

	SEGGER_RTT_WriteString(0, "Real-Time Application\r\n\r\n");
#endif

	// Initialize the application task system
	AppTask_Init();
	// Add the background task to the application task system
	AppTask_Add(&backgroundTask);

	// Main application loop
	while (true)
	{
		// Your application code here
		// For example, toggle an LED or read a sensor
		AppTask_Run();
	}

	return 0; // Should never reach here
}