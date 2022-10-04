;Write a program that reads a string of capital letters,
;ending with a carriage return and displays the longest sequence
;of consecutive alphabetically increasing capital letters read.

.MODEL SMALL
.STACK 100H

.DATA
    MSG_1 DB 'ENTER A STRING OF CAPITAL LETTERS: $'
    MSG_2 DB 0DH,0AH,'THE LONGEST CONSECUTIVELY INCREASING STRING IS: $'
    ILLEGAL DB 0DH,0AH,'INVALID STRING OF CAPITAL LETTERS. TRY AGAIN: $'

.CODE
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG_1
    MOV AH,9
    INT 21H
    JMP INITIATE

    NOT_CAPITAL:
        LEA DX,ILLEGAL
        MOV AH,9
        INT 21H

    INITIATE:
        MOV AH,1
        INT 21H

        CMP AL,0DH
        JE NOT_CAPITAL
        CMP AL,41H
        JB NOT_CAPITAL
        CMP AL,5AH
        JA NOT_CAPITAL

        MOV BL,AL
        MOV BH,AL
        MOV DH,AL
        MOV DL,1
        MOV CL,1

    ENTER_CAPITAL:
        INT 21H

        CMP AL,0DH
        JE TERMINATE_INPUT
        CMP AL,41H
        JB NOT_CAPITAL
        CMP AL,5AH
        JA NOT_CAPITAL

        INC BL

        CMP AL,BL
        JNE CHECK_REPLACE

        INC CL
        JMP ENTER_CAPITAL

        CHECK_REPLACE:
        CMP CL,DL
        JLE BREAK_UPDATE_1

        MOV DH,BH
        MOV DL,CL

        BREAK_UPDATE_1:
        MOV BH,AL
        MOV BL,AL
        MOV CL,1
        JMP ENTER_CAPITAL

    TERMINATE_INPUT:
        CMP CL,DL
        JLE BREAK_UPDATE_2

        MOV DH,BH
        MOV DL,CL

    BREAK_UPDATE_2:
        MOV BX,DX

        LEA DX,MSG_2
        MOV AH,9
        INT 21H

        XOR CX,CX

        MOV CL,BL
        MOV DL,BH
        MOV AH,2

        DISPLAY:
            INT 21H
            INC DL
        LOOP DISPLAY

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
