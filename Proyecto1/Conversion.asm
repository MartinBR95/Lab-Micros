;-----------------------------------------subrutina acomodo_byte-------------------------------------------------------
;se encarga de acomodar el valor hexadecimal convertido en la posicion que le corresponde estar, evaluando la posicion del byte que se esta
;analizando para asi ubicarlo en la posicion correspondiente en la constante de 32 bits
_acomodo_byte:
    mov rax, [cons_cuenta_conv]
    cmp rax, 0
    jne _mov_uno
    jmp _volver

_mov_uno:
    mov rax, [cons_cuenta_conv]
    cmp rax, 1
    jne _mov_dos
    mov rax, [cons_movimiento]
    shl rax, 4
    mov [cons_movimiento], eax
    jmp _volver

_mov_dos:
    mov rax, [cons_cuenta_conv]
    cmp rax, 2
    jne _mov_tres
    mov rax, [cons_movimiento]
    shl rax, 8
    mov [cons_movimiento], eax
    jmp _volver

_mov_tres:
    mov rax, [cons_cuenta_conv]
    cmp rax, 3
    jne _mov_cuatro
    mov rax, [cons_movimiento]
    shl rax, 12
    mov [cons_movimiento], eax
    jmp _volver

_mov_cuatro:
    mov rax, [cons_cuenta_conv]
    cmp rax, 4
    jne _mov_cinco
    mov rax, [cons_movimiento]
    shl rax, 16
    mov [cons_movimiento], eax
    jmp _volver

_mov_cinco:
    mov rax, [cons_cuenta_conv]
    cmp rax, 5
    jne _mov_seis
    mov rax, [cons_movimiento]
    shl rax, 20
    mov [cons_movimiento], eax
    jmp _volver

_mov_seis:
    mov rax, [cons_cuenta_conv]
    cmp rax, 6
    jne _mov_siete
    mov rax, [cons_movimiento]
    shl rax, 24
    mov [cons_movimiento], eax
    jmp _volver

_mov_siete:
    mov rax, [cons_movimiento]
    shl rax, 28
    mov [cons_movimiento], eax

_volver:
    ret
;-----------------------------------------FIN subrutina acomodo_byte-------------------------------------------------------

;-----------------------------------------subrutina acomodo_hexa-----------------------------------------------------------
; le da a cons_hexa el valor del la instruccion o dato ya convertido [en 32 bits]y posicionado en el lugar que le corresponde, ubicado
;previamente por la subrutina acomodar 
_acomodo_hexa:    
    mov rax, [cons_hexa]        
    mov rdi, [cons_movimiento]
    or rax, rdi
    mov [cons_hexa], eax
    ret
;-----------------------------------------FIN subrutina acomodo_hexa--------------------------------------------------------

;-----------------------------------------subrutina conversion--------------------------------------------------------------
;se encarga de hacer el recorrido y comparacion de la constante que contenga el dato o la instruccion y la comparacion para la transformacion
;de ASCII a hexadecimal
_conversion:
    mov rdi, -1
    mov [cons_cuenta_conv], rdi      ;se inicializa en -1 la cuenta cada vez que inicie sub_rutina

    mov rdi, 0
    mov [cons_hexa], rdi             ;se reinicia el valor de cons_hexa en 0

_loop_conversion:
    mov rax, [cons_cuenta_conv]
    add rax, 1
    mov [cons_cuenta_conv], rax          ;se suma 1 a cons_cuenta_conv

    mov rax, cons_orden_correcto
    add rax, [cons_cuenta_conv]
    mov rdi,[rax]                   ;se obtiene el byte de la posicion de memoria que sera comparada
    mov [cons_conversion],dil

_cero:
    mov rax, [cons_conversion]
    cmp rax, 0x30                   ;se compara para saber si es un "0"
    jne _uno
    mov rsi, 0x0
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion


_uno:
    mov rax, [cons_conversion]
    cmp rax, 0x31                   ;se compara para saber si es un "1"
    jne _dos
    mov rsi, 0x1
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_dos:
    mov rax, [cons_conversion]
    cmp rax, 0x32                   ;se compara para saber si es un "2"
    jne _tres
    mov rsi, 0x2
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_tres:
    mov rax, [cons_conversion]
    cmp rax, 0x33                   ;se compara para saber si es un "3"
    jne _cuatro
    mov rsi, 0x3
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_cuatro:
    mov rax, [cons_conversion]
    cmp rax, 0x34                   ;se compara para saber si es un "4"
    jne _cinco
    mov rsi, 0x4
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_cinco:
    mov rax, [cons_conversion]
    cmp rax, 0x35                   ;se compara para saber si es un "5"
    jne _seis
    mov rsi, 0x5
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_seis:
    mov rax, [cons_conversion]
    cmp rax, 0x36                   ;se compara para saber si es un "6"
    jne _siete
    mov rsi, 0x6
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_siete:
    mov rax, [cons_conversion]
    cmp rax, 0x37                   ;se compara para saber si es un "7"
    jne _ocho
    mov rsi, 0x7
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_ocho:
    mov rax, [cons_conversion]
    cmp rax, 0x38                   ;se compara para saber si es un "8"
    jne _nueve
    mov rsi, 0x8
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_nueve:
    mov rax, [cons_conversion]
    cmp rax, 0x39                   ;se compara para saber si es un "9"
    jne _a
    mov rsi, 0x9
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_a:
    mov rax, [cons_conversion]
    cmp rax, 0x61                   ;se compara para saber si es un "a"
    je _achange
    cmp rax, 0x41
    jne _b
_achange:
    mov rsi, 0xa
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_b:
    mov rax, [cons_conversion]
    cmp rax, 0x62                   ;se compara para saber si es un "b"
    je _bchange
    cmp rax, 0x42
    jne _c
_bchange:
    mov rsi, 0xb
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_c:
    mov rax, [cons_conversion]
    cmp rax, 0x63                   ;se compara para saber si es un "c"
    je _cchange
    cmp rax, 0x43
    jne _d
_cchange:
    mov rsi, 0xc
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_d:
    mov rax, [cons_conversion]
    cmp rax, 0x64                   ;se compara para saber si es un "d"
    je _dchange
    cmp rax, 0x44
    jne _e
_dchange:
    mov rsi, 0xd
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_e:
    mov rax, [cons_conversion]
    cmp rax, 0x65                   ;se compara para saber si es un "e"
    je _echange
    cmp rax, 0x45
    jne _f
_echange:
    mov rsi, 0xe
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa
    jmp _evaluar_posicion

_f:
    mov rax, [cons_conversion]
    mov rsi, 0xf
    mov [cons_movimiento], esi
    call _acomodo_byte
    call _acomodo_hexa

_evaluar_posicion:
    mov rax, [cons_cuenta_conv]
    cmp rax, 0x7
    jne _loop_conversion
    ret
;-----------------------------------------FIN subrutina conversion----------------------------------------------------------