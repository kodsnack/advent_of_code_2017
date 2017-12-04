
/*------------------------------------------------------------------------
    File        : day3.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Sun Dec 03 10:51:51 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/

DEFINE VARIABLE iGoal AS INTEGER NO-UNDO INIT 277678.

DEFINE VARIABLE iX AS INTEGER NO-UNDO.
DEFINE VARIABLE iY AS INTEGER NO-UNDO.

DEFINE VARIABLE iStep      AS INTEGER NO-UNDO.
DEFINE VARIABLE iTotalStep AS INTEGER NO-UNDO INIT 1.
DEFINE VARIABLE iSpiral    AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttCoord NO-UNDO 
    FIELD x    AS INTEGER 
    FIELD y    AS INTEGER 
    FIELD step AS INTEGER 
    FIELD val  AS INTEGER
    INDEX id1 x y
    INDEX id2 val.

FUNCTION findValues RETURNS INTEGER (INPUT piX AS INTEGER, INPUT piY AS INTEGER):

    DEFINE VARIABLE iSum AS INTEGER NO-UNDO.
    DEFINE VARIABLE iX AS INTEGER NO-UNDO.
    DEFINE VARIABLE iY AS INTEGER NO-UNDO.
    DEFINE BUFFER bCoord FOR ttCoord.
  
    DO iX = piX - 1 TO piX + 1:
        DO iY = piY - 1 TO piY + 1:
            FIND FIRST bCoord WHERE bCoord.x = iX AND bCoord.y = iy NO-ERROR.
            IF AVAILABLE bCoord AND ROWID(bCoord) <> ROWID(ttCoord) THEN DO:
                iSum = iSum + bCoord.val.
            END.
        END.
    END. 
    
    RETURN iSum.
END.

CREATE ttCoord.
ASSIGN ttCoord.X    = 0
       ttCoord.Y    = 0
       ttCoord.val  = 1
       ttCoord.step = 1.
       
REPEAT:
    iSpiral = iSpiral + 1.

    iTotalStep = iTotalStep + 1.
    /* 1 R */
    iX = iX + 1.        
    CREATE ttCoord.
    ASSIGN ttCoord.X    = iX
           ttCoord.Y    = iY
           ttCoord.step = iTotalStep
           ttCoord.val  = findValues(ix, iy).
           
    /* Spiral U */
    DO iStep = 1 TO (iSpiral * 2) - 1:
        iTotalStep = iTotalStep + 1.
        iY = iY + 1.
        CREATE ttCoord.
        ASSIGN ttCoord.X    = iX
               ttCoord.Y    = iY
               ttCoord.step = iTotalStep
               ttCoord.val  = findValues(ix, iy).
        
    END.
    /* Spiral + 1 L */
    DO iStep = 1 TO (iSpiral * 2):
        iTotalStep = iTotalStep + 1.
        iX = iX - 1.
        CREATE ttCoord.
        ASSIGN ttCoord.X    = iX
               ttCoord.Y    = iY
               ttCoord.step = iTotalStep
               ttCoord.val  = findValues(ix, iy).
        
    END.
    
    /* Spiral + 1 D */
    DO iStep = 1 TO (iSpiral * 2):
        iTotalStep = iTotalStep + 1.
        iY = iY - 1.
        CREATE ttCoord.
        ASSIGN ttCoord.X    = iX
               ttCoord.Y    = iY
               ttCoord.step = iTotalStep
               ttCoord.val  = findValues(ix, iy).
        
    END.
    
    /* Spiral + 1 R */
    DO iStep = 1 TO (iSpiral * 2):
        iTotalStep = iTotalStep + 1.
        iX = iX + 1.
        CREATE ttCoord.
        ASSIGN ttCoord.X    = iX
               ttCoord.Y    = iY
               ttCoord.step = iTotalStep
               ttCoord.val  = findValues(ix, iy).
        
    END.    
    
    FIND FIRST ttCoord WHERE ttCoord.val > iGoal NO-ERROR.
    IF AVAILABLE ttCoord THEN DO:
        MESSAGE ttCoord.val VIEW-AS ALERT-BOX.
        LEAVE.
    END.
END.