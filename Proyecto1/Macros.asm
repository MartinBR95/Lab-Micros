
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

;Por su naturaleza los parametros de este macro deben estar en memoria
;Recibe como primer parametro la direccion en memoria de un numero de max 32b a imprimir
;Recibe como segundo la cantidad de caracteres a imprimir(max 8)
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
        mov r12,r15
        sub r12,rcx
        mov cl,r12b

    shr r14,cl ;se desplaza r14
    and r14,1111b ;se enmascara r14 para obtener el numero a imprimir
    cmp r14,1001b ;se compara con 9
    jle %%Num_0_9 ;si el numero es menor que nueve se alinea a los numeros ascii
    
    ;si el numero es mayor que nueve se alinea a las letras ascii
    add r14,37h ;se alinea el valor a los numeros ascii de 0 a 9
    mov [var_NUMtoSCR],r14b ;se guarda porque el macro de imprescion resibe la direccion en memoria
    Impr_pant var_NUMtoSCR,1 ;Se imprime el numero
    jmp %%inicio_NUMtoASCII ;se retorna al inicio de la funcion

%%Num_0_9:
    add r14,30h ;se alinea el valor a los numeros ascii de 0 a 9
    mov [var_NUMtoSCR],r14b ;se guarda porque el macro de imprescion resibe la direccion en memoria
    Impr_pant var_NUMtoSCR,1 ;Se imprime el numero
    jmp %%inicio_NUMtoASCII ;se retorna al inicio de la funcion

%%Fin_impr:
    mov [cont_NUMtoASCII],byte -1 ;se reinicia el valor del contador
%endmacro



;el primer parametro es la direccion de memoria donde estan los datos en ASCII
;el segundo parametro es la direccion de memoria donde s guardaran los datos en binario
;el tercer parametro es la cantidad de caracteres

%macro ASCIItoNUM_32b 2
    mov rbx,0x0 ;se inicializa
    mov r8 ,0x0
    mov rcx,0x0
    mov rdx,0x0
    mov r12, [var_ASCIItoNUM];direccion de memoria donde estan los datos en ASCII
    mov r10,-1  ;cantidad de numeros a convertir
    mov r13,-1  ;contador sobre la salida
    jmp _Primer_num

_Valor_nulo:
    sub r13,1 ;en caso de que el valor de entrada sea nulo no se avansa sobre la salida
_Siguiente_Numero:
    shl r12,8 ;se desplaza para obtener cada letra
_Primer_num:
    mov rax,r12 ;se pasa a rax que sera el modificado
    shr rax,56 ;se desplaza para obtener los 8MSB
    add r10,1 ;se aumenta el contador de caracteres
    add r13,1 ;se aumenta el contador de salida
    cmp r10,8 ;se compara si se ha terminado el ciclo    
    je _Fin_ASCIItoNUM_32b 
    mov r8,0x0 ;se limpia el registro  
    mov r8b,al ;registro auxiliar    
    cmp al,0x0 ;se compara para buscar el inicio de los caracteres
    je _Valor_nulo  ;no se desplaza sobre la salida en caso de no ser un caracter  
    cmp al,0x39 ;se compara para saber si es menor a 9    
    jle _Num_0_9    
    cmp al,0x61 ;se compara para saber si es mayor a 9
    jge _NUM_a_b

    ;Numero mayor a 9 en mayuscula
        sub r8b,0x37 ;se corrije el ascii        
        mov rcx,r13 ;registro auxiliar        
        imul rcx,4 ;se obtiene la cantidad de bits a desplazar en la salida        
        shl r8,cl ;se desplaza        
        add rbx,r8 ;registro de salida        
        jmp _Siguiente_Numero

    ;Numero mayor a 9 en minuscula
    _NUM_a_b:
        sub r8b,0x57 ;se corrije el ascii
        mov rcx,r13 ;registro auxiliar
        imul rcx,4 ;se obtiene la cantidad de bits a desplazar en la salida
        shl r8,cl ;se desplaza
        add rbx,r8 ;registro de salida
        jmp _Siguiente_Numero

    ;Numero de 0 a 9
    _Num_0_9:
        sub r8b,0x30 ;se corrije el ascii
        mov rcx,r13 ;registro auxiliar
        imul rcx,4 ;se obtiene la cantidad de bits a desplazar en la salida
        shl r8,cl ;se desplaza
        add rbx,r8 ;registro de salida
        jmp _Siguiente_Numero

_Fin_ASCIItoNUM_32b:
    mov [r11],ebx ; se mueve el dato a la salida

%endmacro