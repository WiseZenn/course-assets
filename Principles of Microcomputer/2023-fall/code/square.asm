stack segment stack 'stack'
    db 32 dup(0)
ends

data segment
INPUT DB 'PLEASE INPUT N(0-9):$'
N DB 0
OUTPUT DB 'OUTPUT IS $' 
RESULT DB 2 DUP(0), '$'  ; ���ڴ洢ƽ������� ASCII ��
data ends

code segment
start   proc far
        assume cs:code,ds:data,ss:stack
        push ds
        sub ax,ax
        push ax
        mov ax,data
        mov ds,ax
        
        ; ��ʾ��ʾ��Ϣ
        MOV DX,OFFSET INPUT
        MOV AH,9H
        INT 21H
        
        ; ��ȡ�û�����
        MOV AH,1
        INT 21H
        MOV N,AL
        
        ; ���лس�
        MOV AH,02H
        MOV DL,0AH
        INT 21H
        MOV AH,02H
        MOV DL,0DH
        INT 21H
        MOV DX, OFFSET OUTPUT
        MOV AH, 09H
        INT 21H        
        ; ����ƽ��ֵ
        MOV AL, N
        AND AL, 0FH       ; ������4λ
        MUL AL            ; AL = AL * AL
        
        ; ��ƽ��ֵת��Ϊ ASCII ��
        MOV BX, OFFSET RESULT
        AAM               ; �� AL �е�ֵת��Ϊ BCD �룬AH Ϊʮλ��AL Ϊ��λ
        ADD AH, '0'       ; ʮλת��Ϊ ASCII ��
        ADD AL, '0'       ; ��λת��Ϊ ASCII ��
        MOV [BX], AH      ; �洢ʮλ
        MOV [BX+1], AL    ; �洢��λ
        
        ; ��ʾƽ��ֵ
        MOV DX, OFFSET RESULT
        MOV AH, 9
        INT 21H        
        ret
start endp
code ends
end start