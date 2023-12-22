/*
 * File:   TDisplay.c
 * Author: Oscar & Oriol
 * 
 * FUNCIONAMENT:
 * 1. motorMenu:    Segons la posició mostrarem unes opcions del menú o unes altres.
 * 2. showLCD:      Decideix quines dos cadenes es mostrarán a la pantalla.
 * 3. showMessage:  Fem LcPutChar() de cada caràcter de la cadena que li arriba.
 * 
 * printLetter:     Serveix per printar només una lletra (mode SMS)
 * changeMenuJoy:   Segons el joystick canviem de opcions a mostrar del menú.
 */

/* Includes ------------------------------------------------------------------*/
#include "TMenu.h"

/* Variables privades --------------------------------------------------------*/
static char timer, timer2;
unsigned char caseMenu, posJoystick, posLCD, n, empty;
unsigned char extraPos, posMax, posMin, posMin2, finalMarq, finalMarq2;
unsigned char showTime[MAX_LENGTH];
unsigned char num;

unsigned char END_MSG[23] = "bye bye    !";

/* Private functions ---------------------------------------------------------*/

void initMenu(void) {
    timer = TiGetTimer();
    TiResetTics(timer);
    timer2 = TiGetTimer();
    TiResetTics(timer2);
    posLCD = posJoystick = caseMenu = n = num = empty = 0;
    extraPos = posMin = posMin2 = finalMarq = finalMarq2 = 0;
    showTime[2] = ':';
    showTime[0] = showTime[1] = showTime[3] = showTime[4]= '0';
    posMax = MAX_LENGTH;
    LcCursorOn();
    cleanMarquesina();
    
}

void writeName(unsigned char* towerName){
    END_MSG[8] = towerName[0];
    END_MSG[9] = towerName[1];
    END_MSG[10] = towerName[2];
}


void updateHora(unsigned char pos, unsigned char hora, unsigned char mod) {
    showTime[pos] = hora;
    if  (mod) {
        actHora(pos, hora);
    }
}

void emptyRec(void){
    empty = 1;
}

void changeMenu(unsigned char mode) {
    cleanMarquesina();
    n = 0;
    TiResetTics(timer2);
    caseMenu = mode;
}

// Neteja cadena del PortName (ES CRIDA DES DE CENTRAL)
void cleanPortName() {
    LcGotoXY(0, 1);
    LcPutChar(' ');
    LcGotoXY(1, 1);
    LcPutChar(' ');
    LcGotoXY(2, 1);
    LcPutChar(' ');
    LcGotoXY(0, 1);
}

// Printa cada lletra a la pantalla LCD. (ES CRIDA DES DE CENTRAL)
void printLetter(unsigned char finalKey, unsigned char posY){
    LcGotoXY(posY - 1, 1);
    LcPutChar(finalKey);
}

// Mostrem les dos cadenas en les dues files de la pantalla.
void showLCD(const char * message1, const char * message2) {
//void showLCD(unsigned char message1[], unsigned char message2[]) {
    if ((message1[SIZE_LCD] == '\0') && (message2[SIZE_LCD] == '\0')) {
        if (posLCD < SIZE_LCD) {
            LcGotoXY(posLCD, 0);
            LcPutChar((message1[posLCD] != '\0') ? message1[posLCD] : ' ');
            LcGotoXY(posLCD, 1);
            LcPutChar((message2[posLCD] != '\0') ? message2[posLCD] : ' ');
            posLCD++;  
        } else {
            if (caseMenu == 5) {
                posLCD = 0;
            }
        }
    }
}

void showLCD_Records(const char *message11, const char *message12, const char * message21, const char * message22){
//void showLCD_Records(unsigned char message11[], unsigned char message12[], unsigned char message21[], unsigned char message22[]){
    if (posLCD < SIZE_LCD) {
        if(posLCD < 3){
            LcGotoXY(posLCD, 0);
            LcPutChar(message11[posLCD]);
        }else if(posLCD == 3){
            LcGotoXY(posLCD, 0);
            LcPutChar(' ');
        }else if(posLCD == 4){
            LcGotoXY(posLCD, 0);
            LcPutChar('-');
        }else if(posLCD == 5){
            LcGotoXY(posLCD, 0);
            LcPutChar(' ');
        }else if(posLCD < 11){
            LcGotoXY(posLCD, 0);
            LcPutChar(message12[posLCD - 6]);
        }else{
            LcGotoXY(posLCD, 0);
            LcPutChar(' ');
        }
        if(message21[0] == 'I'){
            if(posLCD < 3){
                LcGotoXY(posLCD, 1);
                LcPutChar(message21[posLCD]);
            }else if(posLCD == 3){
                LcGotoXY(posLCD, 1);
                LcPutChar(' ');
            }else if(posLCD == 4){
                LcGotoXY(posLCD, 1);
                LcPutChar('-');
            }else if(posLCD == 5){
                LcGotoXY(posLCD, 1);
                LcPutChar(' ');
            }else if(posLCD < 11){
                LcGotoXY(posLCD, 1);
                LcPutChar(message22[posLCD - 6]);
            }else{
                LcGotoXY(posLCD, 1);
                LcPutChar(' ');
            }
        }
        posLCD++; 
    }
}
    

// Mostrem les dos cadenas en les dues files de la pantalla en format Marquiesina.
//void showLCD_Marq(unsigned char message1[], unsigned char message2[]) {
void showLCD_Marq(const char *message1, const char *message2) {

    if (TiGetTics(timer) >= 252){
        // Mostrarem una cadena de 16 caracters per el LCD
        if(posLCD < SIZE_LCD){
            // Ens col·loquem en la posició que toca.
            LcGotoXY(posLCD, 0);
            // Fins que no arribem al final del missatge l'anem mostrant de manera normal
            if(message1[posLCD + extraPos] != '\0' && !finalMarq){
                LcPutChar(message1[posLCD + extraPos]);
            } else{
                
                if  (!finalMarq) {
                    finalMarq = 1;
                    LcPutChar(' ');
                }

                // Un cop hem acabat de mostrar el missatge utilitzem una variable auxiliar
                if  (posLCD < posMax){
                    // Per una part mostrarem el 'final' del missatge anterior
                    LcPutChar(message1[posLCD + extraPos]);
                } else {
                    // Per altra banda començarem a mostrar el missatge per principi (marquesina)
                    LcPutChar(message1[posMin]);
                    posMin++;
                }
            }

            // El mateix per al missatge de la segona fila
            LcGotoXY(posLCD, 1);
            if(message2[posLCD + extraPos] != '\0' && !finalMarq2){
                LcPutChar(message2[posLCD + extraPos]);
            } else{
                if  (!finalMarq2) {
                    finalMarq2 = 1;
                    LcPutChar(' ');
                }
                if  (posLCD < posMax){
                    LcPutChar(message2[posLCD + extraPos]);
                } else {
                    LcPutChar(message2[posMin2]);
                    posMin2++;
                }
            }
            
            // Un cop hem mostrat tota la cadena sencera reiniciem la variable de les posicions extras
            if  (extraPos+1 == MAX_LENGTH) {
                extraPos = 0;
                posMax = MAX_LENGTH;
            }
            
            posLCD++;
        // Un com hem mostrat els primers 16 caràcters, sumem una posició extra per a llegir
        // els següents caràcters de l'array del missatge.
        } else {
            extraPos++;
            // Ademés de sumar una posició extra reiniciem les variables per mostrar els 16 primers.
            posLCD = posMin = posMin2 = finalMarq = finalMarq2 = 0;
            // També canviem la variable que ha de mostrar el 'final' de la cadena (marquesina)
            posMax--;            
        }
        TiResetTics(timer);
    }   
}

// Reinicia variables Marquesina
void cleanMarquesina() {
    LcClear();
   posLCD = extraPos = posMin = posMin2 = finalMarq = finalMarq2 = 0;
   posMax = MAX_LENGTH;
}

void changeJoystick(unsigned char pos) {
    if (caseMenu == 1) {
        posJoystick = pos;
    } else if (caseMenu == 3) {
        n = pos;
    }
}

// Controla missatges a mostrar per a la pantalla LCD del menú.
void motorMenu(void) {
    switch(caseMenu){
        case 0: /* PORT NAME */
            showLCD(MENU1_LOG, NOTHING2);
            break;
        case 1: /* MENU PRINCIPAL */  
            switch(posJoystick){
                case 0: /* OPT1 & OPT2 */
                    showLCD_Marq(MENU2_START, MENU2_PLAY);
                    break;
                case 1: /* OPT2 & OPT3 */
                    showLCD_Marq(MENU2_PLAY, MENU2_MODIFY);
                    break;
                case 2: /* OPT3 & OPT4 */
                    showLCD_Marq(MENU2_MODIFY, MENU2_TIME);
                    break;
                case 3: /* OPT4 & OPT5 */
                    showLCD_Marq(MENU2_TIME, MENU2_END);
                    break;
                case 4: /* OPT5 */
                    showLCD_Marq(MENU2_END, NOTHING);
                    break;
                }
                break;
        case 2: /* START RECORDING */
            showLCD(SHOW_RECORDING, NOTHING2);
            break;
        case 3: /* PLAY RECORDINGS */
            if(empty == 0){
                showLCD(EMPTY, EMPTY2);
            }else{
              if  (n == 7) {
                  showLCD_Records(recordings[n].index, recordings[n].timestmp, "        ", "        ");
              } else {
                  showLCD_Records(recordings[n].index, recordings[n].timestmp, recordings[n+1].index, recordings[n+1].timestmp);
              }  
            }
            break;
        case 4: /* MODIFY CURRENT TIME */
            showLCD(SHOW_MODY_TIME, "");
            break;
        case 5: /* SHOW CURRENT TIME */
            showLCD(SHOW_CURR_TIME, showTime);
            break;
        case 6: /* END COMUNICATION */
            showLCD(END_MSG, NOTHING2);
            if  (TiGetTics(timer2) >= 8000) {
                cleanMarquesina();
                showTime[0] = showTime[1] = showTime[3] = showTime[4]= '0';
                caseMenu = 0;
            }
            break;
            
    }
}