; vClick score for „Madame de Shanghai” by Luc Ferrari									
; written by Tarmo Johannes trmjhnns@gmail.com									
									
;count-down 									
									
									
#define TUTTI  #0#									
#define SPEED #1#									
#define TEMPO1 #[60 * $SPEED]#									
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)									
									
#define TEMPO60 #[60*$SPEED]#									
									
									
									
t 0 $REPTEMPO									
i 1 0 0 $REPTEMPO 0									
i "countdown" 0 4 4 $TUTTI			; four click in four beats						
i "notification" 3 1  "READY"			; notification						
									
s									
									
									
									
									
									
									
;ADVANCE		; do not change by hand!							
; a 0 0.01 < beats>									
									
									
									
t	0	$TEMPO1							
i 	1	0	0	$TEMPO1	0	0			
									
									
									
; start playback of the file here (or from file?)									
i	"playfile"	0.1	999	"/home/tarmo/tarmo/fl_ja_elektroonika/Luc Ferrari -  Madame de Shanghai/0070ONA_MadameDeShanghai_LucFerrari_Audio.wav"	0	0	; NB! , p5 is the skiptime -  maybe arrange it somehow when you start from later		
i	"notification"	0.01	2	"Start"	$TUTTI				
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	
i	2	1	45	45	4	0	0	$TUTTI	; 46 seconds before countdown, start on second 0
									
; flutes start to play in 0:50									
i	"countdown"	46	4	4	$TUTTI	; four click in four beats			
i	"notification"	49	1	"Ready"	$TUTTI				
i	"notification"	50.01	2	"Start"	$TUTTI				
									
; times bar by bar									
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	
i	2	50	4	4	4	0	1001	$TUTTI	; 101 to be able to start from here
i	2	54	4	4	4	0	2	$TUTTI	
i	2	58	4	4	4	0	3	$TUTTI	
i	2	62	4	4	4	0	4	$TUTTI	
i	2	66	4	4	4	0	5	$TUTTI	
i	2	70	4	4	4	0	6	$TUTTI	
i	2	74	4	4	4	0	7	$TUTTI	
i	2	78	4	4	4	0	8	$TUTTI	
i	2	82	4	4	4	0	9	$TUTTI	
i	2	86	4	4	4	0	10	$TUTTI	
i	2	90	4	4	4	0	11	$TUTTI	
i	2	94	4	4	4	0	12	$TUTTI	
i	2	98	4	4	4	0	13	$TUTTI	
i	2	102	4	4	4	0	14	$TUTTI	
i	2	106	4	4	4	0	15	$TUTTI	
i	2	110	4	4	4	0	16	$TUTTI	
i	2	114	4	4	4	0	17	$TUTTI	
i	2	118	4	4	4	0	18	$TUTTI	
i	2	122	4	4	4	0	19	$TUTTI	
i	2	126	4	4	4	0	20	$TUTTI	
i	2	130	4	4	4	0	21	$TUTTI	
i	2	134	4	4	4	0	22	$TUTTI	
i	2	138	4	4	4	0	23	$TUTTI	
i	2	142	4	4	4	0	24	$TUTTI	
i	2	146	4	4	4	0	25	$TUTTI	; last bar of section 1
									
									
									
									
i	"notification"	150	4	"2:30"					
									
i	"notification"	180	4	"3:00"					
									
; section 2 starts at 3:28									
									
i	"countdown"	204	4	4	$TUTTI	; four click in four beats			
i	"notification"	207	1	"Ready"	$TUTTI				
i	"notification"	208.01	2	"Section 2"	$TUTTI				
									
i	2	208	4	4	4	0	26	$TUTTI	
i	2	212	4	4	4	0	27	$TUTTI	
i	2	216	4	4	4	0	28	$TUTTI	
i	2	220	4	4	4	0	29	$TUTTI	
i	2	224	4	4	4	0	30	$TUTTI	
i	2	228	4	4	4	0	31	$TUTTI	
i	2	232	4	4	4	0	32	$TUTTI	
i	2	236	4	4	4	0	33	$TUTTI	
i	2	240	4	4	4	0	34	$TUTTI	
i	2	244	4	4	4	0	35	$TUTTI	
i	2	248	4	4	4	0	36	$TUTTI	
i	2	252	4	4	4	0	37	$TUTTI	
i	2	256	4	4	4	0	38	$TUTTI	
i	2	260	4	4	4	0	39	$TUTTI	
i	2	264	4	4	4	0	40	$TUTTI	
i	2	268	4	4	4	0	41	$TUTTI	
i	2	272	4	4	4	0	42	$TUTTI	
i	2	276	4	4	4	0	43	$TUTTI	
i	2	280	4	4	4	0	44	$TUTTI	
i	2	284	4	4	4	0	45	$TUTTI	
i	2	288	4	4	4	0	46	$TUTTI	
i	2	292	4	4	4	0	47	$TUTTI	
i	2	296	4	4	4	0	48	$TUTTI	
i	2	300	4	4	4	0	49	$TUTTI	
i	2	304	4	4	4	0	50	$TUTTI	
i	2	308	4	4	4	0	51	$TUTTI	
i	2	312	4	4	4	0	52	$TUTTI	
i	2	316	4	4	4	0	53	$TUTTI	
i	2	320	4	4	4	0	54	$TUTTI	
i	2	324	4	4	4	0	55	$TUTTI	
i	2	328	4	4	4	0	56	$TUTTI	
									
									
i	"notification"	332	4	"2:30"	$TUTTI				
									
i	"notification"	360	4	"6:00"	$TUTTI				
									
; section 3 starts at 6:33									
									
i	"countdown"	389	4	4	$TUTTI	; four click in four beats			
i	"notification"	392	1	"Ready"	$TUTTI				
i	"notification"	393.01	2	"Section 3"	$TUTTI				
									
i	2	393	4	4	4	0	57	$TUTTI	
i	2	397	4	4	4	0	58	$TUTTI	
i	2	401	4	4	4	0	59	$TUTTI	
i	2	405	4	4	4	0	60	$TUTTI	
i	2	409	4	4	4	0	61	$TUTTI	
i	2	413	4	4	4	0	62	$TUTTI	
i	2	417	4	4	4	0	63	$TUTTI	
i	2	421	4	4	4	0	64	$TUTTI	
i	2	425	4	4	4	0	65	$TUTTI	
i	2	429	4	4	4	0	66	$TUTTI	
i	2	433	4	4	4	0	67	$TUTTI	
i	2	437	4	4	4	0	68	$TUTTI	
i	2	441	4	4	4	0	69	$TUTTI	
i	2	445	4	4	4	0	70	$TUTTI	
i	2	449	4	4	4	0	71	$TUTTI	
i	2	453	4	4	4	0	72	$TUTTI	
i	2	457	4	4	4	0	73	$TUTTI	
i	2	461	4	4	4	0	74	$TUTTI	
i	2	465	4	4	4	0	75	$TUTTI	
i	2	469	4	4	4	0	76	$TUTTI	
i	2	473	4	4	4	0	77	$TUTTI	
i	2	477	4	4	4	0	78	$TUTTI	
i	2	481	4	4	4	0	79	$TUTTI	
i	2	485	4	4	4	0	80	$TUTTI	
i	2	489	4	4	4	0	81	$TUTTI	
i	2	493	4	4	4	0	82	$TUTTI	
i	2	497	4	4	4	0	83	$TUTTI	
i	2	501	4	4	4	0	84	$TUTTI	
i	2	505	4	4	4	0	85	$TUTTI	
i	2	509	4	4	4	0	86	$TUTTI	
i	2	513	4	4	4	0	87	$TUTTI	
									
i	"notification"	513	4	"8:33"	$TUTTI				
									
i	"notification"	540	4	"9:00"	$TUTTI				
									
; section 4 starts at 9:33									
									
i	"countdown"	569	4	4	$TUTTI	; four click in four beats			
i	"notification"	572	1	"Ready"	$TUTTI				
i	"notification"	573.01	2	"Section 4"	$TUTTI				
									
i	2	573	4	4	4	0	88	$TUTTI	
i	2	577	4	4	4	0	89	$TUTTI	
i	2	581	4	4	4	0	90	$TUTTI	
i	2	585	4	4	4	0	91	$TUTTI	
i	2	589	4	4	4	0	92	$TUTTI	
i	2	593	4	4	4	0	93	$TUTTI	
i	2	597	4	4	4	0	94	$TUTTI	
i	2	601	4	4	4	0	95	$TUTTI	
i	2	605	4	4	4	0	96	$TUTTI	
i	2	609	4	4	4	0	97	$TUTTI	
i	2	613	4	4	4	0	98	$TUTTI	
i	2	617	4	4	4	0	99	$TUTTI	
i	2	621	4	4	4	0	100	$TUTTI	
i	2	625	4	4	4	0	101	$TUTTI	
i	2	629	4	4	4	0	102	$TUTTI	
i	2	633	4	4	4	0	103	$TUTTI	
i	2	637	4	4	4	0	104	$TUTTI	
i	2	641	4	4	4	0	105	$TUTTI	
i	2	645	4	4	4	0	106	$TUTTI	
i	2	649	4	4	4	0	107	$TUTTI	
i	2	653	4	4	4	0	108	$TUTTI	
i	2	657	4	4	4	0	109	$TUTTI	
i	2	661	4	4	4	0	110	$TUTTI	
i	2	665	4	4	4	0	111	$TUTTI	
i	2	669	4	4	4	0	112	$TUTTI	
i	2	673	4	4	4	0	113	$TUTTI	
i	2	677	4	4	4	0	114	$TUTTI	
i	2	681	4	4	4	0	115	$TUTTI	
i	2	685	4	4	4	0	116	$TUTTI	
i	2	689	4	4	4	0	117	$TUTTI	
i	2	693	4	4	4	0	118	$TUTTI	
i	2	697	4	4	4	0	119	$TUTTI	
									
i	"notification"	697	4	"11:34"	$TUTTI				
									
i	"notification"	720	4	"12:00"	$TUTTI				
i	"notification"	750	4	"12:30"	$TUTTI				
									
; section 5 starts at 12:56									
									
i	"countdown"	772	4	4	$TUTTI	; four click in four beats			
i	"notification"	775	1	"Ready"	$TUTTI				
i	"notification"	776.01	2	"Section 4"	$TUTTI				
									
i	2	776	4	4	4	0	120	$TUTTI	
i	2	780	4	4	4	0	121	$TUTTI	
i	2	784	4	4	4	0	122	$TUTTI	
i	2	788	4	4	4	0	123	$TUTTI	
i	2	792	4	4	4	0	124	$TUTTI	
i	2	796	4	4	4	0	125	$TUTTI	
i	2	800	4	4	4	0	126	$TUTTI	
i	2	804	4	4	4	0	127	$TUTTI	
i	2	808	4	4	4	0	128	$TUTTI	
i	2	812	4	4	4	0	129	$TUTTI	
i	2	816	4	4	4	0	130	$TUTTI	
i	2	820	4	4	4	0	131	$TUTTI	
i	2	824	4	4	4	0	132	$TUTTI	
i	2	828	4	4	4	0	133	$TUTTI	
i	2	832	4	4	4	0	134	$TUTTI	
i	2	836	4	4	4	0	135	$TUTTI	
i	2	840	4	4	4	0	136	$TUTTI	
i	2	844	4	4	4	0	137	$TUTTI	
i	2	848	4	4	4	0	138	$TUTTI	
i	2	852	4	4	4	0	139	$TUTTI	
i	2	856	4	4	4	0	140	$TUTTI	
i	2	860	4	4	4	0	141	$TUTTI	
i	2	864	4	4	4	0	142	$TUTTI	
i	2	868	4	4	4	0	143	$TUTTI	
i	2	872	4	4	4	0	144	$TUTTI	
i	2	876	4	4	4	0	145	$TUTTI	
i	2	880	4	4	4	0	146	$TUTTI	
i	2	884	4	4	4	0	147	$TUTTI	
i	2	888	4	4	4	0	148	$TUTTI	
i	2	892	4	4	4	0	149	$TUTTI	
i	2	896	4	4	4	0	150	$TUTTI	
i	2	900	4	4	4	0	151	$TUTTI	
i	2	904	4	4	4	0	152	$TUTTI	
									
i	"notification"	900.01	4	"15:00"	$TUTTI				
