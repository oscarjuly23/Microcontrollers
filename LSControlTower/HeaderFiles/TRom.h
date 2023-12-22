/*
 * File:   TRom.h
 * Author: Oscar & Oriol
 */

#ifndef _TROM_H_
#define	_TROM_H_

/* Includes ------------------------------------------------------------------*/
#include <xc.h> // include processor files - each processor file is guarded.
#include "TMenu.h"

/* Constants -----------------------------------------------------------------*/

/* Variables -----------------------------------------------------------------*/

/* Private function prototypes -----------------------------------------------*/
void initROM(void);
void motorROM(void);
void writeEEPROM(unsigned char addr, unsigned char data);
char readEEPROM(unsigned char addr);
void activeWritting(void);
char getNT(void);
char getPT(void);
void updateNT(void);
void updatePT(void);

#endif /* TROM_H */