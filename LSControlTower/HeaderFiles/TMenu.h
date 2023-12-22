/*
 * File:   TDisplay.h
 * Author: Oscar & Oriol
 */

#ifndef TDISPLAY_H
#define	TDISPLAY_H

/* Includes ------------------------------------------------------------------*/
#include <xc.h> // include processor files - each processor file is guarded.
#include "LcTLCD.h"
#include "TiTTimer.h"
#include "THora.h"

#define MAX_LENGTH      23
#define SIZE_LCD        16

/* Constants -----------------------------------------------------------------*/
const unsigned char MENU1_LOG       [MAX_LENGTH]    = {"PORT NAME:"};
const unsigned char MENU2_START     [MAX_LENGTH]    = {"1. START RECORDING    "};
const unsigned char MENU2_PLAY      [MAX_LENGTH]    = {"2. PLAY RECORDINGS    "};
const unsigned char MENU2_MODIFY    [MAX_LENGTH]    = {"3. MODIFY CURRENT TIME"};
const unsigned char MENU2_TIME      [MAX_LENGTH]    = {"4. SHOW CURRENT TIME  "};
const unsigned char MENU2_END       [MAX_LENGTH]    = {"5. END COMUNICATION   "};
const unsigned char NOTHING         [MAX_LENGTH]    = {"                      "};
const unsigned char NOTHING2        [MAX_LENGTH]    = {""};
const unsigned char EMPTY           [MAX_LENGTH]    = {"EMPTY RECORDINGS"};
const unsigned char EMPTY2          [MAX_LENGTH]    = {"DO A RECORD!"};

const unsigned char SHOW_RECORDING  [MAX_LENGTH]    = {"RECORDING..."};
const unsigned char SHOW_PLAYING    [MAX_LENGTH]    = {"PLAYING..."};

const unsigned char SHOW_MODY_TIME  [MAX_LENGTH]    = {"MODIFY TIME:"};
const unsigned char SHOW_CURR_TIME  [MAX_LENGTH]    = {"CURRENT TIME:"};

const unsigned char SHOW_END        [MAX_LENGTH]    = {"bye bye    !"};

typedef struct{
    unsigned char index[4];
    unsigned char timestmp[6];
}Recording;

Recording recordings[8];

/* Variables -----------------------------------------------------------------*/

/* Private function prototypes -----------------------------------------------*/
void initMenu(void);
void motorMenu(void);
void cleanPortName(void);
void printLetter(unsigned char finalKey, unsigned char posY);
void cleanMarquesina(void);
void changeMenu(unsigned char mode);
void updateHora(unsigned char pos, unsigned char hora, unsigned char mod);
void changeJoystick(unsigned char pos);
void writeName(unsigned char* towerName);
void saveLetter(unsigned char key, unsigned char countChar);
void emptyRec(void);

//Precondicions: ?
//Postcondicions: ?

#endif /* TDISPLAY_H */