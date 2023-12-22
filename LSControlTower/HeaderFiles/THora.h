/*
 * File:   TADC.h
 * Author: Oscar & Oriol
 */

#ifndef _THORA_H_
#define	_THORA_H_

/* Includes ------------------------------------------------------------------*/
#include <xc.h> // include processor files - each processor file is guarded.
#include "TiTTimer.h"
#include "TCentral.h"

/* Private function prototypes -----------------------------------------------*/
void initHora(void);
void motorHora(void);
void actHora(unsigned char pos, unsigned char hora);

#endif 	/* THORA_H */