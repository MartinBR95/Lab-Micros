;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\   INICIO DEL PROGRAMA    \\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


	_Execute:

	;Parche 
	mov ebx,[PC]			;Compia el PC para impresion 
	mov [PC_I],ebx			;El PC que ingresa al execute, es el PC de la instruccion en ejecucion 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; Descomposicion de instruccion ;;;;;;;;;;;;;;;;;;;;;


	mov eax, [instruccion] 	;Trasladamos la instruccion en lectura a el registro eax (32bits)
	shr eax, 26		  		;Se le hace un corrimiento a la derecha de 24bits obtener el opcode 
	mov [opcode], eax 		;Se guarda el opcode

	;Se determina que tipo de instruccion es 
	cmp eax, 0x00     		;Pregunta si es tipo R
	je  Inst_TipoR    		;Si lo es salta a las tipo R

	cmp eax, 0x02	  		;Pregunta si es un jump
	je  Inst_TipoJ 	  		;Si lo es salta a las tipo j

	cmp eax, 0x03	  		;Pregunta si es un jump and linck 
	je  Inst_TipoJ 	 	 	;Si lo es salta a las tipo j

	jne Inst_TipoI 	  		;Si lo es salta a las tipo I



	;/////////////////////////////////////////////////////////////////////////////
	;//////////////////////// Descompociono de tipo R ////////////////////////////
	Inst_TipoR: 	
		mov eax, [instruccion]

		;/////////////////////////////   Extraccion del funct   /////////////////////////////
		mov bl, al 			;Se traslada el al a bl (ultimos 8 bits de la instruccion)
		and bl, 00111111b	;Se hace una mascara para solo usar los ultimos 6 bits (menos significativos)
		mov [funct],bl		;Se traslada al espacio de memoria "funct"


		;/////////////////////////////   Extraccion del shamt	/////////////////////////////
		mov bx, ax 			;Se usan los 16 bits menos significativos de la instruccion y son trasladados a bx
		shr bx, 6 			;Se hace un corrimiento a la derecha de 6 para eliminar la parte de la instruccion correspondiente a funct
		and bl, 00011111b	;Se hace una mascara para solo usar los ultimos 5 bits (menos significativos)
		mov [shamt],bl		;Se traslada al espacio de memoria "shamt"


		;Parche Posible multiplicacion 
		cmp byte[funct],0x18 ;Si se tiene una multiplicacion es muy posible que en el espacio donde debe estar el rd este lleno de 0x0
		je Salto_rd
		;////////


		;/////////////////////////////   Extraccion del rd   /////////////////////////////
		mov rbx, rax 		;Se copia el la instruccion en rbx 
		shr rbx, 11			;Se corre 11 espacios a la derecha para eliminar al funct y al shamt
		and rbx, 00011111b	;Se enmascara para obtener los 5 bits menos significativos (en este punto ya se obtuvo el rd)

		cmp rbx, 0x0		;Pregunta si el registro en cuestion es el r0
		je  Error_Reg		;Si es r0 tira error

		mov rcx,4			;Se pasa un 4h a el rcx para realizar la multiplicacion por 4 
		imul rbx,rcx		;Se multiplica el rd por 4 
							;Ahora ya se tiene la cantidad de bytes que se le deben sumar a la direccion "regs_sim" para obtener el registro
							;indicado para rd
		mov [rd],bl

		Salto_rd:

		;/////////////////////////////   Extraccion del [rt]
		mov rbx, rax 		
		shr rbx, 16
		and rbx, 00011111b 

		mov rcx,4
		imul rbx,rcx
		mov [rt],bl


		;/////////////////////////////   Extraccion del [rs]
		mov  ebx, [instruccion] 		;
		shr  ebx, 21
		and  ebx, 00011111b 

		mov  ecx,4
		imul ebx, ecx
		mov [rs],bl
	
		jmp Comparacion_



	;/////////////////////////////////////////////////////////////////////////////
	;//////////////////////// Descompociono de tipo I ////////////////////////////
	Inst_TipoI: 
	
		mov eax, [instruccion]

		;/////////////////////////////  Extraccion del inmediate
		mov [inmediate],ax  


		;/////////////////////////////   Extraccion del [rt]
		mov rbx, rax 		
		shr rbx, 16
		and rbx, 00011111b 

		cmp rbx, 0x0		;Pregunta si el registro en cuestion es el r0
		je  Error_Reg		;Si es r0 tira error

		mov rcx,4
		imul rbx,rcx
		mov [rt],bl


		;/////////////////////////////   Extraccion del [rs]
		mov rbx, rax 		;
		shr rbx, 21 
		and rbx, 00011111b 

		mov rcx,4
		imul rbx, rcx
		mov [rs],bl

		jmp Comparacion_

	


	;/////////////////////////////////////////////////////////////////////////////
	;//////////////////////// Descompociono de tipo J ////////////////////////////
		Inst_TipoJ: 

		;/////////////////////////////  Extraccion del adress
		mov eax, [instruccion]
		and eax, 00000011111111111111111111111111b
		mov [address],eax

		jmp Comparacion_



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Comparaciones de opcode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;Se compara el Opcode para luego saltar a la instruccion especifica 

	Comparacion_:

    mov byte bl,[opcode]
    movzx rax,bl

    cmp rax, 0x8
        je ADDI_
    cmp rax, 0xc
        je ANDI_
    cmp rax, 0x4
        je BEQ_
    cmp rax, 0x5
        je BNE_
    cmp rax, 0x2
        je J_
    cmp rax, 0x3
        je JAL_
    cmp rax, 0x23
        je LW_
    cmp rax, 0xd
        je ORI_
    cmp rax, 0xa
        je SLTI_
    cmp rax, 0xb
        je SLTIU_
    cmp rax, 0x0
        je _CompFunct ; Aquí me deberá llevar a la comparación
                      ; del Function, en los casos que tenga
		
	Impr_pant cons_Error_instru,cons_Tamano_Error_instru   ;En caso de que la instruccion no este en el set, lanza un mensaje de error
    mov [var_tamano_NUMtoConvert],byte 8
    Impr_NUMtoASCII instruccion,var_tamano_NUMtoConvert    
   	Impr_pant cons_exe_fallida,cons_exe_fallida_tamano
    mov rax,0xc
    ret

	;Comparación del Function
	_CompFunct:

    mov byte bl,[funct]
    movzx rax,bl

    cmp rax, 0x20
        je ADD_
    cmp rax, 0x21
        je ADDU_
    cmp rax, 0x24
        je AND_
    cmp rax, 0x08
        je JR_
    cmp rax, 0x27
        je NOR_
    cmp rax, 0x25
        je OR_
    cmp rax, 0x2a
        je SLT_
    cmp rax, 0x2b
        je SLTU_
    cmp rax, 0x00
        je SLL_
    cmp rax, 0x02
        je SRL_
    cmp rax, 0x22
        je SUB_
    cmp rax, 0x23
        je SUBU_
    cmp rax, 0x18
        je MULT_
	
	Impr_pant cons_Error_instru,cons_Tamano_Error_instru	;En caso de que la instruccion no este en el set, lanza un mensaje de error
    mov [var_tamano_NUMtoConvert], byte 8
    Impr_NUMtoASCII instruccion,var_tamano_NUMtoConvert
   	Impr_pant cons_exe_fallida,cons_exe_fallida_tamano
    mov rax,0xc
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Seccion de execute ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
	;Esta seccion es la encargada de extraer de memoria las partes de la instruccion segun sera la necesidad de la instruccion en ejecucion 

	Extraccion_TR:

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;Obtencion de los datos de los registros simulados

		;Obtencion de [Rs]
		mov rax,0x0
		mov al,[rs]       		;Se le da el numero del [rs] a rax
		mov rbx,regs_sim 	  	;Se le da la direccion en memoria de los registros simulados a rbx
		add rbx,rax		    	;Se suman ambos valores para encontrar la direccion del reg [rs] solicitado
		mov rcx,0x0
		mov ecx,[rbx] 			;Se pasa el contenido del registro [rs] deseado a el registro edx
	
		;Obtencion de RT
		mov rax,0x0	
		mov al, [rt]	        ;Se le da el numero del rt a rax
		mov rbx, regs_sim    	;Se le da la direccion en memoria de los registros simulados a rbx
		add rbx,rax		    	;Se suman ambos valores para encontrar la direccion del reg [rs] solicitado
		mov rdx,0x0
		mov edx,[rbx] 			;Se pasa el contenido del registro [rs] deseado a el registro edx

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;Obtencion de Rd
		mov rax,0x0	
		mov al, [rd]       		;Se le da el numero del [rd] a rax
		mov rbx, regs_sim   	;Se le da la direccion en memoria de los registros simulados a rbx
		add rax, rbx	    	;Se suman ambos valores para encontrar la direccion del reg [rd] solicitado
		mov r8, rax
		ret

		Extraccion_I_SE:

		;Obtencion de sing Extlmm
		mov bx,[inmediate] 		;Se copia lo que se encuentra en el inmediate
		movsx rdx,bx	   		;Se hace una extension de signo para pasar de 16 a 32 bits 

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;Obtencion de Rs
		mov rax,0x0	
		mov al, [rs]       		;Se le da el numero del [rs] a rax
		mov rbx, regs_sim   	;Se le da la direccion en memoria de los registros simulados a rbx
		add rax, rbx	    	;Se suman ambos valores para encontrar la direccion del reg [rs] solicitado
		mov rcx,0x0
		mov ecx, [rax]

		;Obtencion de RT
		mov rax,0x0	
		mov al, [rt]	        ;Se le da el numero del rt a rax
		mov rbx,regs_sim    	;Se le da la direccion en memoria de los registros simulados a rbx
		add rbx,rax		    	;Se suman ambos valores para encontrar la direccion del reg [rt] solicitado
		mov r8,rbx 			;Se pasa el contenido del registro [rt] deseado a el registro edx
		ret

		Extraccion_I_ZE:


		;Obtencion de zero Extlmm
		mov bx,[inmediate]  ;Se copia lo que se encuentra en el inmediate
		movzx ecx,bx	    ;Se hace un cero extendido para pasar de 16 a 32 bits 

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;Obtencion de Rs
		mov rax,0x0	
		mov al, [rs]       		;Se le da el numero del [rs] a rax
		mov rbx, regs_sim   	;Se le da la direccion en memoria de los registros simulados a rbx
		add rax, rbx	    	;Se suman ambos valores para encontrar la direccion del reg [rs] solicitado
		mov rdx,0x0
		mov edx, [rax]

		;Obtencion de RT
		mov rax,0x0	
		mov al, [rt]	        ;Se le da el numero del rt a rax
		mov rbx,regs_sim    	;Se le da la direccion en memoria de los registros simulados a rbx
		add rbx,rax		    	;Se suman ambos valores para encontrar la direccion del reg [rt] solicitado
		mov r8,rbx 			;Se pasa el contenido del registro [rt] deseado a el registro edx
		ret


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION ADD      (1)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	ADD_:
	call Extraccion_TR 		

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de suma ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	add ecx,edx 			;Se suma los valores obtenidos de los registros simulados
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'ADD   '  		;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION ADDI     (2)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	ADDI_:
	call Extraccion_I_SE
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de addi ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	add edx,ecx 			;Se suma los valores obtenidos de los registros solicitados
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'ADDI  '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION ADDU     (3)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	ADDU_:

	call Extraccion_TR

	cmp edx, -1				;Se pregunta si el numero del registro es negativo
	jg  Resolver_aduu1 		;Si no lo es entonces se va a la solicitud del siguiente registro
	neg edx					;Si lo es entonces se niega el registro (se hace un complemento a 2)


	Resolver_aduu1:
	cmp ecx, -1				;Se pregunta si el numero del registro es negativo
	jg  Resolver_aduu2 		;Si no lo es entonces se va a la solicitud de la instruccion 
	neg ecx					;Si lo es entonces se niega el registro (se hace un complemento a 2)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de addu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Resolver_aduu2:
	add edx,ecx 			;Se suma los valores, sin importar el signo, obtenidos de los registros solicitados
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'ADDU  '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION AND      (4)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	AND_:

	call Extraccion_TR

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de and  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	and edx,ecx 			;Se ejecuta la operacion and 
	mov [r8],rdx


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'AND   '    	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION ANDI     (5)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	ANDI_:

	call Extraccion_I_ZE

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de andi  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	and edx,ecx 			;Se ejecuta la operacion and 
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'ADDI  '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION NOR      (6)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////
	
	NOR_:

	call Extraccion_TR

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de nor  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	or edx,ecx 				;Se ejecuta la operacion or 
	not edx    				;Se niega el resultado, dando como resultado final una nor 
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'NOR   '    	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION OR       (7)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	OR_:
	
	call Extraccion_TR
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de or  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	or edx,ecx 				;Se ejecuta la operacion or 
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'OR    '      	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION ORI      (8)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	ORI_:

	call Extraccion_I_ZE

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de ori  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	or edx,ecx 				;Se ejecuta la operacion or 
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'ORI   '     	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION SLT      (9)     ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////
	
	SLT_:

	call Extraccion_TR

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de SLT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
	cmp ecx,edx  			;Se hace una comparacion 
	setl dl      			;Se pone un uno si [rs] es menor que [rt] y un 0 si no
	and rdx, 0x1 			;Se hace una mascara para que solo halla un 1 o un 0 en el registro
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'SLT   '     	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION SLTI     (10)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	SLTI_:
	
	call Extraccion_I_SE

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de SLT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
	cmp  ecx,edx  			;Se hace una comparacion 
	setl dl       			;Se pone un uno si [rs] es menor que [rt] y un 0 si no
	and  rdx, 0x1 			;Se hace una mascara para que solo halla un 1 o un 0 en el registro
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'SLTI  '   	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION SLTIU    (11)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////
	
	SLTIU_:

	call Extraccion_I_SE

	cmp edx, -1				;Se pregunta si el numero del registro es negativo
	jg  Resol_SLTIU1 		;Si no lo es entonces se va a la solicitud del siguiente registro
	neg edx					;Si lo es entonces se niega el registro (se hace un complemento a 2)

	Resol_SLTIU1:

	cmp ecx, -1				;Se pregunta si el numero del registro es negativo
	jg  Resol_SLTIU2 		;Si no lo es entonces se va a la solicitud de la instruccion 
	neg ecx					;Si lo es entonces se niega el registro (se hace un complemento a 2)


	Resol_SLTIU2:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de SLTIU ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cmp  ecx,edx  			;Se hace una comparacion 
	setl dl       			;Se pone un uno si [rs] es menor que [rt] y un 0 si no
	and  rdx, 0x1 			;Se hace una mascara para que solo halla un 1 o un 0 en el registro
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'SLTIU '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION SLTU     (12)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	SLTU_:

	call Extraccion_TR

	cmp edx, -1				;Se pregunta si el numero del registro es negativo
	jg  Resol_SLTU1 		;Si no lo es entonces se va a la solicitud del siguiente registro
	neg edx					;Si lo es entonces se niega el registro (se hace un complemento a 2)

	Resol_SLTU1:
	cmp ecx, -1				;Se pregunta si el numero del registro es negativo
	jg  Resol_SLTU2 		;Si no lo es entonces se va a la solicitud de la instruccion 
	neg ecx					;Si lo es entonces se niega el registro (se hace un complemento a 2)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de SLTIU ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Resol_SLTU2:

	cmp  ecx,edx  			;Se hace una comparacion 
	setl dl       			;Se pone un uno si [rs] es menor que [rt] y un 0 si no
	and  rdx, 0x1 			;Se hace una mascara para que solo halla un 1 o un 0 en el registro
	mov [r8],rdx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'SLTU  '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION SUB      (13)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	SUB_:

	call Extraccion_TR

	sub ecx,edx 			;Se resta los valores obtenidos de los registros simulados
	mov [r8],rcx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'SUB   '    	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION SUBU     (14)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	SUBU_:

	call Extraccion_TR

	cmp edx, -1				;Se pregunta si el numero del registro es negativo
	jg  Resol_SUBBU1 		;Si no lo es entonces se va a la solicitud del siguiente registro
	neg edx					;Si lo es entonces se niega el registro (se hace un complemento a 2)

	;Obtencion de inmediate
	Resol_SUBBU1:
	cmp ecx, -1				;Se pregunta si el numero del registro es negativo
	jg  Resol_SUBBU2 		;Si no lo es entonces se va a la solicitud de la instruccion 
	neg ecx					;Si lo es entonces se niega el registro (se hace un complemento a 2)

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de SUBU ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Resol_SUBBU2:
	sub ecx, edx
	mov [r8],rcx

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'SUBU  '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION SLL      (15)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	SLL_:

	call Extraccion_TR

	mov ecx,0x0
	mov cl, [shamt]			;Paso al cl el shamt

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de shift left ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	shl edx,cl	 			;Se hace un corrimiento de el contenido de edx, por cl	
	mov [r8],rdx			;Se guarda el resultado en el r8

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'SLL   '     	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION SRL      (16)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	SRL_:

	call Extraccion_TR

	mov rcx, 0x0
	mov cl, [shamt]			;Paso al cl el shamt

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de shift rigth ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	shr edx,cl				;Se hace un corrimiento de el contenido de edx, por cl	
	mov [r8],eax

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'SRL   '    	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////             INSTRUCCION LW      (17)     ///////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	LW_:

	call Extraccion_I_SE

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de LW  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	add ecx,edx				;Se suma el "inmediate(SE)" con el [rs] para obtener la direccion deseada

	;/////////////////////////
	;Posibles errores

	cmp ecx, 0x10000000		;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion inferior a 10 000 000h)
	jl Error_ME
	;//////////////////////////

	;Si no se encontraron errores 
	sub ecx, 0x10000000 	;Se resta 1000 0000hex para [sumarselo] a la memoria de datos

	mov eax, memoria_datos	;obtiene la direccion en memoria de la memoria simulada
	add eax,ecx				;Se suma a la direccion de memoria solicitada junto con la seccion de la memoria
							;simulada

	mov dword edx,[eax] 	;Se saca lo que se tiene en memoria y se coloca en el registro indicado 
	mov [r8],rdx


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'LW   '     	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I			;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION MUL      (18)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	MULT_:

	movzx rax,byte [rs] ;Valor de rs
	movzx rbx,byte [rt] ;Valor de rt
	
	add rax,regs_sim ;se aline el valor a los registros simulados
	add rbx,regs_sim ;se aline el valor a los registros simulados

    mov eax,[rax] ;se lee el valor de rs simulado
    mov ebx,[rbx] ;se lee el valor de rt simulado

    imul rax,rbx ;Multiplicacion

    ;se guardan los valores correspondientes
	mov [LO],eax
	shr rax,16
	mov [HI],eax


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'MUL   '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I		;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////             INSTRUCCION JR      (19)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	JR_:

	call Extraccion_TR

	cmp ecx, 0x10000000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion superior a 10 000 000h)
	jge Error_SNP

	cmp ecx, 0x400000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion inferior a 400 000h)
	jl Error_SNP

	mov [PC],ecx	;Se pasa la direccion dada por el rs a el PC simulado

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'JR    '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_R		;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION JAL      (20)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	JAL_:
	
	;Almacenamiento de PC
	mov rax, 0x0
	mov rax, PC     	;Se mueve la direccion en memoria del PC simulado a rax
	
	mov rcx, 0x0
	mov rcx, [PC]		;Se guarda el contenido de PC simulado en el registre rcx
	mov rbx, regs_sim 	;Se le da la direccion en memoria de los registros a rbx
	add rbx, 124 		;Se le suma a la direccion rbx 124 para llegar al registro 31 (31*4 = 124) 

	add rcx, 0x8		;Se le suma 8 a el contenido de PC simulado
	mov [rbx],rcx		;Se guarda el contenido de PC mas 8 en el registro 31 

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Obtencion del jump addr
	mov ebx,[PC]    	;Se solicita el contenido de PC
	add ebx,0x4		  	;Se le suma 4 a el contenido de PC

	and ebx,0xF0000000	;Se enmascara de modo que solo quedan los 4bits mas significativos

	mov rcx,0x0
	mov ecx,[address] 	;Movemos lo que hay en address a un registro 
	shl ecx,2			;Se hace un corrimiento a la izquierda de 2 bits del address
	
	add ebx,ecx			;Se suman ambos valores para obtener el jump addr 

	;//////////////////
	; Posibles Errores

	cmp ebx, 0x10000000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion superior a 10 000 000h)
	jge Error_SNP

	cmp ebx, 0x400000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion inferior a 400 000h)
	jl Error_SNP
	;//////////////////


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Salto

	mov [rax],ebx 		;Se le da el valor de jump address al PC simulado 

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'JAL   '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_J		;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION J        (21)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	J_:

	mov rax, 0x0
	mov rax, PC     ;Se mueve la direccion en memoria del PC simulado a rax
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Obtencion del jump addr
	mov ebx,[PC]    	;Se solicita el contenido de PC
	add ebx,0x4		  	;Se le suma 4 a el contenido de PC

	and ebx,0xF0000000	;Se enmascara de modo que solo quedan los 4bits mas significativos

	mov ecx,[address] 	;Movemos lo que hay en address a un registro 
	shl ecx,2			;Se hace un corrimiento a la izquierda de 2 bits del address
	
	add ebx,ecx			;Se suman ambos valores para obtener el jump addr 

	;//////////////////
	; Posibles Errores
	
	cmp ebx, 0x10000000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion superior a 10 000 000h)
	jge Error_SNP

	cmp ebx, 0x400000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion inferior a 400 000h)
	jl Error_SNP
	;//////////////////


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; JUMP

	sub ebx,0x400004	
	mov [rax],ebx		;Se le da la direccion de jump address a el PC simulado 


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'J     '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_J		;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION BNE      (22)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	BNE_:

	call Extraccion_I_ZE     ;Se hace un llamado a la extraccion con cero extendido, aunque no se usara el inmediate con cero extendido

	;Obtencion del branch addr 
	mov word ax,[inmediate]  ;Se copia lo que se encuentra en el inmediate
	movsx ebx,ax	   		 ;Se hace un cero extendido para pasar de 16 a 32 bits 
	shl   ebx,2				 ;Se hace un corrimiento de 2 a la izquierda 

	;//////////////////
	; Posibles Errores
	
	cmp ebx, 0x10000000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion superior a 10 000 000h)
	jge Error_SNP

	cmp ebx, 0x400000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion inferior a 400 000h)
	jl Error_SNP
	;//////////////////


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de BEQ   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cmp rdx,r8        	;Se compara los registros rs y rt
	je No_BNE  			;Se hace un jump para saltar la modificacion del PC si estos reg son iguales
	
	mov [PC],ebx   		;Si no son iguales, se modifica el PC 

	No_BNE:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'BEQ   '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I		;Salto para imprimir datos


;////////////////////////////////////////////////////////////////////////////////////////
;///////////////////////            INSTRUCCION BEQ      (23)    ////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////

	BEQ_:

	call Extraccion_I_ZE     ;Se hace un llamado a la extraccion con cero extendido, aunque no se usara el inmediate con cero extendido

	;Obtencion del branch addr 
	mov word ax,[inmediate]  ;Se copia lo que se encuentra en el inmediate
	movsx ebx,ax	   		 ;Se hace un cero extendido para pasar de 16 a 32 bits 
	shl   ebx,2				 ;Se hace un corrimiento de 2 a la izquierda 

	;//////////////////
	; Posibles Errores
	
	cmp ebx, 0x10000000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion superior a 10 000 000h)
	jge Error_SNP

	cmp ebx, 0x400000	;Pregunta si el espacio de memoria al que se esta saltano esta permitido (direccion inferior a 400 000h)
	jl Error_SNP
	;//////////////////


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;; operacion de BEQ   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cmp rdx,r8        		;Se compara los registros rs y rt

	jne No_BEQ 				;Se hace un jump para saltar la modificacion del PC si estos reg no son iguales
	mov [PC],ebx   			;Si son iguales, se modifica el PC 

	No_BEQ:

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov rax, 'BEQ   '	  	;Se guarda el nombre de la instruccion en el espacio de memoria "[nomb_inst]"
	mov [nomb_inst],rax
	jmp Imprimir_I		;Salto para imprimir datos





;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\	         IMPRIMIR        \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Imprimir_R:
	
	Impr_pant nomb_inst,6 ;Imprime el mnemonico de la instruccion
	
	;Se hara la traduccion nesesaria para imprimir los registros usados en cada instruccion
	mov al,[rd]
	shr al,2

	imul rax,4
	add rax,cons_Registros
	mov rbx,[rax]
	mov [var_NUMtoConvert],rbx
	;se imprime el numero de registro
	Impr_pant var_NUMtoConvert,4


	;Se hara la traduccion nesesaria para imprimir los registros usados en cada instruccion
	mov al,[rs]
	shr al,2

	imul rax,4
	add rax,cons_Registros
	mov rbx,[rax]
	mov [var_NUMtoConvert],rbx
	;se imprime el numero de registro
	Impr_pant var_NUMtoConvert,4

	;Se hara la traduccion nesesaria para imprimir los registros usados en cada instruccion
	mov al,[rt]
	shr al,2

	imul rax,4
	add rax,cons_Registros
	mov rbx,[rax]
	mov [var_NUMtoConvert],rbx
	;se imprime el numero de registro
	Impr_pant var_NUMtoConvert,4

	jmp Imprimir_reg

Imprimir_I:

	Impr_pant nomb_inst,6 ;Imprime el mnemonico de la instruccion

	mov al,[rt]
	shr al,2

	imul rax,4
	add rax,cons_Registros
	mov rbx,[rax]
	mov [var_NUMtoConvert],rbx
	;se imprime el numero de registro
	Impr_pant var_NUMtoConvert,4

	mov al,[rs]
	shr al,2

	imul rax,4
	add rax,cons_Registros
	mov rbx,[rax]
	mov [var_NUMtoConvert],rbx
	;se imprime el numero de registro
	Impr_pant var_NUMtoConvert,4

	cmp dword [nomb_inst],"MUL "
	je Imprimir_reg

	mov ax,[inmediate] ;se respalda el inmediato
	mov [var_NUMtoConvert],rax
	mov [var_tamano_NUMtoConvert],byte 4
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert
	jmp Imprimir_reg

Imprimir_J:

	Impr_pant nomb_inst,6 ;Imprime el mnemonico de la instruccion

	mov eax,[address] ;se respalda el inmediato
	mov [var_NUMtoConvert],rax
	mov [var_tamano_NUMtoConvert],byte 7
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert

Imprimir_reg:
	;Se imprime el detalle de los registros:

	;------------------PC------------------------------
	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_PC,9;Imprime: PC

	mov eax, [PC_I]
	add rax,0x400000
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert


	;------------------s0---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_s0,9;Imprime: "	$s0 : 0x"

	mov eax, [regs_sim+ 4*16]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert	

	;------------------s1---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_s1,9;Imprime: "	$s1 : 0x"

	mov eax, [regs_sim+ 4*17]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert	

	;------------------s2---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_s2,9;Imprime: "	$s2 : 0x"

	mov eax, [regs_sim+ 4*18]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert	

	;------------------s---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_s3,9;Imprime: "	$s3 : 0x"

	mov eax, [regs_sim+ 4*19]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert	

	;------------------s4---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_s4,9;Imprime: "	$s4 : 0x"

	mov eax, [regs_sim+ 4*20]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert	

	;------------------s5---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_s5,9;Imprime: "	$s5 : 0x"

	mov eax, [regs_sim+ 4*21]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert	

	;------------------s6---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_s6,9;Imprime: "	$s6 : 0x"

	mov eax, [regs_sim+ 4*22]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert	

	;------------------s7---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_s7,9;Imprime: "	$s7 : 0x"

	mov eax, [regs_sim+ 4*23]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert	

	;------------------sp---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_sp,9;Imprime: "	$sp : 0x"

	mov eax, [regs_sim+ 4*29]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert


	;------------------a0---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_a0,9;Imprime: "	$a0 : 0x"

	mov eax, [regs_sim+ 4*4]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert


	;------------------a1---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_a1,9;Imprime: "	$a1 : 0x"

	mov eax, [regs_sim+ 4*5]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert


	;------------------a2---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_a2,9;Imprime: "	$a2 : 0x"

	mov eax, [regs_sim+ 4*6]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert


	;------------------a3---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_a3,9;Imprime: "	$a3 : 0x"

	mov eax, [regs_sim+ 4*7]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert


	;------------------v0---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_v0,9;Imprime: "	$v0 : 0x"

	mov eax, [regs_sim+ 4*2]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert


	;------------------v1---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_v1,9;Imprime: "	$v1 : 0x"

	mov eax, [regs_sim+ 4*3]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert


	;------------------HI---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_HI,9;Imprime: "	HI : 0x"

	mov eax, [HI]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert

	;------------------LO---------------------------

	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_LO,9;Imprime: "	LO : 0x"

	mov eax, [LO]
	mov [var_NUMtoConvert],rax ; mueve el valor del PC un espacio dedicado de memoria
	mov [var_tamano_NUMtoConvert],byte 8
	Impr_NUMtoASCII var_NUMtoConvert,var_tamano_NUMtoConvert
	
	Impr_pant cons_LF,1;Imprime: Cambio de linea
	Impr_pant cons_LF,1;Imprime: Cambio de linea

	ret

	Error_Reg:
	Impr_pant cons_Error_instru,cons_Tamano_Error_instru
    mov [var_tamano_NUMtoConvert], byte 8
    Impr_NUMtoASCII instruccion,var_tamano_NUMtoConvert
   	Impr_pant cons_exe_fallida,cons_exe_fallida_tamano
	mov rax,0xc
	ret

	Error_ME:
	Impr_pant cons_Error_instru,cons_Tamano_Error_instru
	mov [var_tamano_NUMtoConvert], byte 8
    Impr_NUMtoASCII instruccion,var_tamano_NUMtoConvert
   	Impr_pant cons_exe_fallida,cons_exe_fallida_tamano
	mov rax,0xc
	ret

	Error_SNP:
	Impr_pant cons_Error_instru,cons_Tamano_Error_instru
	mov [var_tamano_NUMtoConvert], byte 8
    Impr_NUMtoASCII instruccion,var_tamano_NUMtoConvert
   	Impr_pant cons_exe_fallida,cons_exe_fallida_tamano
	mov rax,0xc
	ret