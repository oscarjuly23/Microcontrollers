/*
 * File:   TSIO.h
 * Author: Oscar & Raul
 */

#ifndef _TSIO_H_
#define	_TSIO_H_

/* Includes ------------------------------------------------------------------*/
#include <xc.h>
#include "TRom.h"
//#include "THora.h"

/* Variables -----------------------------------------------------------------*/

/* Private function prototypes -----------------------------------------------*/
void initSIO(void);
void motorRX(void);
void motorTX(void);
void enviaDada(unsigned char c, unsigned char* info);
void enviaMostra(unsigned char sound);
void selectSound(unsigned char ind);
void activaRecording(void);
void setMode(unsigned char m);

#endif /* TSIO_H */