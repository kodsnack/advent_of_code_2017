
/*------------------------------------------------------------------------
    File        : day5.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Dec 05 05:29:36 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/

DEFINE TEMP-TABLE ttJump NO-UNDO 
    FIELD jump AS INTEGER FORMAT "-zzzz9"
    FIELD pos  AS INTEGER 
    INDEX pos pos.
DEFINE VARIABLE iJumps    AS INTEGER NO-UNDO.
DEFINE VARIABLE iJump     AS INTEGER NO-UNDO.    
DEFINE VARIABLE iTotal    AS INTEGER NO-UNDO.
INPUT FROM VALUE(SEARCH("day5.txt")).

REPEAT:
    CREATE ttJump.
    IMPORT ttJump.
    
    iTotal = iTotal + 1.
    ttJump.pos = iTotal.
    
   
END.
INPUT CLOSE.

/* Ta bort skräppost */
FIND FIRST ttJump.
DELETE ttJump.

FIND FIRST ttJump.

DISPLAY "Lets jump".
jumping:
REPEAT:
    iJump = ttJump.pos + ttJump.jump.
    iJumps = iJumps + 1.
    
    IF iJumps MOD 1000 = 0 THEN DO:
        DISPLAY iJumps WITH FRAME x1 1 DOWN.
        PAUSE 0.
    END.
    
    ttJump.jump = ttJump.jump + 1.
    
    FIND FIRST ttJump WHERE ttJump.pos = iJump NO-ERROR.
    IF NOT AVAILABLE ttJump THEN DO:
        MESSAGE iJumps VIEW-AS ALERT-BOX.
        LEAVE jumping.
        
    END.    
END.
DISPLAY "Done...".