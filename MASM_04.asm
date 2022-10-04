;Write an assembly language program that will prompt the user to enter a
;hex digit character (“0”,......”9” or “A”,.... “F”), display it on the
;next line in decimal and check whether this decimal number is odd or not.
;If odd then the program will repeat and if even then the program will terminate.
;If the user enters an illegal character, prompt the user to enter another character.

.MODEL SMALL
.STACK 100H

.DATA
S1 DB "ENTER THE HEX DIGIT: $"
S2 DB "IN DECIMAL IT IS: $"
S3 DB " IS AN ODD NUMBER $"
S4 DB " IS AN ILLEGAL CHARACTER $"

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    TOP:

      LEA DX,S1
      MOV AH,09H
      INT 21H

      MOV AH,1
      INT 21H
      MOV BL,AL

      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H


      CMP BL,41H
      JL ILLEGAL

      CMP BL,46H
      JG ILLEGAL


      CMP BL,42H
      JE ODD
      CMP BL,44H
      JE ODD
      CMP BL,46H
      JE ODD


      CMP BL,41H
      JE EVEN
      CMP BL,43H
      JE EVEN
      CMP BL,45H
      JE EVEN

    LOOP TOP

    EVEN:

      MOV AH,2
      MOV DL,BL
      INT 21H

      LEA DX,S4
      MOV AH,09H
      INT 21H

      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H

    ODD:

      MOV AH,2
      MOV DL,BL
      INT 21H

      LEA DX,S3
      MOV AH,09H
      INT 21H

      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H

      JMP TOP

    ILLEGAL:

      MOV AH,2
      MOV DL,BL
      INT 21H

      LEA DX,S4
      MOV AH,09H
      INT 21H

      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H

      JMP TOP


    MAIN ENDP
END MAIN
