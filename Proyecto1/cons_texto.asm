;se define el texto de la pantalla de inicio
	cons_Bienvenida db 0xa,'                 Bienvenido al Emulador de MIPS',0xa,0xa,'Curso: El-4313 Lab. Estructura de Microprocesadores',0xa,'Semestre: 1S-2017',0xa,'Buscando archivo ROM.txt ...',0xa,0xa,0xa,0xa
	cons_Tamano_Bienvenida equ $-cons_Bienvenida
;constante para la busqueda del archivo ROM.txt
	cons_ROMtxt db 'ROM.txt',0; caracter nulo para que el SO lea el nombre del archivo
;constantes para pantalla final
	cons_ROM_no_encontrado db 'Archivo ROM.txt no encontrado',0xa,0xa
	cons_Tamano_ROM_no_encontrado equ $-cons_ROM_no_encontrado
;text de RO;.txt encontrado
	cons_ROM_encontrado db 'Archivo ROM.txt encontrado',0xa,0xa
	cons_Tamano_ROM_encontrado equ $-cons_ROM_encontrado
;texto ejecucion exitosa
	cons_Ejecucion_Exitosa db 'Ejecucion Exitosa',0xa,0xa
	cons_Tamano_Ejecucion_exitosa equ $-cons_Ejecucion_Exitosa
;texto Precione ENTER para Finalizar
	cons_TextoFinal db '                 Precione ENTER para Finalizar',0xa,0xa,'Martin Barquero Retana 2014043266',0xa
	cons_Tamano_TextoFinal equ $-cons_TextoFinal
;texto Precione ENTER para Iniciar
	cons_Textoinicial db '                 Precione ENTER para Iniciar',0xa
	cons_Tamano_Textoinicial equ $-cons_Textoinicial

; Se definen textos pertenecientes a la seccion de impresion de fabricante de procesador
cons_fabr_Proce db 'El procesador fue fabricado por: '
cons_Tamano_fabr_Proce equ $-cons_fabr_Proce

AMDisbetter db 'early engineering samples of AMD K5 processor',0xa
cons_Tamano_AMDisbetter equ $-AMDisbetter

AuthenticAMD db 'AMD',0xa
cons_Tamano_AuthenticAMD equ $-AuthenticAMD

CentaurHauls db 'Centaur (Including some VIA CPU)',0xa
cons_Tamano_CentaurHauls equ $-CentaurHauls

CyrixInstead db 'Cyrix',0xa
cons_Tamano_CyrixInstead equ $-CyrixInstead

GenuineIntel db 'Intel',0xa
cons_Tamano_GenuineIntel equ $-GenuineIntel

TransmetaCPU db 'Transmeta',0xa
cons_Tamano_TransmetaCPU equ $-TransmetaCPU

GenuineTMx86 db 'Transmeta',0xa
cons_Tamano_GenuineTMx86 equ $-GenuineTMx86

Geode_by_NSC db 'National Semiconductor',0xa
cons_Tamano_Geode equ $-Geode_by_NSC

NexGenDriven db 'NexGen',0xa
cons_Tamano_NexGenDriven equ $-NexGenDriven

RiseRiseRise db 'Rise',0xa
cons_Tamano_RiseRiseRise equ $-RiseRiseRise

SiS_SiS_SiS  db 'SiS',0xa
cons_Tamano_SiS equ $-SiS_SiS_SiS

UMC_UMC_UMC  db  'UMC',0xa
cons_Tamano_UMC equ $-UMC_UMC_UMC

VIA_VIA_VIA   db 'VIA',0xa
cons_Tamano_VIA equ $-VIA_VIA_VIA

Vortex86_SoC db 'Vortex',0xa
cons_Tamano_Vortex equ $-Vortex86_SoC

KVMKVMKVM_  db 'KVM',0xa
cons_Tamano_KMV equ $-KVMKVMKVM_

Microsoft_Hv db 'Microsoft Hyper-V or Windows Virtual PC',0xa
cons_Tamano_Microsoft equ $-Microsoft_Hv

_lrpepyh_vr db 'Parallels',0xa
cons_Tamano_Parallels equ $-_lrpepyh_vr

VMwareVMware db  'VMware',0xa
cons_Tamano_VMware equ $-VMwareVMware

XenVMMXenVMM db  'Xen HVM',0xa
cons_Tamano_Xen equ $-XenVMMXenVMM