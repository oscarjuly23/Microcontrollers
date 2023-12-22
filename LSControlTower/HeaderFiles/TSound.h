/*
 * File:   TAltaveu.h
 * Author: Oscar & Oriol
 */

#ifndef _TSound_H_
#define	_TSound_H_

/* Includes ------------------------------------------------------------------*/
#include <xc.h> // include processor files - each processor file is guarded.
#include "TiTTimer.h"

/* Private function prototypes -----------------------------------------------*/
void initSound(void);
void motorSound(void);
void motorMelody(void);
void pressSound(unsigned char nota);
void playMelody(void);

#endif 	/* TSOUND_H */