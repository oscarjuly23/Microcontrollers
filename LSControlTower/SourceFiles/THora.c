/*
 * File:   THora.c
 * Author: Oscar & Oriol
 */

/* Includes ------------------------------------------------------------------*/
#include "THora.h"

/* Variables privades --------------------------------------------------------*/
static char timer;
unsigned char countTime[5], startTime;

/* Private functions ---------------------------------------------------------*/
void initHora(void){
    timer = TiGetTimer();
    TiResetTics(timer);
    countTime[2] = ':';
    countTime[0] = countTime[1] = countTime[3] = countTime[4]= '0';
    newHora(3, countTime[3], 0);
    newHora(4, countTime[4], 0);
    newHora(0, countTime[0], 0);
    newHora(1, countTime[1], 0);
    startTime = 1;
}

void actHora(unsigned char pos, unsigned char hora){
    TiResetTics(timer);
    countTime[pos] = hora;
}

void manageSegons(void){
    if  (countTime[4] < '9') {
        countTime[4]++;
        newHora(4, countTime[4], 0);
    } else {
        countTime[4] = '0';
        countTime[3]++;
        newHora(4, countTime[4], 0);
        newHora(3, countTime[3], 0);
    }
}

void manageMinutes(void){
    if  (countTime[1] < '9') {
        countTime[1]++;
        newHora(1, countTime[1], 0);
    } else {
        countTime[1] = '0';
        countTime[0]++;
        newHora(1, countTime[1], 0);
        newHora(0, countTime[0], 0);
    }
}

void motorHora(void){
    unsigned static char state = 0;
    if (startTime) {
        switch (state) {
            case 0:
                if  (TiGetTics(timer) >= 4000) {
                    TiResetTics(timer);
                    manageSegons();
                    state = 1;
                }
                break;
            case 1:
                if (countTime[3] == '6' && countTime[4] == '0') {
                    countTime[3] = countTime[4] = '0';
                    newHora(3, countTime[3], 0);
                    newHora(4, countTime[4], 0);
                    manageMinutes();
                }
                state = 0;
                break;
        }
    }
}