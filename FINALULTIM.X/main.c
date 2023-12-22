#include <PIC18f4321.h>
#include <xc.h>

#include "TiTTimer.h"
#include "LcTLCD.h"
#include "TCentral.h"
#include "TMenu.h"
#include "TTeclat.h"
#include "TSms.h"
#include "TSound.h"
#include "TADC.h"
#include "TSIO.h"
#include "THora.h"
#include "TRom.h"

#pragma config OSC = INTIO2
#pragma config PBADEN = DIG
#pragma config MCLRE = OFF
#pragma config DEBUG = OFF
#pragma config PWRT = OFF
#pragma config BOR = OFF
#pragma config WDT = OFF
#pragma config LVP = OFF

void main(void);

void __interrupt(high_priority) RSI_High(void){
    if (INTCONbits.TMR0IF == 1) {
        //LATAbits.LATA2 = !LATAbits.LATA2;
		RSI_Timer0();
    }
}

void main(void) {
    //TRISAbits.TRISA2 = 0;  // Configura RA2 como salida
    INTCONbits.GIE = INTCONbits.PEIE = 1;
    
    TiInit();
    LcInit(2,16);
    initROM();
    initMenu();
    initTeclat();
    initCentral();
    initSMS();
    initADC();
    initSound();
    initSIO();
    
    while(1) {
        motorMenu();
        motorTeclat();
        motorSound();
        motorTX();
        motorADC();
        motorRX();
        motorHora();
        motorMelody();
        motorROM();
        motorMicro();
    }
}