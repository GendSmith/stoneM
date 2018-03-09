; ����Դ���루stone.asm��
; ���������ı���ʽ��ʾ���ϴ���������һ��*��,��45���������˶���ײ���߿�������,��������.
;   NASM������ʽ
    Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
    Up_Rt equ 2                  ;
    Up_Lt equ 3                  ;
    Dn_Lt equ 4                  ;
    delay equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ������ٶ�
    ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ������ٶ�

    org 07c00h					; �������ص�100h������������COM

DispInfo:
	mov	ax,0B800h				; �ı������Դ���ʼ��ַ
	mov es,ax
	mov byte [es:0000],'G'
	mov byte [es:0002],'o'
	mov byte [es:0004],'o'
	mov byte [es:0006],'d'
	mov byte [es:0008],'G'
	mov byte [es:0010],'o'
	mov byte [es:0012],'o'
	mov byte [es:0014],'d'
	mov byte [es:0016],'S'
	mov byte [es:0018],'t'
	mov byte [es:0020],'u'
	mov byte [es:0022],'d'
	mov byte [es:0024],'y'
	mov byte [es:0026],'D'
	mov byte [es:0028],'a'
	mov byte [es:0030],'y'
	mov byte [es:0032],'D'
  mov byte [es:0034],'a'
  mov byte [es:0036],'y'
  mov byte [es:0038],'U'
  mov byte [es:0040],'p'
	jmp start



start:
	xor ax,ax					; AX = 0   �������ص�0000��100h������ȷִ��
      mov ax,cs
	mov es,ax					; ES = 0
	mov ds,ax					; DS = CS

	mov	ax,0B800h				; �ı������Դ���ʼ��ַ
	mov es,ax
	mov	gs,ax					; GS = B800h
      mov byte[char],'A'
loop1:
	dec word[count]				; �ݼ���������
	jnz loop1					; >0����ת;
	mov word[count],delay
	dec word[dcount]				; �ݼ���������
      jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay

      mov al,1
      cmp al,byte[rdul]
	jz  DnRt

      mov al,2
      cmp al,byte[rdul]
	jz  UpRt

      mov al,3
      cmp al,byte[rdul]
	jz  UpLt

      mov al,4
      cmp al,byte[rdul]
	jz  DnLt

      jmp $

DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dr2ur
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  dr2dl
	jmp show
dr2ur:
      mov word[x],23
      mov byte[rdul],Up_Rt
      jmp show
dr2dl:
      mov word[y],78
      mov byte[rdul],Dn_Lt
      jmp show

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  ur2ul
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ur2dr
	jmp show
ur2ul:
      mov word[y],78
      mov byte[rdul],Up_Lt
      jmp show
ur2dr:
      mov word[x],1
      mov byte[rdul],Dn_Rt
      jmp show



UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ul2dl
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  ul2ur
	jmp show

ul2dl:
      mov word[x],1
      mov byte[rdul],Dn_Lt
      jmp show
ul2ur:
      mov word[y],1
      mov byte[rdul],Up_Rt
      jmp show



DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  dl2dr
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dl2ul
	jmp show

dl2dr:
      mov word[y],1
      mov byte[rdul],Dn_Rt
      jmp show

dl2ul:
      mov word[x],23
      mov byte[rdul],Up_Lt
      jmp show


show:
      xor ax,ax                 ; �����Դ���ַ
      mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2
	mul bx
	mov bp,ax
	mov ah,0Fh				;  0000���ڵס�1111�������֣�Ĭ��ֵΪ07h��
	mov al,byte[char]			;  AL = ��ʾ�ַ�ֵ��Ĭ��ֵΪ20h=�ո�����
	mov word[gs:bp],ax  		;  ��ʾ�ַ���ASCII��ֵ

	jmp loop1





end:
    jmp $                   ; ֹͣ����������ѭ��

datadef:
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; �������˶�
    x    dw 7
    y    dw 0
    char db 'A'
