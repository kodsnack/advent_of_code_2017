
/*------------------------------------------------------------------------
    File        : day4.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Mon Dec 04 07:12:46 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/

DEFINE TEMP-TABLE ttPass NO-UNDO 
    FIELD phrase AS CHARACTER EXTENT 30.

DEFINE VARIABLE iPhrase1 AS INTEGER NO-UNDO.
DEFINE VARIABLE iPhrase2 AS INTEGER NO-UNDO.
DEFINE VARIABLE iInvalid AS INTEGER NO-UNDO.
DEFINE VARIABLE iTotal   AS INTEGER NO-UNDO.
INPUT FROM VALUE(SEARCH("day4.txt")).


REPEAT:
    CREATE ttPass.
    IMPORT DELIMITER " " ttPass.
    iTotal = iTotal + 1.
END.
INPUT CLOSE.

FUNCTION ascii RETURNS INTEGER EXTENT 255 (INPUT pcString AS CHARACTER) :
    DEFINE VARIABLE i AS INTEGER NO-UNDO.
    DEFINE VARIABLE cAscii AS INTEGER NO-UNDO EXTENT 255.
    
    
    DO i = 1 TO LENGTH(pcString):
        cAscii[ASC(SUBSTRING(pcString, i, 1))] = cAscii[ASC(SUBSTRING(pcString, i, 1))] + 1.
    END.
    
    RETURN cAscii.
     
END.

FUNCTION anagramMatch RETURN LOGICAL( INPUT pcString1 AS CHARACTER
                                    , INPUT pcString2 AS CHARACTER):
    
    DEFINE VARIABLE cAscii1 AS INTEGER  EXTENT 255.
    DEFINE VARIABLE cAscii2 AS INTEGER  EXTENT 255.
    
    DEFINE VARIABLE i AS INTEGER NO-UNDO.
    
    cAscii1 = ascii(pcString1).
    cAscii2 = ascii(pcString2).
    
    DO i = 1 TO 255:
        IF cAscii1[i] <> cAscii2[i] THEN RETURN FALSE.
    END.
    RETURN TRUE.
                             
END FUNCTION.

pass:
FOR EACH ttPass TABLE-SCAN:
    DO iPhrase1 = 1 TO EXTENT(ttPass.phrase):
        DO iPhrase2 = 2 TO EXTENT(ttPass.phrase):
            IF iPhrase1 <> iPhrase2 AND ttPass.phrase[iPhrase1] <> "" AND anagramMatch(ttPass.phrase[iPhrase1], ttPass.phrase[iPhrase2]) THEN DO:
                iInvalid = iInvalid + 1.
                NEXT pass.
            END.    
        END.
    END.
END.

MESSAGE iTotal - iInvalid VIEW-AS ALERT-BOX.