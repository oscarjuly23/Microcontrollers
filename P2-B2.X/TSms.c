/*
 * File:   TSms.c
 * Author: Oscar Julian & Raúl Pérez
 */

#include "TSms.h"

static char timer;
unsigned char times, previousKey, numChars, keyColumn, longer, times;

void initSms(void) {
    timer = TiGetTimer();
    times = 0;
}

void searchLetter(){
    if (TiGetTics(timer) <= 750){
        if (longer == 0){
            if (keyColumn == 3){
                keyColumn = 0;
            } else {
                keyColumn++;
            }
        } else {
            if (keyColumn == 4){
                keyColumn = 0;
            } else {
                keyColumn++;
            }
        }
    } else {
        keyColumn = 0;
        numChars++;
    }
}

void manageCursor(unsigned char key){
    if (key == previousKey){
        searchLetter();
    } else {
        keyColumn = 0;
        numChars++;
    }
}

void manageKeySMS(char key){
    if (modeSMS == 1){
        if (times == 0){
            numChars--;
            times = 1;
        }
        if (key == '0'){
            numChars++;
            manageKey(key, numChars);
        } else if (key == '1'){
            numChars++;
            manageKey(key, numChars);
        } else if (key == '2'){
            manageCursor(key);
            manageKey(key2[keyColumn], numChars);
        } else if (key == '3'){
            manageCursor(key);
            manageKey(key3[keyColumn], numChars);
        } else if (key == '4'){
            manageCursor(key);
            manageKey(key4[keyColumn], numChars);
        } else if (key == '5'){
            manageCursor(key);
            manageKey(key5[keyColumn], numChars);
        } else if (key == '6'){
            manageCursor(key);
            manageKey(key6[keyColumn], numChars);
        } else if (key == '7'){
            manageCursor(key);
            manageKey(key7[keyColumn], numChars);
        } else if (key == '8'){
            manageCursor(key);
            manageKey(key8[keyColumn], numChars);
        } else if (key == '9'){
            manageCursor(key);
            manageKey(key9[keyColumn], numChars);
        }
        previousKey = key;
        TiResetTics(timer); 
        if (key == '#' || key == '*'){
            TiCloseTimer(timer);
            numChars++;
            manageKey(key, numChars);
            numChars = times = 0;
        }
    } else {
        manageKey(key, numChars);
    }
}
