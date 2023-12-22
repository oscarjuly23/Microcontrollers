/*
 * File:   TUsers.c
 * Author: Oscar Julian & Raúl Pérez
 */

#include "TUsers.h"

unsigned char name, scoreUser;

void initUsers(void) {
    numUsers = user = scoreUser = 0; 
    array = 1;
    for (int i = 0; i < 10; i++){
        for (int j = 0; j < MAXNAME; j++){
            users1[i].name[j] = '\0';
            users2[i].name[j] = '\0';
        }
        users1[i].score = 0;
        users2[i].score = 0;
    }
}

void selectUser(unsigned char pos){
    if (pos != 0){
        if (pos % 2 != 0){
            array = 2;
            user = ((pos + 1) >> 1) - 1;
        } else {
            array = 1;
            user = pos >> 1;
        }
    } else {
        array = 1;
        user = pos;
    }
}

void writeName(unsigned char key, unsigned char numChars){
    if (array == 1){
        users1[user].name[numChars] = key;
    } else {
        users2[user].name[numChars] = key;
    }
}

void changeUser(User *users, unsigned char numUsersAux){
        if (array == 1) {
            for (int i = 0; i < MAXNAME; i++){
                users1[user].name[i] = users[numUsersAux].name[i];
                users[numUsersAux].name[i] = '\0';
            }
            users1[user].score = users[numUsersAux].score;
        } else {
            for (int i = 0; i < MAXNAME; i++){
                users2[user].name[i] = users2[numUsersAux].name[i];
                users2[numUsersAux].name[i] = '\0';
            }
            users2[user].score = users[numUsersAux].score;        
        }
        users[numUsersAux].score = 0;
}

void deleteUser(void){
    static unsigned char numUsersAux = 0;
    if ((numUsers - 1) % 2 != 0 && (numUsers - 1) != 0){
        numUsersAux = ((numUsers) >> 1) - 1;
        changeUser(users2, numUsersAux);
    } else {
        numUsersAux = ((numUsers - 1) >> 1);
        changeUser(users1, numUsersAux);
    }
}

void orderUsers(User *users, unsigned char offset, unsigned char extra){
    for (int i = offset; i < 9 + extra; i++){
        for(int j = 0; j < 5; j++){
            if (users[i].score > users1[j].score){
                for(int k = 0; k < MAXNAME; k++){
                    name = users1[j].name[k];
                    users1[j].name[k] = users[i].name[k];
                    users[i].name[k] = name;
                }
                scoreUser = users1[j].score;
                users1[j].score = users[i].score;
                users[i].score = scoreUser;
                i = 0;
                break; 
            }
        }
    }
}