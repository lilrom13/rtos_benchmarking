#include "app_task.h"

#include "config/app_config.h"

static AppTaskInfo *appTasks[APP_MAX_TASKS];
static int appTaskCount = 0;

void AppTask_Init(void) {
    appTaskCount = 0;
}

void AppTask_Add(AppTaskInfo *taskInfo) {
    if (appTaskCount < APP_MAX_TASKS) {
        appTasks[appTaskCount++] = taskInfo;
    }
}

void AppTask_Run(void) {
    for (int i = 0; i < appTaskCount; i++) {
        if (appTasks[i] && appTasks[i]->taskFunction) {
            appTasks[i]->taskFunction();
        }
    }
}

void AppTask_PrintInfo(void) {
    for (int i = 0; i < appTaskCount; i++) {
        if (appTasks[i]) {
            printf("Task ID: %d, Name: %s, Priority: %d\n",
                   appTasks[i]->taskId,
                   appTasks[i]->name,
                   appTasks[i]->priority);
        }
    }
}