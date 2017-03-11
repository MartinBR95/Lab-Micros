;----------------------------------- subrutina de inversion---------------------------------------------------------------
;se encarga de invertir el orden del registro.
 _inversion:  
    mov rdi, -1
    mov [cons_cuentapos], rdi           ;se reinicia el contenido de cons_cuentapos en -1 

    mov rdi, 0
    mov [cons_orden_correcto], rdi      ;se reinicia el contenido de cons_orden_correcto con 0

    jmp _inicio_inversion

_aumento_inversion:
    mov rax, [cons_cuentapos]
    add rax, 1                          ;aumenta con_cuentapos en 1 para cada iteracion
    mov [cons_cuentapos],rax
    ret

_inicio_inversion:
    call _aumento_inversion             ;se llama a la subrutina _aumento_inversion
    mov rax, cons_orden_inv             
    add rax, [cons_cuentapos]
    mov rdi,[rax]                       ;se ubica la posicion de memoria a partir de donde se quieren tomar datos
    mov [cons_inversor],dil             ;se le otorga a cons_inversor el valor de los ultimos 8 bits de rdi
    mov rax, [cons_inversor]            
    shl rax, 56                         ;se corren los 8 bits hasta la posicion en que necesitemos que este en el registro, en este caso 56
    mov rdi, [cons_orden_correcto]
    or rax, [cons_orden_correcto]       ;se compara con cons_orden_correcto para que en rax se vaya completando con la posicion correcta de los 8 bytes
    mov [cons_orden_correcto],rax       ;se guarda en cons_orden_correcto
;----------------------------------------Se repite el mismo proceso, pero cambiando la posicion que se corre
    call _aumento_inversion
    mov rax, cons_orden_inv
    add rax, [cons_cuentapos]
    mov rdi,[rax]
    mov [cons_inversor],dil
    mov rax, [cons_inversor]
    shl rax, 48
    mov rdi, [cons_orden_correcto]
    or rax, [cons_orden_correcto]
    mov [cons_orden_correcto],rax
;---------------------------------------
    call _aumento_inversion
    mov rax, cons_orden_inv 
    add rax, [cons_cuentapos]
    mov rdi,[rax]
    mov [cons_inversor],dil
    mov rax, [cons_inversor]
    shl rax, 40
    mov rdi, [cons_orden_correcto]
    or rax, [cons_orden_correcto]
    mov [cons_orden_correcto],rax
;------------------------------------
    call _aumento_inversion
    mov rax, cons_orden_inv
    add rax, [cons_cuentapos]
    mov rdi,[rax]
    mov [cons_inversor],dil
    mov rax, [cons_inversor]
    shl rax, 32
    mov rdi, [cons_orden_correcto]
    or rax, [cons_orden_correcto]
    mov [cons_orden_correcto],rax
;------------------------------------
    call _aumento_inversion
    mov rax, cons_orden_inv
    add rax, [cons_cuentapos]
    mov rdi,[rax]
    mov [cons_inversor],dil
    mov rax, [cons_inversor]
    shl rax, 24
    mov rdi, [cons_orden_correcto]
    or rax, [cons_orden_correcto]
    mov [cons_orden_correcto],rax
;-----------------------------------
    call _aumento_inversion
    mov rax, cons_orden_inv
    add rax, [cons_cuentapos]
    mov rdi,[rax]
    mov [cons_inversor],dil
    mov rax, [cons_inversor]
    shl rax, 16
    mov rdi, [cons_orden_correcto]
    or rax, [cons_orden_correcto]
    mov [cons_orden_correcto],rax
;------------------------------------
    call _aumento_inversion
    mov rax, cons_orden_inv
    add rax, [cons_cuentapos]
    mov rdi,[rax]
    mov [cons_inversor],dil
    mov rax, [cons_inversor]
    shl rax, 8
    mov rdi, [cons_orden_correcto]
    or rax, [cons_orden_correcto]
    mov [cons_orden_correcto],rax
;-----------------------------------
    call _aumento_inversion
    mov rax, cons_orden_inv
    add rax, [cons_cuentapos]
    mov rdi,[rax]
    mov [cons_inversor],dil
    mov rax, [cons_inversor]
    shl rax, 0
    mov rdi, [cons_orden_correcto]
    or rax, [cons_orden_correcto]
    mov [cons_orden_correcto],rax
;----------------------------------
    ret
;-----------------------------------------FIN subrutina inversion-----------------------------------------------------