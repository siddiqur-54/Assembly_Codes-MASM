;Enter a character. Find the ASCII value in the binary form
;and count the the number of 1s in the binary form.

.MODEL SMALL
.STACK 100H

.DATA
  MSG_1 DB 'ENTER A CHARACTER: $'
  MSG_2 DB 0DH,0AH,'THE ASCII CODE IN BINARY FORM IS: $'
  MSG_3 DB 0DH,0AH,'THE NUMBER OF 1 BITS ARE: $'

.CODE
  MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG_1
    MOV AH,9
    INT 21H

    MOV AH,1
    INT 21H

    XOR BX,BX
    MOV BL,AL

    LEA DX,MSG_2
    MOV AH,9
    INT 21H


    XOR BH,BH
    MOV CX,8
    MOV AH,2

    SHIFT:
      SHL BL,1

      JC ONE_BIT
      MOV DL,30H
      JMP SHOW

      ONE_BIT:
        INC BH
        MOV DL,31H

      SHOW:
        INT 21H
    LOOP SHIFT

    LEA DX,MSG_3
    MOV AH,9
    INT 21H

    OR BH,30H

    MOV AH,2
    MOV DL,BH
    INT 21H

    MOV AH,4CH
    INT 21H
  MAIN ENDP
END MAIN
