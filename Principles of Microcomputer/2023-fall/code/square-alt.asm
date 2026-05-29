
DATA SEGMENT      ;���ݶ�
 	TABLE DB 0, 1, 4, 9, 16, 25, 36, 49, 64, 81
 	INPUT DB 'PLEASE INPUT N(0-9):', 0DH, 0AH, '$'
 	OUTPUT DB 'OUTPUT IS $' 
DATA ENDS
 
;�����
CODE SEGMENT 
START:
    ASSUME   CS:CODE, DS:DATA      
	MOV AX,DATA
	MOV DS,AX   	;������ݶεĶε�ַ
	MOV DX, OFFSET INPUT	;�ַ���INPUT�׵�ַ
	MOV AH, 09H 	;�ַ������,��ʾ��ʾ��Ϣ
    INT 21H        
    MOV AH, 01H     ;�����ַ�
    INT 21H 	    ;�浽AL��   
    ;XLAT ����ָ�� ��DS:[BX+AL]ָ��Ĵ洢��Ԫ�������͵�AL
    AND AL, 0FH		;��AL����λ����
    LEA BX, TABLE	;ƫ�Ƶ�ַ����BX
    XLAT   
    PUSH AX			;����AX 
    MOV AH,2        ;����
    MOV DL,0AH      
    INT 21H
    MOV DX, OFFSET OUTPUT	;�ַ���OUTPUT�׵�ַ
    MOV AH, 09H 	;�ַ������
    INT 21H  
    POP AX			;��ջ
    CALL DISPLAY
    MOV AH, 4CH
    INT 21H
     
 
;��16����ת����ASCII�룬����Ļ�����
DISPLAY:
   PUSH BX ;ѹ���ջ����
   PUSH CX
   
   ;��λ���룬�ֱ���ʾ��λʮλ
   MOV AH,0
   MOV BL,10
   DIV BL  ; AX/10,����AL������AH
   XCHG AL,AH  ;һ�����ʵ�ֽ���AL��AH����
   OR AX,3030H ;��3030H��������תASCII��
   
   MOV CX,AX
   MOV DL,CH  ;AH��DL
   MOV AH,02H ;���ַ���ʾDL������
   INT 21H
    
   MOV DL,CL   ;AL��DL
   MOV AH,02H  ;���ַ���ʾDL������
   INT 21H 
   POP CX ;�ȳ�
   POP BX
RET
     
CODE ENDS 
END START  