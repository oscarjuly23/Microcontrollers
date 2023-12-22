/*
 * File:   TUsers.h
 * Author: Oscar Julian & Raúl Pérez
 */

#ifndef _TUSERS_H_
#define	_TUSERS_H_

#include <xc.h>

#define MAXNAME  10
#define MAXUSERS 20

typedef struct{
    unsigned char name[MAXNAME];
    unsigned char score;
}User;

User users1[10];
User users2[10];
unsigned char numUsers, user, array;

void initUsers(void);
void selectUser(unsigned char pos);
void writeName(unsigned char key, unsigned char numChars);
void deleteUser(void);
void orderUsers(User *users, unsigned char offset, unsigned char extra);

#endif