;Enter a character. Find the ASCII value in the hexadecimal form.

.MODEL SMALL
.STACK 100H

.DATA
  MSG_1 DB 0DH,0AH,'ENTER A CHARACTER: $'
  MSG_2 DB 0DH,0AH,'ASCII CODE IN HEX FORM IS: $'

.CODE
  MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG_1
    MOV AH,9
    INT 21H

    MOV AH,1
    INT 21H

    MOV BL,AL

    XOR DX,DX
    MOV CX,4

    SHIFT_1:
      SHL BL,1
      RCL DL,1
    LOOP SHIFT_1

    MOV CX,4

    SHIFT_2:
      SHL BL,1
      RCL DH,1
    LOOP SHIFT_2

    MOV BX,DX

    LEA DX,MSG_2
    MOV AH,9
    INT 21H

    MOV CX,2
    FINAL:
      CMP CX,1
      JE NEXT_DIGIT
      MOV DL,BL
      JMP CONVERT

      NEXT_DIGIT:
        MOV DL,BH

      CONVERT:
        MOV AH,2
        CMP DL,9
        JG TO_LETTER
        OR DL,30H
        JMP SHOW

      TO_LETTER:
        SUB DL,9
        OR DL,40H

      SHOW:
        INT 21H
    LOOP FINAL

    MOV AH,4CH
    INT 21H
  MAIN ENDP
END MAIN
