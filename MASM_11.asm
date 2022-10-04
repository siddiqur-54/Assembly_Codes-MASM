;Write a program to display a “?”, read two capital letters
; and display them on the next line in alphabetical order.

.MODEL SMALL
.STACK 100H

.DATA
    CR_LF  DB  0DH,0AH,"$"

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV AH,2
        MOV DL,"?"
        INT 21H

        MOV AH,1
        INT 21H

        MOV BL,AL

        MOV AH,1
        INT 21H

        MOV BH,AL

        MOV AH,9
        LEA DX,CR_LF
        INT 21H

        MOV AH,2

        CMP BL,BH

        JAE FIRST
        MOV DL,BL
        INT 21H

        MOV DL,BH
        INT 21H

        JMP FINISH
        FIRST:
            MOV DL,BH
            INT 21H

            MOV DL,BL
            INT 21H

        FINISH:
            MOV AH,4CH
            INT 21H
    MAIN ENDP
END MAIN
