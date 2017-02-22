_ImprimeFabricante:
Impr_pant cons_fabr_Proce,cons_Tamano_fabr_Proce
	mov rax,0
	cpuid

	cmp rcx,"ter!"
		je Impr_AMDi

	cmp rcx,"ntel"
		je Impr_GenuI

	cmp rcx,"cAMD"
		je Impr_Auth
	 
	cmp rcx,"auls"
		je Impr_Cent
	 
	cmp rcx,"tead"
		je Impr_Cyri
	 
	cmp rcx,"aCPU"
		je Impr_Tran
	 
	cmp rcx,"Mx86"
		je Impr_GenuT
	 
	cmp rcx," NSC"
		je Impr_Geod
	 
	cmp rcx,"iven"
		je Impr_NexG
	 
	cmp rcx,"Rise"
		je Impr_Rise
	 
	cmp rcx," SiS"
		je Impr_SiS 
	 
	cmp rcx," UMC"
		je Impr_UMC
	 
	cmp rcx," VIA"
		je Impr_VIA 
	 
	cmp rcx," Soc"
		je Impr_Vort
	 
	cmp rcx,"MKVM"
		je Impr_KVMK
	 
	cmp rcx,"t Hv"
		je Impr_Micr
	 
	cmp rcx,"h vr"
		je Impr_lrp
	 
	cmp rcx,"ware"
		je Impr_VMwa
	 
	cmp rcx,"nVMM"
		je Impr_XenV
	ret


	Impr_AMDi:
		Impr_pant  AMDisbetter,cons_Tamano_AMDisbetter
		ret

	Impr_GenuI:
		Impr_pant  GenuineIntel,cons_Tamano_GenuineIntel
		ret
		
	Impr_Auth:
		Impr_pant  AuthenticAMD,cons_Tamano_AuthenticAMD
		ret
		
	Impr_Cent:
		Impr_pant  CentaurHauls,cons_Tamano_CentaurHauls
		ret
		
	Impr_Cyri:
		Impr_pant  CyrixInstead,cons_Tamano_CyrixInstead
		ret
		
	Impr_Tran:
		Impr_pant  TransmetaCPU,cons_Tamano_TransmetaCPU
		ret
		
	Impr_GenuT:
		Impr_pant  GenuineTMx86,cons_Tamano_GenuineTMx86
		ret
		
	Impr_Geod:
		Impr_pant  Geode_by_NSC,cons_Tamano_Geode
		ret
		
	Impr_NexG:
		Impr_pant  NexGenDriven,cons_Tamano_NexGenDriven
		ret
		
	Impr_Rise:
		Impr_pant  RiseRiseRise,cons_Tamano_RiseRiseRise
		ret
		
	Impr_SiS:
		Impr_pant  SiS_SiS_SiS,cons_Tamano_SiS
		ret
		
	Impr_UMC:
		Impr_pant  UMC_UMC_UMC,cons_Tamano_UMC
		ret
		
	Impr_VIA:
		Impr_pant  VIA_VIA_VIA,cons_Tamano_VIA
		ret
		
	Impr_Vort:
		Impr_pant  Vortex86_SoC,cons_Tamano_Vortex
		ret
		
	Impr_KVMK:
		Impr_pant  KVMKVMKVM_,cons_Tamano_KMV
		
	Impr_Micr:
		Impr_pant  Microsoft_Hv,cons_Tamano_Microsoft
		ret
		
	Impr_lrp:
		Impr_pant  _lrpepyh_vr,cons_Tamano_Parallels
		ret
		
	Impr_VMwa:
		Impr_pant  VMwareVMware,cons_Tamano_VMware
		ret
		
	Impr_XenV:
		Impr_pant  XenVMMXenVMM,cons_Tamano_Xen
		ret
		