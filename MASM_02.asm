;Write an assembly language program to read one of the
;hex digits (A-F) and display it on next line in decimal.

.MODEL SMALL
.STACK 100H
.DATA
    MSG_1 DB 'Enter a hex digit (A-F): $'
    MSG_2 DB 0AH,0DH,'In decimal it is: 1'
    ANS DB ?
    MSG_3 DB '$'

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    MOV AH,9
    LEA DX,MSG_1
    INT 21H

    MOV AH,1
    INT 21H

    SUB AL,11H
    MOV ANS,AL

    MOV AH,9
    LEA DX,MSG_2
    INT 21H

    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
