;Input a binary number. Convert it into Hexadecimal form.

.MODEL SMALL
.STACK 100H

.DATA
  MSG_1 DB 'ENTER A BINARY NUMBER (MAX - 8 DIGITS): $'
  MSG_2 DB 0DH,0AH,'THE BINARY IN HEXADECIMAL IS : $'
  INVALID DB 0DH,0AH,'INVALID INPUT. PLEASE TRY AGAIN: $'

.CODE
  MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG_1
    MOV AH,9
    INT 21H

    INPUT:
      MOV AH,1
      INT 21H

      CMP AL,0DH
      JNE SKIP

      CMP DH,1
      JB ILLEGAL
      JMP END

      SKIP:
        INC DH
        AND AL,0FH

        CMP AL,0
        JB ILLEGAL
        CMP AL,1
        JA ILLEGAL

        SHL BX,1
        OR BL,AL

        CMP DH,8
        JE END
        JMP INPUT


    ILLEGAL:
      LEA DX,INVALID
      MOV AH,9
      INT 21H

      XOR BX,BX
      MOV DH,0
      JMP INPUT

    END:
    LEA DX,MSG_2
    MOV AH,9
    INT 21H
    MOV CX,4
    MOV AH,2

    LOOP_ONE:
      XOR DX,DX

      LOOP_TWO:
        SHL BX,1
        RCL DL,1
        INC DH
        CMP DH,4
      JNE LOOP_TWO

      CMP DL,9
      JG LETTER_DIGIT
      OR DL,30H
      JMP OUTPUT

      LETTER_DIGIT:
        SUB DL,9
        OR DL,40H

      OUTPUT:
        INT 21H
    LOOP LOOP_ONE
    MOV AH, 4CH
    INT 21H
  MAIN ENDP
END MAIN
