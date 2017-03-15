;-----------------------------------------subrutina aumento en 1 cons_avance------------------------------------------
;se encarga de aumentar en 1 cons_avance para el recorrido de la memoria donde se guardo lo tomado del txt
_aumento_en_1:
    add qword [cons_avance],1             ;se suma 1 a cons_avance,
    mov rax,[cons_avance]           ;se otorga el resultado a cons_avance para la proxima iteracion

    cmp rax,[cons_ROM_tamano]       ;compara cons_avance con el valor de cons_ROM_tamano para saber si ya llego al final de lo tomado del txt
    je _finalizar

    mov rax,[cons_ROM_Memdir]
    add rax,[cons_avance]          ;se suma cons_avance con cons_ROM_Memdir para movernos a la posicion de memoria
    mov rdi,[rax]
    jmp _regreso

_finalizar:
    mov rsi, 0x1
    mov [fin_cuenta], sil          ;activa bandera de que finalizo el recorrido de memoria donde esta el txt

_regreso:
    ret
;-----------------------------------------FIN subrutina aumento en 1 cons_avance--------------------------------------


;-----------------------------------------subrutina aumento en 10 cons_avance-----------------------------------------
;se encarga de aumentar en 10 cons_avance para que una vez que reconoce [ salte a tomar el dato o la instruccion
_aumento_en_10:
    mov rax,[cons_avance]          
    add rax,10                      ;se suma 10 a cons_avance, para caer en la posicion donde inicia una inst o un dato
    mov [cons_avance],rax 

    mov rax,[cons_ROM_Memdir]
    add rax,[cons_avance]          ;se suma cons_avance con cons_ROM_Memdir para movernos a la posicion de memoria
    mov rdi,[rax]

    ret
;-----------------------------------------FIN subrutina aumento en 10 cons_avance--------------------------------------

;----------------------------------------------------------aumento PC------------------------------------------------------------------
_PC:
    mov rax,[PC]          
    add rax,4                      ;se suma 4 a PC, para recorrido en memoria_intr
    mov [PC],rax 

    mov rax,memoria_intr
    add rax,[PC]          
    mov rdi,[rax]               ;se pone en rdi la instruccion que se va a analizar
    mov [instruccion],edi       ;instruccion aislada de memoria
    ret
;--------------------------------------------------------FIN aumento PC----------------------------------------------------------------