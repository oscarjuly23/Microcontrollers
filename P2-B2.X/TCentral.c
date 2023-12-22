/*
 * File:   TCentral.c
 * Author: Oscar Julian & Raúl Pérez
 */

#include "TCentral.h"

void initCentral(void){
    modeSMS = 0;
}

void selectOption(unsigned char min, unsigned char max, unsigned char option){
    if (option == 1){
        if (pos == min){
            pos = max;
        } else {
            pos--;
        }    
    } else {
        if (pos == max){
            pos = min;
        } else {
            pos++;
        }
    }
    resetMenu();
}

void reset(){
    subMenu = modeSMS = mGame = mModUSelect = mModUEdit = showAM = playing = 0;
}

void actionsSubMenus(unsigned char key, unsigned char numChars){
    static unsigned char posTime = 0;
    
    if (subMenu == 1){
        if (mGame == 2){
            modeSMS = 1;
            if (key != '*' && key != '#'){
                printLetter(key, numChars);
                writeName(key, numChars);
            }
        }
    } else if (subMenu == 6){
        if (key != '*'){
            timeAM[posTime] = key;
            printLetter(key, posTime + 8);
            posTime++;
            if (posTime == 2){
                timeAM[posTime] = ':';
                printLetter(':', posTime + 8);
                posTime++;
            }
        } else {
            posTime = 0;
        }
    }
}

void manageKey(unsigned char key, unsigned char numChars) {
    switch(key){
        case '2':
            if (subMenu == 0 && playing == 0){
                selectOption(1, 6, 1);
            } else if (subMenu == 1 || subMenu == 4) {
                if ((subMenu == 1 && mGame == 0) || (subMenu == 4 && mModUSelect == 1)){
                    selectOption(1, 2, 1);
                } else if ((subMenu == 1 && mGame == 1) || (subMenu == 4 && mModUSelect == 0)) {
                    selectOption(1, numUsers, 1);
                    selectUser(pos - 1);
                }
            } else if (playing == 1){
                selectMessage(3);
            }
            break;
        case '4':
            if (playing == 1){
                selectMessage(5);
            }
            break;
        case '6':
            if (playing == 1){
                selectMessage(6);
            }
            break;
        case '8':
            if (subMenu == 0 && playing == 0){
                selectOption(1, 6, 2);
            } else if (subMenu == 1 || subMenu == 4) {
                if ((subMenu == 1 && mGame == 0) || (subMenu == 4 && mModUSelect == 1)){
                    selectOption(1, 2, 2);
                } else if ((subMenu == 1 && mGame == 1) || (subMenu == 4 && mModUSelect == 0)){
                    selectOption(1, numUsers, 2);
                    selectUser(pos - 1);
                }
            } else if (playing == 1){
                selectMessage(4);
            }
            break;
        case '9':
            break;
        case '*':
            if (subMenu == 0 && playing == 0){
                subMenu = pos;
                if (subMenu == 2){
                    orderUsers(users1, 5, 1);
                    orderUsers(users2, 0, 0);
                }
            } else if (subMenu == 1){
                if (mGame == 0){
                    if (mGame == 0){
                        mGame = pos;
                    }
                    if (mGame == 1){
                        selectUser(pos - 1);
                    } else if (mGame == 2){
                        selectUser(numUsers);
                    }
                } else if (mGame == 1){
                    selectUser(pos - 1);
                    reset();
                    selectMessage(1);
                    playing = 1;
                    points[0] = points[1] = points[2] = hScore[0] = hScore[1] = hScore[2] = '0';
                    initAM();
                    resetADC();
                } else if (mGame == 2){
                    if(mModUEdit == 0){
                        numUsers++;
                    }
                    reset();
                }
            } else if (subMenu == 4){
                if (mModUSelect == 0){
                    mModUSelect = 1;
                    selectUser(pos - 1);
                } else {
                    if (mModUEdit == 0){
                        if (mModUEdit == 0){
                            mModUEdit = pos;
                        }
                        if (mModUEdit == 1){
                            subMenu = 1;
                            mGame = 2;
                        }
                        if (mModUEdit == 2){
                            deleteUser();
                            numUsers--;
                            reset();
                        }
                    }
                }
            } else if (subMenu == 6){
                for (int i = 0; i < SIZE_HORA; i++){
                    time[i] = timeAM[i];
                }
                showHora = 1;
                resetHora();
                reset();
            }
            pos = 1;
            resetMenu();
            break;
        case '#':
            pos = 1;
            playing = 0;
            reset();
            resetMenu();
            break;
        default:
            break;
    }
    actionsSubMenus(key, numChars);
}
