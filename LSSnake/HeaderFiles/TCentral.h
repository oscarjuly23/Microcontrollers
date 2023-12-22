/*
 * File:   TCentral.h
 * Author: Oscar Julian & Ra�l P�rez
 */

#ifndef _TCENTRAL_H
#define _TCENTRAL_H

#include <xc.h>
#include "TMenu.h"
#include "TUsers.h"
#include "THora.h"
#include "TSIO.h"
#include "TADC.h"

unsigned char modeSMS;

void initCentral(void);
void manageKey(unsigned char key, unsigned char numChars);

#endif