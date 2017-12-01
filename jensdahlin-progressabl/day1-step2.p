
/*------------------------------------------------------------------------
    File        : day1-step2.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Fri Dec 01 08:30:55 CET 2017
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
DEFINE VARIABLE iHalf    AS INTEGER   NO-UNDO.
DEFINE VARIABLE iNext    AS INTEGER   NO-UNDO.

COPY-LOB FROM FILE SEARCH("day1.txt") TO cCaptcha.

iHalf = LENGTH(cCaptcha) / 2.

DO iStep = 1 TO LENGTH(cCaptcha):

    iNext = iStep + iHalf.
    
    IF iNext > LENGTH(cCaptcha) THEN 
        iNext = iNext - LENGTH(cCaptcha).
    
    cNext = SUBSTRING(cCaptcha, iNext, 1).
        
    cThis = SUBSTRING(cCaptcha, iStep, 1).
    
    IF cThis = cNext THEN 
        iSum = iSum + INTEGER(cThis).
    
END.    

MESSAGE "Sum:" iSum VIEW-AS ALERT-BOX.