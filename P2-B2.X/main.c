/*
 * File:   main.c
 * Author: Oscar Julian & Raúl Pérez
 */

#include <PIC18f4321.h>
#include <xc.h>

#include "TITTIMER.h"
#include "LcTLCD.h"
#include "TTeclat.h"
#include "TMenu.h"
#include "TCentral.h"
#include "THora.h"
#include "TSIO.h"
#include "TADC.h"
#include "TAltaveu.h"

#pragma config OSC = INTIO2
#pragma config PBADEN = DIG
#pragma config DEBUG = OFF
#pragma config PWRT = OFF
#pragma config BOR = OFF
#pragma config WDT = OFF
#pragma config LVP = OFF

void main(void);

void __interrupt(high_priority) RSI_High(void){
    if (INTCONbits.TMR0IF == 1) {
		RSI_Timer0();
    }
}

void main(void) {
  INTCONbits.GIE = INTCONbits.PEIE = 1;
  
  TiInit();
  LcInit(2,16);
  initCentral();
  initTeclat();
  initMenu();
  initUsers();
  initHora();
  initSIO();
  initADC();
  initAltaveu();
  
  while(1) {
      motorTeclat();
      motorMenu();
      motorHora();
      motorTX();
      motorAM();
      motorRX();
      motorADC();
      motorMusica();
      motorPWM();
  }
}
