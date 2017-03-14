
;Macro para enviar texto a pantalla:
;1 arg: Puntero a texto a enviar
;2 arg: Tamaño de texto a enviar
%macro Impr_pant 2
    mov rax,1           ;sys_write
    mov rdi,1           ;Salida standard (pantalla)
    mov rsi,%1          ;mensaje a pantalla
    mov rdx,%2          ;tamaño del mensaje a imprimir
    syscall             ;llama al SO

    mov rax,1           ;sys_write
    mov rdi,[cons_Resultadostxt_fd] ;Salida standard (pantalla)
    mov rsi,%1          ;mensaje a escribir
    mov rdx,%2          ;tamaño del mensaje a escribir
    syscall             ;llama al SO
%endmacro

;Por su naturaleza los parametros de este macro no pueden ser rcx ni de r12 a r15
;Resibe como primer parametro la direccion en memoria de un numero de max 32b a imprimir
;Resibe como segundo la cantidad de caracteres a imprimir(max 8)
%macro Impr_NUMtoASCII 2
%%inicio_NUMtoASCII:
    add [cont_NUMtoASCII],byte 1 ;se aumenta el contador de los numeros a imprimir
    mov r15b,[cont_NUMtoASCII] ;contador inicial
    cmp r15b,[%2] ;Compara el valor del contador con la cantidad de numeros aa imprimir
    je %%Fin_impr ;Si se ha terminado de imprimir los numeros se sale del macro
    ;Se imprimira un numero:
    mov r14,[%1] ;se pasa el numero a imprimir a r14
    mov rcx,4 ;se prepara cl con 4 para saber cuantas veces debe desplazarse el valor de r14
    imul rcx,r15 ;se obtine en cl la cantidad de bits que debe desplazarse r14
    ;Codigo para invertir la salida
    	mov r15,[%2]
    	imul r15,4
    	sub r15,4
        mov r12, r15
        sub r12,rcx
        mov cl,r12b

    shr r14,cl ;se desplaza r14
    and r14,1111b ;se enmascara r14 para obtener el numero a imprimir
    cmp r14,1001b ;se compara con 9
    jle %%Num_0_9 ;si el numero es menor que nueve se alinea a los numeros ascii
    jmp %%NUM_A_F ;si el numero es mayor que nueve se alinea a las letras ascii

%%Num_0_9:
    add r14,30h ;se alinea el valor a los numeros ascii de 0 a 9
    mov [var_NUMtoSCR],r14 ;se guarda porque el macro de imprescion resibe la direccion en memoria
    Impr_pant var_NUMtoSCR,1 ;Se imprime el numero
    jmp %%inicio_NUMtoASCII ;se retorna al inicio de la funcion

%%NUM_A_F:
    add r14,37h ;se alinea el valor a los numeros ascii de 0 a 9
    mov [var_NUMtoSCR],r14 ;se guarda porque el macro de imprescion resibe la direccion en memoria
    Impr_pant var_NUMtoSCR,1 ;Se imprime el numero
    jmp %%inicio_NUMtoASCII ;se retorna al inicio de la funcion


%%Fin_impr:
    mov [cont_NUMtoASCII],byte -1 ;se reinicia el valor del contador
%endmacro