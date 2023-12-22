/*
 * File:   TADC.c
 * Author: Oscar & Raul
 *
 */


#include "TADC.h"

static char timerADC;
unsigned char channel;

void initADC(void) {
    channel = 0;
    timerADC = TiGetTimer();
    TRISAbits.RA0 = 1;
    TRISAbits.RA1 = 1;
    // A/D Input channel:               ADCON0 --> CH1: 0000001, CH2: 00000101
    //ADCON0bits.ADON = 1;
    // A/D Configuration control bits:  ADCON1 --> 00001110
    ADCON1 = 0x0D;
    // A/D Conversion time:             ADCON2 --> 00001001 o a 0 que es igual creo
    ADCON2 = 0x89;
}

void resetADC(void){
    TiResetTics(timerADC);
}
  
void motorADC(void) {
	static char state = 0;
    
    if(playing == 1){
        switch(state) {
            case 0:
                if (TiGetTics(timerADC) >= 100) {
                    ADCON0bits.ADON = 1;
                    ADCON0bits.GODONE = 1;
                    state = 1;
                }
                break;
            case 1:
                if (ADCON0bits.GODONE == 0) {
                    ADCON0bits.ADON = 0;
                    if (channel == 0){
                        if (ADRESL < 3){
                            selectMessage(5);
                        } else if(ADRESH > 1) {
                            selectMessage(6);
                        }
                    } else {
                        if (ADRESL < 3){
                            selectMessage(3);
                        } else if (ADRESH > 1){
                            selectMessage(4);
                        }
                    }
                    state = 2;
                } else {
                    state = 1;
                }
                break;
            case 2:
                if (channel == 0){
                    ADCON0bits.CHS = 0x01;
                    channel = 1;
                } else {
                    ADCON0bits.CHS = 0x00;
                    channel = 0;
                }
                TiResetTics(timerADC);
                state = 0;
                break;
        }    
    } 
}
