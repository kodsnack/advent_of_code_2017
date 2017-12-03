
/*------------------------------------------------------------------------
    File        : day3.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Sun Dec 03 10:51:51 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/
/*
               c
  -3  -2  -1   0  +1  +2 +3
  37  36  34  34  33  32 31 +3  
  38  17  16  15  14  13 30 +2
  39  18   5   4   3  12 29 +1
  40  19   6   1   2  11 28  0 <- c
  41  20   7   8   9  10 27 -1
  42  21  22  23  24  25 26 -2
  43  44  45  46  47  48 49 -3

*/

PROCEDURE valueTOCoord:
    DEFINE INPUT  PARAMETER piValue    AS INTEGER NO-UNDO.
    DEFINE OUTPUT PARAMETER piDistance AS INTEGER NO-UNDO.
    
    DEFINE VARIABLE iSpiralTest AS INTEGER NO-UNDO.
    DEFINE VARIABLE iSpiral     AS INTEGER NO-UNDO.
    DEFINE VARIABLE iStart      AS INTEGER NO-UNDO.
    DEFINE VARIABLE iEnd        AS INTEGER NO-UNDO.
    DEFINE VARIABLE iOffCentre  AS INTEGER NO-UNDO.
    DEFINE VARIABLE iCentre     AS INTEGER NO-UNDO EXTENT 4.
    /* Steg 1 hur långt ut i cirkeln är vi? */
    /* 1 varv = exponenten av ett udda tal (1, 3, 5, 7 etc) */
    
    spiral:
    DO iSpiralTest = 1 TO 1000 BY 2:
        iSpiral = iSpiral + 1.
        IF EXP(iSpiralTest, 2) >= piValue THEN 
            LEAVE spiral.
        
    END.
    
    /* Steg 2. Placera på varvet */
    /* Start och slut för varvet */    
    iStart = EXP(iSpiralTest - 2, 2) + 1.
    iEnd   = EXP(iSpiralTest, 2).
    
    /* Ta reda på hur "off center" vi är */
    /* Det finns fyra centra på varje sida */
    ASSIGN 
        iCentre[1] = iStart + iSpiralTest / 2 - 2
        iCentre[2] = iCentre[1] + (iSpiralTest - 1)
        iCentre[3] = iCentre[2] + (iSpiralTest - 1)
        iCentre[4] = iCentre[3] + (iSpiralTest - 1).
    
    iOffCentre = MIN(ABS(piValue - iCentre[1]) , ABS(piValue - iCentre[2]), ABS(piValue - iCentre[3]), ABS(piValue - iCentre[4])).
  
    piDistance = iSpiral + iOffCentre - 1.

END.
DEFINE VARIABLE iDistance AS INTEGER NO-UNDO.

RUN valueTOCoord(277678, OUTPUT iDistance).

DISPLAY iDistance.