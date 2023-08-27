; vClick score for Toshio Hosokawa – Vertical Time Study I										
; written by Tarmo Johannes trmjhnns@gmail.com										
										
;count-down 										
										
										
#define TUTTI  #0#										
#define SPEED #1#										
#define TEMPO1 #[21 * $SPEED]#										
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)										
										
#define TEMPO42_SLOW #[18*$SPEED]#										
#define TEMPO42 #[21*$SPEED]#										
#define TEMPO48_SLOW #[20*$SPEED]#										
#define TEMPO40 #[20*$SPEED]#										
#define TEMPO46 #[23*$SPEED]#										
#define TEMPO50 #[25*$SPEED]#										
#define TEMPO54 #[27*$SPEED]#										
#define TEMPO60 #[27*$SPEED]#										
#define TEMPO72 #[33*$SPEED]#										
#define TEMPO63 #[28*$SPEED]#										
#define TEMPO48 #[24*$SPEED]#										
t 0 $REPTEMPO										
i 1 0 0 $REPTEMPO 0										
i "countdown" 0 2 4 $TUTTI			; four click in four beats							
i "notification" 1.5 0.5  "READY"			; notification							
										
s										
										
										
t	0	$TEMPO1	33	$TEMPO1	33	$TEMPO40	65	$TEMPO40	\	
	65	$TEMPO46	87	$TEMPO46	87	$TEMPO50	101	$TEMPO50	\	
	101	$TEMPO54	109	$TEMPO54	109	$TEMPO50	132	$TEMPO50 	\	
	132	$TEMPO60	133	$TEMPO60					\	
	133	$TEMPO63	137.75	$TEMPO63	137.75	$TEMPO72	152	$TEMPO72	\	
	152	$TEMPO60	161	$TEMPO60	161	$TEMPO48_SLOW	177	$TEMPO48_SLOW	\	
	177	$TEMPO42_SLOW								
										
i 	1	0	0	$TEMPO1	0	0	; set the tempo			
i 	1	33	0	$TEMPO40	0	0				
i 	1	65	0	$TEMPO46	0	0				
i 	1	87	0	$TEMPO50	0	0				
i 	1	101	0	$TEMPO54	0	0				
i 	1	109	0	$TEMPO50	0	0				
i 	1	132	0	$TEMPO60	0	0				
i 	1	137.75	0	$TEMPO72	0	0				
i 	1	152	0	$TEMPO60	0	0				
i 	1	161	0	$TEMPO48	0	0				
i 	1	177	0	$TEMPO42	0	0				
										
										
										
										
										
										
;ADVANCE		; do not change by hand!								
; a 0 0.01 < beats>										
										
; times bar by bar										
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments		
i	2	0	0.5	1	8	0	1	$TUTTI	; tempo 1	
i	2	0.5	1.5	3	8	0	2	$TUTTI		
i	2	2	2.5	5	8	0	3	$TUTTI	; fermaat 5	
i	2	4.5	0.5	1	8	0	4	$TUTTI		
i	2	5	2	4	8	0	5	$TUTTI		
i	2	7	3.5	7	8	0	6	$TUTTI		
i	2	10.5	0.5	1	8	0	7	$TUTTI		
i	2	11	1.5	3	8	0	8	$TUTTI		
i	2	12.5	3.5	7	8	0	9	$TUTTI		
i	2	16	0.5	2	16	0	10	$TUTTI		
i	2	16.5	2	4	8	0	11	$TUTTI		
i	2	18.5	1.5	3	8	0	12	$TUTTI		
i	2	20	3.5	7	8	0	13	$TUTTI		
i	2	23.5	0.5	1	8	0	14	$TUTTI		; 6/4 for fermata, 4. löögil edasi
i	2	24	0.5	2	16	0	15	$TUTTI		
i	2	24.5	2.5	5	8	0	16	$TUTTI		
i	2	27	1.5	3	8	0	17	$TUTTI		
i	2	28.5	1.5	3	8	0	18	$TUTTI		
i	2	30	2.5	5	8	0	19	$TUTTI		
i	2	32.5	0.5	1	8	0	20	$TUTTI	; 2	
i	2	33	2	4	8	0	21	$TUTTI	; tempo 40	
i	2	35	2.5	5	8	0	22	$TUTTI	; väike fermaat 5/8 (teade!)	
i	2	37.5	0.5	2	16	0	23	$TUTTI		
i	2	38	1.5	3	8	0	24	$TUTTI		
i	2	39.5	2.5	5	8	0	25	$TUTTI		
i	2	42	2.5	5	8	0	26	$TUTTI		
i	2	44.5	1	4	16	0	27	$TUTTI		
i	2	45.5	1.5	3	8	0	28	$TUTTI		
i	2	47	2	4	8	0	29	$TUTTI		
i	2	49	2	4	8	0	30	$TUTTI		
i	2	51	2	4	8	0	31	$TUTTI		
i	2	53	2	4	8	0	32	$TUTTI		
i	2	55	1.5	3	8	0	33	$TUTTI		
i	2	56.5	2	4	8	0	34	$TUTTI		
i	2	58.5	1.5	3	8	0	35	$TUTTI		
i	2	60	5	10	8	0	36	$TUTTI		
i	2	65	2	4	8	0	37	$TUTTI	; 3 Tempo 46	
i	2	67	2	4	8	0	38	$TUTTI		
i	2	69	2	4	8	0	39	$TUTTI		
i	2	71	2	4	8	0	40	$TUTTI		
i	2	73	2	4	8	0	41	$TUTTI		
i	2	75	2	4	8	0	42	$TUTTI		
i	2	77	2	4	8	0	43	$TUTTI		
i	2	79	2	4	8	0	44	$TUTTI		
i	2	81	1.5	3	8	0	45	$TUTTI		
i	2	82.5	2	4	8	0	46	$TUTTI	; molto rit, ignore now...	
i	2	84.5	2.5	5	8	0	47	$TUTTI	; fermaat 5/8	
i	2	87	2	4	8	0	48	$TUTTI	; 4 tempo 50	
i	2	89	1.5	3	8	0	49	$TUTTI		
i	2	90.5	2	4	8	0	50	$TUTTI		
i	2	92.5	1.5	3	8	0	51	$TUTTI		
i	2	94	2	4	8	0	52	$TUTTI		
i	2	96	1.5	3	8	0	53	$TUTTI		
i	2	97.5	2	4	8	0	54	$TUTTI		
i	2	99.5	1.5	3	8	0	55	$TUTTI	; accel 	
i	2	101	2	4	8	0	56	$TUTTI	; tempo 54	
i	2	103	1.5	3	8	0	57	$TUTTI		
i	2	104.5	2	4	8	0	58	$TUTTI		
i	2	106.5	2.5	5	8	0	59	$TUTTI	; fermaat 5/8	
i	2	109	2	4	8	0	60	$TUTTI	; 5 tempo 50	
i	2	111	1.5	3	8	0	61	$TUTTI		
i	2	112.5	2	4	8	0	62	$TUTTI		
i	2	114.5	1.5	3	8	0	63	$TUTTI		
i	2	116	2	4	8	0	64	$TUTTI		
i	2	118	1.5	3	8	0	65	$TUTTI		
i	2	119.5	2	4	8	0	66	$TUTTI		
i	2	121.5	1.5	3	8	0	67	$TUTTI		
i	2	123	1.5	3	8	0	68	$TUTTI		
i	2	124.5	1.5	3	8	0	69	$TUTTI		
i	2	126	1.5	3	8	0	70	$TUTTI		
i	2	127.5	1.5	3	8	0	71	$TUTTI		
i	2	129	1.5	3	8	0	72	$TUTTI		
i	2	130.5	1.5	3	8	0	73	$TUTTI	; accel 	
i	2	132	1	2	8	0	74	$TUTTI	; tempo 60	
i	2	133	2	4	8	0	75	$TUTTI	; 6 tempo 63 	
i	2	135	0.5	2	16	0	76	$TUTTI		
i	2	135.5	1.5	3	8	0	77	$TUTTI		
i	2	137	0.75	3	16	0	78	$TUTTI		
i	2	137.75	1.5	3	8	0	79	$TUTTI	; tempo 72	
i	2	139.25	1.5	3	8	0	80	$TUTTI		
i	2	140.75	0.75	3	16	0	81	$TUTTI		
i	2	141.5	1.5	3	8	0	82	$TUTTI		
i	2	143	0.5	2	16	0	83	$TUTTI		
i	2	143.5	1.5	3	8	0	84	$TUTTI		
i	2	145	2	4	8	0	85	$TUTTI		
i	2	147	1.5	3	8	0	86	$TUTTI		
i	2	148.5	1.5	3	8	0	87	$TUTTI	; rit	
i	2	150	2	4	8	0	88	$TUTTI	; accel  koma -  4/8	
i	2	152	1.5	3	8	0	89	$TUTTI	; 7 tempo 60	
i	2	153.5	1.5	3	8	0	90	$TUTTI		
i	2	155	2	4	8	0	91	$TUTTI		
i	2	157	4	8	8	0	92	$TUTTI		
i	2	161	3	6	8	0	93	$TUTTI	; tempo 48	
i	2	164	3	6	8	0	94	$TUTTI		
i	2	167	2	4	8	0	95	$TUTTI		
i	2	169	1.5	3	8	0	96	$TUTTI		
i	2	170.5	2	4	8	0	97	$TUTTI		
i	2	172.5	2	4	8	0	98	$TUTTI	; fermaat 4/8	
i	2	174.5	2.5	5	8	0	99	$TUTTI	; fermaat 5/8	
i	2	177	1.5	3	8	0	100	$TUTTI	; 8 tempo 42	
i	2	178.5	1.5	3	8	0	101	$TUTTI		
i	2	180	1.5	3	8	0	102	$TUTTI		
i	2	181.5	1.5	3	8	0	103	$TUTTI		
i	2	183	1.5	3	8	0	104	$TUTTI		
i	2	184.5	3	6	8	0	105	$TUTTI	; fermaat 6/8	
i	2	187.5	2.5	5	8	0	106	$TUTTI	; fermaat 5/8	
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
; NOTIFICATIONS										
										
i	"notification"	0.01	2	"Start"						
i	"notification"	32.5	2	"2"						
i	"notification"	65	2	"3"						
i	"notification"	87	2	"4"						
i	"notification"	109	2	"5"						
i	"notification"	133	2	"6"						
i	"notification"	152	2	"7"						
i	"notification"	177	2	"8"						
