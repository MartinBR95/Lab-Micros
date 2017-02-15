section .data
	;se define el texto de la pantalla de inicio
	cons_Bienvenida db 0xa,'                 Bienvenido al Emulador de MIPS',0xa,0xa,'Curso: El-4313 Lab. Estructura de Microprocesadores !',0xa,'Semestre: 1S-2017',0xa,'Buscando archivo ROM.txt',0xa,0xa,0xa,0xa
	cons_Tamano_Bienvenida equ $-cons_Bienvenida
	;constante para la busqueda del archivo ROM.txt
	cons_ROMtxt db 'ROM.txt'
	;constantes para pantalla final
	cons_ROM_no_encontrado db 'Archivo ROM.txt no encontrado',0xa,0xa
	cons_Tamano_ROM_no_encontrado equ $-cons_ROM_no_encontrado

	cons_TextoFinal db '                 Precione ENTER para Finalizar',0xa,0xa,'Martin Barquero Retana 2014043266',0xa
	cons_Tamano_TextoFinal equ $-cons_TextoFinal

;seccion para valores no inicializados
section .bss
	cons_ENTER_fin resb 1; se reservara un byte para el ENTER que finaliza el programa



section	 .text
	GLOBAL _start
	GLOBAL _test
	GLOBAL _Fin_programa
	GLOBAL _ROM_no_encontrado
_start:
	mov rax,1 ;sys_write
	mov rdi,1 ;Salida standard (pantalla)
	mov rsi,cons_Bienvenida; mensaje a pantalla
	mov rdx,cons_Tamano_Bienvenida; tamaño del mensaje a imprimir
	syscall; llama al SO

;Se busca el archivo ROM.txt
	mov rax,2 ;sys_open
	mov rdi, cons_ROMtxt; se abrira el archivo ROM.txt
	mov rsi, 0
	syscall 
_test:
	;se comparara el valor retornado por sys_open con el codigo de error	
	cmp rax,-2; -2 es el coddigo de error en caso de no encontrar el archivo
	je _ROM_no_encontrado
	


_ROM_no_encontrado:
	mov rax,1 ;sys_write
	mov rdi,1 ;Salida standard (pantalla)
	mov rsi,cons_ROM_no_encontrado; mensaje a pantalla
	mov rdx,cons_Tamano_ROM_no_encontrado; tamaño del mensaje a imprimir
	syscall; llama al SO

_Fin_programa:

	mov rax,1 ;sys_write
	mov rdi,1 ;Salida standard (pantalla)
	mov rsi,cons_TextoFinal; mensaje a pantalla
	mov rdx,cons_Tamano_TextoFinal; tamaño del mensaje a imprimir
	syscall; llama al SO

_Loop_Enter_fin:

	mov rax,0; Se leera el ENTER que finaliza el programa
	mov rdi,0; Se leera la entrada standard
	mov rsi,cons_ENTER_fin;donde se guardara el ENTER
	mov rdx,2;se leera un byte
	syscall

	cmp byte [cons_ENTER_fin],0xa;Compara si la tecla oprimida es ENTER
	jne _Loop_Enter_fin
	;liberar recursos
	mov rax,60	;sys_exit
	mov rdi,0	;sin codigo de error
	syscall

