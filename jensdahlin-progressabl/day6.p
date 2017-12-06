
/*------------------------------------------------------------------------
    File        : day6.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Wed Dec 06 07:42:14 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/

DEFINE VARIABLE iBanks           AS INTEGER   NO-UNDO EXTENT 16.
DEFINE VARIABLE i                AS INTEGER   NO-UNDO.
DEFINE VARIABLE iBiggestPosition AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDistribPosition AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNumLists        AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDistribute      AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE ttList NO-UNDO 
    FIELD list AS CHARACTER
    FIELD num  AS INTEGER
    INDEX list list. 
    
DEFINE TEMP-TABLE ttBank NO-UNDO 
    FIELD pos AS INTEGER
    FIELD val AS INTEGER
    INDEX pos pos
    INDEX val val.
 
 DEFINE BUFFER bBank FOR ttBank.

INPUT FROM VALUE(SEARCH("day6.txt")).
IMPORT DELIMITER " " iBanks.
INPUT CLOSE.   


PROCEDURE storeList:
    DEFINE VARIABLE cList AS CHARACTER NO-UNDO.
    
    FOR EACH ttBank :
        cList = cList + STRING(ttBank.val) + ",".
    END.
    
    cList = TRIM(cList, ",").
    
    FIND FIRST ttList WHERE ttList.list = cList NO-ERROR.
    IF NOT AVAILABLE ttList THEN DO:
        iNumLists = iNumLists + 1.  
        CREATE ttList.
        ASSIGN 
            ttList.list = cList
            ttList.num  = iNumLists.
        
    END. 
    ELSE DO:
        MESSAGE "Part 1:" iNumLists "Part 2:" iNumLists - ttList.num + 1 VIEW-AS ALERT-BOX.
        
        RETURN "break". 
    END.   
    
END.

DO i = 1 TO EXTENT(iBanks):
    CREATE ttBank.
    ASSIGN 
        ttBank.pos = i
        ttBank.val = iBanks[i].
END.

RUN storeList.

/* Huvudloop */
DISPLAY "Running".
main:
REPEAT:
    
    biggest:
    FOR EACH ttBank BY ttBank.val DESCENDING BY ttBank.pos:
        iBiggestPosition = ttBank.pos.
        LEAVE biggest.
    END.
    
    iDistribPosition = iBiggestPosition + 1.
    IF iDistribPosition > EXTENT(iBanks) THEN 
        iDistribPosition = 1. 
    
    ASSIGN
        iDistribute = ttBank.val 
        ttBank.val  = 0.
    
    /* Distributionsloop */
    distr:
    REPEAT:
        
        FIND FIRST bBank WHERE bBank.pos = iDistribPosition NO-ERROR.

        IF iDistribute = 0 THEN DO:
            LEAVE distr.
        END.
        ELSE DO:
                    
            bBank.val = bBank.val + 1. 
            iDistribute = iDistribute - 1.
        
        END.
        
        iDistribPosition = iDistribPosition + 1.
        IF iDistribPosition > EXTENT(iBanks) THEN 
            iDistribPosition = 1.           
        
    END.

    RUN storeList.   
    IF RETURN-VALUE = "break" THEN LEAVE main.
    
END.