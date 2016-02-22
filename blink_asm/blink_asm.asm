;=============================================================================
;
;This software shows how to work with gpio using assembler on Galileo Gen1 board.
;
;If you want to contact me, you may find my account on
;https://communities.intel.com/community/tech/galileo/content
;or send e-mail on pub@relvarsoft.com
;
;xbolshe
;
;=============================================================================
;The MIT License (MIT)
;
;Copyright (c) 2016 xbolshe
;
;Permission is hereby granted, free of charge, to any person obtaining a copy
;of this software and associated documentation files (the "Software"), to deal
;in the Software without restriction, including without limitation the rights
;to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;copies of the Software, and to permit persons to whom the Software is
;furnished to do so, subject to the following conditions:
;
;The above copyright notice and this permission notice shall be included in
;all copies or substantial portions of the Software.
;
;THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;THE SOFTWARE.
;
;=============================================================================
;
;Version 1.0, Feb 2016, xbolshe
;    - first public release (available on https://github.com/xbolshe/galileo-sources/blink_asm/ )
;
;=============================================================================

        SECTION .data
str1:
	db	'Blink on Galileo Gen1 board using assembler',13,10
	db	'Copyright 2016, Eugene Bolshakov',13,10
	db	0
str2	db	'/sys/class/gpio/export',0
str3	db	'/sys/class/gpio/gpio3/value',0
str4	db	'/sys/class/gpio/gpio3/direction',0
strin	db	'in',0
strout	db	'out',0
sleep:	dd	1,0,0,0
sleep2:	dd	0,0,0,0
val0	db	'0',0
val1	db	'1',0
val3	db	'3',0

        SECTION .text
        global  _start
_start:
	;welcome message
	
	mov	edx,80
	mov	ecx,str1
	mov	ebx,1
	mov	eax,4
	int	80h
	
	;export

	mov	ebx,str2
	mov	esi,val3
	mov	edi,1
	call	export

	;set pins as output

	mov	ebx,str4
	mov	esi,strout
	mov	edi,3
	call	export

	mov	ebp,5
next:
	push	ebp
	
	;set pin IO13 as HIGH

	mov	ebx,str3
	mov	esi,val1
	mov	edi,1
	call	export

	;delay 1 second

	mov	ebx,sleep
	mov	ecx,sleep2
	mov	eax,162
	int	80h
	
	;set pin IO13 as LOW

	mov	ebx,str3
	mov	esi,val0
	mov	edi,3
	call	export

	;delay 1 second

	mov	ebx,sleep
	mov	ecx,sleep2
	mov	eax,162
	int	80h

	
	pop	ebp
	dec	ebp
	jnz	next

	;exit

        mov     eax,1
        int	80h

export:
	push	eax
	push	esi
	push	edi

	mov	ecx,1
	mov	eax,5
	int	80h
	mov	ebx,eax
	cmp	eax,-2048
	pop	edx
	pop	ecx
	pop	eax
	ja	exporte

	mov	eax,4
	push	ebx
	int	80h
	pop	ebx
	
	mov	eax,6
	int	80h
exporte:
	ret

