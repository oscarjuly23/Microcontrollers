/*
 * File:   TCentral.h
 * Author: Oscar & Oriol
 */

#ifndef _TCENTRAL_H
#define _TCENTRAL_H

/* Includes ------------------------------------------------------------------*/
#include <xc.h> // include processor files - each processor file is guarded.
#include "TMenu.h"
#include "TSound.h"
#include "TSIO.h"
#include "THora.h"
#include "TRom.h"

/* Variables -----------------------------------------------------------------*/

/* Private function prototypes -----------------------------------------------*/
void initCentral(void);
void manageKey(unsigned char key, unsigned char countChar, unsigned char note);
void changePos(unsigned char pos);
void resetPortName(void);
void changeMode(unsigned char u);
void modifyHora(unsigned char num);
void sendSound(unsigned char sound);
void newHora(unsigned char pos, unsigned char hora, unsigned char mod);

#endif /* TCENTRAL_H */