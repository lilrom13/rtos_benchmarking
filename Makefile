# C compiler
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as

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

# Third party libraries
## SEGGER Real-Time Transfer (RTT) and SystemView
### Source files
C_SEGGER_SRC_FILES := $(wildcard $(THIRD_DIR)/SEGGER/*.c)
### Include files
INC = -I$(THIRD_DIR)/SEGGER/include

# Application source files
## Core application files
### Source files
C_APP_SRC_FILES 	:= 	$(CORE_DIR)/startup.c \
						$(CORE_DIR)/Main_RTT_MenuApp.c
### Include files
INC += -I$(CORE_DIR)/include
INC += -I$(DRIVERS_DIR)/Device/ST/Include
INC += -I$(DRIVERS_DIR)/BSP/STM32F4xx_Nucleo_144/include
INC += -I$(DRIVERS_DIR)/CMSIS/CMSIS/Core/Include
INC += -I$(DRIVERS_DIR)/CMSIS/Device/ST/STM32F4xx/include
INC += -I$(DRIVERS_DIR)/STM32F4xx_HAL_Driver/Inc/

# Combine all the source files to be compiled
C_SRC_FILES := $(C_APP_SRC_FILES) $(C_SEGGER_SRC_FILES)

# Create a list of object files to be generated
OBJECTS += $(patsubst %.c,$(OBJDIR)/%.o,$(C_SRC_FILES))

LINKER_SCRIPT := $(LINKER_DIR)/stm32f4xx.ld

all: $(OBJECTS)
	@echo "Executing target '$@'"
	@mkdir -p $(OUTPUT)
	$(CC) $(LINKFLAGS) -T$(LINKER_SCRIPT) -o $(OUTPUT)/program.elf $(OBJECTS)

$(OBJDIR)/%.o: %.c
	@echo "Building file '$<' to '$(@)'"
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(CCFLAGS) $(INC) -c -o $(OBJDIR)/$*.o $<

clean:
	$(RM) $(OBJDIR)/*.o
	$(RM) $(OUTPUT)/program.elf

.PHONY: all program clean
