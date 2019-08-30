; vClick score for Gordon Fitzell „Elea”									
; written by Tarmo Johannes trmjhnns@gmail.com									
									
;count-down 									
									
									
#define TUTTI  #0#									
#define SPEED #0.9#									
#define TEMPO1 #[60 * $SPEED]#									
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)									
									
#define TEMPO60 #[60*$SPEED]#									
#define TEMPO2 #[48 * $SPEED]#									
#define TEMPO3 #[40 * $SPEED]#									
									
									
									
									
									
t 0 $REPTEMPO									
i 1 0 0 $REPTEMPO 0									
i "countdown" 0 4 4 $TUTTI			; four click in four beats						
i "notification" 3 1  "READY"			; notification						
									
s									
									
									
t	0	$TEMPO1	160	$TEMPO1	165	$TEMPO2	165	$TEMPO1	\
	168	$TEMPO1	171	$TEMPO2	171	$TEMPO1	173	$TEMPO1	\
	178	$TEMPO2	178	$TEMPO1	183	$TEMPO1	191	$TEMPO3	\
	191	$TEMPO1	231	$TEMPO1	240	$TEMPO2	240	$TEMPO1	\
									
									
									
									
i 	1	0	0	$TEMPO1	0	0	; set the tempo		
i 	1	160	5	$TEMPO1	$TEMPO2	5			
i 	1	165	0	$TEMPO1	0	0			
i 	1	168	3	$TEMPO1	$TEMPO2	3			
i 	1	171	0	$TEMPO1	0	0			
i 	1	173	5	$TEMPO1	$TEMPO2	5			
i 	1	178	0	$TEMPO1	0	0			
i 	1	183	8	$TEMPO1	$TEMPO3	8			
i 	1	191	0	$TEMPO1	0	0			
i 	1	231	9	$TEMPO1	$TEMPO2	9			
i 	1	240	0	$TEMPO1	0	0			
									
									
									
									
									
									
;ADVANCE		; do not change by hand!							
; a 0 0.01 < beats>									
									
; times bar by bar									
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	
i	2	0	5	5	4	0	1	$TUTTI	; tempo 1
i	2	5	5	5	4	0	2	$TUTTI	
i	2	10	3	3	4	0	3	$TUTTI	
i	2	13	5	5	4	0	4	$TUTTI	
i	2	18	4	4	4	0	5	$TUTTI	
i	2	22	5	5	4	0	6	$TUTTI	
i	2	27	5	5	4	0	7	$TUTTI	
i	2	32	3	3	4	0	8	$TUTTI	; fermaat 2 sekundit
i	2	35	4	4	4	0	9	$TUTTI	; A
i	2	39	3	3	4	0	10	$TUTTI	
i	2	42	3	3	4	0	11	$TUTTI	
i	2	45	3	3	4	0	12	$TUTTI	
i	2	48	4	4	4	0	13	$TUTTI	
i	2	52	4	4	4	0	14	$TUTTI	; fermaat  2 sek
i	2	56	3	3	4	0	15	$TUTTI	; B
i	2	59	5	5	4	0	16	$TUTTI	; fermaat 5 sekundit
i	2	64	3	3	4	0	17	$TUTTI	; C
i	2	67	3	3	4	0	18	$TUTTI	
i	2	70	2	2	4	0	19	$TUTTI	
i	2	72	5	5	4	0	20	$TUTTI	
i	2	77	5	5	4	0	21	$TUTTI	
i	2	82	3	3	4	0	22	$TUTTI	
i	2	85	2	2	4	0	23	$TUTTI	
i	2	87	4	4	4	0	24	$TUTTI	; fermaat, lisa 1 sekund
i	2	91	4	4	4	0	25	$TUTTI	
i	2	95	4	4	4	0	26	$TUTTI	
i	2	99	3	3	4	0	27	$TUTTI	; D
i	2	102	3	3	4	0	28	$TUTTI	
i	2	105	2	2	4	0	29	$TUTTI	
i	2	107	3	3	4	0	30	$TUTTI	
i	2	110	6	6	4	0	31	$TUTTI	; fermaat, 6/4
i	2	116	3	3	4	0	32	$TUTTI	
i	2	119	3	3	4	0	33	$TUTTI	
i	2	122	4	4	4	0	34	$TUTTI	; fermaat, 4/4
i	2	126	3	3	4	0	35	$TUTTI	
i	2	129	4	4	4	0	36	$TUTTI	; fermaat 4/4
i	2	133	2	2	4	0	37	$TUTTI	; E
i	2	135	3	3	4	0	38	$TUTTI	
i	2	138	2	2	4	0	39	$TUTTI	
i	2	140	3	3	4	0	40	$TUTTI	
i	2	143	4	4	4	0	41	$TUTTI	; fermaat 4/4
i	2	147	5	5	4	0	42	$TUTTI	; fermaat  2 sek
i	2	152	3	3	4	0	43	$TUTTI	
i	2	155	5	5	4	0	44	$TUTTI	
i	2	160	5	5	4	0	45	$TUTTI	; ritenuto
i	2	165	3	3	4	0	46	$TUTTI	; a tempo
i	2	168	3	3	4	0	47	$TUTTI	; ritenuto
i	2	171	7	7	4	0	48	$TUTTI	; a tempo ; rit 3. löögist, fermaat  7/4 
i	2	178	5	5	4	0	49	$TUTTI	; a tempo
i	2	183	3	3	4	0	50	$TUTTI	; rit molto
i	2	186	5	5	4	0	51	$TUTTI	; fermaat 5/4
i	2	191	5	5	4	0	52	$TUTTI	; F atempo
i	2	196	6	6	4	0	53	$TUTTI	; comma 6/4
i	2	202	5	5	4	0	54	$TUTTI	
i	2	207	3	3	4	0	55	$TUTTI	
i	2	210	3	3	4	0	56	$TUTTI	
i	2	213	5	5	4	0	57	$TUTTI	
i	2	218	3	3	4	0	58	$TUTTI	
i	2	221	5	5	4	0	59	$TUTTI	
i	2	226	5	5	4	0	60	$TUTTI	; G
i	2	231	5	5	4	0	61	$TUTTI	; ritenuto
i	2	236	4	4	4	0	62	$TUTTI	; fermaat 4/4
i	2	240	5	5	4	0	63	$TUTTI	; H a tempo
i	2	245	3	3	4	0	64	$TUTTI	
i	2	248	2	2	4	0	65	$TUTTI	
i	2	250	4	4	4	0	66	$TUTTI	; koma
i	2	254	3	3	4	0	67	$TUTTI	
i	2	257	2	2	4	0	68	$TUTTI	
i	2	259	2	2	4	0	69	$TUTTI	
i	2	261	3	3	4	0	70	$TUTTI	
i	2	264	3	3	4	0	71	$TUTTI	
i	2	267	4	4	4	0	72	$TUTTI	
i	2	271	4	4	4	0	73	$TUTTI	
i	2	275	2	2	4	0	74	$TUTTI	; I
i	2	277	2	2	4	0	75	$TUTTI	
i	2	279	4	4	4	0	76	$TUTTI	; fermaat 4/4
i	2	283	3	3	4	0	77	$TUTTI	
i	2	286	4	4	4	0	78	$TUTTI	; fermaat 5/4
i	2	290	7	7	4	0	79	$TUTTI	; fermaat 7/4
i	2	297	5	5	4	0	80	$TUTTI	; J
i	2	302	3	3	4	0	81	$TUTTI	
i	2	305	3	3	4	0	82	$TUTTI	
i	2	308	3	3	4	0	83	$TUTTI	
i	2	311	4	4	4	0	84	$TUTTI	
i	2	315	3	3	4	0	85	$TUTTI	
i	2	318	3	3	4	0	86	$TUTTI	
i	2	321	5	5	4	0	87	$TUTTI	; fermaat 5/4
i	2	326	9	9	4	0	88	$TUTTI	; fermaat (lunga) 7/4
i	2	335	5	5	4	0	89	$TUTTI	; K
i	2	340	3	3	4	0	90	$TUTTI	
i	2	343	3	3	4	0	91	$TUTTI	
i	2	346	5	5	4	0	92	$TUTTI	
i	2	351	5	5	4	0	93	$TUTTI	
i	2	356	5	5	4	0	94	$TUTTI	
i	2	361	3	3	4	0	95	$TUTTI	
i	2	364	5	5	4	0	96	$TUTTI	
i	2	369	5	5	4	0	97	$TUTTI	
i	2	374	3	3	4	0	98	$TUTTI	
i	2	377	5	5	4	0	99	$TUTTI	
i	2	382	5	5	4	0	100	$TUTTI	
i	2	387	3	3	4	0	101	$TUTTI	
i	2	390	5	5	4	0	102	$TUTTI	
i	2	395	5	5	4	0	103	$TUTTI	
i	2	400	3	3	4	0	104	$TUTTI	
i	2	403	5	5	4	0	105	$TUTTI	
i	2	408	3	3	4	0	106	$TUTTI	
i	2	411	5	5	4	0	107	$TUTTI	
i	2	416	3	3	4	0	108	$TUTTI	
i	2	419	7	7	4	0	109	$TUTTI	; fermaat 5/4
i	2	426	4	4	4	0	110	$TUTTI	; L
i	2	430	4	4	4	0	111	$TUTTI	
i	2	434	5	5	4	0	112	$TUTTI	
i	2	439	3	3	4	0	113	$TUTTI	
i	2	442	2	2	4	0	114	$TUTTI	
i	2	444	3	3	4	0	115	$TUTTI	; fermaat 3/4
i	2	447	5	5	4	0	116	$TUTTI	
i	2	452	3	3	4	0	117	$TUTTI	
i	2	455	5	5	4	0	118	$TUTTI	; fermaat 5/4
i	2	460	5	5	4	0	119	$TUTTI	
i	2	465	5	5	4	0	120	$TUTTI	
i	2	470	3	3	4	0	121	$TUTTI	
i	2	473	8	8	4	0	122	$TUTTI	; fermaat 8/4
									
; NOTIFICATIONS									
									
i	"notification"	0.01	2	"Start"					
i	"notification"	32	3	"Fermaat 3/4"					
i	"notification"	35	3	"A"					
i	"notification"	56	3	"B"					
i	"notification"	52	3	"Fermaat 4/4"					
i	"notification"	59	3	"Fermaat 5/4"					
i	"notification"	64	3	"C"					
i	"notification"	87	3	"Fermaat 4/4"					
i	"notification"	99	3	"Fermaat 4/4"					
i	"notification"	99	3	"D"					
i	"notification"	110	3	"Fermaat 6/4"					
i	"notification"	122	3	"Fermaat 4/4"					
i	"notification"	129	3	"Fermaat 4/4"					
i	"notification"	133	3	"E"					
i	"notification"	143	3	"Fermaat 4/4"					
i	"notification"	171	3	"Fermaat 7/4"					
i	"notification"	186	3	"Fermaat 5/4"					
i	"notification"	191	3	"F"					
i	"notification"	226	3	"G"					
i	"notification"	240	3	"H"					
i	"notification"	275	3	"I"					
i	"notification"	279	3	"Fermaat 4/4"					
i	"notification"	290	3	"Fermaat 7/4"					
i	"notification"	297	3	"J"					
i	"notification"	321	3	"Fermaat 5/4"					
i	"notification"	326	3	"9/4 (lunga)"					
i	"notification"	335	3	"K"					
i	"notification"	419	3	"Fermaat 7/4"					
i	"notification"	426	3	"L"					
i	"notification"	444	3	"Fermaat 3/4"					
i	"notification"	455	3	"Fermaat 5/4"					
i	"notification"	473	3	"Fermaat 8/4"					
