/*
 * File:   TADC.c
 * Author: Oscar & Oriol
 */

/* Includes ------------------------------------------------------------------*/
#include "TADC.h"

/* Variables privades --------------------------------------------------------*/
static char timerADC, timerMicro;
unsigned char move, center, posJoy;

/* Private functions ---------------------------------------------------------*/

void initADC(void) {
    timerADC = TiGetTimer();
    TiResetTics(timerADC);
    timerMicro = TiGetTimer();
    TiResetTics(timerMicro);
    move = posJoy = center = 0;
    TRISAbits.RA0 = 1;
    TRISAbits.RA1 = 1;
    // A/D Configuration control bits:  ADCON1 --> 00001110
    ADCON1 = 0x0D;
    ADCON2 = 0x00;
    //ADCON2 = 0x89;
}

//Controla els moviments del Joystick i avisa a Central.
void motorADC(void) {
    static unsigned char state = 0;
    switch(state) {
        case 0:
            ADCON0bits.ADON = 0;  // Apagar el módulo ADC antes de la configuración
            ADCON0bits.CHS = 0;   // Seleccionar el canal AN1 para la lectura del joystick
            ADCON0bits.ADON = 1;
            ADCON0bits.GODONE = 1;
            state = 1;
            break;
        case 1:
            if (ADCON0bits.GODONE == 0) {
                posJoy = ADRESH;
                ADCON0bits.ADON = 0;
                
                if (posJoy > 120 && posJoy < 130){
                    center = 1;
                } else if (posJoy > 200) {
                    move = 1;
                } else if (posJoy < 50) {
                    move = 2;
                }
                state = 2;
            }
            break;
        case 2:
            if (center == 1 && move == 0) {
                center = 0;
            }
            if ((center == 1) && (move > 0)){
                changePos(move);
                move = 0;
                center = 0;
            }
            state = 0;
            break;
    }
}

//Controla els moviments del Joystick i avisa a Central.
void motorADC(void) {
    static unsigned char state = 0;
        switch(state) {
            case 0:
                ADCON0bits.ADON = 0;  // Apagar el módulo ADC antes de la configuración
                ADCON0bits.CHS = 0;   // Seleccionar el canal AN1 para la lectura del joystick
                ADCON0bits.ADON = 1;
                if (TiGetTics(timerADC) >= 400) {
                    ADCON0bits.GODONE = 1;
                    state = 1;
                }
                break;
            case 1:
                if (ADCON0bits.GODONE == 0) {
                    ADCON0bits.ADON = 0;
                    if (ADRESH > 120 && ADRESH < 130 && move){
                        changePos(move);
                        move = 0;
                    } else if (ADRESH > 200) {
                        move = 1;
                    } else if (ADRESH < 50) {
                        move = 2;
                    }
                    state = 2;
                } else {
                    state = 1;
                }
                break;
            case 2:
                TiResetTics(timerADC);
                state = 0;
                break;
        }
}

void motorADC(void) {
    static unsigned char state = 0;
    switch(state) {
        case 0:
            ADCON0bits.ADON = 0;  // Apagar el módulo ADC antes de la configuración
            ADCON0bits.CHS = 0;   // Seleccionar el canal AN1 para la lectura del joystick
            ADCON0bits.ADON = 1;
            ADCON0bits.GODONE = 1;
            state = 1;
            break;
        case 1:
            if (ADCON0bits.GODONE == 0) {
                posJoy = ADRESH;
                ADCON0bits.ADON = 0;

                if (posJoy > 100 && posJoy < 140){
                    state = 2;
                } else if (posJoy > 230) {
                    move = 1;
                } else if (posJoy < 15) {
                    move = 2;
                }
            }
            break;
        case 2:
            if (move > 0){
                changePos(move);
                move = 0;
            }
            state = 0;
            break;
    }
}

void motorMicro(void){
    static unsigned char states = 0;

    switch(states){
        case 0:
            ADCON0bits.ADON = 0;  // Apagar el módulo ADC antes de la configuración
            ADCON0bits.CHS = 1;   // Seleccionar el canal AN1 para la lectura del micrófono
            ADCON0bits.ADON = 1;
            if (TiGetTics(timerMicro) >= 1) {
                ADCON0bits.GODONE = 1;
                states = 1;
            }
            break;
        case 1:
            if (ADCON0bits.GODONE == 0) {
                ADCON0bits.ADON = 0;
                sendSound(ADRESH);
                TiResetTics(timerMicro);
                states = 0;
            }
            break;
    }
}