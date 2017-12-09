
/*------------------------------------------------------------------------
    File        : day8.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Dec 08 06:35:05 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/
DEFINE TEMP-TABLE ttRegister NO-UNDO 
    FIELD regName  AS CHARACTER 
    FIELD regValue AS INTEGER 
    INDEX regName regName.
    
DEFINE TEMP-TABLE ttCommand NO-UNDO 
    FIELD regName AS CHARACTER  
    FIELD com     AS CHARACTER 
    FIELD valueMod AS INTEGER 
    FIELD nah      AS CHARACTER
    FIELD regComp AS CHARACTER 
    FIELD operator AS CHARACTER 
    FIELD compValue AS INTEGER
    .
    
DEFINE BUFFER bCompare FOR ttRegister.

DEFINE VARIABLE lDoIt    AS LOGICAL NO-UNDO.   
DEFINE VARIABLE iHighest AS INTEGER NO-UNDO.
INPUT FROM VALUE(SEARCH("day8.txt")).
REPEAT:
    CREATE ttCommand.
    IMPORT DELIMITER " " ttCommand.
    
    FIND FIRST ttRegister WHERE ttREgister.regName = ttCommand.regName NO-ERROR.
    IF NOT AVAILABLE ttRegister THEN DO:
        CREATE ttRegister.
        ASSIGN ttRegister.regName = ttCommand.regName.
    END.
    
    FIND FIRST ttRegister WHERE ttREgister.regName = ttCommand.regName NO-ERROR.
    IF NOT AVAILABLE ttRegister THEN DO:
        CREATE ttRegister.
        ASSIGN ttRegister.regName = ttCommand.regComp.
    END.

END.
INPUT CLOSE.
    
FOR EACH ttCommand:
    
    FIND FIRST ttRegister WHERE ttRegister.regName = ttCommand.regName NO-ERROR.
    FIND FIRST bCompare WHERE bCompare.regName = ttCommand.regComp NO-ERROR.
    
    lDoIt = FALSE.
    IF AVAILABLE ttRegister AND AVAILABLE bCompare THEN DO:
        CASE ttCommand.operator :
            WHEN "==" THEN DO:
                IF bCompare.regValue = ttCommand.compValue THEN 
                    lDoIt = TRUE.                
            END.
            WHEN ">=" THEN DO:
                IF bCompare.regValue >= ttCommand.compValue THEN 
                    lDoIt = TRUE.
            END.
            WHEN ">" THEN DO:
                IF bCompare.regValue > ttCommand.compValue THEN 
                    lDoIt = TRUE.
            END.
            WHEN "<=" THEN DO:
                IF bCompare.regValue  <= ttCommand.compValue THEN 
                    lDoIt = TRUE.
            END.
            WHEN "<" THEN DO:
                IF bCompare.regValue < ttCommand.compValue THEN 
                    lDoIt = TRUE.
            END.
            WHEN "!=" THEN DO:
                IF bCompare.regValue  <> ttCommand.compValue THEN 
                    lDoIt = TRUE.
            END.
            OTHERWISE DO:
                DISPLAY "WHat?".
            END.
        END CASE.
        
        IF lDoIt THEN DO:
            IF ttCommand.com = "inc" THEN 
                ttRegister.regValue = ttRegister.regValue + ttCommand.valueMod.
            ELSE
                ttRegister.regValue = ttRegister.regValue - ttCommand.valueMod.
            
            IF ttRegister.regValue > iHighest THEN 
                iHighest = ttRegister.regValue.
         END.    
         
                
    END.
    
END.

FOR EACH ttRegister BY ttREgister.regVal DESCENDING :
    MESSAGE "Largest" ttRegister.regval " part 2 "iHighest VIEW-AS ALERT-BOX.
    LEAVE.
END.
    
 