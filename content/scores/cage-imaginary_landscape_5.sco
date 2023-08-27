; vClick score for John Cage -  Imaginary Landscape 5									
; written by Tarmo Johannes trmjhnns@gmail.com									
									
;count-down 									
									
									
#define TUTTI  #0#									
#define SPEED #1#									
#define TEMPO1 #[120 * $SPEED]#									
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)									
									
#define TEMPO60 #[60*$SPEED]#									
									
									
									
									
									
									
									
t 0 $REPTEMPO									
i 1 0 0 $REPTEMPO 0									
i "countdown" 0 4 4 $TUTTI			; four click in four beats						
i "notification" 3 1  "READY"			; notification						
									
s									
									
									
t	0	$TEMPO1							\
									
									
									
									
									
									
									
i 	1	0	0	$TEMPO1	0	0	; set the tempo		
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
;ADVANCE		; do not change by hand!							
; a 0 0.01 < beats>									
									
; times bar by bar									
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	
i	2	0	5	5	4	0	1	$TUTTI	; tempo 1
i	2	5	8	8	4	0	2	$TUTTI	
i	2	13	8	8	4	0	3	$TUTTI	
i	2	21	8	8	4	0	4	$TUTTI	
i	2	29	8	8	4	0	5	$TUTTI	
i	2	37	8	8	4	0	6	$TUTTI	
i	2	45	8	8	4	0	7	$TUTTI	
i	2	53	8	8	4	0	8	$TUTTI	
i	2	61	8	8	4	0	9	$TUTTI	
i	2	69	6	6	4	0	10	$TUTTI	
i	2	75	5	5	4	0	11	$TUTTI	
i	2	80	8	8	4	0	12	$TUTTI	
i	2	88	8	8	4	0	13	$TUTTI	
i	2	96	8	8	4	0	14	$TUTTI	
i	2	104	8	8	4	0	15	$TUTTI	
i	2	112	8	8	4	0	16	$TUTTI	
i	2	120	8	8	4	0	17	$TUTTI	
i	2	128	8	8	4	0	18	$TUTTI	
i	2	136	8	8	4	0	19	$TUTTI	
i	2	144	6	6	4	0	20	$TUTTI	
i	2	150	5	5	4	0	21	$TUTTI	
i	2	155	8	8	4	0	22	$TUTTI	
i	2	163	8	8	4	0	23	$TUTTI	
i	2	171	8	8	4	0	24	$TUTTI	
i	2	179	8	8	4	0	25	$TUTTI	
i	2	187	8	8	4	0	26	$TUTTI	
i	2	195	8	8	4	0	27	$TUTTI	
i	2	203	8	8	4	0	28	$TUTTI	
i	2	211	8	8	4	0	29	$TUTTI	
i	2	219	6	6	4	0	30	$TUTTI	
i	2	225	5	5	4	0	31	$TUTTI	
i	2	230	8	8	4	0	32	$TUTTI	
i	2	238	8	8	4	0	33	$TUTTI	
i	2	246	8	8	4	0	34	$TUTTI	
i	2	254	8	8	4	0	35	$TUTTI	
i	2	262	8	8	4	0	36	$TUTTI	
i	2	270	8	8	4	0	37	$TUTTI	
i	2	278	8	8	4	0	38	$TUTTI	
i	2	286	8	8	4	0	39	$TUTTI	
i	2	294	8	8	4	0	40	$TUTTI	
i	2	302	6	6	4	0	41	$TUTTI	
i	2	308	5	5	4	0	42	$TUTTI	
i	2	313	8	8	4	0	43	$TUTTI	
i	2	321	8	8	4	0	44	$TUTTI	
i	2	329	8	8	4	0	45	$TUTTI	
i	2	337	8	8	4	0	46	$TUTTI	
i	2	345	8	8	4	0	47	$TUTTI	
i	2	353	8	8	4	0	48	$TUTTI	
i	2	361	8	8	4	0	49	$TUTTI	
i	2	369	8	8	4	0	50	$TUTTI	
i	2	377	6	6	4	0	51	$TUTTI	
i	2	383	5	5	4	0	52	$TUTTI	
i	2	388	8	8	4	0	53	$TUTTI	
i	2	396	8	8	4	0	54	$TUTTI	
i	2	404	8	8	4	0	55	$TUTTI	
i	2	412	8	8	4	0	56	$TUTTI	
i	2	420	8	8	4	0	57	$TUTTI	
i	2	428	8	8	4	0	58	$TUTTI	
i	2	436	8	8	4	0	59	$TUTTI	
i	2	444	8	8	4	0	60	$TUTTI	
i	2	452	6	6	4	0	61	$TUTTI	
i	2	458	5	5	4	0	62	$TUTTI	
i	2	463	8	8	4	0	63	$TUTTI	
i	2	471	8	8	4	0	64	$TUTTI	
i	2	479	8	8	4	0	65	$TUTTI	
i	2	487	8	8	4	0	66	$TUTTI	
i	2	495	8	8	4	0	67	$TUTTI	
i	2	503	8	8	4	0	68	$TUTTI	
i	2	511	8	8	4	0	69	$TUTTI	
i	2	519	8	8	4	0	70	$TUTTI	
i	2	527	6	6	4	0	71	$TUTTI	
i	2	533	5	5	4	0	72	$TUTTI	
i	2	538	8	8	4	0	73	$TUTTI	
i	2	546	8	8	4	0	74	$TUTTI	
i	2	554	8	8	4	0	75	$TUTTI	
i	2	562	8	8	4	0	76	$TUTTI	
i	2	570	8	8	4	0	77	$TUTTI	
i	2	578	8	8	4	0	78	$TUTTI	
i	2	586	8	8	4	0	79	$TUTTI	
i	2	594	8	8	4	0	80	$TUTTI	
i	2	602	6	6	4	0	81	$TUTTI	
i	2	608	5	5	4	0	82	$TUTTI	
i	2	613	8	8	4	0	83	$TUTTI	
i	2	621	8	8	4	0	84	$TUTTI	
i	2	629	8	8	4	0	85	$TUTTI	
i	2	637	8	8	4	0	86	$TUTTI	
i	2	645	8	8	4	0	87	$TUTTI	
i	2	653	8	8	4	0	88	$TUTTI	
i	2	661	8	8	4	0	89	$TUTTI	
i	2	669	8	8	4	0	90	$TUTTI	
i	2	677	6	6	4	0	91	$TUTTI	
i	2	683	5	5	4	0	92	$TUTTI	
i	2	688	8	8	4	0	93	$TUTTI	
i	2	696	8	8	4	0	94	$TUTTI	
i	2	704	8	8	4	0	95	$TUTTI	
i	2	712	8	8	4	0	96	$TUTTI	
i	2	720	8	8	4	0	97	$TUTTI	
i	2	728	8	8	4	0	98	$TUTTI	
i	2	736	8	8	4	0	99	$TUTTI	
i	2	744	8	8	4	0	100	$TUTTI	
i	2	752	6	6	4	0	101	$TUTTI	
i	2	758	5	5	4	0	102	$TUTTI	
i	2	763	8	8	4	0	103	$TUTTI	
i	2	771	8	8	4	0	104	$TUTTI	
i	2	779	8	8	4	0	105	$TUTTI	
i	2	787	8	8	4	0	106	$TUTTI	
i	2	795	8	8	4	0	107	$TUTTI	
i	2	803	8	8	4	0	108	$TUTTI	
i	2	811	8	8	4	0	109	$TUTTI	
i	2	819	8	8	4	0	110	$TUTTI	
i	2	827	6	6	4	0	111	$TUTTI	
i	2	833	5	5	4	0	112	$TUTTI	
i	2	838	4	4	4	0	113	$TUTTI	
i	2	842	4	4	4	0	114	$TUTTI	
i	2	846	4	4	4	0	115	$TUTTI	
i	2	850	4	4	4	0	116	$TUTTI	
i	2	854	4	4	4	0	117	$TUTTI	
i	2	858	4	4	4	0	118	$TUTTI	
i	2	862	4	4	4	0	119	$TUTTI	
i	2	866	4	4	4	0	120	$TUTTI	
i	2	870	6	6	4	0	121	$TUTTI	
									
									
									
									
									
									
									
									
									
									
									
; NOTIFICATIONS									
									
i	"notification"	0.01	2	"Start"					
