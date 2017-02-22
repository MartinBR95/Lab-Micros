_CompProces:
	mov rax,1
	cpuid
	cmp rax,0000000000000500h   
		je _00000500
	cmp rax,0000000000000501h  
		je _00000501
	cmp rax,0000000000000511h  
		je _00000511
	cmp rax,0000000000000514h  
		je _00000514
	cmp rax,0000000000000524h 
		je _00000524
	cmp rax,0000000000000562h  
		je _00000562
	cmp rax,0000000000000570h  
		je _00000570
	cmp rax,0000000000000580h  
		je _00000580
	cmp rax,000000000000058Ch  
		je _0000058C
	cmp rax,0000000000000591h  
		je _00000591
	cmp rax,00000000000005A2h  
		je _000005A2
	cmp rax,00000000000005D0h  
		je _000005D0
	cmp rax,00000000000005D4h  
		je _000005D4
	cmp rax,0000000000000612h  
		je _00000612
	cmp rax,0000000000000622h  
		je _00000622
	cmp rax,0000000000000630h  
		je _00000630
	cmp rax,0000000000000644h  
		je _00000644
	cmp rax,0000000000000662h  
		je _00000662
	cmp rax,0000000000000670h  
		je _00000670
	cmp rax,0000000000000680h  
		je _00000680
	cmp rax,0000000000000681h  
		je _00000681
	cmp rax,00000000000006A0h  
		je _000006A0
	cmp rax,0000000000000F4Ah  
		je _00000F4A
	cmp rax,0000000000000F51h  
		je _00000F51
	cmp rax,0000000000000F5Ah  
		je _00000F5A
	cmp rax,0000000000010FC0h  
		je _00010FC0
	cmp rax,0000000000010FF0h  
		je _00010FF0
	cmp rax,0000000000020FB1h  
		je _00020FB1
	cmp rax,0000000000020FC2h  
		je _00020FC2
	cmp rax,0000000000020FF0h  
		je _00020FF0
	cmp rax,0000000000040F12h  
		je _00040F12
	cmp rax,0000000000040F33h  
		je _00040F33
	cmp rax,0000000000050FF3h  
		je _00050FF3
	cmp rax,0000000000060FB1h  
		je _00060FB1
	cmp rax,0000000000070FF1h  
		je _00070FF1
	cmp rax,0000000000100F21h  
		je _00100F21
	cmp rax,0000000000100F22h  
		je _00100F22
	cmp rax,0000000000100F23h  
		je _00100F23
	cmp rax,0000000000100F2Ah  
		je _00100F2A
	cmp rax,0000000000100F42h  
		je _00100F42
	cmp rax,0000000000100F52h  
		je _00100F52
	cmp rax,0000000000100F62h  
		je _00100F62
	cmp rax,0000000000100F80h  
		je _00100F80
	cmp rax,0000000000100F81h  
		je _00100F81
	cmp rax,0000000000100F91h  
		je _00100F91
	cmp rax,0000000000100FA0h  
		je _00100FA0
	cmp rax,0000000000200F30h  
		je _00200F30
	cmp rax,0000000000200F31h  
		je _00200F31
	cmp rax,0000000000300F10h  
		je _00300F10
	cmp rax,0000000000500F01h  
		je _00500F01
	cmp rax,0000000000500F10h  
		je _00500F10
	cmp rax,0000000000500F20h  
		je _00500F20
	cmp rax,0000000000600F00h  
		je _00600F00
	cmp rax,0000000000600F01h  
		je _00600F01
	cmp rax,0000000000600F10h  
		je _00600F10
	cmp rax,0000000000600F11h  
		je _00600F11
	cmp rax,0000000000600F12h  
		je _00600F12
	cmp rax,0000000000600F13h  
		je _00600F13
	cmp rax,0000000000600F20h  
		je _00600F20
	cmp rax,0000000000610F01h  
		je _00610F01
	cmp rax,0000000000610F31h  
		je _00610F31
	cmp rax,0000000000630F01h  
		je _00630F01
	cmp rax,0000000000630F81h  
		je _00630F81
	cmp rax,0000000000660F01h  
		je _00660F01
	cmp rax,0000000000660F51h  
		je _00660F51
	cmp rax,0000000000670F00h  
		je _00670F00
	cmp rax,0000000000700F01h  
		je _00700F01
	cmp rax,0000000000730F01h  
		je _00730F01
	cmp rax,0000000000000541h  
		je _00000541
	cmp rax,0000000000000542h  
		je _00000542
	cmp rax,0000000000000585h  
		je _00000585
	cmp rax,0000000000000587h  
		je _00000587
	cmp rax,000000000000058Ah  
		je _0000058A
	cmp rax,0000000000000660h  
		je _00000660
	cmp rax,0000000000000663h  
		je _00000663
	cmp rax,0000000000000673h  
		je _00000673
	cmp rax,0000000000000678h  
		je _00000678
	cmp rax,000000000000067Ah  
		je _0000067A
	cmp rax,0000000000000689h  
		je _00000689
	cmp rax,0000000000000691h  
		je _00000691
	cmp rax,0000000000000693h  
		je _00000693
	cmp rax,0000000000000694h  
		je _00000694
	cmp rax,0000000000000695h  
		je _00000695
	cmp rax,0000000000000698h  
		je _00000698
	cmp rax,00000000000006A9h  
		je _000006A9
	cmp rax,00000000000006D0h  
		je _000006D0
	cmp rax,00000000000006F1h  
		je _000006F1
	cmp rax,00000000000006F2h  
		je _000006F2
	cmp rax,00000000000006F8h  
		je _000006F8
	cmp rax,00000000000006FAh  
		je _000006FA
	cmp rax,00000000000006FCh  
		je _000006FC
	cmp rax,00000000000006FDh  
		je _000006FD
	cmp rax,00000000000006FEh  
		je _000006FE
	cmp rax,0000000000000540h  
		je _00000540
	cmp rax,0000000000000600h  
		je _00000600
	cmp rax,0000000000000601h  
		je _00000601
	cmp rax,0000000000000551h  
		je _00000551
	cmp rax,0000000000000552h  
		je _00000552
	cmp rax,0000000000000480h  
		je _00000480
	cmp rax,0000000000000517h  
		je _00000517
	cmp rax,0000000000000525h  
		je _00000525
	cmp rax,0000000000000526h  
		je _00000526
	cmp rax,000000000000052Ch  
		je _0000052C
	cmp rax,0000000000000532h  
		je _00000532
	cmp rax,0000000000000543h  
		je _00000543
	cmp rax,0000000000000582h  
		je _00000582
	cmp rax,0000000000000590h  
		je _00000590
	cmp rax,0000000000000617h  
		je _00000617
	cmp rax,0000000000000619h  
		je _00000619
	cmp rax,0000000000000632h  
		je _00000632
	cmp rax,0000000000000633h  
		je _00000633
	cmp rax,0000000000000651h  
		je _00000651
	cmp rax,0000000000000653h  
		je _00000653
	cmp rax,0000000000000665h  
		je _00000665
	cmp rax,000000000000066Ah  
		je _0000066A
	cmp rax,0000000000000683h  
		je _00000683
	cmp rax,0000000000000686h  
		je _00000686
	cmp rax,00000000000006B1h  
		je _000006B1
	cmp rax,00000000000006D8h  
		je _000006D8
	cmp rax,00000000000006E4h  
		je _000006E4
	cmp rax,00000000000006E8h  
		je _000006E8
	cmp rax,00000000000006F4h  
		je _000006F4
	cmp rax,00000000000006F6h  
		je _000006F6
	cmp rax,00000000000006F7h  
		je _000006F7
	cmp rax,00000000000006F9h  
		je _000006F9
	cmp rax,00000000000006FBh  
		je _000006FB
	cmp rax,0000000000000F13h  
		je _00000F13
	cmp rax,0000000000000F24h  
		je _00000F24
	cmp rax,0000000000000F25h  
		je _00000F25
	cmp rax,0000000000000F27h  
		je _00000F27
	cmp rax,0000000000000F29h  
		je _00000F29
	cmp rax,0000000000000F34h  
		je _00000F34
	cmp rax,0000000000000F41h  
		je _00000F41
	cmp rax,0000000000000F43h  
		je _00000F43
	cmp rax,0000000000000F44h  
		je _00000F44
	cmp rax,0000000000000F48h  
		je _00000F48
	cmp rax,0000000000000F62h  
		je _00000F62
	cmp rax,0000000000000F64h  
		je _00000F64
	cmp rax,0000000000000F65h  
		je _00000F65
	cmp rax,0000000000000F66h  
		je _00000F66
	cmp rax,0000000000000F68h  
		je _00000F68
	cmp rax,0000000000010650h  
		je _00010650
	cmp rax,0000000000010661h  
		je _00010661
	cmp rax,0000000000010676h  
		je _00010676
	cmp rax,0000000000010677h  
		je _00010677
	cmp rax,000000000001067ah  
		je _0001067A
	cmp rax,00000000000106A1h  
		je _000106A1
	cmp rax,00000000000106A2h  
		je _000106A2
	cmp rax,00000000000106A4h  
		je _000106A4
	cmp rax,00000000000106C2h  
		je _000106C2
	cmp rax,00000000000106CAh  
		je _000106CA
	cmp rax,00000000000106D0h  
		je _000106D0
	cmp rax,00000000000106D1h  
		je _000106D1
	cmp rax,00000000000106E0h  
		je _000106E0
	cmp rax,00000000000106E5h  
		je _000106E5
	cmp rax,00000000000106F1h  
		je _000106F1
	cmp rax,0000000000020652h  
		je _00020652
	cmp rax,0000000000020661h  
		je _00020661
	cmp rax,0000000000020672h  
		je _00020672
	cmp rax,00000000000206A2h  
		je _000206A2
	cmp rax,00000000000206A6h  
		je _000206A6
	cmp rax,00000000000206A7h  
		je _000206A7
	cmp rax,00000000000206C1h  
		je _000206C1
	cmp rax,00000000000206C2h  
		je _000206C2
	cmp rax,00000000000206D5h  
		je _000206D5
	cmp rax,00000000000206D6h  
		je _000206D6
	cmp rax,00000000000206E4h  
		je _000206E4
	cmp rax,00000000000206E5h  
		je _000206E5
	cmp rax,00000000000206E6h  
		je _000206E6
	cmp rax,00000000000206F2h  
		je _000206F2
	cmp rax,0000000000030651h  
		je _00030651
	cmp rax,0000000000030661h  
		je _00030661
	cmp rax,0000000000030669h  
		je _00030669
	cmp rax,0000000000030673h  
		je _00030673
	cmp rax,0000000000030678h  
		je _00030678
	cmp rax,00000000000306A9h  
		je _000306A9
	cmp rax,00000000000306C3h  
		je _000306C3
	cmp rax,00000000000306D4h  
		je _000306D4
	cmp rax,00000000000306E3h  
		je _000306E3
	cmp rax,00000000000306E4h  
		je _000306E4
	cmp rax,00000000000306F2h  
		je _000306F2
	cmp rax,0000000000040651h  
		je _00040651
	cmp rax,0000000000040661h  
		je _00040661
	cmp rax,0000000000040671h  
		je _00040671
	cmp rax,00000000000406C3h  
		je _000406C3
	cmp rax,00000000000406D8h  
		je _000406D8
	cmp rax,00000000000406E3h  
		je _000406E3
	cmp rax,00000000000406F1h  
		je _000406F1
	cmp rax,0000000000050662h  
		je _00050662
	cmp rax,0000000000050670h  
		je _00050670
	cmp rax,00000000000506A0h  
		je _000506A0
	cmp rax,00000000000506C9h  
		je _000506C9
	cmp rax,00000000000506D1h  
		je _000506D1
	cmp rax,00000000000506E0h  
		je _000506E0
	cmp rax,00000000000506E3h  
		je _000506E3
	cmp rax,00000000000806E9h  
		je _000806E9
	cmp rax,00000000000906E9h  
		je _000906E9
	cmp rax,0000000000000586h  
		je _00000586
	cmp rax,0000000000000504h  
		je _00000504
	cmp rax,0000000000000521h  
		je _00000521
	cmp rax,0000000000000505h  
		je _00000505
	cmp rax,0000000000000522h  
		je _00000522
	Impr_pant cons_proce_noenc,cons_Tamano_proce_noenc
	ret

	_00000500:
		Impr_pant cons_Proce_00000500,cons_Tamano_Proce_00000500
		ret
	_00000501:
		Impr_pant cons_Proce_00000501,cons_Tamano_Proce_00000501
		ret
	_00000511:
		Impr_pant cons_Proce_00000511,cons_Tamano_Proce_00000511
		ret
	_00000514:
		Impr_pant cons_Proce_00000514,cons_Tamano_Proce_00000514
		ret
	_00000524:
		Impr_pant cons_Proce_00000524,cons_Tamano_Proce_00000524
		ret
	_00000562:
		Impr_pant cons_Proce_00000562,cons_Tamano_Proce_00000562
		ret
	_00000570:
		Impr_pant cons_Proce_00000570,cons_Tamano_Proce_00000570
		ret
	_00000580:
		Impr_pant cons_Proce_00000580,cons_Tamano_Proce_00000580
		ret
	_0000058C:
		Impr_pant cons_Proce_0000058C,cons_Tamano_Proce_0000058C
		ret
	_00000591:
		Impr_pant cons_Proce_00000591,cons_Tamano_Proce_00000591
		ret
	_000005A2:
		Impr_pant cons_Proce_000005A2,cons_Tamano_Proce_000005A2
		ret
	_000005D0:
		Impr_pant cons_Proce_000005D0,cons_Tamano_Proce_000005D0
		ret
	_000005D4:
		Impr_pant cons_Proce_000005D4,cons_Tamano_Proce_000005D4
		ret
	_00000612:
		Impr_pant cons_Proce_00000612,cons_Tamano_Proce_00000612
		ret
	_00000622:
		Impr_pant cons_Proce_00000622,cons_Tamano_Proce_00000622
		ret
	_00000630:
		Impr_pant cons_Proce_00000630,cons_Tamano_Proce_00000630
		ret
	_00000644:
		Impr_pant cons_Proce_00000644,cons_Tamano_Proce_00000644
		ret
	_00000662:
		Impr_pant cons_Proce_00000662,cons_Tamano_Proce_00000662
		ret
	_00000670:
		Impr_pant cons_Proce_00000670,cons_Tamano_Proce_00000670
		ret
	_00000680:
		Impr_pant cons_Proce_00000680,cons_Tamano_Proce_00000680
		ret
	_00000681:
		Impr_pant cons_Proce_00000681,cons_Tamano_Proce_00000681
		ret
	_000006A0:
		Impr_pant cons_Proce_000006A0,cons_Tamano_Proce_000006A0
		ret
	_00000F4A:
		Impr_pant cons_Proce_00000F4A,cons_Tamano_Proce_00000F4A
		ret
	_00000F51:
		Impr_pant cons_Proce_00000F51,cons_Tamano_Proce_00000F51
		ret
	_00000F5A:
		Impr_pant cons_Proce_00000F5A,cons_Tamano_Proce_00000F5A
		ret
	_00010FC0:
		Impr_pant cons_Proce_00010FC0,cons_Tamano_Proce_00010FC0
		ret
	_00010FF0:
		Impr_pant cons_Proce_00010FF0,cons_Tamano_Proce_00010FF0
		ret
	_00020FB1:
		Impr_pant cons_Proce_00020FB1,cons_Tamano_Proce_00020FB1
		ret
	_00020FC2:
		Impr_pant cons_Proce_00020FC2,cons_Tamano_Proce_00020FC2
		ret
	_00020FF0:
		Impr_pant cons_Proce_00020FF0,cons_Tamano_Proce_00020FF0
		ret
	_00040F12:
		Impr_pant cons_Proce_00040F12,cons_Tamano_Proce_00040F12
		ret
	_00040F33:
		Impr_pant cons_Proce_00040F33,cons_Tamano_Proce_00040F33
		ret
	_00050FF3:
		Impr_pant cons_Proce_00050FF3,cons_Tamano_Proce_00050FF3
		ret
	_00060FB1:
		Impr_pant cons_Proce_00060FB1,cons_Tamano_Proce_00060FB1
		ret
	_00070FF1:
		Impr_pant cons_Proce_00070FF1,cons_Tamano_Proce_00070FF1
		ret
	_00100F21:
		Impr_pant cons_Proce_00100F21,cons_Tamano_Proce_00100F21
		ret
	_00100F22:
		Impr_pant cons_Proce_00100F22,cons_Tamano_Proce_00100F22
		ret
	_00100F23:
		Impr_pant cons_Proce_00100F23,cons_Tamano_Proce_00100F23
		ret
	_00100F2A:
		Impr_pant cons_Proce_00100F2A,cons_Tamano_Proce_00100F2A
		ret
	_00100F42:
		Impr_pant cons_Proce_00100F42,cons_Tamano_Proce_00100F42
		ret
	_00100F52:
		Impr_pant cons_Proce_00100F52,cons_Tamano_Proce_00100F52
		ret
	_00100F62:
		Impr_pant cons_Proce_00100F62,cons_Tamano_Proce_00100F62
		ret
	_00100F80:
		Impr_pant cons_Proce_00100F80,cons_Tamano_Proce_00100F80
		ret
	_00100F81:
		Impr_pant cons_Proce_00100F81,cons_Tamano_Proce_00100F81
		ret
	_00100F91:
		Impr_pant cons_Proce_00100F91,cons_Tamano_Proce_00100F91
		ret
	_00100FA0:
		Impr_pant cons_Proce_00100FA0,cons_Tamano_Proce_00100FA0
		ret
	_00200F30:
		Impr_pant cons_Proce_00200F30,cons_Tamano_Proce_00200F30
		ret
	_00200F31:
		Impr_pant cons_Proce_00200F31,cons_Tamano_Proce_00200F31
		ret
	_00300F10:
		Impr_pant cons_Proce_00300F10,cons_Tamano_Proce_00300F10
		ret
	_00500F01:
		Impr_pant cons_Proce_00500F01,cons_Tamano_Proce_00500F01
		ret
	_00500F10:
		Impr_pant cons_Proce_00500F10,cons_Tamano_Proce_00500F10
		ret
	_00500F20:
		Impr_pant cons_Proce_00500F20,cons_Tamano_Proce_00500F20
		ret
	_00600F00:
		Impr_pant cons_Proce_00600F00,cons_Tamano_Proce_00600F00
		ret
	_00600F01:
		Impr_pant cons_Proce_00600F01,cons_Tamano_Proce_00600F01
		ret
	_00600F10:
		Impr_pant cons_Proce_00600F10,cons_Tamano_Proce_00600F10
		ret
	_00600F11:
		Impr_pant cons_Proce_00600F11,cons_Tamano_Proce_00600F11
		ret
	_00600F12:
		Impr_pant cons_Proce_00600F12,cons_Tamano_Proce_00600F12
		ret
	_00600F13:
		Impr_pant cons_Proce_00600F13,cons_Tamano_Proce_00600F13
		ret
	_00600F20:
		Impr_pant cons_Proce_00600F20,cons_Tamano_Proce_00600F20
		ret
	_00610F01:
		Impr_pant cons_Proce_00610F01,cons_Tamano_Proce_00610F01
		ret
	_00610F31:
		Impr_pant cons_Proce_00610F31,cons_Tamano_Proce_00610F31
		ret
	_00630F01:
		Impr_pant cons_Proce_00630F01,cons_Tamano_Proce_00630F01
		ret
	_00630F81:
		Impr_pant cons_Proce_00630F81,cons_Tamano_Proce_00630F81
		ret
	_00660F01:
		Impr_pant cons_Proce_00660F01,cons_Tamano_Proce_00660F01
		ret
	_00660F51:
		Impr_pant cons_Proce_00660F51,cons_Tamano_Proce_00660F51
		ret
	_00670F00:
		Impr_pant cons_Proce_00670F00,cons_Tamano_Proce_00670F00
		ret
	_00700F01:
		Impr_pant cons_Proce_00700F01,cons_Tamano_Proce_00700F01
		ret
	_00730F01:
		Impr_pant cons_Proce_00730F01,cons_Tamano_Proce_00730F01
		ret
	_00000541:
		Impr_pant cons_Proce_00000541,cons_Tamano_Proce_00000541
		ret
	_00000542:
		Impr_pant cons_Proce_00000542,cons_Tamano_Proce_00000542
		ret
	_00000585:
		Impr_pant cons_Proce_00000585,cons_Tamano_Proce_00000585
		ret
	_00000587:
		Impr_pant cons_Proce_00000587,cons_Tamano_Proce_00000587
		ret
	_0000058A:
		Impr_pant cons_Proce_0000058A,cons_Tamano_Proce_0000058A
		ret
	_00000660:
		Impr_pant cons_Proce_00000660,cons_Tamano_Proce_00000660
		ret
	_00000663:
		Impr_pant cons_Proce_00000663,cons_Tamano_Proce_00000663
		ret
	_00000673:
		Impr_pant cons_Proce_00000673,cons_Tamano_Proce_00000673
		ret
	_00000678:
		Impr_pant cons_Proce_00000678,cons_Tamano_Proce_00000678
		ret
	_0000067A:
		Impr_pant cons_Proce_0000067A,cons_Tamano_Proce_0000067A
		ret
	_00000689:
		Impr_pant cons_Proce_00000689,cons_Tamano_Proce_00000689
		ret
	_00000691:
		Impr_pant cons_Proce_00000691,cons_Tamano_Proce_00000691
		ret
	_00000693:
		Impr_pant cons_Proce_00000693,cons_Tamano_Proce_00000693
		ret
	_00000694:
		Impr_pant cons_Proce_00000694,cons_Tamano_Proce_00000694
		ret
	_00000695:
		Impr_pant cons_Proce_00000695,cons_Tamano_Proce_00000695
		ret
	_00000698:
		Impr_pant cons_Proce_00000698,cons_Tamano_Proce_00000698
		ret
	_000006A9:
		Impr_pant cons_Proce_000006A9,cons_Tamano_Proce_000006A9
		ret
	_000006D0:
		Impr_pant cons_Proce_000006D0,cons_Tamano_Proce_000006D0
		ret
	_000006F1:
		Impr_pant cons_Proce_000006F1,cons_Tamano_Proce_000006F1
		ret
	_000006F2:
		Impr_pant cons_Proce_000006F2,cons_Tamano_Proce_000006F2
		ret
	_000006F8:
		Impr_pant cons_Proce_000006F8,cons_Tamano_Proce_000006F8
		ret
	_000006FA:
		Impr_pant cons_Proce_000006FA,cons_Tamano_Proce_000006FA
		ret
	_000006FC:
		Impr_pant cons_Proce_000006FC,cons_Tamano_Proce_000006FC
		ret
	_000006FD:
		Impr_pant cons_Proce_000006FD,cons_Tamano_Proce_000006FD
		ret
	_000006FE:
		Impr_pant cons_Proce_000006FE,cons_Tamano_Proce_000006FE
		ret
	_00000540:
		Impr_pant cons_Proce_00000540,cons_Tamano_Proce_00000540
		ret
	_00000600:
		Impr_pant cons_Proce_00000600,cons_Tamano_Proce_00000600
		ret
	_00000601:
		Impr_pant cons_Proce_00000601,cons_Tamano_Proce_00000601
		ret
	_00000551:
		Impr_pant cons_Proce_00000551,cons_Tamano_Proce_00000551
		ret
	_00000552:
		Impr_pant cons_Proce_00000552,cons_Tamano_Proce_00000552
		ret
	_00000480:
		Impr_pant cons_Proce_00000480,cons_Tamano_Proce_00000480
		ret
	_00000517:
		Impr_pant cons_Proce_00000517,cons_Tamano_Proce_00000517
		ret
	_00000525:
		Impr_pant cons_Proce_00000525,cons_Tamano_Proce_00000525
		ret
	_00000526:
		Impr_pant cons_Proce_00000526,cons_Tamano_Proce_00000526
		ret
	_0000052C:
		Impr_pant cons_Proce_0000052C,cons_Tamano_Proce_0000052C
		ret
	_00000532:
		Impr_pant cons_Proce_00000532,cons_Tamano_Proce_00000532
		ret
	_00000543:
		Impr_pant cons_Proce_00000543,cons_Tamano_Proce_00000543
		ret
	_00000582:
		Impr_pant cons_Proce_00000582,cons_Tamano_Proce_00000582
		ret
	_00000590:
		Impr_pant cons_Proce_00000590,cons_Tamano_Proce_00000590
		ret
	_00000617:
		Impr_pant cons_Proce_00000617,cons_Tamano_Proce_00000617
		ret
	_00000619:
		Impr_pant cons_Proce_00000619,cons_Tamano_Proce_00000619
		ret
	_00000632:
		Impr_pant cons_Proce_00000632,cons_Tamano_Proce_00000632
		ret
	_00000633:
		Impr_pant cons_Proce_00000633,cons_Tamano_Proce_00000633
		ret
	_00000651:
		Impr_pant cons_Proce_00000651,cons_Tamano_Proce_00000651
		ret
	_00000653:
		Impr_pant cons_Proce_00000653,cons_Tamano_Proce_00000653
		ret
	_00000665:
		Impr_pant cons_Proce_00000665,cons_Tamano_Proce_00000665
		ret
	_0000066A:
		Impr_pant cons_Proce_0000066A,cons_Tamano_Proce_0000066A
		ret
	_00000683:
		Impr_pant cons_Proce_00000683,cons_Tamano_Proce_00000683
		ret
	_00000686:
		Impr_pant cons_Proce_00000686,cons_Tamano_Proce_00000686
		ret
	_000006B1:
		Impr_pant cons_Proce_000006B1,cons_Tamano_Proce_000006B1
		ret
	_000006D8:
		Impr_pant cons_Proce_000006D8,cons_Tamano_Proce_000006D8
		ret
	_000006E4:
		Impr_pant cons_Proce_000006E4,cons_Tamano_Proce_000006E4
		ret
	_000006E8:
		Impr_pant cons_Proce_000006E8,cons_Tamano_Proce_000006E8
		ret
	_000006F4:
		Impr_pant cons_Proce_000006F4,cons_Tamano_Proce_000006F4
		ret
	_000006F6:
		Impr_pant cons_Proce_000006F6,cons_Tamano_Proce_000006F6
		ret
	_000006F7:
		Impr_pant cons_Proce_000006F7,cons_Tamano_Proce_000006F7
		ret
	_000006F9:
		Impr_pant cons_Proce_000006F9,cons_Tamano_Proce_000006F9
		ret
	_000006FB:
		Impr_pant cons_Proce_000006FB,cons_Tamano_Proce_000006FB
		ret
	_00000F13:
		Impr_pant cons_Proce_00000F13,cons_Tamano_Proce_00000F13
		ret
	_00000F24:
		Impr_pant cons_Proce_00000F24,cons_Tamano_Proce_00000F24
		ret
	_00000F25:
		Impr_pant cons_Proce_00000F25,cons_Tamano_Proce_00000F25
		ret
	_00000F27:
		Impr_pant cons_Proce_00000F27,cons_Tamano_Proce_00000F27
		ret
	_00000F29:
		Impr_pant cons_Proce_00000F29,cons_Tamano_Proce_00000F29
		ret
	_00000F34:
		Impr_pant cons_Proce_00000F34,cons_Tamano_Proce_00000F34
		ret
	_00000F41:
		Impr_pant cons_Proce_00000F41,cons_Tamano_Proce_00000F41
		ret
	_00000F43:
		Impr_pant cons_Proce_00000F43,cons_Tamano_Proce_00000F43
		ret
	_00000F44:
		Impr_pant cons_Proce_00000F44,cons_Tamano_Proce_00000F44
		ret
	_00000F48:
		Impr_pant cons_Proce_00000F48,cons_Tamano_Proce_00000F48
		ret
	_00000F62:
		Impr_pant cons_Proce_00000F62,cons_Tamano_Proce_00000F62
		ret
	_00000F64:
		Impr_pant cons_Proce_00000F64,cons_Tamano_Proce_00000F64
		ret
	_00000F65:
		Impr_pant cons_Proce_00000F65,cons_Tamano_Proce_00000F65
		ret
	_00000F66:
		Impr_pant cons_Proce_00000F66,cons_Tamano_Proce_00000F66
		ret
	_00000F68:
		Impr_pant cons_Proce_00000F68,cons_Tamano_Proce_00000F68
		ret
	_00010650:
		Impr_pant cons_Proce_00010650,cons_Tamano_Proce_00010650
		ret
	_00010661:
		Impr_pant cons_Proce_00010661,cons_Tamano_Proce_00010661
		ret
	_00010676:
		Impr_pant cons_Proce_00010676,cons_Tamano_Proce_00010676
		ret
	_00010677:
		Impr_pant cons_Proce_00010677,cons_Tamano_Proce_00010677
		ret
	_0001067A:
		Impr_pant cons_Proce_0001067A,cons_Tamano_Proce_0001067A
		ret
	_000106A1:
		Impr_pant cons_Proce_000106A1,cons_Tamano_Proce_000106A1
		ret
	_000106A2:
		Impr_pant cons_Proce_000106A2,cons_Tamano_Proce_000106A2
		ret
	_000106A4:
		Impr_pant cons_Proce_000106A4,cons_Tamano_Proce_000106A4
		ret
	_000106C2:
		Impr_pant cons_Proce_000106C2,cons_Tamano_Proce_000106C2
		ret
	_000106CA:
		Impr_pant cons_Proce_000106CA,cons_Tamano_Proce_000106CA
		ret
	_000106D0:
		Impr_pant cons_Proce_000106D0,cons_Tamano_Proce_000106D0
		ret
	_000106D1:
		Impr_pant cons_Proce_000106D1,cons_Tamano_Proce_000106D1
		ret
	_000106E0:
		Impr_pant cons_Proce_000106E0,cons_Tamano_Proce_000106E0
		ret
	_000106E5:
		Impr_pant cons_Proce_000106E5,cons_Tamano_Proce_000106E5
		ret
	_000106F1:
		Impr_pant cons_Proce_000106F1,cons_Tamano_Proce_000106F1
		ret
	_00020652:
		Impr_pant cons_Proce_00020652,cons_Tamano_Proce_00020652
		ret
	_00020661:
		Impr_pant cons_Proce_00020661,cons_Tamano_Proce_00020661
		ret
	_00020672:
		Impr_pant cons_Proce_00020672,cons_Tamano_Proce_00020672
		ret
	_000206A2:
		Impr_pant cons_Proce_000206A2,cons_Tamano_Proce_000206A2
		ret
	_000206A6:
		Impr_pant cons_Proce_000206A6,cons_Tamano_Proce_000206A6
		ret
	_000206A7:
		Impr_pant cons_Proce_000206A7,cons_Tamano_Proce_000206A7
		ret
	_000206C1:
		Impr_pant cons_Proce_000206C1,cons_Tamano_Proce_000206C1
		ret
	_000206C2:
		Impr_pant cons_Proce_000206C2,cons_Tamano_Proce_000206C2
		ret
	_000206D5:
		Impr_pant cons_Proce_000206D5,cons_Tamano_Proce_000206D5
		ret
	_000206D6:
		Impr_pant cons_Proce_000206D6,cons_Tamano_Proce_000206D6
		ret
	_000206E4:
		Impr_pant cons_Proce_000206E4,cons_Tamano_Proce_000206E4
		ret
	_000206E5:
		Impr_pant cons_Proce_000206E5,cons_Tamano_Proce_000206E5
		ret
	_000206E6:
		Impr_pant cons_Proce_000206E6,cons_Tamano_Proce_000206E6
		ret
	_000206F2:
		Impr_pant cons_Proce_000206F2,cons_Tamano_Proce_000206F2
		ret
	_00030651:
		Impr_pant cons_Proce_00030651,cons_Tamano_Proce_00030651
		ret
	_00030661:
		Impr_pant cons_Proce_00030661,cons_Tamano_Proce_00030661
		ret
	_00030669:
		Impr_pant cons_Proce_00030669,cons_Tamano_Proce_00030669
		ret
	_00030673:
		Impr_pant cons_Proce_00030673,cons_Tamano_Proce_00030673
		ret
	_00030678:
		Impr_pant cons_Proce_00030678,cons_Tamano_Proce_00030678
		ret
	_000306A9:
		Impr_pant cons_Proce_000306A9,cons_Tamano_Proce_000306A9
		ret
	_000306C3:
		Impr_pant cons_Proce_000306C3,cons_Tamano_Proce_000306C3
		ret
	_000306D4:
		Impr_pant cons_Proce_000306D4,cons_Tamano_Proce_000306D4
		ret
	_000306E3:
		Impr_pant cons_Proce_000306E3,cons_Tamano_Proce_000306E3
		ret
	_000306E4:
		Impr_pant cons_Proce_000306E4,cons_Tamano_Proce_000306E4
		ret
	_000306F2:
		Impr_pant cons_Proce_000306F2,cons_Tamano_Proce_000306F2
		ret
	_00040651:
		Impr_pant cons_Proce_00040651,cons_Tamano_Proce_00040651
		ret
	_00040661:
		Impr_pant cons_Proce_00040661,cons_Tamano_Proce_00040661
		ret
	_00040671:
		Impr_pant cons_Proce_00040671,cons_Tamano_Proce_00040671
		ret
	_000406C3:
		Impr_pant cons_Proce_000406C3,cons_Tamano_Proce_000406C3
		ret
	_000406D8:
		Impr_pant cons_Proce_000406D8,cons_Tamano_Proce_000406D8
		ret
	_000406E3:
		Impr_pant cons_Proce_000406E3,cons_Tamano_Proce_000406E3
		ret
	_000406F1:
		Impr_pant cons_Proce_000406F1,cons_Tamano_Proce_000406F1
		ret
	_00050662:
		Impr_pant cons_Proce_00050662,cons_Tamano_Proce_00050662
		ret
	_00050670:
		Impr_pant cons_Proce_00050670,cons_Tamano_Proce_00050670
		ret
	_000506A0:
		Impr_pant cons_Proce_000506A0,cons_Tamano_Proce_000506A0
		ret
	_000506C9:
		Impr_pant cons_Proce_000506C9,cons_Tamano_Proce_000506C9
		ret
	_000506D1:
		Impr_pant cons_Proce_000506D1,cons_Tamano_Proce_000506D1
		ret
	_000506E0:
		Impr_pant cons_Proce_000506E0,cons_Tamano_Proce_000506E0
		ret
	_000506E3:
		Impr_pant cons_Proce_000506E3,cons_Tamano_Proce_000506E3
		ret
	_000806E9:
		Impr_pant cons_Proce_000806E9,cons_Tamano_Proce_000806E9
		ret
	_000906E9:
		Impr_pant cons_Proce_000906E9,cons_Tamano_Proce_000906E9
		ret
	_00000586:
		Impr_pant cons_Proce_00000586,cons_Tamano_Proce_00000586
		ret
	_00000504:
		Impr_pant cons_Proce_00000504,cons_Tamano_Proce_00000504
		ret
	_00000521:
		Impr_pant cons_Proce_00000521,cons_Tamano_Proce_00000521
		ret
	_00000505:
		Impr_pant cons_Proce_00000505,cons_Tamano_Proce_00000505
		ret
	_00000522:
		Impr_pant cons_Proce_00000522,cons_Tamano_Proce_00000522
		ret