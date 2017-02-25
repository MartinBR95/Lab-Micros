;Funcionalidad: Este es el segmento base del Emulador, se encarga de 
;directamente de la pantalla de inicio y de la de fin

;Parametros:(NO IMPLEMENTADOS AUN)
;ARG0 = $a0 
;ARG1 = $a1
;ARG2 = $a2
;ARG3 = $a3

;Restricciones: El archivo ROM.txt no debe pesar mas de 1TiB

;Macro para enviar texto a pantalla:
;1 arg: Puntero a texto a enviar
;2 arg: Tamaño de texto a enviar
%macro Impr_pant 2
	mov rax,1 ;sys_write
	mov rdi,1 ;Salida standard (pantalla)
	mov rsi,%1; mensaje a pantalla
	mov rdx,%2; tamaño del mensaje a imprimir
	syscall; llama al SO
	mov rax,1 ;sys_write
	mov rdi,[cons_Resultadostxt_fd] ;Salida standard (pantalla)
	mov rsi,%1; mensaje a escribir
	mov rdx,%2; tamaño del mensaje a escribir
	syscall; llama al SO
%endmacro

;seccion de constantes
section .data
;Se incluye el archivo que contiene todas las constantes de texto
%include "cons_texto.asm"
%include "Cons_proces.asm"
%include "CompFabr.asm"
%include "CompProcesadores.asm"

;seccion para valores no inicializados
section .bss
	cons_ENTER resb 1; se reservara un byte para el ENTER que finaliza el programa
	;constantes para manejar los valores asociados a ROM.txt
	cons_Stat_ROMtxt resb 144; se reservan 144 Bytes para las propiedades de ROM.txt de donde se obtendra el tamano
	cons_ROM_fd resb 8; donde se guardara el fd de ROM.txt
	cons_Resultadostxt_fd resb 8; donde se guardara el fd de Resultados.txt.txt
	cons_ROM_tamano resb 8; donde se guardara el tamano de ROM.txt
	cons_ROM_Memdir resb 8; donde se guardara la direccion en memoria de ROM.txt
	cons_fabricante_cpuid resb 16

;seccion de codigo
;Etiquetas:
section	 .text
	GLOBAL _start

_start:
;Se crea el archivo Resultados.txt
	mov rax,2 ;sys_open; en caso de acierto el fd queda en rax
	mov rdi,cons_Resultadostxt; se creara el archivo ROM.txt
	mov rsi,(2000o+1000o+100o+2o); bandera se creara o se truncara a 0 y se usara en modo append
	mov rdx,(700o+40o+4o);permisos
	syscall
	mov [cons_Resultadostxt_fd],rax

;Se imprime el texto de Bienvenida
	_test2:
	Impr_pant cons_Bienvenida, cons_Tamano_Bienvenida
 
;Se busca el archivo ROM.txt
	mov rax,2 ;sys_open; en caso de acierto el fd queda en rax
	mov rdi,cons_ROMtxt; se abrira el archivo ROM.txt
	mov rsi,0; bandera se abrira en solo lectura
	syscall 

;Se respalda el valor del Fd de ROM.txt
	mov [cons_ROM_fd], rax; se guarda el valor de rax(fd de ROM.txt)

;Se comparara el valor retornado por sys_open con el codigo de error
	and rax,0x10000000; se filtra el primer bit(signo negativo)
	cmp rax,0x10000000; los coddigos de error son negativos
	je _ROM_no_encontrado

;Se imprime "Archivo ROM.txt encontrado"
	Impr_pant cons_ROM_encontrado,cons_Tamano_ROM_encontrado

;En caso de encontrar el archivo ROM.txt se guardara en memoria
	;se obtendra el tamaño del archivo
	mov rax,4; sys_stat se obtendra el tamaño de ROM.txt para poder pasarlo a memoria
	mov rdi,cons_ROMtxt; se obtendran los datos de ROM.txt
	mov rsi,cons_Stat_ROMtxt; Donde se guardaran los datos
	syscall
;Se guarda el valor del tamaño de ROM.txt
	mov rax, qword [cons_Stat_ROMtxt + 48];48 sale del estudio de la estructura de STAT
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
	_test:
	mov [cons_ROM_Memdir],rax;se respalda el valor de la direccion en memoria de ROM.txt
	_test1:
;Se imprime "Presione enter para iniciar"
	Impr_pant cons_Textoinicial,cons_Tamano_Textoinicial

;Se leera el ENTER que inicia el programa
_Loop_Enter_inic:
	mov rax,0; sys_read;
	mov rdi,0; Se leera la entrada standard
	mov rsi,cons_ENTER;donde se guardara el ENTER
	mov rdx,2;se leera un byte
	syscall

;Compara si la tecla oprimida es ENTER
	cmp byte [cons_ENTER],0xa
	jne _Loop_Enter_inic; si la tecla oprimida no es enter se vuelve a leer



















;Se imprime Ejecucion exitosa
Impr_pant cons_Ejecucion_Exitosa,cons_Tamano_Ejecucion_exitosa

jmp _Fin_programa ;Salta al fin del Programa en caso de que corriera el programa con normalidad

;Texto a imprimir en caso de no haber encontrado el archivo ROM.txt
_ROM_no_encontrado:
	Impr_pant cons_ROM_no_encontrado,cons_Tamano_ROM_no_encontrado

;Se imprime mensaje de fin de programa
_Fin_programa:
	Impr_pant cons_TextoFinal,cons_Tamano_TextoFinal


;Se obtiene e imprime el fabricante del procesador
	call _ImprimeFabricante;se llama a la subrutina de buscar e imprimir el fabricante del procesador
	call _CompProces;se llama a la subrutina de buscar e imprimir el procesador

;Se leera el ENTER que finaliza el programa
_Loop_Enter_fin:
	mov rax,0; sys_read;
	mov rdi,0; Se leera la entrada standard
	mov rsi,cons_ENTER;donde se guardara el ENTER
	mov rdx,2;se leera un byte
	syscall

;Compara si la tecla oprimida es ENTER
	cmp byte [cons_ENTER],0xa
	jne _Loop_Enter_fin; si la tecla oprimida no es enter se vuelve a leer
	;liberar recursos
	mov rax,60	;sys_exit
	mov rdi,0	;sin codigo de error
	syscall

