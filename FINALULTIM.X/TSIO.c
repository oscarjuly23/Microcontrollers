/*
 * File:   TSIO.c
 * Author: Oscar & Oriol
 */

/* Includes ------------------------------------------------------------------*/
#include "TSIO.h"

/* Variables privades --------------------------------------------------------*/
unsigned char send, action, count, mode, enviaNom, i, s, ok, flying, recording;
unsigned char sendName[5], time[6];

/* Private functions ---------------------------------------------------------*/

void initSIO(void) {
    //TRISC |= 0xD0; // Mascara amb els 2MSB a 1
    TRISCbits.TRISC6 = 1;
    TRISCbits.TRISC7 = 1;
 	TXSTA = 0x26;	//TXEN = 1; SYNC = 0; BRGH = 1
 	RCSTA = 0x90;	//SPEN = 1; CREN = 1
 	BAUDCONbits.BRG16 = 1;
    SPBRG = 68;
    SPBRGH = 0;
    
    time[2] = ':';
    time[0] = time[1] = time[3] = time[4]= '0';
    time[5] = '\0';
    send = action = count = mode = enviaNom = s = flying = recording = ok = 0;
    i = 1;
}

void activaRecording(void){
    recording = 1;
}

void enviaMostra(unsigned char sound) {
    if  (flying) {
        action = 'S';
        s = sound;
        send = 1;
    }
}

void selectSound(unsigned char ind){
    action = 'P';
    s = ind;
    send = 1;
}

void enviaDada(unsigned char c, unsigned char* info) {
    switch (c){
        case 0:
            // Send Tower Name
            action = 'T';
            sendName[1] = info[0];
            sendName[2] = info[1];
            sendName[3] = info[2];
            sendName[4] = '\0';
            break;
        case 1:
            // Send New Song
            action = 'D';
            time[0] = info[0];
            time[1] = info[1];
            time[2] = ':';
            time[3] = info[3];
            time[4] = info[4];
            time[5] = '\0';
            break;
        case 2:
            action = 'P';
            break;    
    }

    send = 1;
}

void setMode(unsigned char m) {
    mode = m;
}

// MOTOR RECIVE SIO RX 
void motorRX(void){
    static char info;
    unsigned char num;
    // Fem polling del registre RCIF esperant a rebre dades
    if (PIR1bits.RCIF == 1){
        info = RCREG;
        
        if (info == 'K' && mode == 0) {
            cleanMarquesina();
            enviaNom = 1; 
        } else if(info == 'J'){
            playMelody();
        }else if (info == 'K' && mode == 3){
            ok = 1;
        }else if(info == 'F'){
           changeMode(1);
        }else if(info == 'O'){
           changeMode(1);
           recording = 0;
           flying = 0;
           playMelody();
        }else {
            num = getNT();
            recordings[num].index[i] = info;
            i++;
            
            if (i == 3) {
                num = getNT();
                recordings[num].index[0] = 'I';
                recordings[num].index[3] = '\0';
                updateNT();
                num = getNT();
                if (num == 7) {
                    updatePT();
                }
                
                activeWritting();
                flying = 1;
                i = 1;                
            }
        }
    }
}
    
// MOTOR SEND SIO TX
void motorTX(void){
    static unsigned char state = 0;
    unsigned char num;

    switch (state){
        case 0:
            if (send){
                state = 1;
            }
            break;
        case 1:
            send = 0;
            switch (action){
                case 'T': // Send Tower Name
                    if (TXSTAbits.TRMT == 1){
                        TXREG = action;
                        state = 2;
                    }
                    break;
                case 'D': // Send New Song
                    if (TXSTAbits.TRMT == 1){
                        TXREG = action;
                        state = 3;
                        }
                    break;
                case 'S':
                    if (TXSTAbits.TRMT == 1){
                        TXREG = s;
                        state = 0;
                        }
                    break;
                case 'P':
                    if (TXSTAbits.TRMT == 1){
                        TXREG = action;
                        state = 4;
                        }
                    break;
            }
        case 2:
            if (enviaNom) {
                if (count < 5) {
                    if (TXSTAbits.TRMT == 1){
                        if(count != 0){
                            TXREG = sendName[count];   
                        }
                        count++;
                    }
                } else {
                    changeMode(1);
                    count = 0;
                    enviaNom = 0;
                    state = 0;
                }
            }
            break;
        case 3:
            if (count < 6) {
                if (TXSTAbits.TRMT == 1){
                    TXREG = time[count];
                    num = getNT();
                    recordings[num].timestmp[count] = time[count];  
                    count++;
                }
            } else {
                count = 0;
                state = 0;
            }            
            break;
        case 4:
            if (ok) {             
                if (count < 3) {
                    if (TXSTAbits.TRMT == 1){
                        TXREG = recordings[s].index[count+1];
                        count++;
                    }
                } else {
                    count = 0;
                    state = 0;
                }         
            }
            break;
    }
}