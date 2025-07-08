#ifndef _APP_CONFIG_H
#define _APP_CONFIG_H

// Task priorities for the application
// Lower numbers indicate higher priority
#define APP_TASK_PRIORITY_LOWEST    10 // Lowest priority for background tasks
#define APP_TASK_PRIORITY_NORMAL    5 // Normal priority for tasks
#define APP_TASK_PRIORITY_HIGH      3 // High priority for critical tasks
#define APP_TASK_PRIORITY_HIGHEST   1 // Highest priority for real-time tasks

#define APP_MAX_TASKS 10 // Maximum number of tasks in the application
#define APP_TASK_STACK_SIZE 1024 // Stack size for each task in bytes

#endif // _APP_CONFIG_H