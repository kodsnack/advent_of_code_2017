
/*------------------------------------------------------------------------
    File        : day10.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Sat Dec 09 08:45:00 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/

DEFINE VARIABLE cInput   AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cMode    AS CHARACTER NO-UNDO INIT "read".
DEFINE VARIABLE iStep    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cChr     AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTotal   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iGarbage AS INTEGER   NO-UNDO.

COPY-LOB FROM FILE SEARCH("day10.txt") TO cInput.

DEFINE TEMP-TABLE ttGroup NO-UNDO
    FIELD posStart AS INTEGER 
    FIELD posEnd   AS INTEGER
    FIELD score    AS INTEGER.

DEFINE BUFFER bContainer FOR ttGroup.

DO iStep = 1 TO LENGTH(cInput):
    cChr = SUBSTRING(cInput, iStep, 1).
    
    IF cMode = "read" THEN DO:
        IF cChr = "~{" THEN DO:
            
            IF AVAILABLE ttGroup THEN DO:
                FIND LAST bContainer WHERE bContainer.posEnd = 0.
            END.
            CREATE ttGroup.
            ASSIGN 
                ttGroup.posStart = iStep
                ttGroup.score    = IF AVAILABLE bContainer THEN bContainer.score + 1 ELSE 1.
                
            
        END.
        ELSE IF cChr = "}" THEN DO:
            FIND LAST ttGroup WHERE ttGRoup.posEnd = 0.
            ASSIGN ttGroup.posEnd = iStep.
        END.
        ELSE IF cChr = "<" THEN DO:
            cMode = "garbage".
        END. 
        ELSE IF cChr = "!" THEN DO:
            iStep = iStep + 1.
        END.
        ELSE IF cChr = "," THEN DO:
            
        END.
        ELSE DO:
            ttGroup.score = bContainer.score + 1.
        END.
    END.
    ELSE IF cMode = "garbage" THEN DO:
        IF cChr = ">" THEN DO:
            cMode = "read".
        END. 
        ELSE IF cChr = "!" THEN DO:
            iStep = iStep + 1.
        END.
        ELSE DO:
            iGarbage = iGarbage + 1.
        END.
    END.
END. 

FOR EACH ttGroup:
    iTotal = iTotal + ttGroup.score.
END.

MESSAGE "Part 1:" iTotal "Part 2:" iGarbage VIEW-AS ALERT-BOX.