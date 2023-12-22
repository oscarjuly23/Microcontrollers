/*
 * File:   TSIO.h
 * Author: Oscar Julian & Raúl Pérez
 */

#ifndef _TSIO_H_
#define	_TSIO_H_

#include <xc.h>
#include "TUsers.h"

const char UP = 'U';
const char DOWN = 'D';
const char LEFT = 'L';
const char RIGHT = 'R';

unsigned char playing, AM;
unsigned char points[3], hScore[3];

void initSIO(void);
void selectMessage(unsigned char messageAux);
void convertScore(unsigned char score);
void motorRX(void);
void motorTX(void);

#endif