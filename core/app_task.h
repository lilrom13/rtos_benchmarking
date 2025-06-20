#ifndef _APP_TASK_H
#define _APP_TASK_H

// Application task definitions go here
typedef struct {
    int taskId;          // Unique identifier for the task
    const char* name;    // Name of the task
    void (*taskFunction)(void); // Pointer to the task function
    int priority;        // Task priority
} AppTaskInfo;

// Function to initialize the application task system
void AppTask_Init(void);
// Function to add a task to the application task system
void AppTask_Add(AppTaskInfo *taskInfo);

// Function to run all tasks in the application task system
void AppTask_Run(void);

// Function to print information about all tasks in the application task system
void AppTask_PrintInfo(void);

#endif // _APP_TASK_H