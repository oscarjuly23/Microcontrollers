/*
 * File:   TAltaveu.h
 * Author: Oscar & Raúl
 *
 */

#ifndef _TAltaveu_H_
#define	_TAltaveu_H_

#include <xc.h> // include processor files - each processor file is guarded.
#include "TITTIMER.h"
#include "TSIO.h"

void initAltaveu(void);
void motorPWM(void);
void motorMusica(void);

#endif
