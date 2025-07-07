#include "app_config.h"

#ifdef APP_DEBUG
	#include "SEGGER_SYSVIEW.h"
	#include "SEGGER_RTT.h"
#endif

void vApplicationIdleHook( void ) {
    // This function will be called when the system is idle
    // You can implement low-power modes or other idle tasks here
}

void vApplicationTickHook( void )
{
    static int tickHookCounter = 0;

	#ifdef APP_DEBUG
		SEGGER_RTT_printf(0, "TickHookCounter: %d\n\r", tickHookCounter++);
    #endif /* APP_DEBUG */
}