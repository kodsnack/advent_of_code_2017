       IDENTIFICATION DIVISION.
       PROGRAM-ID. Advent1-1.
      *DESCRIPTION. Advent of code 2017, day 1, puzzle 1.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT input-file ASSIGN TO 'day1.txt'
                             ORGANIZATION IS SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD input-file.
       01 input-character  PIC 9.
       WORKING-STORAGE SECTION.
       77  first-character PIC 9.
       77  prev-character  PIC 9.
       77  summa           PIC 9(10) VALUE ZERO.
       01  switches.
           05  eof-switch  PIC 9     VALUE 0.
           88  eof                   VALUE 1.
       PROCEDURE DIVISION.
           OPEN INPUT input-file
           READ input-file
           MOVE input-character TO first-character
           MOVE input-character TO prev-character
           PERFORM UNTIL eof
               PERFORM Read-next-character
               IF input-character EQUALS prev-character THEN 
                   ADD input-character TO summa
               END-IF
               MOVE input-character TO prev-character
           END-PERFORM
           CLOSE input-file
           DISPLAY summa
           STOP RUN
       .

       Read-next-character.
           READ input-file
               AT END SET eof TO TRUE
               MOVE first-character TO input-character
           END-READ
       .

       END PROGRAM Advent1-1.
