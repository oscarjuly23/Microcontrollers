/*
 * File:   TMenu.h
 * Author: Oscar Julian & Raúl Pérez
 */

#ifndef TMENU_H
#define	TMENU_H

#include <xc.h> 
#include "LcTLCD.h"
#include "TUsers.h"
#include "TSIO.h"

#define MAX_LENGTH      20
#define SIZE_LCD        16
#define SIZE_ARROW       3
#define SIZE_HORA        5

const unsigned char ARROW[SIZE_ARROW]   = {'-','>',' '};
const unsigned char OPTION1[MAX_LENGTH] = {"1. New Game"};
const unsigned char OPTION2[MAX_LENGTH] = {"2. Show top 5 scores"};
const unsigned char OPTION3[MAX_LENGTH] = {"3. Show users"};
const unsigned char OPTION4[MAX_LENGTH] = {"4. Modify users"};
const unsigned char OPTION5[MAX_LENGTH] = {"5. Show time"};
const unsigned char OPTION6[MAX_LENGTH] = {"6. Modify time"};

const unsigned char SELECT_USER[MAX_LENGTH]     = {"1. Select User"};
const unsigned char NEW_USER[MAX_LENGTH]        = {"2. New User"};
const unsigned char EDIT_NAME[MAX_LENGTH]       = {"Edit Name"};
const unsigned char DELETE_USER[MAX_LENGTH]     = {"Delete User"};
const unsigned char ENTER_NAME[MAX_LENGTH]      = {"Enter Name:"};
const unsigned char ENTER_NEW_NAME[MAX_LENGTH]  = {"Enter New Name"};
const unsigned char SHOW_TIME[MAX_LENGTH]       = {"Current Time"};
const unsigned char ENTER_NEWTIME[MAX_LENGTH]   = {"Enter New Time"};
const unsigned char TIME[MAX_LENGTH]            = {"(HH:MM):"};
const unsigned char SCORE[MAX_LENGTH]           = {"Score: "};
unsigned char HIGH_SCORE[MAX_LENGTH]      = {"High score: "};
const unsigned char INFO_GAME[MAX_LENGTH]       = {"T       | S "};

unsigned char pos, subMenu;
unsigned char mGame, mModUSelect, mModUEdit;
unsigned char time[SIZE_HORA], timeAM[SIZE_HORA];
unsigned char showHora, showAM;

void initMenu(void);
void resetMenu(void);
void printLetter(unsigned char key, unsigned char numChars);
void motorMenu(void);

#endif