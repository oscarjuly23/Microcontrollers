/*
 * File:   TAltaveu.c
 * Author: Oscar & Raul
 *
 */


#include "TAltaveu.h"
#define n1 1

static char timerPWM, timerMusica;
unsigned char nota;

void initAltaveu(void) {
  timerPWM = TiGetTimer();
  timerMusica = TiGetTimer();
  TiResetTics(timerPWM);
  TiResetTics(timerMusica);
  TRISAbits.TRISA2 = 0;
  LATAbits.LATA2 = 0;
  nota = 1;
}

void motorPWM(void){
  static char estat = 0;
  if (playing == 1){
    switch (estat)  {
      case 0:
        if (TiGetTics(timerPWM) >= (nota >> 1)){
          TiResetTics(timerPWM);
          LATAbits.LATA2 = 1;
          estat = 1;
        }
        break;
      case 1:
        if (TiGetTics(timerPWM)>= (nota >> 1)){
          TiResetTics(timerPWM);
          LATAbits.LATA2 = 0;
          estat = 0;
        }
        break;
      }
  }
}

void motorMusica(){
    if (TiGetTics(timerMusica) >= 2000){
        TiResetTics(timerMusica);
        if (nota == 10){
            nota = 1;
        } else {
            nota++;
        }
    }
}
