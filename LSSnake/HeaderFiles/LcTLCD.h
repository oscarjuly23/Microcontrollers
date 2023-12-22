/*
 * File:   LcTLCD.h
 * Author: Oscar & Raul
 *
 */

#ifndef LCTLCD_H
#define	LCTLCD_H

#include <xc.h>
#include "TITTIMER.h"

#define SetD4_D7Sortida()		   (TRISCbits.RC0 = TRISCbits.RC1 = TRISCbits.RC2 = TRISCbits.RC3 = 0)
#define SetD4_D7Entrada()		   (TRISCbits.RC0 = TRISCbits.RC1 = TRISCbits.RC2 = TRISCbits.RC3 = 1)
#define SetControlsSortida()       (TRISBbits.RB3 = TRISBbits.RB4 = TRISBbits.RB5 = 0)
#define SetD4(On)				       (LATCbits.LATC3 = (On))
#define SetD5(On)				       (LATCbits.LATC2 = (On))
#define SetD6(On)				       (LATCbits.LATC0 = (On))
#define SetD7(On)				       (LATCbits.LATC1 = (On))
#define GetBusyFlag()                  (PORTCbits.RC1)
#define RSUp()					       (LATBbits.LATB3 = 1)
#define RSDown()				       (LATBbits.LATB3 = 0)
#define RWUp()					       (LATBbits.LATB4 = 1)
#define RWDown()				       (LATBbits.LATB4 = 0)
#define EnableUp()                     (LATBbits.LATB5 = 1)
#define EnableDown()                   (LATBbits.LATB5 = 0)
// -------------------------------END--HARDWARE---AREA--------------------


void LcInit(char Files, char Columnes);
// Pre: Files = {1, 2, 4}  Columnes = {8, 16, 20, 24, 32, 40 }
// Pre: Hi ha un timer lliure
// Post: L'Hitachi merd€s necessita 40ms de tranquilitat desde
// la pujada de Vcc fins cridar aquest constructor
// Post: Aquesta rutina pot trigar fins a 100ms
// Post: El display queda esborrat, el cursor apagat i a la
// posici€ 0, 0.

void LcEnd(void);
// El Destructor

void LcClear(void);
// Post: Esborra el display i posa el cursor a la posici€ zero en
// l'estat en el que estava.
// Post: La propera ordre pot trigar fins a 1.6ms

void LcCursorOn(void);
// Post: Enc»n el cursor
// Post: La propera ordre pot trigar fins a 40us

void LcCursorOff(void);
// Post: Apaga 0el cursor
// Post: La propera ordre pot trigar fins a 40us

void LcGotoXY(char Columna, char Fila);
// Pre : Columna entre 0 i 39, Fila entre 0 i 3
// Post: Posiciona el cursor en aquestes coordenades
// Post: La propera ordre pot trigar fins a 40us

void LcPutChar(char c);
// Post: Pinta C en l'actual poscici€ del cursor i incrementa
// la seva posici€. Si la columna arriba a 39, salta a 0 tot
// incrementant la fila si el LCD »s de dues files.
// Si es de 4 files, incrementa de fila en arribar a la columna 20
// AixÃ mateix, la fila 4 passa a la zero.
// En els LCDs d'una fila, quan la columna arriba a 39, torna
// a zero. No s'incrementa mai la fila

void printCadena(char OPTION[]);

#endif	/* LCTLCD_H */