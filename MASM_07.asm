;Input a string containing space. Show each words in the form of reversed letters.

.MODEL SMALL
.STACK 100H

.DATA
  MSG_1 DB 'TYPE SOME TEXT CONSISTING OF WORDS SEPARATED BY BLANKS: $'
  MSG_2 DB 0DH,0AH,'THE TEXT WITH REVERSED LETTERS IN EACH WORDS: $'
  CNT DW 0

.CODE
  MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MSG_1
    MOV AH,9
    INT 21H

    XOR CX,CX
    MOV AH,1

    CHAR_IN:
      INT 21H

      CMP AL,0DH
      JNE NOT_CR

      MOV BX,50H
      XCHG BX,SP
      PUSH 0020H

      XCHG BX,SP
      INC CNT
      JMP LOOP_CHAR

      NOT_CR:
        PUSH AX
        INC CX
    JMP CHAR_IN

    LOOP_CHAR:
      POP DX
      XCHG BX,SP
      PUSH DX
      XCHG BX,SP
      INC CNT
    LOOP LOOP_CHAR

    LEA DX,MSG_2
    MOV AH,9
    INT 21H
    MOV CX,CNT
    MOV CNT,0

    PUSH 0020H
    INC CNT

    DISPLAY:
      XCHG BX,SP
      POP DX
      XCHG BX,SP

      CMP DL,20H
      JNE BREAK

      MOV AH,2

      LOOP_DISPLAY:
        POP DX
        INT 21H
        DEC CNT
      JNZ LOOP_DISPLAY
      MOV DX,0020H

      BREAK:
        PUSH DX
        INC CNT
    LOOP DISPLAY
    MOV AH,4CH
    INT 21H
  MAIN ENDP
END MAIN
