/*
 * File:   TMenu.c
 * Author: Oscar Julian & Raúl Pérez
 */


#include "TMenu.h"

static char timer;
unsigned char isPrinted, posLCD, arrow, posLCDAux, posScore, first, second;
unsigned char posMarkesine, sumand, usersPrinted, times;

void initMenu(void) {
    timer = TiGetTimer();
    TiResetTics(timer);
    isPrinted = posLCD = arrow = posLCDAux = posScore = 0;
    subMenu = mGame = mModUSelect = mModUEdit = times = 0;
    pos = 1;
    time[0] = time[1] = time[3] = time[4]= '0';
    time[2] = timeAM[2] = ':';
    timeAM[0] = timeAM[1] = timeAM[3] = timeAM[4]= '0';
    showHora = showAM = 1;
    first = second = 0;
    posMarkesine = sumand = usersPrinted = 0;
}

void resetMenu(void){
    LcClear();
    LcCursorOff();
    isPrinted = posLCD = arrow = posLCDAux = 0;
    posMarkesine = sumand = usersPrinted = 0;
    if (subMenu == 1 && playing == 0){
        if (mGame == 1){
            posLCD = 3;
        } else if (mGame == 2){
            LcCursorOn();
            arrow = 1;
        }
    } else if (subMenu == 5){
        arrow = 1;
        showHora = 1;
    } else if (subMenu == 6 || subMenu == 2 || subMenu == 3){
        arrow = 1;
    } else if (playing == 1){
        arrow = 1;
        showAM = 1;    
    } else if (playing == 2){
        arrow = 1;
    } else if (subMenu == 0){
        first = 0;
    }
}

void printLetter(unsigned char key, unsigned char numChars){
    if (playing == 2 && second == 0){
        LcGotoXY(numChars, 0);
    } else {
        LcGotoXY(numChars, 1);
    }
    LcPutChar(key);
}

void showMessage(unsigned char message[]){
    if (((subMenu == 1 && mGame == 1) || subMenu == 4) && playing == 0){
        if (message[posLCD - 3] != '\0' && (posLCD - 3) < MAXNAME){
            LcPutChar(message[posLCD - 3]);
        } else {
            LcPutChar(' ');
        }    
    } else {
        if (message[posLCD] != '\0'){
            LcPutChar(message[posLCD]);
        } else {
            LcPutChar(' ');
        }
    }
}

void printOptions(unsigned char message1[], unsigned char message2[]){
    if (posLCD < SIZE_LCD){
        if (isPrinted == 0){
            LcGotoXY(posLCD, 0);
            if ((playing == 1 && posLCD > 9) || ((subMenu == 2 || subMenu == 3) && posLCD > 10)){
                LcPutChar(' ');
            } else {
                showMessage(message1);
            }
            LcGotoXY(posLCD, 1);
            if ((subMenu == 5 && posLCD > SIZE_HORA - 1) || (subMenu == 3 && posLCD > 10)){
                LcPutChar(' ');
            } else {
                showMessage(message2);
            }
            posLCD++;
        }
    } else if (isPrinted == 0){
        isPrinted = 1;
        posLCD = 0;
    }
    
    if (showAM == 1 && playing == 1){
        if (posLCDAux < SIZE_HORA){
            printLetter(timeAM[posLCDAux], posLCDAux + 2);
            posLCDAux++;
        } else {
            posLCDAux = 0;
        }
    }
    
    if (playing == 1){
        if (posScore < 3){
            printLetter(points[posScore], posScore + 12);
            posScore++;
        } else {
            posScore = 0;
        }
    }
}

void toMarkesination(unsigned char message1[], unsigned char message2[], unsigned char limit, unsigned char refresh){ 
    if (isPrinted == 0){
        convertScore(users1[0].score);
        HIGH_SCORE[12] = hScore[0]; 
        HIGH_SCORE[13] = hScore[1];
        HIGH_SCORE[14] = hScore[2];
        printOptions(message1, message2);
        if (isPrinted == 1){
            posMarkesine = refresh;
        }
    } else {
        if (TiGetTics(timer) >= 63){
            if(posMarkesine < SIZE_LCD){
                if (subMenu == 3 || subMenu == 2){
                    LcGotoXY(posMarkesine, 0);
                    if (message1[posMarkesine + sumand] != '\0' ) {
                        if (subMenu == 3){
                            LcPutChar(message1[posMarkesine + sumand]);
                        } else if ((posMarkesine + sumand) <= MAXNAME){
                            LcPutChar(users1[times].name[posMarkesine + sumand]);
                        }
                        LcPutChar(' ');
                    } else {
                        LcPutChar(' ');
                    }           
                }
                LcGotoXY(posMarkesine, 1);
                if (message2[posMarkesine + sumand] != '\0' && subMenu != 2){
                    LcPutChar(message2[posMarkesine + sumand]);
                    LcPutChar(' ');
                } else if (posMarkesine + sumand < 15 && subMenu == 2){
                    LcPutChar(HIGH_SCORE[posMarkesine + sumand]);    
                } else {
                    LcPutChar(' ');
                    if(posMarkesine + sumand == 17){
                        times++;
                        convertScore(users1[times].score);
                        HIGH_SCORE[12] = hScore[0]; 
                        HIGH_SCORE[13] = hScore[1];
                        HIGH_SCORE[14] = hScore[2];
                    }
                }
                posMarkesine++;
            } else {
                if (sumand == (limit - SIZE_LCD)){
                    sumand = 0;
                } else {
                    sumand++;
                }
                posMarkesine = refresh;
            }
            TiResetTics(timer);
        }
    }
}

void showArrow(unsigned char message[], unsigned char column, unsigned char row){
    if ((subMenu == 1 && mGame == 1) || subMenu == 4){
        LcGotoXY(posLCD, 0);
        LcPutChar(' ');
        LcGotoXY(posLCD, 1);
        LcPutChar(' ');
    } else {
        LcGotoXY(column,row);
        LcPutChar(message[posLCD]); 
    }
}

void showLCD(unsigned char message1[], unsigned char message2[]){
    if ((message1[SIZE_LCD] == '\0' && message2[SIZE_LCD] == '\0' && subMenu != 3 && subMenu != 2) || playing == 1 || subMenu == 5) {
        printOptions(message1, message2);
    } else if (subMenu == 0){
        toMarkesination(message1, message2, MAX_LENGTH, 3);
    } else if (subMenu == 2){
        toMarkesination(users1[0].name, HIGH_SCORE, 31, 0);
    } else if (subMenu == 3){
         toMarkesination(users1[0].name, users2[0].name, ((MAX_LENGTH - 3) * ((numUsers >> 1) + 1)), 0);
    }
    if (isPrinted == 1 && arrow == 0){
        if (pos % 2 != 0 && posLCD == 0){
            showArrow(message2, 0, 1);
            LcGotoXY(0,0);
        } else if (pos%2 != 0 && posLCD == 1){
            showArrow(message2, 1, 1);
            LcGotoXY(1,0);
        } else if (pos%2 == 0 && posLCD == 0) {
            showArrow(message1, 0, 0);
            LcGotoXY(0,1);
        } else if (pos%2 == 0 && posLCD == 1){
            showArrow(message1, 1, 0);
            LcGotoXY(1,1);
        } 
        if (posLCD < SIZE_ARROW){
            LcPutChar(ARROW[posLCD]);
            posLCD++;
        } else {
            arrow = 1;
        }
    }
    
}

void motorMenu(void) {
    if(subMenu == 0 && playing == 0) {
        if (pos == 1 || pos == 2){
            showLCD(OPTION1, OPTION2);
        } else if (pos == 3 || pos == 4){
            showLCD(OPTION3, OPTION4);
        } else {
            showLCD(OPTION5, OPTION6);
        }
    } else if (subMenu == 1 || subMenu == 4){
        if (subMenu == 1 && mGame == 0){
            showLCD(SELECT_USER, NEW_USER);
        } else if (subMenu == 1 && mGame == 2){
            if (mModUEdit == 0){
                showLCD(ENTER_NAME, "");
            } else {
                showLCD(ENTER_NEW_NAME, "");
            }
        } else if ((subMenu == 1 && mGame == 1) || subMenu == 4){
            if (subMenu == 4 && mModUSelect == 1 && mModUEdit == 0){
                showLCD(EDIT_NAME, DELETE_USER);
            } else {
                showLCD(users1[user].name, users2[user].name);
            }
        }
    } else if (subMenu == 2){
        showLCD("", "");
    } else if (subMenu == 3){
        showLCD("", "");
    } else if (subMenu == 5){
        if (showHora == 1){
            showLCD(SHOW_TIME, time);
        }
    } else if (subMenu == 6){
        showLCD(ENTER_NEWTIME, TIME);
    } else if (playing == 1){
        if (array == 1){
            showLCD(users1[user].name, INFO_GAME);
        } else {
            showLCD(users2[user].name, INFO_GAME);
        }
    } else if (playing == 2){
        if (first == 0){
            resetMenu();
            first = 1;
        } else {
            showLCD(SCORE, HIGH_SCORE);
            if (posScore < 3) {
                printLetter(points[posScore], posScore + 7);
                second = 1;
                printLetter(hScore[posScore], posScore + 12);
                second = 0;
                posScore++;
            } else {
                posScore = 0;
            }
        }
    }
}