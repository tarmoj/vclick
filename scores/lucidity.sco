; vClick scorefor Pall Ragnar Palsson „Lucidity”										
; written by Tarmo Johannes trmjhnns@gmail.com										
										
;count-down 										
										
										
#define TUTTI  #0#										
#define SPEED #1#										
#define TEMPO1 #[40 * $SPEED]#										
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)										
										
#define TEMPO40 #[40*$SPEED]#										
#define TEMPO46 #[46*$SPEED]#										
#define TEMPO36 #[36*$SPEED]#										
#define TEMPO44 #[44*$SPEED]#										
#define TEMPO52 #[52*$SPEED]#										
#define TEMPO48 #[48*$SPEED]#										
										
										
t 0 $REPTEMPO										
i 1 0 0 $REPTEMPO 0										
i "countdown" 0 4 4 $TUTTI			; four click in four beats							
i "notification" 3 1  "READY"			; notification							
										
s										
										
										
t	0	$TEMPO1	36	$TEMPO1	36	$TEMPO44	52	$TEMPO44	\	
	52	$TEMPO40	102	$TEMPO40	102	$TEMPO46	114	$TEMPO46	\	
	130	$TEMPO36	154	$TEMPO36	170	$TEMPO44	270	$TEMPO44	\	
	270	$TEMPO48	294	$TEMPO48	294	$TEMPO52	326	$TEMPO52	\	
	338	$TEMPO36								
										
										
										
i 	1	0	0	$TEMPO1	0	0	; set the tempo			
i 	1	36	0	$TEMPO44	0	0				
i 	1	52	0	$TEMPO40	0	0				
i 	1	102	0	$TEMPO46	0	0				
i 	1	114	16	$TEMPO46	$TEMPO36	16				
i 	1	130	0	$TEMPO36	0	0				
i 	1	154	16	$TEMPO36	$TEMPO44	16				
i 	1	170	0	$TEMPO44	0	0				
i 	1	270	0	$TEMPO48	0	0				
i 	1	294	0	$TEMPO52	0	0				
i 	1	326	12	$TEMPO52	$TEMPO36	12				
i 	1	338	0	$TEMPO36	0	0				
										
										
										
										
										
;ADVANCE		; do not change by hand!								
; a 0 0.01 < beats>										
										
; times bar by bar										
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments		
i	2	0	4	4	4	0	1	$TUTTI	; tempo 40	
i	2	4	4	4	4	0	2	$TUTTI		
i	2	8	4	4	4	0	3	$TUTTI		
i	2	12	4	4	4	0	4	$TUTTI		
i	2	16	4	4	4	0	5	$TUTTI		
i	2	20	4	4	4	0	6	$TUTTI		
i	2	24	4	4	4	0	7	$TUTTI		
i	2	28	4	4	4	0	8	$TUTTI		
i	2	32	4	4	4	0	9	$TUTTI		
i	2	36	4	4	4	0	10	$TUTTI	; poci più mosso (tempo 44)	
i	2	40	4	4	4	0	11	$TUTTI		
i	2	44	4	4	4	0	12	$TUTTI		
i	2	48	4	4	4	0	13	$TUTTI		
i	2	52	6	6	4	0	14	$TUTTI	; a tempo (T40)	; 6/4 for fermata, 4. löögil edasi
i	2	58	4	4	4	0	15	$TUTTI		
i	2	62	4	4	4	0	16	$TUTTI		
i	2	66	4	4	4	0	17	$TUTTI		
i	2	70	4	4	4	0	18	$TUTTI		
i	2	74	4	4	4	0	19	$TUTTI		
i	2	78	4	4	4	0	20	$TUTTI		
i	2	82	4	4	4	0	21	$TUTTI		
i	2	86	4	4	4	0	22	$TUTTI		
i	2	90	4	4	4	0	23	$TUTTI		
i	2	94	4	4	4	0	24	$TUTTI		
i	2	98	4	4	4	0	25	$TUTTI		
i	2	102	4	4	4	0	26	$TUTTI	; Energico, Tempo 46	
i	2	106	4	4	4	0	27	$TUTTI		
i	2	110	4	4	4	0	28	$TUTTI		
i	2	114	4	4	4	0	29	$TUTTI	; rit poco a poco	
i	2	118	4	4	4	0	30	$TUTTI		
i	2	122	4	4	4	0	31	$TUTTI		
i	2	126	4	4	4	0	32	$TUTTI		
i	2	130	4	4	4	0	33	$TUTTI	; a tempo36	
i	2	134	4	4	4	0	34	$TUTTI		
i	2	138	4	4	4	0	35	$TUTTI		
i	2	142	4	4	4	0	36	$TUTTI		
i	2	146	4	4	4	0	37	$TUTTI		
i	2	150	4	4	4	0	38	$TUTTI		
i	2	154	4	4	4	0	39	$TUTTI	; accel	
i	2	158	4	4	4	0	40	$TUTTI		
i	2	162	4	4	4	0	41	$TUTTI		
i	2	166	4	4	4	0	42	$TUTTI		
i	2	170	4	4	4	0	43	$TUTTI	; a tempo44	
i	2	174	4	4	4	0	44	$TUTTI		
i	2	178	4	4	4	0	45	$TUTTI		
i	2	182	4	4	4	0	46	$TUTTI		
i	2	186	4	4	4	0	47	$TUTTI		
i	2	190	4	4	4	0	48	$TUTTI		
i	2	194	4	4	4	0	49	$TUTTI		
i	2	198	4	4	4	0	50	$TUTTI		
i	2	202	4	4	4	0	51	$TUTTI		
i	2	206	4	4	4	0	52	$TUTTI		
i	2	210	4	4	4	0	53	$TUTTI		
i	2	214	4	4	4	0	54	$TUTTI		
i	2	218	4	4	4	0	55	$TUTTI		
i	2	222	4	4	4	0	56	$TUTTI		
i	2	226	4	4	4	0	57	$TUTTI		
i	2	230	4	4	4	0	58	$TUTTI		
i	2	234	4	4	4	0	59	$TUTTI		
i	2	238	4	4	4	0	60	$TUTTI		
i	2	242	4	4	4	0	61	$TUTTI		
i	2	246	4	4	4	0	62	$TUTTI		
i	2	250	4	4	4	0	63	$TUTTI		
i	2	254	4	4	4	0	64	$TUTTI		
i	2	258	4	4	4	0	65	$TUTTI		
i	2	262	4	4	4	0	66	$TUTTI		
i	2	266	4	4	4	0	67	$TUTTI		
i	2	270	4	4	4	0	68	$TUTTI	; poco più moto (tempo 48)	
i	2	274	4	4	4	0	69	$TUTTI		
i	2	278	4	4	4	0	70	$TUTTI		
i	2	282	4	4	4	0	71	$TUTTI		
i	2	286	4	4	4	0	72	$TUTTI		
i	2	290	4	4	4	0	73	$TUTTI		
i	2	294	4	4	4	0	74	$TUTTI	; con molto fuoco (tempo 52)	
i	2	298	4	4	4	0	75	$TUTTI		
i	2	302	4	4	4	0	76	$TUTTI		
i	2	306	4	4	4	0	77	$TUTTI		
i	2	310	4	4	4	0	78	$TUTTI		
i	2	314	4	4	4	0	79	$TUTTI		
i	2	318	4	4	4	0	80	$TUTTI		
i	2	322	4	4	4	0	81	$TUTTI		
i	2	326	4	4	4	0	82	$TUTTI	; rit poco a poco	
i	2	330	4	4	4	0	83	$TUTTI		
i	2	334	4	4	4	0	84	$TUTTI		
i	2	338	4	4	4	0	85	$TUTTI	; silentico tempo36	
i	2	342	4	4	4	0	86	$TUTTI		
i	2	346	4	4	4	0	87	$TUTTI		
i	2	350	4	4	4	0	88	$TUTTI		
i	2	354	4	4	4	0	89	$TUTTI		
i	2	358	4	4	4	0	90	$TUTTI		
i	2	362	4	4	4	0	91	$TUTTI		
i	2	366	4	4	4	0	92	$TUTTI		
i	2	370	4	4	4	0	93	$TUTTI		
i	2	374	4	4	4	0	94	$TUTTI		
i	2	378	4	4	4	0	95	$TUTTI		
i	2	382	4	4	4	0	96	$TUTTI		
i	2	386	4	4	4	0	97	$TUTTI		
i	2	390	4	4	4	0	98	$TUTTI		
i	2	394	4	4	4	0	99	$TUTTI		
i	2	398	4	4	4	0	100	$TUTTI		
i	2	402	4	4	4	0	101	$TUTTI		
i	2	406	4	4	4	0	102	$TUTTI		
i	2	410	4	4	4	0	103	$TUTTI		
i	2	414	4	4	4	0	104	$TUTTI		
i	2	418	4	4	4	0	105	$TUTTI		
i	2	422	4	4	4	0	106	$TUTTI		
i	2	426	4	4	4	0	107	$TUTTI		
i	2	430	4	4	4	0	108	$TUTTI		
i	2	434	4	4	4	0	109	$TUTTI		
i	2	438	4	4	4	0	110	$TUTTI		
i	2	442	4	4	4	0	111	$TUTTI		
i	2	446	4	4	4	0	112	$TUTTI		
i	2	450	4	4	4	0	113	$TUTTI		
i	2	454	4	4	4	0	114	$TUTTI		
i	2	458	4	4	4	0	115	$TUTTI		
i	2	462	4	4	4	0	116	$TUTTI		
i	2	466	4	4	4	0	117	$TUTTI		
i	2	470	4	4	4	0	118	$TUTTI		
										
										
										
; NOTIFICATIONS										
										
i	"notification"	0.01	2	"Lento"						
i	"notification"	36	2	"Poco piu mosso"						
i	"notification"	52	2	"6/4 cl. on 4"						
i	"notification"	102	2	"Energico"						
i	"notification"	130	2	"Silentico"						
i	"notification"	170	2	"Con fuoco"						
i	"notification"	186	2	"Calmo ma intensivo"						
i	"notification"	226	2	"Silentico"						
i	"notification"	294	2	"Con molto fuoco"						
i	"notification"	338	2	"Poco silentico"						
i	"notification"	418	2	"Sostenuto e morendo"						
i	"notification"	474	2	"ca 30 sec."						
