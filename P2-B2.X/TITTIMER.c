//
// M?dul de gesti? de Timers
// Barsalona, Novembre de 1995, Juan Perez & Josep M. Ribes.
// Desembre de 2001. FEC. Ajustat per al Fujitsu 90583
// Mar? de 2010. FEC. Ajustat per al PIC24 (com passen els anys...)
// 
#include "TITTIMER.h"
#include <PIC18f4321.h>


//
//--------------------------------CONSTANTS---AREA-----------

#define         TI_FALS                         0
#define         TI_CERT                         1

// Tipus imb?cils
typedef unsigned char        BYTE;
typedef unsigned short       WORD;

//
//---------------------------End--CONSTANTS---AREA-----------
//

//
//--------------------------------VARIABLES---AREA-----------
//
struct Timer {
	unsigned int h_TicsInicials;
	unsigned char b_busy;
} s_Timers[TI_NUMTIMERS]; 

static unsigned int  h_Tics=0;
static int counter;

//
//---------------------------End--VARIABLES---AREA-----------
//
//
//--------------------------------PRIVADES----AREA-----------
//


void RSI_Timer0 (void) { 
	// Cada 1ms, amb un error del 1,74% (segons simulador) i triga 10us
//	IO_SetValue(GPIO_1, 1); // Per comprovar la temportitzaci?
    	INTCONbits.TMR0IF = 0;    //Resetejo el flag de peticio d'interrupcio
	TMR0L=6;
	h_Tics++;

	if (h_Tics>=TI_MAXTICS) {
		// Abans que dongui la volta, tots avall (cada 30s)
		for (counter=0;counter<TI_NUMTIMERS;counter++)
			if (s_Timers[counter].b_busy==TI_CERT)
				s_Timers[counter].h_TicsInicials -= h_Tics;
		h_Tics=0;
	}
//	IO_SetValue(GPIO_1, 0); // Per comprovar la temportitzaci?
}
//
//---------------------------End--PRIVADES----AREA-----------
//

//
//--------------------------------PUBLIQUES---AREA-----------
//

void TiInit () {
	unsigned char counter;
	for (counter=0;counter<TI_NUMTIMERS;counter++) {
		s_Timers[counter].b_busy=TI_FALS;
	}
	h_Tics=0;
    OSCCONbits.IRCF2 = 1;
    OSCCONbits.IRCF1 = 1;
    OSCCONbits.IRCF0 = 0;
	// Suposo que anem a 4MHz
	T0CONbits.T08BIT=1; // 8 bits
	T0CONbits.T0CS = 0;	// Clock: fosc/4
	T0CONbits.PSA = 0; // Prescaler
	T0CONbits.T0PS = 1; // Preescaler a 1/4, pols de 4us
	// La resta de valors de T1CON per defecte
	TMR0L=6;	// (256-6) * 4us = 1ms 
	T0CONbits.TMR0ON = 1;		// Activo el timer
	// Activo la interrupci? del timer 1
	INTCONbits.TMR0IF = 0;
	INTCONbits.TMR0IE = 1;
}

char TiGetTimer() {
	unsigned char counter=0;
	while (s_Timers[counter].b_busy==TI_CERT) {
		counter++;
		if (counter == TI_NUMTIMERS) return -1;
	}
	s_Timers[counter].b_busy=TI_CERT;
	return (counter);
}

void TiResetTics (unsigned char Handle) {
	//__DI(); h_Tics integer, per tant, indivisible
	s_Timers[Handle].h_TicsInicials=h_Tics;
	//__EI();
}


unsigned int TiGetTics (unsigned char Handle) {
volatile unsigned int actual;
	actual=h_Tics; // indivisible si ?s un int, clar.
	return (actual-(s_Timers[Handle].h_TicsInicials));
}

void TiCloseTimer (unsigned char Handle) {
	s_Timers[Handle].b_busy=TI_FALS;
}

//
//---------------------------End--PUBLIQUES---AREA-----------
//