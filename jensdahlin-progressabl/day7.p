
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
    FIELD pgm         AS CHARACTER 
    FIELD weight      AS INTEGER
    FIELD totalWeight AS INTEGER 
    FIELD parentPgm   AS CHARACTER
    FIELD depth       AS INTEGER 
    INDEX pgm pgm
    INDEX parentPgm parentPgm.
 
DEFINE VARIABLE cData    AS CHARACTER NO-UNDO.   
DEFINE VARIABLE iPointer AS INTEGER NO-UNDO.
DEFINE VARIABLE cPgms    AS CHARACTER NO-UNDO.

DEFINE TEMP-TABLE ttWeight NO-UNDO
    FIELD parentPgm  AS CHARACTER 
    FIELD depth      AS INTEGER 
    FIELD weight     AS INTEGER
    FIELD numWeights AS INTEGER.

DEFINE TEMP-TABLE ttWeights NO-UNDO 
    FIELD weight AS INTEGER 
    FIELD num    AS INTEGER.

DEFINE BUFFER bPgm FOR ttPgm.
DEFINE BUFFER bWeight FOR ttWeight.


DEFINE VARIABLE iWeight     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cOdd        AS CHARACTER NO-UNDO.
DEFINE VARIABLE iErrorDepth AS INTEGER   NO-UNDO.
DEFINE VARIABLE cParent     AS CHARACTER NO-UNDO.
DEFINE VARIABLE iDiff       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cBadParent  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iDepth      AS INTEGER NO-UNDO.
DEFINE VARIABLE iSearch     AS INTEGER NO-UNDO.

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
            ELSE DO:
                ttPgm.parentPgm = ENTRY(1, cData, " ").
            END.         
        END.
    END.
END. 
INPUT CLOSE.
   

FIND FIRST ttPgm WHERE ttPgm.parentpgm = "" NO-ERROR.
MESSAGE "Parent, part 1:" ttPgm.pgm VIEW-AS ALERT-BOX.

/* Part 2 below */
FUNCTION returnWeight RETURNS INTEGER (INPUT pcPgm AS CHARACTER, INPUT piDepth AS INTEGER, INPUT plSet AS LOGICAL) :

    
    DEFINE BUFFER bbPgm FOR ttPgm.
    DEFINE BUFFER bPgm FOR ttPgm.
    
    DEFINE VARIABLE iNumPgms AS INTEGER NO-UNDO.
    DEFINE VARIABLE iWeight   AS INTEGER NO-UNDO.
    
    FIND FIRST bbPgm WHERE bbPgm.pgm = pcPgm NO-ERROR.
    IF plSet THEN 
        ASSIGN bbPGm.depth = piDepth.
    
    FOR EACH bPgm WHERE bPgm.parentPgm = pcPgm:
        iWeight = iWeight + returnWeight(bPgm.pgm, piDepth + 1, plSet).
    END.
    
    IF plSet THEN 
        bbPgm.totalWeight = iWeight + bbPgm.weight.

    IF iNumPgms = 0 THEN      
        RETURN (bbPgm.weight + iWeight).
END.

returnWeight(ttPgm.pgm, 1, TRUE).

FOR EACH ttPgm BY ttPgm.depth DESCENDING:
    iDepth = ttPgm.depth.
    LEAVE.
END.


DO iSearch = 1 TO iDepth:
    
    iWeight = 0.
    
    FOR EACH ttpgm WHERE ttPgm.depth = iSearch BY ttPgm.parentPgm:
        iWeight = returnWeight(ttPgm.pgm, 1, FALSE).
        FIND FIRST ttWeight WHERE ttWeight.parentPgm = ttPgm.parentPgm 
                              AND ttWeight.weight    = iWeight NO-ERROR.
        IF NOT AVAILABLE ttWeight THEN DO:
            CREATE ttWeight.                         
            ASSIGN 
                ttWeight.parentPgm = ttPgm.parentPgm
                ttWeight.weight    = iWeight
                ttWeight.depth     = iSearch.
        END.
        ttWeight.numWeights = ttWeight.numWeights + 1.
    END.
END.



DO iSearch = 1 TO iDepth:
    FIND FIRST ttWeight WHERE ttweight.numweights = 1
                          AND ttWeight.depth      = iSearch NO-ERROR.
    IF AVAILABLE ttWeight THEN DO:
        cParent = ttWeight.parentPgm.
    END.
END.

FOR EACH ttPgm WHERE ttPgm.parentPgm = cParent :
    
    FIND FIRST ttWeights WHERE ttWeights.weight = ttPgm.totalWeight NO-ERROR. 
    IF NOT AVAILABLE ttWeights THEN DO:
        CREATE ttWeights.
        ttWeights.weight = ttPgm.totalWeight.
    END.
    ttWeights.num = ttWeights.num + 1.  
        
END.

FIND FIRST ttWeights WHERE ttWeights.num <> 1 NO-ERROR.
iDiff = ttWeights.weight.

FIND FIRST ttWeights WHERE ttWeights.num = 1 NO-ERROR.
iDiff = iDiff - ttWeights.weight.

FOR FIRST ttPgm WHERE ttPgm.parentPgm   = cparent 
                 AND ttPgm.totalWeight = ttWeights.weight:
    MESSAGE "Part 2:" ttPgm.pgm " should be " ttPgm.weight + iDiff VIEW-AS ALERT-BOX.
END.



    