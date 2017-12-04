
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

pass:
FOR EACH ttPass:
    DO iPhrase1 = 1 TO EXTENT(ttPass.phrase):
        DO iPhrase2 = 2 TO EXTENT(ttPass.phrase):
            IF iPhrase1 <> iPhrase2 AND ttPass.phrase[iPhrase1] <> "" AND ttPass.phrase[iPhrase1] = ttPass.phrase[iPhrase2] THEN DO:
                iInvalid = iInvalid + 1.
                NEXT pass.
            END.    
        END.
    END.
END.

MESSAGE iTotal - iInvalid VIEW-AS ALERT-BOX.