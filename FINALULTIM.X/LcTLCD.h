/*
 * File:   LcTLCD.h
 * Author: Oscar & Oriol
 */

#ifndef LCTLCD_H
#define	LCTLCD_H

#include <xc.h>
#include "TiTTimer.h"

#define SetD4_D7Sortida()		   (TRISCbits.RC0 = TRISCbits.RC1 = TRISCbits.RC2 = TRISCbits.RC3 = 0)
#define SetD4_D7Entrada()		   (TRISCbits.RC0 = TRISCbits.RC1 = TRISCbits.RC2 = TRISCbits.RC3 = 1)
#define SetControlsSortida()       (TRISBbits.RB3 = TRISBbits.RB4 = TRISBbits.RB5 = 0)
#define SetD4(On)				       (LATCbits.LATC3 = (On))
#define SetD5(On)				       (LATCbits.LATC2 = (On))
#define SetD6(On)				       (LATCbits.LATC1 = (On))
#define SetD7(On)				       (LATCbits.LATC0 = (On))
#define GetBusyFlag()                  (PORTCbits.RC1)
#define RSUp()					       (LATBbits.LATB3 = 1)
#define RSDown()				       (LATBbits.LATB3 = 0)
#define RWUp()					       (LATBbits.LATB4 = 1)
#define RWDown()				       (LATBbits.LATB4 = 0)
#define EnableUp()                     (LATBbits.LATB5 = 1)
#define EnableDown()                   (LATBbits.LATB5 = 0)
// -------------------------------END--HARDWARE---AREA--------------------


void LcInit(char rows, char columns);
// Pre: Rows = {1, 2, 4}  Columns = {8, 16, 20, 24, 32, 40 }
// Pre: There is a free timer
// Pre: It needs 40ms of tranquility between the VCC raising and this constructor being called.
// Post: This routine can last up to 100ms
// Post: The display remains cleared, the cursor turned off and at the position 0, 0.

void LcEnd(void);
// The destructor

void LcClear(void);
// Post: Clears the display and sets the cursor to its previous state.
// Post: The next order can last up to 1.6ms.

void LcCursorOn(void);
// Post: Turn on the cursor
// Post: The next order can last up to 40us.

void LcCursorOff(void);
// Post: Turns off the cursor
// Post: The next order can last up to 40us.

void LcGotoXY(char Column, char Row);
// Pre : Column between 0 and 39, row between 0 and 3.
// Post: Sets the cursor to those coordinates.
// Post: The next order can last up to 40us.

void LcPutChar(char c);
// Post: Paints the char in the actual cursor position and increments
// its position. If the column gets to 39 it returns to 0.
// The row of the LCD is increased when this happens until the second
// row and then it is reset back to row 0 if it has 2 rows total.
// If the LCD has 4 rows it will reset back to row 0 when it
// reaches row 4 and the columns will go till 39 before reseting to 0.
// The one row LCDs returns to 0 when a column gets to 39.
// The row is never increased.
	// The char is written

void LcPutString(char *s);
// Post: Paints the string from the actual cursor position.
// The coordinate criteria is the same as the LcPutChar.
// Post: Can last up to 40us per char of a routine output.


#endif	/* LCTLCD_H */
