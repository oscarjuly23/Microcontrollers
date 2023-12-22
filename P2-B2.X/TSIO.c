/*
 * File:   TSIO.c
 * Author: Oscar Julian & Raúl Pérez
 */

#include "TSIO.h"

unsigned char enviaDada, message, posName, score;

void initSIO(void) {
    TRISC |= 0xD0; // Mascara amb els 2MSB a 1
 	TXSTA = 0x24;	//TXEN = 1; SYNC = 0; BRGH = 1
 	RCSTA = 0x90;	//SPEN = 1; CREN = 1
    BAUDCON = 0x02;
 	SPBRG = 25;
    playing = AM = enviaDada = message = posName = score = 0;
    points[0] = points[1] = points[2] = hScore[0] = hScore[1] = hScore[2] = '0';
}

void selectMessage(unsigned char messageAux){
    enviaDada = 1;
    message = messageAux;
}

void sendMessage(unsigned char info){
    TXREG = info;
    message = 0;
}

void updatePoints(){
    if (points[2] == '0'){
        points[2] = '5';
    } else {
        points[2] = '0';
        if (points[1] < '9'){
            points[1]++;
        } else {
            points[1] = '0';
            if(points[0] < '2'){
                points[0]++;
            } else {
                points[0] = '0';
            }
        }
    }
}

void convertScore(unsigned char score){
    if (score < 10){
        if (score == 5){
            hScore[2] = '5';
        }
    } else {
        if (score % 2 != 0){
            hScore[2] = '5';
        }
        if (score < 100){
            hScore[0] = '0';
            hScore[1] = 48 + (score / 10);
        } else if (score < 200){
            hScore[1] = 48 + ((score / 10) - 10);
            hScore[0] = '1';
        } else {
            hScore[0] = '2';
        }
    }
}

void motorRX(void){
    static char info;
    
    if (PIR1bits.RCIF == 1){
        info = RCREG;
        if (info == 'A'){
            score += 5;
            updatePoints();
        } else if (info == 'B'){
            playing = 2;
            if (array == 1){
                if (users1[user].score < score){
                    users1[user].score = score;
                } else {
                    score = users1[user].score;
                }
            } else {
                if (users2[user].score < score){
                    users2[user].score = score;
                } else {
                    score = users2[user].score;
                }
            }
            convertScore(score);
            score = 0;
        }
    }
}

void motorTX(void){
    static char state = 0;
    
    switch (state){
        case 0:
            if (TX == 1 && enviaDada == 1){
                enviaDada = TX = 0;
                state = 1;
            }
            break;
        case 1:
            if (TXSTAbits.TRMT == 1){
                switch (message){
                    case 1:
                        if (posName < 10){
                            if (array == 1){
                                TXREG = users1[user].name[posName];
                            } else {
                                TXREG = users2[user].name[posName];
                            }
                            posName++;
                            selectMessage(1);
                        } else {
                            posName = 0;
                            message = 0;
                        }
                        break;
                    case 2:
                        sendMessage(AM);
                        break;
                    case 3:
                        sendMessage(UP);
                        break;
                    case 4:
                        sendMessage(DOWN);
                        break;
                    case 5:
                        sendMessage(LEFT);
                        break;
                    case 6:
                        sendMessage(RIGHT);
                        break;
                    default:
                        break;
                }
                state = 0;
            }
            break;
    }
}
