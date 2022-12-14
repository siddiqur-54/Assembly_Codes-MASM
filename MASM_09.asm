;Enter the time in seconds. Show the time in the form of HH:MM:SS.

.MODEL SMALL
.STACK 100H

.DATA
  MSG_1 DB 'ENTER THE TIME IN SECONDS, UP TO 65535: $'
  MSG_2 DB 0DH,0AH,'THE TIME IN HH:MM:SS: $'
  BLANK DB ' : $'

.CODE
  MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG_1
    MOV AH,9
    INT 21H

    CALL INDEC
    PUSH AX

    LEA DX,MSG_2
    MOV AH,9
    INT 21H
    POP AX
    XOR DX,DX
    MOV CX,3600
    DIV CX

    CMP AX,10
    JGE HH

    PUSH AX

    MOV AX,0
    CALL OUTDEC
    POP AX

    HH:
    CALL OUTDEC

    MOV AX,DX
    PUSH AX

    LEA DX,BLANK
    MOV AH,9
    INT 21H

    POP AX
    XOR DX,DX
    MOV CX,60
    DIV CX

    CMP AX,10
    JGE MM
    PUSH AX

    MOV AX,0
    CALL OUTDEC
    POP AX

    MM:
    CALL OUTDEC

    MOV BX,DX

    LEA DX,BLANK
    MOV AH,9
    INT 21H

    MOV AX,BX

    CMP AX,10
    JGE SEC
    PUSH AX

    MOV AX,0
    CALL OUTDEC
    POP AX

    SEC:
    CALL OUTDEC

    MOV AH,4CH
    INT 21H
  MAIN ENDP

INDEC PROC
  PUSH BX
  PUSH CX
  PUSH DX
  JMP READING

  IGNORE_BACKSPACE:
  MOV AH,2
  MOV DL,20H
  INT 21H

  READING:
  XOR BX,BX
  XOR CX,CX
  XOR DX,DX

  MOV AH,1
  INT 21H

  CMP AL,"-"
  JE MINUS

  CMP AL,"+"
  JE PLUS
  JMP IGNORE_INPUT

  MINUS:
  MOV CH,1
  INC CL
  JMP INPUT

  PLUS:
  MOV CH,2
  INC CL

  INPUT:
    MOV AH,1
    INT 21H

    IGNORE_INPUT:
    CMP AL,0DH
    JE JMP_END_INPUT

    CMP AL,8H
    JNE NOT_CR

    CMP CH,0
    JE NEXT
    CMP CH,1
    JNE SCAN_CLRPLUS

    NEXT:
    CMP CL,0
    JE IGNORE_BACKSPACE
    JMP REVERT

    JMP_END_INPUT:
    JMP TERMINATE_INPUT

    CMP CL,1
    JE REMOVE_PLUMIN

    SCAN_CLRPLUS:
    CMP CL,1
    JNE REVERT

    REMOVE_PLUMIN:
      MOV AH,2
      MOV DL,20H
      INT 21H

      MOV DL,8H
      INT 21H
      JMP READING

    REVERT:
    MOV AX,BX
    MOV BX,10
    DIV BX

    MOV BX,AX

    MOV AH,2
    MOV DL,20H
    INT 21H

    MOV DL,8H
    INT 21H

    XOR DX,DX
    DEC CL

    JMP INPUT

    NOT_CR:
    INC CL

    CMP AL,30H
    JL INVALID

    CMP AL,39H
    JG INVALID

    AND AX,000FH
    PUSH AX

    MOV AX,10
    MUL BX
    MOV BX,AX
    POP AX

    ADD BX,AX
    JNC VALID
    MOV AH,2
    MOV DL,7H
    INT 21H
    XOR CH,CH

    CMP CL,5
    JNG VALID
    MOV AH,2
    MOV DL,7H
    INT 21H
    XOR CH,CH

  VALID:
  JMP INPUT

  INVALID:
  MOV AH,2
  MOV DL,7H
  INT 21H

  XOR CH,CH

  REMOVE:
    MOV DL,8H
    INT 21H

    MOV DL,20H
    INT 21H

    MOV DL,8H
    INT 21H
  LOOP REMOVE
  JMP READING

  TERMINATE_INPUT:
  CMP CH,1
  JE NEGATION
  JMP EXIT

  NEGATION:
  NEG BX

  EXIT:
  MOV AX,BX
  POP DX
  POP CX
  POP BX
  RET
INDEC ENDP

OUTDEC PROC
  PUSH BX
  PUSH CX
  PUSH DX

  CMP AX,0
  JNGE NEGATE
  JMP START

  NEGATE:
  PUSH AX
  MOV AH,2
  MOV DL,"-"
  INT 21H

  POP AX
  NEG AX

  START:
  XOR CX,CX
  MOV BX, 10

  FIND_OUTPUT:
    XOR DX,DX
    DIV BX
    PUSH DX
    INC CX
    OR AX,AX
  JNE FIND_OUTPUT

  MOV AH,2

  SHOW_OUTPUT:
    POP DX
    OR DL,30H
    INT 21H
  LOOP SHOW_OUTPUT

  POP DX
  POP CX
  POP BX

  RET
  OUTDEC ENDP
END MAIN
