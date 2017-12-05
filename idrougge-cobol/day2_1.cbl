       IDENTIFICATION DIVISION.
       PROGRAM-ID. Advent2-1.
      *DESCRIPTION. Advent of code 2017, day 2, puzzle 1.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT input-file ASSIGN TO 'day2.txt'
                             ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD input-file.
       01 input-line  PIC X(256).
       WORKING-STORAGE SECTION.
       77  digits          PIC 999999.
       77  smaller         PIC 999999.
       77  bigger          PIC 999999.
       77  ptr             PIC 999   VALUE 1.
       77  tab             PIC X     VALUE X'09'.
       77  summa           PIC 9(10) VALUE ZERO.
       01  switches.
           05  eof-switch  PIC 9     VALUE 0.
           88  eof                   VALUE 1.
           05  eol-switch  PIC 9     VALUE 0.
           88  end-of-line           VALUE 1.
       PROCEDURE DIVISION.
       Main.
           OPEN INPUT input-file
           PERFORM UNTIL eof
               READ input-file
                   AT END SET eof TO TRUE
                   NOT AT END PERFORM Process-line
               END-READ
           END-PERFORM
           CLOSE input-file
           DISPLAY summa
           GOBACK
       .

       Process-line.
           INITIALIZE eol-switch
           MOVE 1 TO ptr
           UNSTRING input-line DELIMITED BY tab INTO digits
               WITH POINTER ptr
           END-UNSTRING
           MOVE digits TO smaller
           MOVE digits TO bigger
           PERFORM UNTIL end-of-line
               UNSTRING input-line DELIMITED BY tab INTO digits
                   WITH POINTER ptr
                   NOT ON OVERFLOW SET end-of-line TO TRUE
               END-UNSTRING
               PERFORM MinMax
           END-PERFORM
           COMPUTE summa = summa + bigger - smaller
       .

       MinMax.
           COMPUTE smaller = FUNCTION MIN(smaller digits)
           COMPUTE bigger = FUNCTION MAX(bigger digits)
       .

       END PROGRAM Advent2-1.
