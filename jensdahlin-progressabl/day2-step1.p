
/*------------------------------------------------------------------------
    File        : day2.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Sat Dec 02 11:25:52 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/
DEFINE TEMP-TABLE ttSpreadsheet NO-UNDO
    FIELD val AS INTEGER EXTENT 20.

DEFINE VARIABLE iCell AS INTEGER NO-UNDO.
DEFINE VARIABLE iSum  AS INTEGER NO-UNDO.    
DEFINE VARIABLE iMax  AS INTEGER NO-UNDO.
DEFINE VARIABLE iMIn  AS INTEGER NO-UNDO.

INPUT FROM VALUE(SEARCH("day2.txt")).
REPEAT:
    CREATE ttSpreadsheet.
    IMPORT DELIMITER " " ttSpreadsheet. 
END.
INPUT CLOSE.

FOR EACH ttSpreadsheet:
    iMin = 99999999.
    iMax = 0.
    
    
    DO iCell = 1 TO EXTENT(ttSpreadsheet.val):
        IF ttSpreadsheet.val[iCell] > 0 THEN DO:
            IF ttSpreadsheet.val[iCell] > iMax THEN 
                iMax = ttSpreadsheet.val[iCell].
            IF ttSpreadsheet.val[iCell] < iMin THEN 
                iMIn = ttSpreadsheet.val[iCell].
        END.
    END.
    
    IF iMin <> 99999999 THEN
        iSum = iSum + iMax - iMin.    
END.

MESSAGE "Checksum: " iSum VIEW-AS ALERT-BOX.