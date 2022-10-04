;Write a program to (a) promt the user, (b) read first, middle and
;last initials of a person’s name, and (c) display them down the left margin.

.MODEL SMALL
.STACK 100H

.DATA
   OPT_1  EQU  'Enter three initials of your name : $'
   OPT_2  EQU  0DH,0AH,'The initials are :',0DH,0AH,'$'
   OPT_3  EQU  0DH,0AH,'$'

   PROMPT_1  DB  OPT_1
   PROMPT_2  DB  OPT_2
   LINEBREAK   DB  OPT_3

.CODE
  MAIN PROC

    ;initialize DS
    MOV AX,@DATA
    MOV DS,AX

    ;display PROMPT_1
    LEA DX,PROMPT_1
    MOV AH,9
    INT 21H

    ;read 1st initial
    MOV AH,1
    INT 21H

    ;save 1st initial into BL
    MOV BL,AL

    ;read 2nd initial
    MOV AH,1
    INT 21H

    ;save 2nd initials into BH
    MOV BH,AL

    ;read 3rd initial
    MOV AH,1
    INT 21H

    ;save 3rd initial into CL
    MOV CL,AL

    ;display PROMPT_2
    LEA DX,PROMPT_2
    MOV AH,9
    INT 21H

    ;display 1st initial
    MOV AH,2
    MOV DL,BL
    INT 21H

    ;display new line
    LEA DX,LINEBREAK
    MOV AH,9
    INT 21H

    ;display 2nd initial
    MOV AH,2
    MOV DL,BH
    INT 21H

    ;display new line
    LEA DX,LINEBREAK
    MOV AH,9
    INT 21H

    ;display 3rd initial
    MOV AH,2
    MOV DL,CL
    INT 21H

    ;return control to dos
    MOV AH,4CH
    INT 21H
  MAIN ENDP
END MAIN
