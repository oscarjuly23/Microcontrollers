/*
 * File:   TSms.h
 * Author: Oscar & Oriol
 */

#ifndef _TSMS_H_
#define	_TSMS_H_

/* Includes ------------------------------------------------------------------*/
#include <xc.h> // include processor files - each processor file is guarded.
#include "TiTTimer.h"
#include "TCentral.h"

/* Constants -----------------------------------------------------------------*/
const unsigned char key0[]={'0',' ', '0', ' '};
const unsigned char key1[]={'1', '1', '1', '1'};
const unsigned char key2[]={'A','B','C','2'};
const unsigned char key3[]={'D','E','F','3'};
const unsigned char key4[]={'G','H','I','4'};
const unsigned char key5[]={'J','K','L','5'};
const unsigned char key6[]={'M','N','O','6'};
const unsigned char key7[]={'P','Q','R','S','7'};
const unsigned char key8[]={'T','U','V','8'};
const unsigned char key9[]={'W','X','Y','Z','9'};

/* Private function prototypes -----------------------------------------------*/
void initSMS(void);
void manageKeySMS(char key);

#endif 	/* TSMS_H */