
#include <stdint.h>
#include <stdbool.h>

#include <stm32f4xx.h>

/* Other includes */
#include "SEGGER_RTT.h"

extern void delay_us(uint32_t us);

/**
 * Stub required by newlibc.
 * 
 * E.g. for malloc()
 */
void _sbrk(void)
{
}

/**
 * Stub required by newlibc.
 *
 * Used for static constructors in C++
 */
void _init(void)
{
}

// int main (void)
// {	
// 	// Struct of PIO Port D
// 	GPIO_TypeDef *PB = GPIOB;

// 	// blue LED is PD15
// 	// set mode to 01 -> output
// 	PB->MODER = (1 << (7*2));

// 	// switch LED on (is connected between IO and GND)
// 	PB->ODR = (1 << 7);

// 	while(1) {
// 		w->KR = 0x0000AAAA;

// 		// PD->ODR = (1 << 15);
// 		// delay_us(1000000);
		
// 		// PD->ODR = (0 << 15);
// 		// delay_us(1000000);
// 	}
// }

static void _Delay(int period) {
  int i = 100000*period;
  do { ; } while (i--);
}

static IWDG_TypeDef *w = IWDG;
int main(void) {
	do {
		w->KR = 0x0000AAAA;
		SEGGER_RTT_WriteString(0, "Hello World from SEGGER!\r\n");
		_Delay(100);
	} while (1);
  
  return 0;
}