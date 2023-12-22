/*
 * File:   TADC.h
 * Author: Oscar & Oriol
 */

#ifndef _TADC_H_
#define	_TADC_H_

/* Includes ------------------------------------------------------------------*/
#include <xc.h> // include processor files - each processor file is guarded.
#include "TiTTimer.h"
#include "TCentral.h"

/* Private function prototypes -----------------------------------------------*/
void initADC(void);
void motorADC(void);
void motorMicro(void);

#endif 	/* TADC_H */