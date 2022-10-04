;Write a program that will prompt the user to enter a
;hex digit(“0” to “9” and “A” to “F”) and display it on the next line in decimal.

.MODEL SMALL
.STACK 100H

.DATA
    CMD DB 'ENTER A HEX DIGIT: $'
    DECIMAL DB 0DH,0AH,'IN DECIMAL, IT IS: $'
    REPEAT DB 0DH,0AH,'DO YOU WANT TO DO IT AGAIN? $'
    INVALID DB 0DH,0AH,'ILLEGAL CHARACTER - ENTER 0..9 or A..F: $'
    CR_LF DB 0DH,0AH,"$"

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        FIRST:
            MOV AH,9
            LEA DX,CMD
            INT 21H
        SECOND:
            MOV AH,1
            INT 21H

            MOV BL,AL

            CMP BL,"A"
            JB THIRD

            CMP BL,"F"
            JA ILLEGAL

            JMP LETTER_DIGIT
        THIRD:
            CMP BL,"0"
            JB ILLEGAL

            CMP BL,"9"
            JA ILLEGAL

            JMP NUMERIC_DIGIT

        ILLEGAL:
            MOV AH,9
            LEA DX,INVALID
            INT 21H

            JMP SECOND

        NUMERIC_DIGIT:
            MOV AH,9
            LEA DX,DECIMAL
            INT 21H

            MOV AH,2
            MOV DL,BL
            INT 21H

            JMP CONTINUE

        LETTER_DIGIT:
            MOV AH, 9
            LEA DX,DECIMAL
            INT 21H

            MOV AH,2
            MOV DL,31H
            INT 21H

            SUB BL,11H

            MOV DL,BL
            INT 21H

        CONTINUE:
            MOV AH,9
            LEA DX,CR_LF
            INT 21H

            LEA DX,REPEAT
            INT 21H

            MOV AH,1
            INT 21H

            CMP AL,"y"
            JE JUMP

            CMP AL,"Y"
            JE JUMP

            JMP FINISH

        JUMP:
            LEA DX,CR_LF
            MOV AH,9
            INT 21H
            INT 21H

            JMP FIRST

        FINISH:
            MOV AH,4CH
            INT 21H
    MAIN ENDP
END MAIN
