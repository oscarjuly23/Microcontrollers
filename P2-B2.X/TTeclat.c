/*
 * File:   TTeclat.c
 * Author: Oscar Julian & Raúl Pérez
 */

#include "TTeclat.h"

#define T_REBOTS 150

static char timer;
static unsigned char state;
unsigned char HHT, key, f, c;


void initTeclat(void) {
    timer = TiGetTimer();
    TRISD = 0x78;
    state = HHT = 0;
    key = '-';
}

void comprovafila(void) {
	TiResetTics(timer);
    HHT = 1;
	if (PORTDbits.RD6 == 0) {
		f = 4;
	} else if (PORTDbits.RD5 == 0) {
		f = 3;
	} else if (PORTDbits.RD4 == 0) {
		f = 2;
	} else {
		f = 1;
    }
}

void whichKey(void){
    if(f == 1 && c == 1) {
        key = '1';
    } else if (f == 1 && c == 2){
        key = '2';
    } else if (f == 1 && c == 3){
        key = '3';
    } else if (f == 2 && c == 1){
        key = '4';
    } else if (f == 2 && c == 2){
        key = '5';
    } else if (f == 2 && c == 3){
        key = '6';
    } else if (f == 3 && c == 1){
        key = '7';
    } else if (f == 3 && c == 2){
        key = '8';
    } else if (f == 3 && c == 3){
        key = '9';
    } else if (f == 4 && c == 1){
        key = '*';
    } else if (f == 4 && c == 2){
        key = '0';
    } else {
        key = '#';
    }
}

void checkKey(unsigned int D0, unsigned int D1, unsigned int D2, unsigned char stateAux, unsigned char column){
    if (!HHT){
       if ((PORTD & 0x78) == 0x78) {
            LATDbits.LATD0 = D0;
            LATDbits.LATD1 = D1;
            LATDbits.LATD2 = D2;
            state = stateAux;
            c = column;
        } else {
            comprovafila();
            state = 3;
        }
    } else {
        state = 4;
    }
}

void motorTeclat(void){
    switch (state){
        case 0:
           checkKey(/*LATDbits.LATD0 =*/0, /*LATDbits.LATD1 =*/1, /*LATDbits.LATD2 =*/1, /*state =*/1, /*c =*/1);
           break;
        case 1:
           checkKey(/*LATDbits.LATD0 =*/1, /*LATDbits.LATD1 =*/0, /*LATDbits.LATD2 =*/1, /*state =*/2, /*c =*/2);
           break;
        case 2:
           checkKey(/*LATDbits.LATD0 =*/1, /*LATDbits.LATD1 =*/1, /*LATDbits.LATD2 =*/0, /*state =*/0, /*c =*/3);
           break;
        case 3:
            if (TiGetTics(timer) >= T_REBOTS){
                state = 4;
                TiResetTics(timer);
            }
            break;
        case 4:
            if (HHT){
                whichKey();
                manageKeySMS(key);
            }
            state = HHT = 0;
            break;
    }
}
