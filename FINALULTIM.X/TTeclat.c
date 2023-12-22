/*
 * File:   TTeclat.c
 * Author: Oscar & Oriol
 * 
 * FUNCIONAMENT:
 * 
 * 1. motorTeclat:  Anem shiftant les columnes del teclat fins que detectem una polsació.
 * 2. checkKey:     Quan detectem una polsació ens quedem amb la columna.
 * 3. checkFila:    Ens guardem quina quina fila ha estat polsada.
 * 4. wichKey:      Un cop tenim la fila i la columna ja sabem de quina tecla es tracta.
 * 5. --> ManageKeySMS (Un cop sabem la tecla, la enviem al SMS)
 */

/* Includes ------------------------------------------------------------------*/
#include "TTeclat.h"

/* Variables privades --------------------------------------------------------*/
static char timer;
static unsigned char state;
unsigned char keyDetected, fila, columna;

/* Private functions ---------------------------------------------------------*/

void initTeclat(void) {
    timer = TiGetTimer();
    TiResetTics(timer);
    TRISD = 0x78; // 1111000
    state = keyDetected = fila = columna = 0;
}

// Segons la tecla premuda, mirem la fila.
void checkFila(void) {
    TiResetTics(timer);
    keyDetected = 1;
	if (PORTDbits.RD6 == 0) {
		fila = 4;
	} else if (PORTDbits.RD5 == 0) {
		fila = 3;
	} else if (PORTDbits.RD4 == 0) {
		fila = 2;
	} else {
		fila = 1;
    }
}

//Segons la fila&Columna ja sabem quin número ens han apretat
char whichKey(void){
    switch ((fila << 4) | columna) {
        case 0x11:
            return '1';
        case 0x12:
            return '2';
        case 0x13:
            return '3';
        case 0x21:
            return '4';
        case 0x22:
            return '5';
        case 0x23:
            return '6';
        case 0x31:
            return '7';
        case 0x32:
            return '8';
        case 0x33:
            return '9';
        case 0x41:
            return '*';
        case 0x42:
            return '0';
        default:
            return '#';
    }
}


/**
 * @brief  Segons la fila&Columna ja sabem quin número ens han apretat
 * @param  D0,D1,D2: Valors de les columnes.
 * @param  stateAux: Estat futur per al motor.
 * @param  column: Columna que hem detectat.
 * @retval None
 */
char checkKey(unsigned char D0, unsigned char D1, unsigned char D2, unsigned char stateAux, unsigned char column){
    if (!keyDetected){
       if ((PORTD & 0x78) == 0x78) {
            // Shiftem les columnes
            LATDbits.LATD0 = D0;
            LATDbits.LATD1 = D1;
            LATDbits.LATD2 = D2;
            columna = column;
            state = stateAux;
        } else {
            // Un cop detectem la columna mirem quina fila
            checkFila();
            state = 3;
        }
    } else {
        state = 4;
    }
    return state;
}

//Motor que shifta i comprova si ens apreten una tecla en el teclat matriu.
void motorTeclat(void){
    switch (state){
        case 0:
           state =  checkKey(/*LATDbits.LATD0 =*/0, /*LATDbits.LATD1 =*/1, /*LATDbits.LATD2 =*/1, /*state =*/1, /*columna =*/1);
           break;
        case 1:
           state = checkKey(/*LATDbits.LATD0 =*/1, /*LATDbits.LATD1 =*/0, /*LATDbits.LATD2 =*/1, /*state =*/2, /*columna =*/2);
           break;
        case 2:
           state = checkKey(/*LATDbits.LATD0 =*/1, /*LATDbits.LATD1 =*/1, /*LATDbits.LATD2 =*/0, /*state =*/0, /*columna =*/3);
           break;
        case 3:
            if (TiGetTics(timer) >= T_REBOTS){
                state = 4;
                TiResetTics(timer);
            }
            break;
        case 4:
            if (keyDetected){
                manageKeySMS(whichKey()); // Enviem la tecla al TSMS
            }
            state = keyDetected = 0;
            break;
    }
}
