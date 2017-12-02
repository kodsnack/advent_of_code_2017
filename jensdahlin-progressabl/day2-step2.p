
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

DEFINE VARIABLE iCell  AS INTEGER NO-UNDO.
DEFINE VARIABLE iCell2 AS INTEGER NO-UNDO.
DEFINE VARIABLE iSum  AS INTEGER NO-UNDO.    

INPUT FROM VALUE(SEARCH("day2.txt")).
REPEAT:
    CREATE ttSpreadsheet.
    IMPORT DELIMITER " " ttSpreadsheet. 
END.
INPUT CLOSE.

sheetRow:
FOR EACH ttSpreadsheet:
    DO iCell = 1 TO EXTENT(ttSpreadsheet.val):
        DO iCell2 = 1 TO EXTENT(ttSpreadsheet.val):
            IF ttSpreadsheet.val[iCell] <> 0 AND ttSpreadsheet.val[iCell2] <> 0  THEN  DO:
                IF ttSpreadsheet.val[iCell] MODULO ttSpreadsheet.val[iCell2] = 0 AND (ttSpreadsheet.val[iCell] <> ttSpreadsheet.val[iCell2]) THEN DO:
                    DISPLAY ttSpreadsheet.val[iCell]  ttSpreadsheet.val[iCell2] ttSpreadsheet.val[iCell] / ttSpreadsheet.val[iCell2].
                    iSum = iSum + ttSpreadsheet.val[iCell] / ttSpreadsheet.val[iCell2].
                    NEXT sheetRow.
                END.
            END.
        END.
    END.
END.

MESSAGE "Checksum: " iSum VIEW-AS ALERT-BOX.