;Funcionalidad: Este es el segmento base del Emulador, se encarga de 
;directamente de la pantalla de inicio y de la de fin

;Parametros:(NO IMPLEMENTADOS AUN)
;ARG0 = $a0 
;ARG1 = $a1
;ARG2 = $a2
;ARG3 = $a3

;Restricciones: El archivo ROM.txt no debe tener más de 100 instrucciones y 150 datos en memoria
;Los parametros por su naturaleza son de maximo 32b y en hexadecimal






;------------------------Segmento de datos--------------------------------------
section .data
;Se incluye el archivo que contiene todas las constantes de texto
%include "Macros.asm"
%include "cons_.asm"
%include "cons_proces.asm"
%include "CompFabr.asm"
%include "CompProcesadores.asm"
%include "Inversion.asm"
%include "Aumentos.asm"
%include "Conversion.asm"
%include "Execute.asm"
%include "Posicion_mem_dato.asm"
;-------------------------Segmento  para valores no inicializados-------------
section .bss 

	cons_ENTER resb 1			      ;se reserva un byte para el ENTER

;constantes para manejar los valores asociados a ROM.txt
    cons_Stat_ROMtxt: resb 144        ;se reservan 10 Bytes para las propiedades de ROM.txt de donde se obtendra el tamano
	cons_ROM_fd: resb 8			      ;donde se guardara el fd de ROM.txt
    cons_Resultadostxt_fd resb 8      ;donde se guardara el fd de Resultados.txt.txt
    cons_ROM_tamano: resb 8			  ;donde se guardara el tamano de ROM.txt
    cons_ROM_Memdir: resb 8		      ;donde se guardara la direccion en memoria de ROM.txt
	cons_fabricante_cpuid: resb 16
    memoria_intr: resd 150
    memoria_datos: resd 100 

    cons_posicion: resb 8             ;contiene contenido de posicion actual del recorrido en memoria uno por uno
    cons_instdato: resb 8             ;contiene dato obtenido de memoria que dira si es instruccion o dato [00 o 10]
    cons_orden_correcto: resb 8       ;contiene la instruccion obtenida de memoria en el orden correcto
    cons_orden_inv: resb 8            ;contiene la instruccion o dato obtenida de memoria inverso

    cons_inversor: resb 8             ;utilizada para el proceso de inversion
    cons_cuentapos: resb 8            ;utilizada para el proceso de inversion
    fin_cuenta: resb 8                ;se utiliza como bandera que implica que la memoria donde esta el txt se termino de recorrer

    cons_cuenta_conv: resb 8          ;utilizada para el proceso de conversion
    cons_conversion: resb 8           ;utilizada para el proceso de conversion
    cons_cuenta_hexa: resb 8          ;utilizada para el proceso de conversion y acomodo de bits
    cons_hexa: resb 8                 ;contiene el dato o instruccion de 32 bits que sera transferido a memoria
    cons_movimiento: resb 8           ;utilizada para el proceso de conversion

    var_NUMtoConvert resq 1           ; Variable para numeros que se convertiran a ASCII
    var_tamano_NUMtoConvert resb 1    ; Cantidad de caracteres del numero a imprimir
    var_NUMtoSCR resb 1               ; se reserba un byte para imprimir numero en pantalla
    var_ASCIItoNUM resq 1			  ; variable para numeros que se traduciran de ASCII a binario

    instruccion: resb 4               ;instruccion aislada para analisis
    PC_I         resd 1
    HOLA		 resd 1
; EXECUTE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    nomb_inst   resb 6      ;Se reserba 5 bytes de memoria para el nombre de cada instruccion (impresion)


;;;;;;;;;;;;;;;;;; Variables de simulacion de Mips ;;;;;;;;;;;;;;;;;;;
    
    regs_sim    resd 32     ;Registros simulados 
    HI resd 1               ;Parte alta de la multiplicacion
    LO resd 1               ;Parte baja de la multiplicacion
    

;;;;;;;;;;;;;;;; Variables de descompocion de instruccion ;;;;;;;;;;;;;

    ;Partes estandar de las intrucciones
    opcode      resw 1
    rs          resb 1
    rt          resb 1

    ;Partes especificas de instruccion tipo R
    rd          resb 1 
    shamt       resb 1 
    funct       resb 1

    ;Partes especificas de instruccion tipo I
    inmediate   resb 2

    ;Partes especificas de instruccion tipo J
    address     resb 3
    pos_mem_dato resq 1

;-------------------------------Segmento para codigo--------------------------------
section	 .text
	global _start
_start:

	mov rax, regs_sim  	 		;Se guarda un 0 en el r0
	mov dword [regs_sim], 0x0

;Se parasan los argumentos a memoria
	pop r15;se saca de stack la cantidad de argumentos
	pop rbx;se saca de stack el path
	mov r11,(regs_sim+12);direccion-4 de $a0
	_break5:
	jmp (_Parametros2)

_Parametros:
	ASCIItoNUM_32b var_ASCIItoNUM,r11
	mov qword [var_ASCIItoNUM],0x0

_Parametros2:	
	mov r9,var_ASCIItoNUM;direccion-4 de $a0
	sub r15,1;se movera un argumento
	cmp r15,0x0;se compara para saber si ya se cargaron todos los argumentos
	je _Fin_parametros;si ya se leyeron todos los argumentos se continua con el programa
	;en caso de faltar argumentos
	pop r14; se saca un dato del stack

	add r11,4;se pasa al registro simulado siguiente
	mov rdx,[r14];se pasa el dato de memoria


;se extraeran los valores byte a byte comparandolos con 0x0 en ese caso lo que sigue no forma parte del parametro
	cmp dl,0x0;se busca el caracter nulo
	je _Parametros
	mov [r9],dl
	shr rdx,8

	cmp dl,0x0;se busca el caracter nulo
	je _Parametros
	add  r9,1;en caso de ser un valor se pasa byte por byte hasta 64b
	mov [r9],dl
	shr rdx,8	

	cmp dl,0x0;se busca el caracter nulo
	je _Parametros
	add  r9,1;en caso de ser un valor se pasa byte por byte hasta 64b
	mov [r9],dl
	shr rdx,8	

	cmp dl,0x0;se busca el caracter nulo
	je _Parametros
	add  r9,1;en caso de ser un valor se pasa byte por byte hasta 64b
	mov [r9],dl
	shr rdx,8

	cmp dl,0x0;se busca el caracter nulo
	je _Parametros
	add  r9,1;en caso de ser un valor se pasa byte por byte hasta 64b
	mov [r9],dl
	shr rdx,8

	cmp dl,0x0;se busca el caracter nulo
	je _Parametros
	add  r9,1;en caso de ser un valor se pasa byte por byte hasta 64b
	mov [r9],dl
	shr rdx,8

	cmp dl,0x0;se busca el caracter nulo
	je _Parametros
	add  r9,1;en caso de ser un valor se pasa byte por byte hasta 64b
	mov [r9],dl
	shr rdx,8

	cmp dl,0x0;se busca el caracter nulo
	je _Parametros
	add  r9,1;en caso de ser un valor se pasa byte por byte hasta 64b
	mov [r9],dl
	shr rdx,8

	jmp _Parametros

_Fin_parametros:

	

	_break4:
;Se crea el archivo Resultados.txt
    mov rax,2                           ;sys_open; en caso de acierto el fd queda en rax
    mov rdi,cons_Resultadostxt          ;se creara el archivo ROM.txt
    mov rsi,(2000o+1000o+100o+2o)       ;bandera se creara o se truncara a 0 y se usara en modo append
    mov rdx,(700o+40o+4o)               ;permisos
    syscall
    mov [cons_Resultadostxt_fd],rax		;se respalda el fd del archivo de resultados

;Se imprime el texto de bienvenida
	Impr_pant cons_Bienvenida,cons_Tamano_Bienvenida

;Se busca el archivo ROM.txt
	mov rax,2 			      ;sys_open en caso de asierto el fd queda en rax
	mov rdi,cons_ROMtxt		  ;se abrira el archivo ROM.txt
	mov rsi,0				  ;bandera se abrira en solo lectura				
	syscall

;Se respalda el valor del Fd de ROM.txt
    mov [cons_ROM_fd],rax	  ;se guarda el valor de rax(fd de ROM.txt)

;Se comparara el valor retornado por sys_open con el codigo de error
    and rax,0x10000000		  ;se filtra el primer bit(signo negativo)
    cmp rax,0x10000000	      ;los codigos de error son negativos
    je _ROM_no_encontrado	  ;En caso de que sea negativo salta a ROM_no_encontrado

;Si encuentra archivo, entonces imprime msj de archivo encontrado
    Impr_pant cons_ROM_encontrado,cons_Tamano_ROM_encontrado

;En caso de encontrar el archivo ROM.txt se guardara en memoria
	;se obtendra el tamaño del archivo
    mov rax,4                 ;sys_stat se obtendra el tamaño de ROM.txt para poder pasarlo a memoria
    mov rdi,cons_ROMtxt       ;se obtendran los datos de ROM.txt
    mov rsi,cons_Stat_ROMtxt  ;Donde se guardaran los datos
    syscall
;Se guarda el valor del tamaño de ROM.txt
    mov rax, qword [cons_Stat_ROMtxt + 48];48 sale del estudio de la estructura de STAT
    mov [cons_ROM_tamano],rax

;se creara un espacio en memoria para los datos de ROM.txt
    mov rax,9                       ;sys_mmap
    mov rdi,0                       ;El SO pone la memoria donde bien le convenga
    mov rsi,[cons_ROM_tamano]       ;el tamaño de la memoria
    mov rdx,1                       ;solo lectura
    mov r10,2                       ;datos son privados a otros procesos
    movzx r8, byte [cons_ROM_fd]    ;fd de ROM.txt
    mov r9,0                        ;offset del archivo a leer
    syscall
    mov [cons_ROM_Memdir],rax       ;se respalda el valor de la direccion en memoria de ROM.txt

;Se transformara la ROM.txt a la memoria
    %include "Conversion_ROMtxt.asm"

Impr_pant cons_ENTER_inicio,cons_Tamano_ENTER_inicio
_Loop_Enter_inicio:

    mov rax,0                        ; sys_read Se leera el ENTER que inicia  el programa
    mov rdi,0                        ;Se leera la entrada standard
    mov rsi,cons_ENTER               ;donde se guardara el ENTER
    mov rdx,1                        ;se leera un byte
    syscall
    cmp byte [cons_ENTER ],0xa   ;Compara si la tecla oprimida es ENTER
    jne _Loop_Enter_inicio     ; si la tecla oprimida no es enter se vuelve a leer

;Se compara el codigo de operacion de las instrucciones
;Se ejecuta el codigo equivalente de las instrucciones
_ciclo_instruccion:

	call _PC;secuencia que aumenta el PC y mueve la instruccion de la memoria_intr a un espacio especial
	mov eax,0xc
	cmp eax,[instruccion];se compara si la instruccion es de fin de programa


	je _Fin_ciclo_instruccion;en caso de in de programa
	call _Execute
   	break32:
    cmp rax,0xc ; se valida se hubo o no ejecucion exitosa
	je _Fin_programa; en caso de no haber una ejecucion exitosa


	jmp _ciclo_instruccion

_Fin_ciclo_instruccion:


;Se imprime Ejecucion exitosa
Impr_pant cons_exe_exitosa,cons_exe_exitosa_tamano
jmp _Fin_programa;Salta al fin del Programa en caso de que corriera el programa con normalidad

;Texto a imprimir en caso de no haber encontrado el archivo ROM.txt
_ROM_no_encontrado:
	Impr_pant cons_ROM_no_encontrado,cons_Tamano_ROM_no_encontrado

;Se imprime mensaje de fin de programa
_Fin_programa:
;Se obtiene e imprime el fabricante del procesador
	call _ImprimeFabricante

;Se obtiene e imprime  el procesador
	call _CompProces

;Se imprimen miembros del grupo
	Impr_pant cons_Texto_Final,cons_Tamano_Texto_Final

;Se muestra mensaje de oprimir ENTER para finalizar
	Impr_pant cons_ENTER_final,cons_Tamano_ENTER_final


;Se leera el ENTER que finaliza el programa
_Loop_Enter_fin:
    mov rax,0                        ;Se leera el ENTER que finaliza el programa
    mov rdi,0                        ;Se leera la entrada standard
    mov rsi,cons_ENTER		         ;donde se guardara el ENTER
    mov rdx,1                        ;se leera un byte
    syscall
;Compara si la tecla oprimida es ENTER
    cmp byte [cons_ENTER],0xa        ;Compara si la tecla oprimida es ENTER
    jne _Loop_Enter_fin

;liberar_recursos
	mov rax,60	                         ;sys_exit
	mov rdi,0	                         ;sin codigo de error
	syscall
