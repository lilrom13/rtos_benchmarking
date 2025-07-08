# C compiler
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
SIZE = arm-none-eabi-size

# Project folders
CORE_DIR	= core
LINKER_DIR	= linker
THIRD_DIR 	= third_party
BUILD_DIR 	= build
DRIVERS_DIR = drivers

OUTPUT = $(BUILD_DIR)/bin
OBJDIR = $(BUILD_DIR)/obj

# C and C++ Flags
CCFLAGS  = -mcpu=cortex-m4 -mthumb -mthumb-interwork
CCFLAGS += -I.
CCFLAGS += -DSTM32F4XX -DSTM32F429xx -DF_CPU=168000000
CCFLAGS += -Wall -Wextra
# Linker Flags
LINKFLAGS = -mcpu=cortex-m4 -mthumb
LINKFLAGS += -specs=nano.specs -specs=nosys.specs
LINKFLAGS += -nostartfiles
# Assembler Flags
ASFLAGS  = -mcpu=cortex-m4 -mthumb -mthumb-interwork
ASFLAGS += -gdwarf-2

# All the following flags are optional but may be useful:
# Enable FPU
CCFLAGS += -mfloat-abi=softfp -mfpu=fpv4-sp-d16

# All constants are assumed to be float (32 bit) and not
# double (32 bit) by default and warn if a float value is implicit promoted
# to double. Doubles are emulated in software while floats can use the FPU.
CCFLAGS += -fsingle-precision-constant -Wdouble-promotion

# Enable the linker to discard unused functions
CCFLAGS   += -ffunction-sections -fdata-sections
LINKFLAGS += -Wl,--relax -Wl,--gc-sections

# Debug symbols
CCFLAGS += -O0 -g
CCFLAGS += -DDEBUG

#FreeRTOS configuration
CCFLAGS += -DFREERTOS

# Third party libraries
## SEGGER Real-Time Transfer (RTT) and SystemView
### Source files
C_SEGGER_SRC_FILES := $(wildcard $(THIRD_DIR)/SEGGER/*.c)
S_SEGGER_SRC_FILES := $(wildcard $(THIRD_DIR)/SEGGER/*.S)
C_SEGGER_SRC_FILES += $(wildcard $(THIRD_DIR)/SEGGER/Config/Cortex-M/*.c)
### Include files
INC += -I$(CORE_DIR)/include/config/SEGGER
INC += -I$(THIRD_DIR)/SEGGER/include

## Freertos
### Source files
C_FREERTOS_SRC_FILES := $(wildcard $(THIRD_DIR)/FreeRTOS/*.c)
### Include files
INC += -I$(CORE_DIR)/include/config/FreeRTOS
INC += -I$(THIRD_DIR)/FreeRTOS/include

## HAL driver
### Source files
C_HAL_SRC_FILES := 	$(DRIVERS_DIR)/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c \
					$(DRIVERS_DIR)/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c \
					$(DRIVERS_DIR)/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
### Include files
INC += -I$(DRIVERS_DIR)/STM32F4xx_HAL_Driver/Inc/

# Application source files
## Core application files
### Source files
C_APP_SRC_FILES 	:= 	$(CORE_DIR)/system_stm32f4xx.c \
						$(CORE_DIR)/stm32f4xx_nucleo_144.c \
						$(CORE_DIR)/startup.c \
						$(CORE_DIR)/main.c \
						$(CORE_DIR)/app_task.c \
						$(CORE_DIR)/app_hook.c
### Include files
INC += -I$(CORE_DIR)/include
INC += -I$(CORE_DIR)/include/config

# Combine all the source files to be compiled
C_SRC_FILES := $(C_APP_SRC_FILES) $(C_SEGGER_SRC_FILES) $(C_FREERTOS_SRC_FILES) $(C_HAL_SRC_FILES)
S_SRC_FILES := $(S_SEGGER_SRC_FILES)

# Create a list of object files to be generated
OBJECTS := $(patsubst %.c,$(OBJDIR)/%.o,$(C_SRC_FILES))
OBJECTS += $(patsubst %.S,$(OBJDIR)/%.o,$(S_SRC_FILES))

$(info    OBJECTS are $(OBJECTS))

# Others
## Include files
INC += -I$(DRIVERS_DIR)/CMSIS/CMSIS/Core/Include

LINKER_SCRIPT := $(LINKER_DIR)/stm32f4xx.ld

all: $(OUTPUT)/program.elf

$(OUTPUT)/program.elf: $(OBJECTS)
	@echo "Executing target '$@'"
	@mkdir -p $(OUTPUT)
	$(CC) $(LINKFLAGS) -T$(LINKER_SCRIPT) -o $(OUTPUT)/program.elf $(OBJECTS)
	$(SIZE) $(OUTPUT)/program.elf

$(OBJDIR)/%.o: %.c
	@echo "Building C file '$<' to '$(@)'"
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(CCFLAGS) $(INC) -c -o $(OBJDIR)/$*.o $<

# .S files can be compile by gcc too
$(OBJDIR)/%.o: %.S
	@echo "Building S file '$<' to '$(@)'"
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(CCFLAGS) $(INC) -c -o $(OBJDIR)/$*.o $<

clean:
	$(RM) -r $(OBJDIR)
	$(RM) $(OUTPUT)/program.elf

re: clean all

.PHONY: clean re
