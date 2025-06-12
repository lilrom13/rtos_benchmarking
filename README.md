# Welcome to my kingdom

In order to spread terror on your lands, I recommend you to install few usefull tools like [GnuWin32](https://sourceforge.net/projects/getgnuwin32/), `Make` and something that can compile compile source code for an `ARM Cortex-M4`, I think you should use the [ARM GNU Toolchain]('https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads'). If you are on Linux, bad luck, I am using windows but I am sure you will find something [here](https://letmegooglethat.com/?q=how+to+compile+cortex+m4+on+linux).

Once you think you've ready to go, verify your installation by running the following commands:

``` shell
arm-none-eabi-gcc -v
```

and

``` shell
make -v
```

If your PC didn't blow out, congratulations, you're ready to continue.

## Debugging

I personally don't use debuggers. They are slow and archaic and I don't need them because I can mentally visual the flow of CPU instructions in my head and prevent bugs from appearing before the code is even finished to be written. However, my friends use [Open-On-Chip Debugger](https://openocd.org/). `OpenOCD` supports the `JTAG` interface which is the most commonly used debugging interface (event if it wasn't intended to be one) in micro-controllers.

## Documents

### ST

- [NUCLEO-F429ZI](./docs/st/dm00244518.pdf)
- [STM32F429xx](./docs/st/stm32f429zi.pdf)

### ARM
