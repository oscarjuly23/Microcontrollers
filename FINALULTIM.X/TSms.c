 /*
  * File:   TSms.c
  * Author: Oscar & Oriol
  * 
  * FUNCIONAMENT:
  * 
  * 1. manageKeySMS     : Segons la Key que ens arriba determinem que fer. 
  * 2. manageLetter     : Comprovem si es la mateixa tecla premuda o diferent.
  * 3. manageRepeat     : Si es la mateixa controlem les repeticions per saber la lletra.
  * 4. --> ManageKey (Un cop sabem la lletra, la enviem al Central)
  */

/* Includes ------------------------------------------------------------------*/
#include "TSms.h"

/* Variables privades --------------------------------------------------------*/
static char timer;
unsigned char countChar, prevKey;
 unsigned char rep;
 
void initSMS(void) {
    timer = TiGetTimer();
    TiResetTics(timer);
    countChar = 0;
    prevKey = 10;
    rep = 0;
}

char manageRepeat(unsigned char rep, unsigned char max) {
    if (rep == max) {
        rep = 0;
    } else {
        rep++;
    }
    return rep;
}

//Funció que comprova si ens apreten la mateixa tecla o es una nova.
void manageLetter(unsigned char key, unsigned char prevKey) {
    if (key != '#' && key != '*') {
        if(key == prevKey){
            if (TiGetTics(timer) <= 4000){ // Durant 1s
                if (key == '7' || key == '9') {
                    // El cas '7' i '9' té 5 posibilitats, les demés 4.
                    rep = manageRepeat(rep, 4);
                } else {
                    rep = manageRepeat(rep, 3);
                }
            }else{
              countChar++;
              rep = 0; 
            }
        }else{
            countChar++;
            rep = 0;
        }
    }
}
//Segons la Key que ens arriba determinem que fer. (Es crida des de TECLAT)
void manageKeySMS(char key){
    if (countChar < 4) {
        //Segons la tecla que tinguem mirarem la lletra final i la enviarem a TCentral
        manageLetter(key, prevKey);
        switch (key) {
            case '0':
                manageKey(key0[rep], countChar, 20);
                break;
            case '1':
                manageKey(key1[rep], countChar, 2);
                break;
            case '2':
                manageKey(key2[rep], countChar, 3);
                break;
            case '3':
                manageKey(key3[rep], countChar, 4);
                break;
            case '4':
                manageKey(key4[rep], countChar, 5);
                break;
            case '5':
                manageKey(key5[rep], countChar, 6);
                break;
            case '6':
                manageKey(key6[rep], countChar, 7);
                break;
            case '7':
                manageKey(key7[rep], countChar, 8);
                break;
            case '8':
                manageKey(key8[rep], countChar, 10);
                break;
            case '9':
                manageKey(key9[rep], countChar, 12);
                break;
        }
        
        prevKey = key; // Guardem la tecla que tenim en una auxiliar
        TiResetTics(timer);
    }
        
    if (key == '*') {
        countChar = 0;
        prevKey = 10;
        manageKey(key, countChar, 15);
    } else if (key == '#') {
        manageKey(key, countChar, 22);
        if (countChar == 3) {
            initSMS();
        }
    }
    
    modifyHora(key);
}