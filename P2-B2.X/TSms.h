/*
 * File:   TSms.h
 * Author: Oscar Julian & Raúl Pérez
 */

#ifndef _TSMS_H_
#define	_TSMS_H_

#include <xc.h>  
#include "TCentral.h"

const unsigned char key2[]={'A','B','C','2'};
const unsigned char key3[]={'D','E','F','3'};
const unsigned char key4[]={'G','H','I','4'};
const unsigned char key5[]={'J','K','L','5'};
const unsigned char key6[]={'M','N','O','6'};
const unsigned char key7[]={'P','Q','R','S','7'};
const unsigned char key8[]={'T','U','V','8'};
const unsigned char key9[]={'W','X','Y','Z','9'};

void initSms(void);
void manageKeySMS(char key);

#endif 	/* TSMS_H */