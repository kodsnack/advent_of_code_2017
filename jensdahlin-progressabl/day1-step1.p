
/*------------------------------------------------------------------------
    File        : day1-step1.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Dec 01 08:11:55 CET 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
DEFINE VARIABLE cCaptcha AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE iSum     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iStep    AS INTEGER   NO-UNDO.
DEFINE VARIABLE cThis    AS CHARACTER NO-UNDO.
DEFINE VARIABLE cNext    AS CHARACTER NO-UNDO.

COPY-LOB FROM FILE SEARCH("day1.txt") TO cCaptcha.

DO iStep = 1 TO LENGTH(cCaptcha):
        
    IF iStep = LENGTH(cCaptcha) THEN 
        cNext = SUBSTRING(cCaptcha, 1, 1).
    ELSE
        cNext = SUBSTRING(cCaptcha, iStep + 1, 1).
        
    cThis = SUBSTRING(cCaptcha, iStep, 1).
    
    IF cThis = cNext THEN 
        iSum = iSum + INTEGER(cThis).
    
END.    

MESSAGE "Sum:" iSum VIEW-AS ALERT-BOX.