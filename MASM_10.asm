;Write a program to display the extended
;ASCII characters(ASCII codes 80h to FFh).

.MODEL SMALL
.STACK 100H

.DATA
    CR_LF  DB  0DH,0AH,"$"

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    MOV BL,80H
    MOV CL,0
    TOP:
        CMP CL,10
        JE NEWLINE

        INC CL

        MOV AH,2
        MOV DL,BL
        INT 21H

        MOV DL," "
        INT 21H
        INC BL

        CMP BL,0FFH
        JE BOTTOM

        JMP TOP
    NEWLINE:
        MOV AH,9
        LEA DX,CR_LF
        INT 21H

        MOV CL,0
        JMP TOP

    BOTTOM:
        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
