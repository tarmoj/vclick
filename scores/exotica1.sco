; Kagel ECOTICA metronoomi ettevalmistus									

									
#define TUTTI  #0#										
									
;count-down 									
#define REPTEMPO #31.5#		 
#define BEGIN #3#				
t 0 $REPTEMPO									
i 1 0 0 $REPTEMPO 0									
i 18 [$BEGIN-2] 2 4 $TUTTI; 4 klikki 2 löögi jooksul									
s									
								
#define TEMPO1 #31.5#									
								
; skriptis: loe väli <takti nr> ja siis advance <algus>-0.01 lööki									
			
t	0	$TEMPO1
									
;TODO: genereeri t järgi i1 read või vastupidi; võibolla isegi vastupidi...									
i 	1	0	0	$TEMPO1 0	0	; sea tempo		
									
	

; TAKTIMÕÕDUD									
;i	instrnr	algus	kestus	löökide arv	mitmendikku	alajaotusi	takti nr	instrumendid 	
i	2	0	3.5	7	8	0	1	$TUTTI	
i	2	3.5	3.5	7	8	0	2	$TUTTI	
i	2	7	2	2	4	2	3	$TUTTI	
i	2	9	3.5	7	8	0	4	$TUTTI	
i	2	12.5	3	3	4	2	5	$TUTTI	
i	2	15.5	3.5	7	8	0	6	$TUTTI	
i	2	19	3	3	4	2	7	$TUTTI	
i	2	22	3	3	4	2	8	$TUTTI	
i	2	25	3	3	4	2	9	$TUTTI	
i	2	28	2	2	4	2	10	$TUTTI	
i	2	30	2	2	4	2	11	$TUTTI	
i	2	32	2	2	4	2	12	$TUTTI	
i	2	34	4	4	4	2	13	$TUTTI	
i	2	38	3	3	4	2	14	$TUTTI	
i	2	41	3	3	4	2	15	$TUTTI	
i	2	44	2.5	5	8	0	16	$TUTTI	
i	2	46.5	2.5	5	8	0	17	$TUTTI	
i	2	49	2.5	5	8	0	18	$TUTTI	
i	2	51.5	3	3	4	2	19	$TUTTI	
i	2	54.5	1.5	3	8	0	20	$TUTTI	
i	2	56	1.5	3	8	0	21	$TUTTI	
i	2	57.5	1.5	3	8	0	22	$TUTTI	
i	2	59	1.5	3	8	0	23	$TUTTI	
i	2	60.5	4	4	4	2	24	$TUTTI	
i	2	64.5	3	3	4	2	25	$TUTTI	
i	2	67.5	4.5	9	8	0	26	$TUTTI	
i	2	72	1.5	3	8	0	27	$TUTTI	
i	2	73.5	1.5	3	8	0	28	$TUTTI	
i	2	75	1.5	3	8	0	29	$TUTTI	
i	2	76.5	1.5	3	8	0	30	$TUTTI	
i	2	78	4	4	4	2	31	$TUTTI	
i	2	82	4	4	8	0	32	$TUTTI	
i	2	86	3.5	7	8	0	33	$TUTTI	
i	2	89.5	3	6	8	0	34	$TUTTI	
i	2	92.5	1.5	3	8	0	35	$TUTTI	
i	2	94	1.5	3	8	0	36	$TUTTI	
i	2	95.5	2	2	4	2	37	$TUTTI	
i	2	97.5	3	3	4	2	38	$TUTTI	
i	2	100.5	2.5	5	8	0	39	$TUTTI	
i	2	103	2	2	4	2	40	$TUTTI	
i	2	105	2.5	5	8	0	41	$TUTTI	
i	2	107.5	4	4	4	2	42	$TUTTI	
i	2	111.5	4	4	4	2	43	$TUTTI	
i	2	115.5	4	4	4	2	44	$TUTTI	
i	2	119.5	3.5	7	8	0	45	$TUTTI	
i	2	123	1.5	3	8	0	46	$TUTTI	
i	2	124.5	1.5	3	8	0	47	$TUTTI	
i	2	126	3.5	7	8	0	48	$TUTTI	
i	2	129.5	3.5	7	8	0	49	$TUTTI	
i	2	133	2.5	5	8	0	50	$TUTTI	
i	2	135.5	3.5	7	8	0	51	$TUTTI	
i	2	139	1.5	3	8	0	52	$TUTTI	
i	2	140.5	3	3	4	2	53	$TUTTI	
i	2	143.5	4.5	9	8	0	54	$TUTTI	
i	2	148	3.5	7	8	0	55	$TUTTI	
i	2	151.5	3.5	7	8	0	56	$TUTTI	
i	2	155	3.5	7	8	0	57	$TUTTI	
i	2	158.5	2	4	8	0	58	$TUTTI	
i	2	160.5	1.5	3	8	0	59	$TUTTI	
i	2	162	1.5	3	8	0	60	$TUTTI	
i	2	163.5	2	4	8	0	61	$TUTTI	
i	2	165.5	2	4	8	0	62	$TUTTI	
i	2	167.5	1.5	3	8	0	63	$TUTTI	
i	2	169	1.5	3	8	0	64	$TUTTI	
i	2	170.5	1.5	3	8	0	65	$TUTTI	
i	2	172	1	2	8	0	66	$TUTTI	
i	2	173	1	2	8	0	67	$TUTTI	
i	2	174	1	2	8	0	68	$TUTTI	
i	2	175	1	2	8	0	69	$TUTTI	
i	2	176	3.5	7	8	0	70	$TUTTI	; FERMAAT, koma (orig. 2/8)
i	2	179.5	1	2	8	0	71	$TUTTI	; LENTO 
