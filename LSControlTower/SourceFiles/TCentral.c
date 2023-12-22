/*
 * File:   TCentral.c
 * Author: Oscar & Oriol
 */

/* Includes ------------------------------------------------------------------*/
#include "TCentral.h"   

/* Variables privades --------------------------------------------------------*/
unsigned char portName[4], count, mode, posJoystick, n, recording, p;
unsigned char time[5], t[5];

/* Private functions ---------------------------------------------------------*/

void initCentral(void){
    count = mode = posJoystick = n = recording = 0;
    time[2] = ':';
    time[0] = time[1] = time[3] = time[4]= '0';
    time[5] = '\0';
    p = getPT();
    if(p){
        emptyRec();
    }
    
}

void saveLetter(unsigned char key, unsigned char countChar){
    portName[countChar-1] = key;
}

void newHora(unsigned char pos, unsigned char hora, unsigned char mod) {
    time[pos] = hora;
    updateHora(pos, hora, mod);
}

void modifyHora(unsigned char num) {
    LcGotoXY(0,1);
    if (mode == 4) {
        if (num != '*' && num != '#') {
            if (count+1 < 6) {
                t[count] = num;
                printLetter(num, count+1);
                if  (count+1 == 2) {
                    count++;
                    printLetter(':', count+1);
                }
                count++;
            }
        } else if (num == '#' && count+1 == 6) {
            newHora(0, t[0], 1);
            newHora(1, t[1], 1);
            newHora(3, t[3], 1);
            newHora(4, t[4], 1);

            changeMode(1);         
            count = 0;
        }
    }
}

//Depenen de la opció on estigguem anirem a una opció o una altre.
void enterMode(void) {
    switch(posJoystick){
        case 0: /* START RECORDING  */
            enviaDada(1, &time);
            recording = 1;
            activaRecording();
            changeMode(2);
            emptyRec();
            break;
        case 1: /* PLAY RECORDINGS  */
            n = 0;
            changeMode(3);
            break;
        case 2: /* MODIFY CURRENT TIME  */
            changeMode(4);
            break;
        case 3: /* SHOW CURRENT TIME  */
            changeMode(5);
            break;
        case 4: /* END COMUNICATION */
            changeMode(6);
            initCentral();
            initSound();
            initSIO();
            break;
    }
}

//Un cop tenim la Key podem printar-la per pantalla (Es crida des de SMS).
void manageKey(unsigned char key, unsigned char countChar, unsigned char note) {
    pressSound(note);    
    
    if (countChar == 3) {
    }
    
    if (key == '*') {
        // En el cas de l'asterisc, depen si volem reiniciar el portName o tornar al menú
        if (mode == 0) {
            cleanPortName();
        } else if (mode > 2) {
            changeMode(1);
            count = 0;
        }
        
    } else if (key == '#') {
        // Comprovem que ja tenim el portName i canviem de menú.
        if ((countChar == 3 || countChar == 4) && mode == 0) {
            enviaDada(0, &portName); // Enviem una 'T' a la interfície Java (TSIO)
            writeName(&portName);
            initHora();
        } else  if (mode == 1) {
            enterMode(); // Entrem al mode que pertoca
        } else if (mode == 3) {
            selectSound(n);
        }
        
    } else {
        if (mode == 0 && countChar < 4) {
            saveLetter(key, countChar);
            printLetter(key, countChar); // --> TMenu: print en el LCD
        }
    }
}

//Quan detectem un moviment al JoysTick l'enviem al Menú. (Es crida desde ADC)
void changePos(unsigned char pos){
    unsigned char num, num2;
    if (mode == 1) {
    // Si arribem a la última posició o la primera no podrem baixar/pujar més.
        if ((posJoystick < 4) && (pos == 1)) {
            posJoystick++;
            cleanMarquesina();
        } else if ((posJoystick > 0) && (pos == 2)){
            posJoystick--;
            cleanMarquesina();
        }
        changeJoystick(posJoystick);
    
    } else if (mode == 3) {
        num2 = getPT();
        if (num2 < 8){
            num = getNT();
            if ((n < num - 1) && (pos == 1)) {
                n++;
                cleanMarquesina();
            } else if ((n > 0) && (pos == 2)){
                n--;
                cleanMarquesina();
            }  
        } else {
            if ((n < 7) && (pos == 1)) {
                n++;
                cleanMarquesina();
            } else if ((n > 0) && (pos == 2)){
                n--;
                cleanMarquesina();
            } 
        }
        changeJoystick(n);
    }         
}

void sendSound(unsigned char sound) {
    if (recording) {
        enviaMostra(sound);
    }
}

void changeMode(unsigned char u) {
    mode = u;
    changeMenu(u);
    setMode(u);
}