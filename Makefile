# C Flags
CFLAGS = -std=c99

# C++ Flags
CXXFLAGS = -std=c++11 -fno-exceptions -fno-rtti

# C and C++ Flags
CCFLAGS  = -mcpu=cortex-m4 -mthumb -mthumb-interwork
CCFLAGS += 
CCFLAGS += -I.
CCFLAGS += -DSTM32F4XX -DF_CPU=168000000
CCFLAGS += -Wall -Wextra 

# Linker Flags
LINKFLAGS  = -mcpu=cortex-m4 -mthumb
LINKFLAGS += -nostartfiles -L. -Tsrc/stm32f4xx.ld

# Assembler Flags
ASFLAGS  = -mcpu=cortex-m4 -mthumb -mthumb-interwork
ASFLAGS += -gdwarf-2
ASFLAGS += -xassembler-with-cpp

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

build:
	arm-none-eabi-gcc $(CFLAGS) $(CCFLAGS) -Isrc/include -Isrc/include/st -Ithird_party/segger/segger_rtt_v840/rtt -Ithird_party/segger/segger_rtt_v840/config -c -o src/build/obj/segger_rtt.o    third_party/segger/segger_rtt_v840/rtt/SEGGER_RTT.c
	arm-none-eabi-gcc $(CFLAGS) $(CCFLAGS) -Isrc/include -Isrc/include/st -Ithird_party/segger/segger_rtt_v840/rtt -Ithird_party/segger/segger_rtt_v840/config -c -o src/build/obj/main.o    src/main.c
	arm-none-eabi-gcc $(CFLAGS) $(CCFLAGS) -Isrc/include -Isrc/include/st -c -o src/build/obj/startup.o src/startup.c
	
	arm-none-eabi-gcc $(LINKFLAGS) -o src/build/program.elf src/build/obj/segger_rtt.o src/build/obj/main.o src/build/obj/startup.o

program: build
	openocd -f openocd.cfg

clean:
	$(RM) *.o
	$(RM) main.elf

.PHONY: build program clean
