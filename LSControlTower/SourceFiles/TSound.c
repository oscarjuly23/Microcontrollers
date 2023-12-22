/*
 * File:   TSound.c
 * Author: Oscar & Oriol
 */

/* Includes ------------------------------------------------------------------*/
#include "TSound.h"
#define n1 1

/* Variables privades --------------------------------------------------------*/
static char timer, timer2, timer3;
unsigned char nota, sound, melody;

/* Private functions ---------------------------------------------------------*/

void initSound(void) {
  timer = TiGetTimer();
  TiResetTics(timer);
  timer2 = TiGetTimer();
  TiResetTics(timer2);
  timer3 = TiGetTimer();
  TiResetTics(timer3);
  TRISAbits.TRISA5 = 0;
  LATAbits.LATA5 = 0;
  sound = melody = 0;
}

void pressSound(unsigned char tono) {
    TiResetTics(timer);
    TiResetTics(timer2);
    nota = tono;
    sound = 1;
}

void playMelody(void){
    nota = 5;
    TiResetTics(timer);
    TiResetTics(timer2);
    TiResetTics(timer3);
    melody = 1;
}

//Motor que genera senyal PWM per a fer sonar les notas del teclat per l'Altaveu.
void motorSound(void){
    static unsigned char state = 0;

    // Només farem sonar la nota quan ens apreten una tecla.
    if (sound) {
        switch (state)  {
          case 0:
              // Depenent de la senyal canviem el temps a 1 de la senyal.
            if (TiGetTics(timer) >= (nota >> 1)){
              TiResetTics(timer);
              LATAbits.LATA5 = 1;
              state = 1;
            }
            break;
          case 1:
            if (TiGetTics(timer) >= (nota >> 1)){
              TiResetTics(timer);
              LATAbits.LATA5 = 0;
              state = 0;
            }
            break;
        } 
        
        // Farem sonar la nota durant 100 tics i reiniciem les variables.
        if (TiGetTics(timer2) >= 400){
            TiResetTics(timer2);
            sound = 0;
        }   
    }
}

void motorMelody(void){
    static unsigned char state2 = 0;

    if(melody){
        
        switch (state2)  {
               case 0:
                   // Depenent de la senyal canviem el temps a 1 de la senyal.
                    if (TiGetTics(timer) >= (nota >> 1)){
                       TiResetTics(timer);
                       LATAbits.LATA5 = 1;
                       state2 = 1;
                    }
                    break;
               case 1:
                    if (TiGetTics(timer) >= (nota >> 1)){
                      TiResetTics(timer);
                      LATAbits.LATA5 = 0;
                      state2 = 0;
                    }
                    break;
           }

        // Si passa 1 segon, canviem la nota
        if(TiGetTics(timer2) >= 4000){ 
            TiResetTics(timer2);
            nota += 2;
        }
        
        // Si passen 5 segons deixem de fer sonar l'altaveu
        if (TiGetTics(timer3) >= 20000){
            TiResetTics(timer3);
            melody = 0;
        }
    }
}
