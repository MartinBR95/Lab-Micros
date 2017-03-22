;-------------------------------------------------------------------------------------------------------------------------------------------------------
;se encarga de aislar, invertir y convertir la direccion de memoria de datos en donde se va a guardar un dato
_addr_mem_dato:
    mov rdi, [pos_mem_dato]
    shr rdi, 32
    mov rax, 0x0
    mov [pos_mem_dato], rax
    mov [pos_mem_dato], edi
    mov rax,[pos_mem_dato]
    shr rax,24
    shl rax,32    
    or rax,[pos_mem_dato]
    mov [pos_mem_dato],rax

    mov rax,[pos_mem_dato]
    shl rax, 40
    shr rax,56
    shl rax,40
    or rax, [pos_mem_dato]
    mov [pos_mem_dato],rax

    mov rax,[pos_mem_dato]
    shl rax, 48
    shr rax,56
    shl rax,48
    or rax, [pos_mem_dato]
    mov [pos_mem_dato],rax

    mov rax,[pos_mem_dato]
    shl rax, 56
    shr rax,56
    shl rax,56
    or rax, [pos_mem_dato]
    mov [pos_mem_dato],rax

    shr rax, 32
    mov [pos_mem_dato], rax
    mov rdx, [pos_mem_dato]
    mov [cons_orden_correcto], rdx
    call _conversion 
    mov rax, [cons_hexa]
    shl rax,48
    shr rax,48
    mov [pos_mem_dato],rax
    mov rdx, [pos_mem_dato]
    ret