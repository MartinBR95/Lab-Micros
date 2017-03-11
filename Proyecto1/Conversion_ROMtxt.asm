
_pregunta_parcua_izq:
    call _aumento_en_1             ;se llama la subrutina _aumento_en_1
    mov [cons_posicion],dil        ;se le otorga a cons_posicion los ultimos 8 bits de reg rdi que contiene el caracter de la posicion de memoria

    mov rax, [fin_cuenta]
    cmp rax, 0x1
    je _Loop_Enter_inicio

    mov rax, [cons_posicion]
    cmp rax, [cons_parcua_izq]      ;se compara el caracter de la memoria con parentesis cuadrado izq
    je _pregunta_instr              ;si es igual salta a preguntar si es una instruccion o un dato
    jne _pregunta_parcua_izq        ;si no lo es salta a pregunta_parcua_izq para preguntar por el caracter siguiente


_pregunta_instr:          
    call _aumento_en_1
    mov [cons_instdato],di         ;se guarda el contenido de memoria en cons_instdato [00 o 01]

    mov rax, [cons_instdato]
    cmp rax, [cons_addr_instr]     ;pregunta si instdato es igual a 0x3030, es decir una instruccion
    je _tomar_inst                 ;si lo es salta a tomar_inst

_pregunta_dato:
    mov rax, [cons_instdato]
    cmp rax, [cons_addr_dato]      ;pregunta si instdato es igual a 0x3031 [0x3130 al revez], es decir un dato
    jne _pregunta_parcua_izq       ;si no lo es salta a pregunta_parcua_izq

_tomar_dato:             
    call _aumento_en_10
    mov [cons_orden_inv],rdi
    call _inversion            ;se guarda el contenido de memoria que contiene la instruccion en cons_instruccion
    call _conversion    

_dato_a_mem:
    mov rax, [cons_acomodar_dato]
    add rax, 4                       ;se hace la suma de 8 en 8 cada vez que se va a acomodar una instruccion en un bloque de memoria 
    mov [cons_acomodar_dato], rax

    mov rax, [cons_hexa]
    mov rdi, [cons_acomodar_dato]
    mov [memoria_datos + rdi], eax
    jmp _pregunta_parcua_izq

_tomar_inst:   
    call _aumento_en_10
    mov [cons_orden_inv],rdi         ;se guarda el contenido de memoria que contiene la instruccion en cons_instruccion
    call _inversion
    call _conversion  

_instr_a_mem:
;   mov rax, [memoria_intr]         ;prueba para monitorear memoria
;   mov rax, [memoria_datos]        ;prueba
    mov rax, [cons_acomodar_inst]
    add rax, 4                       ;se hace la suma de 8 en 8 cada vez que se va a acomodar una instruccion en un bloque de memoria 
    mov [cons_acomodar_inst], rax

    mov rax, [cons_hexa]
    mov rdi, [cons_acomodar_inst]
    mov [memoria_intr + rdi], eax
    jmp _pregunta_parcua_izq
