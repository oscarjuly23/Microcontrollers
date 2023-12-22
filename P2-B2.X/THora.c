/*
 * File:   THora.c
 * Author: Oscar Julian & Raúl Pérez
 */


#include "THora.h"

static char timer, timerAM;
unsigned static char stateHora, stateAM;
unsigned char seconds;

void initHora(void) {
    timer = TiGetTimer();
    TiResetTics(timer);
    timerAM = TiGetTimer();
    stateHora = seconds = 0;
}

void initAM(void){
    TiResetTics(timerAM);
    timeAM[0] = timeAM[1] = timeAM[3] = timeAM[4]= '0';
    timeAM[2] = ':';
    stateAM = 0;
}

void resetHora(void){
    TiResetTics(timer);
    seconds = 0;
}

void manageHora(unsigned char *time1, unsigned char *time2, unsigned char *state, unsigned char nextState){
    if ((*time2) < '9'){
        (*time2)++;
        (*state) = 0;
    } else if ((*time1) < '5'){
        (*time1)++;
        (*time2) = '0';
        (*state) = 0;
    } else {
        (*state) = nextState;
    }
}

void motorHora(void){
    switch (stateHora){
        case 0:
            if (TiGetTics(timer) >= 1000){
                stateHora = 1;
            }            
            break;
        case 1:
            TiResetTics(timer);
            seconds++;
            if (seconds > 59){
                stateHora = 2;
                seconds = 0;
            } else {
                stateHora = 0;
            }
            break;
        case 2:
            resetMenu();
            manageHora(&time[3], &time[4], &stateHora, 3);
            break;
        case 3:
            time[3] = time[4] = '0';
            if (time[0] < '2'){
                if (time[1] < '9'){
                    time[1]++;
                } else {
                    time[0]++;
                    time[1] = '0';
                }
            } else {
                if (time[1] < '3'){
                    time[1]++;
                } else {
                    time[0] = time[1] = '0';
                }
            }
            stateHora = 0;
            break;
    }
}

void motorAM(void) {
    if (playing == 1) {
        switch (stateAM){
            case 0:
            if (TiGetTics(timerAM) >= 1000){
                stateAM = 1;
            } 
            break;
            case 1:
                TiResetTics(timerAM);
                resetMenu();
                AM++;
                selectMessage(2);
                manageHora(&timeAM[3], &timeAM[4], &stateAM, 2);
                break;
            case 2:
                AM = 0;
                timeAM[3] = timeAM[4] = '0';
                manageHora(&timeAM[0], &timeAM[1], &stateAM, 0);
        }
    }
}