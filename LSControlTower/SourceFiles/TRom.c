/*
 * File:   TRom.c
 * Author: Oscar & Oriol
 */

#include "TRom.h"

unsigned char counter, addr, k, writting, nTotal, pit;
unsigned char index1;
unsigned char index2;

void initROM(void) {
    writting = counter = 0;
    k = 2; 
    index1 = index2 = '0';

    
    pit = readEEPROM(0);
    nTotal = readEEPROM(1);
    
    if  (pit < 1 || pit > 8) {
        pit = 0;
    }
    if  (nTotal < 1 || nTotal > 7) {
        nTotal = 0;
    }    
    
    addr = 2 + (nTotal * 10);
    
    if (pit == 0){
        pit = nTotal;
    }
    
    for (int j = 0; j < pit; j++) {
        for (int i = 0; i < 6; i++){
            recordings[j].timestmp[i] = readEEPROM(k);
            k++;
        }
        for (int i = 0; i < 4; i++){
            recordings[j].index[i] = readEEPROM(k);
            k++;
        }
        index1 = recordings[nTotal-1].index[2];
        index2 = recordings[nTotal-1].index[1];
    }
    
    if (pit > 0) {
        if  (index1 < '9') {
            index1++;
        } else {
            index1 = '0';
            index2++;
        }
    }
}

char getPT(void){
    return pit;
}

char getNT(void){
    return nTotal;
}

void updateNT(void){
    nTotal++;
}

void updatePT(void){
    pit = 8;
}

void activeWritting(void){
    writting = 1;
}

void writeEEPROM(unsigned char addr, unsigned char data) {
    EEADR = addr;
    EEDATA = data;
    
    EECON1bits.EEPGD = 0;   //Point to data memory
    EECON1bits.CFGS = 0;    //Acces epprom
    EECON1bits.WREN = 1;    //Eable writes 0x04
    INTCONbits.GIE = 0;     //Disable Interrupts 
    EECON2 = 0x55;          //Write 55h
    EECON2 = 0xAA;          //Write 0AAh
    EECON1bits.WR = 1;      //Set WR bit to begin write 0x02 
}

char readEEPROM(unsigned char addr) {
    EEADR = addr;           //Data Memory Adress to read
    EECON1bits.EEPGD = 0;   //Point to DATA memory
    EECON1bits.CFGS = 0;    //Access EEPROM
    EECON1bits.RD = 1;      //EEPROM Read
    
    return EEDATA;
}

void motorROM(void){
    static unsigned char stateROM = 0;

    switch(stateROM){
        case 0:
            if(writting){
                stateROM = 1;
            }
            break;
        case 1:
            writting = 0;
            if(!EECON1bits.WR){
                stateROM = 2;
            }
            break;
        case 2:
            writeEEPROM(0, pit);
            INTCONbits.GIE = 1;
            EECON1bits.WREN = 0;
            stateROM = 3;
            break;
        case 3:
            if(!EECON1bits.WR){
                stateROM = 4;
            }
            break;
        case 4:
            writeEEPROM(1, nTotal);
            INTCONbits.GIE = 1;
            EECON1bits.WREN = 0;
            stateROM = 5;
            break;
        case 5:
            if(!EECON1bits.WR){
                stateROM = 6;
            }
            break;            
        case 6:
            if  (counter < 6) {
                writeEEPROM(addr, recordings[nTotal-1].timestmp[counter]);
                INTCONbits.GIE = 1;
                EECON1bits.WREN = 0;
                counter++;
                addr++;
                stateROM = 5;
            } else {
                stateROM = 7;
            }
            break;
        case 7:
            if  (counter < 10) {
                writeEEPROM(addr, recordings[nTotal-1].index[counter-6]);
                INTCONbits.GIE = 1;
                EECON1bits.WREN = 0;
                counter++;
                addr++;
                stateROM = 5;
            } else {
                stateROM = 8;
            }           
            break;
        case 8:
            counter = 0;
            if (nTotal == 8) {
                addr = 2;
                nTotal = 0;
                pit = 8;
            }
            stateROM = 0;
            break;
    }
}
            