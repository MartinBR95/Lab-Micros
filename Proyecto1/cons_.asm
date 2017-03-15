;se define el texto de la pantalla de inicio
	cons_Bienvenida: db 0ax,'___________________________________________________________________________________________',0ax,0xa,0x9,0x9,0x9,'  ----------------------------------',0xa,0x9,0x9,0x9,'  | Bienvenido al Emulador de MIPS |',0xa,0x9,0x9,0x9,'  ----------------------------------',0xa,0xa,0x9,0x9,'-------------------------------------------------------',0xa,0x9,0x9,'| Curso: El-4313 Lab. Estructura de Microprocesadores |',0xa,0x9,0x9,'|                Semestre: 1S-2017                    |',0xa,0x9,0x9,'-------------------------------------------------------',0xa,0xa,0xa,0x9,0x9,0x9,'    ----------------------------',0xa,0x9,0x9,0x9,'==> | Buscando archivo ROM.txt |',0xa,0x9,0x9,0x9,'    ----------------------------',0ax,0ax,0x9,0x9,0x9,0x9,0x9,'  *',0ax,0ax,0x9,0x9,0x9,0x9,0x9,'  *',0ax,0ax,0x9,0x9,0x9,0x9,0x9,'  *',0xa,0xa
        cons_Tamano_Bienvenida: equ $-cons_Bienvenida

;constante para la busqueda del archivo ROM.txt
	cons_ROMtxt: db 'ROM.txt',0		; caracter nulo para que el SO lea el nombre del archivo

;constante del nombre del archivo Resultados.txt
	cons_Resultadostxt db 'Resultados.txt',0
;constantes para archivo encontrado
        cons_ROM_encontrado: db 0x9,0x9,0x9,'  ------------------------------',0xa,0x9,0x9,'      ==> | Archivo ROM.txt encontrado |',0xa,0x9,0x9,0x9,'  ------------------------------',0xa,0xa
        cons_Tamano_ROM_encontrado: equ $-cons_ROM_encontrado

	cons_ENTER_inicio: db 0x9,0x9,' ==>  Precione ENTER para iniciar ejecucion  <==',0xa
        cons_Tamano_ENTER_inicio: equ $-cons_ENTER_inicio

        cons_exe_exitosa: db 0x9,0x9,0x9,0x9,'---------------------',0xa,0x9,0x9,0x9,'    ==> | Ejecucion Exitosa |',0xa,0x9,0x9,0x9,0x9,'---------------------',0xa,0xa
        cons_exe_exitosa_tamano: equ $-cons_exe_exitosa

	cons_exe_fallida: db 0x9,0x9,0x9,0x9,'---------------------',0xa,0x9,0x9,0x9,'    ==> | Ejecucion Fallida |',0xa,0x9,0x9,0x9,0x9,'---------------------',0xa,0xa
        cons_exe_fallida_tamano: equ $-cons_exe_fallida

;constantes para pantalla final
        cons_ROM_no_encontrado: db 0x9,0x9,0x9,'  ---------------------------------',0xa,0x9,0x9,'      ==> | Archivo ROM.txt no encontrado |',0xa,0x9,0x9,0x9,'  ---------------------------------',0xa,0xa
        cons_Tamano_ROM_no_encontrado: equ $-cons_ROM_no_encontrado

        cons_ENTER_final: db '_________________________________________________________________________________________________',0xa,0xa,0x9,0x9,'    ==>  Precione ENTER para Finalizar  <==',0xa
        cons_Tamano_ENTER_final: equ $-cons_ENTER_final

        cons_Texto_Final: db 0xa,'-------------------------------------',0xa,'| Martin Barquero Retana 2014043266 |',0xa,'| Jose Delgado Martinez  201247238  |',0xa,'| Santiago Lopez Rojas   2014098356 |',0xa,'| Beatriz Moya Samper    201140698  |',0xa,'| Daniel Palacios Rivera 2013115351 |',0xa,'-------------------------------------',0xa,0xa
        cons_Tamano_Texto_Final: equ $-cons_Texto_Final

; Se definen espacios de memoria con valores iniciales para la traduccion de ROM.txt
; Se inicializa cons_avance en -1
	cons_avance dq -1
; Se inicializa la cons_parcua_izq con 0x5b ([)
	cons_parcua_izq dq 0x5b
; Se inicializa la cons_addr_instr con 0x3030 (00)
	cons_addr_instr dq 0x3030
; Se inicializa la cons_addr_dato con 0x3130 (10)
	cons_addr_dato dq 0x3031;al revez porque en registro se copia en orden contrario
; Se inicializa la cons_acomodar_dato con -4 
    cons_acomodar_dato dq -4
; Se inicializa la cons_acomodar_inst con -4
    cons_acomodar_inst dq -4
; Se inicializa la constante para imprimir numeros en pantalla
    cont_NUMtoASCII db -1;valor inicial del contador de NUMtoASCII
; Se inicializa el PC
	PC dq -4    
; Se definen textos pertenecientes a la seccion de impresion de fabricante de procesador
	cons_fabr_noenc: db 'Fabricante no encontrado',0xa
	cons_Tamano_fabr_noenc: equ $-cons_fabr_noenc

	cons_proce_es: db '==>  El procesador es el: '
	cons_Tamano_proce_es: equ $-cons_proce_es

	cons_proce_noenc: db 'Procesador no encontrado',0xa
	cons_Tamano_proce_noenc: equ $-cons_proce_noenc

	cons_fabr_Proce: db '==>  El procesador fue fabricado por: '
	cons_Tamano_fabr_Proce: equ $-cons_fabr_Proce

	AMDisbetter: db 'early engineering samples of AMD K5 processor',0xa
	cons_Tamano_AMDisbetter: equ $-AMDisbetter

	AuthenticAMD: db 'AMD',0xa
	cons_Tamano_AuthenticAMD: equ $-AuthenticAMD

	CentaurHauls: db 'Centaur (Including some VIA CPU)',0xa
	cons_Tamano_CentaurHauls: equ $-CentaurHauls

	CyrixInstead: db 'Cyrix',0xa
	cons_Tamano_CyrixInstead: equ $-CyrixInstead

	GenuineIntel: db 'Intel',0xa
	cons_Tamano_GenuineIntel: equ $-GenuineIntel

	TransmetaCPU: db 'Transmeta',0xa
	cons_Tamano_TransmetaCPU: equ $-TransmetaCPU

	GenuineTMx86: db 'Transmeta',0xa
	cons_Tamano_GenuineTMx86: equ $-GenuineTMx86

	Geode_by_NSC: db 'National Semiconductor',0xa
	cons_Tamano_Geode: equ $-Geode_by_NSC

	NexGenDriven: db 'NexGen',0xa
	cons_Tamano_NexGenDriven: equ $-NexGenDriven

	RiseRiseRise: db 'Rise',0xa
	cons_Tamano_RiseRiseRise: equ $-RiseRiseRise

	SiS_SiS_SiS: db 'SiS',0xa
	cons_Tamano_SiS: equ $-SiS_SiS_SiS

	UMC_UMC_UMC: db  'UMC',0xa
	cons_Tamano_UMC: equ $-UMC_UMC_UMC

	VIA_VIA_VIA: db 'VIA',0xa
	cons_Tamano_VIA: equ $-VIA_VIA_VIA

	Vortex86_SoC: db 'Vortex',0xa
	cons_Tamano_Vortex: equ $-Vortex86_SoC

	KVMKVMKVM_: db 'KVM',0xa
	cons_Tamano_KMV: equ $-KVMKVMKVM_

	Microsoft_Hv: db 'Microsoft Hyper-V or Windows Virtual PC',0xa
	cons_Tamano_Microsoft: equ $-Microsoft_Hv

	_lrpepyh_vr: db 'Parallels',0xa
	cons_Tamano_Parallels: equ $-_lrpepyh_vr

	VMwareVMware: db  'VMware',0xa
	cons_Tamano_VMware: equ $-VMwareVMware

	XenVMMXenVMM: db  'Xen HVM',0xa
	cons_Tamano_Xen: equ $-XenVMMXenVMM
