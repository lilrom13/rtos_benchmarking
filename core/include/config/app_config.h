#ifndef _APP_CONFIG_H
#define _APP_CONFIG_H

#ifdef DEBUG
    #include "SEGGER_RTT.h"
    #include "SEGGER_SYSVIEW.h"
    #define APP_DEBUG 1
    #define printf(...) SEGGER_RTT_printf(0, __VA_ARGS__)
#endif

#ifdef FREERTOS
    #include "FreeRTOS.h"
    #include "task.h"
    
    #include "FreeRTOSConfig.h"
    #define APP_FREERTOS 1

    #define APP_TASK_CREATE(xTaskFunction, name, stackSize, parameters, priority, taskHandle) \
        xTaskCreate((xTaskFunction), (name), (stackSize), (parameters), (priority), (taskHandle))

    #define AppTaskHandle TaskHandle_t

    #define APP_TASK_NAME_MAX_LENGTH configMAX_TASK_NAME_LEN
#endif

// Task priorities for the application
// Lower numbers indicate higher priority
#define APP_TASK_PRIORITY_LOWEST    10 // Lowest priority for background tasks
#define APP_TASK_PRIORITY_NORMAL    5 // Normal priority for tasks
#define APP_TASK_PRIORITY_HIGH      3 // High priority for critical tasks
#define APP_TASK_PRIORITY_HIGHEST   1 // Highest priority for real-time tasks


#define APP_MAX_TASKS 10 // Maximum number of tasks in the application
#define APP_TASK_STACK_SIZE 1024 // Stack size for each task in bytes

#endif // _APP_CONFIG_H