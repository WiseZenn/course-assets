stack segment stack 'stack'
    db 32 dup(0)
ends
data segment
INPUT DB 'PLEASE INPUT N(0-9):$'
LFB DB ' 0$ 1$ 8$ 27$ 64$ 125$ 216$ 343$ 512$ 729$'
N DB 0
data ends

code segment
start   proc far
        assume cs:code,ds:data,ss:stack
        push ds
        sub ax,ax
        push ax
        mov ax,data
        mov ds,ax
        MOV DX,OFFSET INPUT ;显示提示信息
        MOV AH,9H           ;
        INT 21H
        MOV AH,1
        INT 21H
        MOV N,AL
        MOV AH,2
        MOV DL,0AH
        INT 21H
        MOV DL,N
        AND DL,0FH
        MOV CL,2
        SHL DL,CL
        MOV DH,0
        ADD DX,OFFSET LFB
        MOV AH,9
        INT 21H
        ret
start endp
code ends
end start
        