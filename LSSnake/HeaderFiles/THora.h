/*
 * File:   THora.h
 * Author: Oscar Julian & Raúl Pérez
 */

#ifndef _THORA_H
#define _THORA_H

#include <xc.h>
#include "TITTIMER.h"
#include "TMenu.h"
#include "TSIO.h"

void initHora(void);
void initAM(void);
void resetHora(void);
void motorHora(void);
void motorAM(void);

#endif