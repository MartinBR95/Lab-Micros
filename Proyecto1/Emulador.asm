;Funcionalidad: Este es el segmento base del Emulador, se encarga de 
;directamente de la pantalla de inicio y de la de fin

;Parametros:(NO IMPLEMENTADOS AUN)
;ARG0 = $a0 
;ARG1 = $a1
;ARG2 = $a2
;ARG3 = $a3

;Restricciones: El archivo ROM.txt no debe pesar mas de 1TiB

;seccion de constante
section .data
	;se define el texto de la pantalla de inicio
	cons_Bienvenida db 0xa,'                 Bienvenido al Emulador de MIPS',0xa,0xa,'Curso: El-4313 Lab. Estructura de Microprocesadores',0xa,'Semestre: 1S-2017',0xa,'Buscando archivo ROM.txt',0xa,0xa,0xa,0xa
	cons_Tamano_Bienvenida equ $-cons_Bienvenida
	;constante para la busqueda del archivo ROM.txt
	cons_ROMtxt db 'ROM.txt',0; caracter nulo para que el SO lea el nombre del archivo
	;constantes para pantalla final
	cons_ROM_no_encontrado db 'Archivo ROM.txt no encontrado',0xa,0xa
	cons_Tamano_ROM_no_encontrado equ $-cons_ROM_no_encontrado

	cons_TextoFinal db '                 Precione ENTER para Finalizar',0xa,0xa,'Martin Barquero Retana 2014043266',0xa
	cons_Tamano_TextoFinal equ $-cons_TextoFinal

;seccion para valores no inicializados
section .bss
	cons_ENTER_fin resb 1; se reservara un byte para el ENTER que finaliza el programa
	;constantes para manejar los valores asociados a ROM.txt
	cons_Stat_ROMtxt resb 144; se reservan 10 Bytes para las propiedades de ROM.txt de donde se obtendra el tamano
	cons_ROM_fd resb 1; donde se guardara el fd de ROM.txt
	cons_ROM_tamano resb 5; donde se guardara el tamano de ROM.txt
	cons_ROM_Memdir resb 16; donde se guardara la direccion en memoria de ROM.txt

;Estructura de datos del stat o system call de los datos de un archivo 
    stat resb 144

struc STAT
    .st_dev         resq 1
    .st_ino         resq 1
    .st_nlink       resq 1
    .st_mode        resd 1
    .st_uid         resd 1
    .st_gid         resd 1
    .pad0           resb 4
    .st_rdev        resq 1
    .st_size        resq 1
    .st_blksize     resq 1
    .st_blocks      resq 1
    .st_atime       resq 1
    .st_atime_nsec  resq 1
    .st_mtime       resq 1
    .st_mtime_nsec  resq 1
    .st_ctime       resq 1
    .st_ctime_nsec  resq 1
endstruc


;seccion de codigo
;Etiquetas:
section	 .text
	GLOBAL _start
	GLOBAL _Fin_programa
	GLOBAL _ROM_no_encontrado
	GLOBAL _test

_start:
;Se imprime el texto de Bienvenida
	mov rax,1 ;sys_write
	mov rdi,1 ;Salida standard (pantalla)
	mov rsi,cons_Bienvenida; mensaje a pantalla
	mov rdx,cons_Tamano_Bienvenida; tamaño del mensaje a imprimir
	syscall; llama al SO

;Se busca el archivo ROM.txt
	mov rax,2 ;sys_open; en caso de asierto el fd queda en rax
	mov rdi,cons_ROMtxt; se abrira el archivo ROM.txt
	mov rsi,0; bandera se abrira en solo lectura
	syscall 

;Se respalda el valor del Fd de ROM.txt
	mov [cons_ROM_fd], rax; se guarda el valor de rax(fd de ROM.txt)
;Se comparara el valor retornado por sys_open con el codigo de error
	and rax,0x10000000; se filtra el primer bit(signo negativo)
	cmp rax,0x10000000; los coddigos de error son negativos
	je _ROM_no_encontrado

;En caso de encontrar el archivo ROM.txt se guardara en memoria
	;se obtendra el tamaño del archivo
	mov rax,4; sys_stat se obtendra el tamaño de ROM.txt para poder pasarlo a memoria
	mov rdi,cons_ROMtxt; se obtendran los datos de ROM.txt
	mov rsi,stat; Donde se guardaran los datos
	syscall
;Se guarda el valor del tamaño de ROM.txt
	mov rax, qword [stat + STAT.st_size]
	mov [cons_ROM_tamano],rax
;se creara un espacio en memoria para los datos de ROM.txt

	mov rax,9; sys_mmap 
	mov rdi,0; El SO pone la memoria donde bien le convenga
	mov rsi,[cons_ROM_tamano]; el tamaño de la memoria
	mov rdx,1; solo lectura
	mov r10,2; datos son privados a otros procesos
	movzx r8, byte [cons_ROM_fd]; fd de ROM.txt
	mov r9,0;offset del archivo a leer
	syscall
	mov [cons_ROM_Memdir],rax;se respalda el valor de la direccion en memoria de ROM.txt
_test:
	


;Texto a imprimir en caso de no haber encontrado el archivo ROM.txt
jmp _Fin_programa ;Salta al fin del Programa en caso de que corriera el programa con normalidad
_ROM_no_encontrado:
	mov rax,1 ;sys_write
	mov rdi,1 ;Salida standard (pantalla)
	mov rsi,cons_ROM_no_encontrado; mensaje a pantalla
	mov rdx,cons_Tamano_ROM_no_encontrado; tamaño del mensaje a imprimir
	syscall; llama al SO

;Se imprime mensaje de fin de programa
_Fin_programa:
	mov rax,1 ;sys_write
	mov rdi,1 ;Salida standard (pantalla)
	mov rsi,cons_TextoFinal; mensaje a pantalla
	mov rdx,cons_Tamano_TextoFinal; tamaño del mensaje a imprimir
	syscall; llama al SO

;Aqui deben ir los valores obtenidos del SO

;Se leera el ENTER que finaliza el programa
_Loop_Enter_fin:
	mov rax,0; sys_read;
	mov rdi,0; Se leera la entrada standard
	mov rsi,cons_ENTER_fin;donde se guardara el ENTER
	mov rdx,2;se leera un byte
	syscall

;Compara si la tecla oprimida es ENTER
	cmp byte [cons_ENTER_fin],0xa
	jne _Loop_Enter_fin; si la tecla oprimida no es enter se vuelve a leer
	;liberar recursos
	mov rax,60	;sys_exit
	mov rdi,0	;sin codigo de error
	syscall

