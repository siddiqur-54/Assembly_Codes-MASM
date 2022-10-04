;Write an assembly language program to find the largest
;number among 3 decimal numbers which are less than 10.

.model small
.stack 100h
.data
    msg_1 DB 'Enter three numbers: $'
    msg_2 DB 'The largest number is: $'
.code

main proc

    mov ax,@DATA
    mov ds,ax

    mov ah,9
    lea dx,msg_1
    int 21h

    mov ah,1

    int 21h
    mov bl,al

    int 21h

    int 21h
    mov bh,al

    int 21h

    int 21h
    mov cl,al

    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h

    mov ah,9
    lea dx,msg_2
    int 21h


    cmp bl,bh
    jg l1

    cmp bh,cl
    jg l3
    mov ah,2
    mov dl,cl
    int 21h

    jmp exit

    l1:
    cmp bl,cl
    jg l2
    mov ah,2
    mov dl,cl
    int 21h

    jmp exit

    l2:
    mov ah,2
    mov dl,bl
    int 21h

    jmp exit

    l3:
    mov ah,2
    mov dl,bh
    int 21h

    exit:
    mov ah,4ch
    main endp
end main
