
/*------------------------------------------------------------------------
    File        : day7.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Thu Dec 07 06:51:42 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/

DEFINE TEMP-TABLE ttPgm NO-UNDO
    FIELD pgm       AS CHARACTER 
    FIELD weight    AS INTEGER
    FIELD parentPgm AS CHARACTER.
 
DEFINE VARIABLE cData    AS CHARACTER NO-UNDO.   
DEFINE VARIABLE iPointer AS INTEGER NO-UNDO.
DEFINE VARIABLE cPgms    AS CHARACTER NO-UNDO.
INPUT FROM VALUE(SEARCH("day7.txt")).
REPEAT:
    IMPORT UNFORMATTED cData.   
 
    FIND FIRST ttPgm WHERE ttPgm.pgm = ENTRY(1, cData, " ") NO-ERROR.
    IF NOT AVAILABLE ttPgm THEN DO:    
    CREATE ttPgm.
        ASSIGN ttPgm.pgm = ENTRY(1, cData, " ").
    END.
    ttPgm.weight = INTEGER(TRIM(ENTRY(2, cDAta,  "" ), "()")).
            
    IF INDEX(cData, "->") > 0 THEN DO:
        cPgms = SUBSTRING(cData, INDEX(cData, "->") + 3 ).
        
        DO iPointer = 1 TO NUM-ENTRIES(cPgms):
            FIND FIRST ttPgm WHERE ttPgm.pgm = TRIM(ENTRY(iPointer, cPgms)) NO-ERROR.
            IF NOT AVAILABLE ttPgm THEN DO:    
                CREATE ttPgm.
                ASSIGN 
                    ttPgm.pgm       = TRIM(ENTRY(iPointer, cPgms))
                    ttPgm.parentPgm = ENTRY(1, cData, " ").
            END.            
        END.
    END.
END. 
INPUT CLOSE.   
FOR EACH ttPgm:
     DISPLAY ttPgm.
     PAUSE 0.
     END.
    READKEY.