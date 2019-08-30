; vClick score for Alican Camci -  Insects symphony									
; written by Tarmo Johannes trmjhnns@gmail.com									
									
; NB! Different parts! Set the instrument numbers: 1 – fl, 2 -cl, 3 – vl, 4 – vc, 5 – perc, 6 – pf (like in score)									
									
;count-down 									
									
									
#define TUTTI  #0#									
#define SPEED #1#									
#define TEMPO1 #[80* $SPEED]#									
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)									
									
#define TEMPO90 #[80*$SPEED]#									
#define TEMPO80 #[68*$SPEED]#									
									
									
									
									
									
									
t 0 $REPTEMPO									
i 1 0 0 $REPTEMPO 0									
i "countdown" 0 4 4 $TUTTI			; four click in four beats						
i "notification" 3 1  "READY"			; notification						
									
s									
									
									
t	0	$TEMPO90	125	$TEMPO90	125	$TEMPO80	268	$TEMPO80	\
	268	$TEMPO90							
									
									
									
									
									
									
i 	1	0	0	$TEMPO90	0	0	; set the tempo		
i 	1	125	0	$TEMPO80	0	0			
i 	1	268	0	$TEMPO90	0	0			
									
									
									
;ADVANCE		; do not change by hand!							
; a 0 0.01 < beats>									
									
; times bar by bar									
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	; fl: 4:3, cl – 5:3, perc: 4:3, pf, 5:3, kp 3/4
i	2	0	3	4	5.33333333333333	0	1	17	; fl & perc , 0b010001
i	2	3	3	4	5.33333333333333	0	2	17	; instr 17 = 16 + 1
i	2	6	3	4	5.33333333333333	0	3	17	
i	2	9	3	4	5.33333333333333	0	4	17	
i	2	12	3	4	5.33333333333333	0	5	17	
i	2	15	3	4	5.33333333333333	0	6	17	
i	2	18	3	4	5.33333333333333	0	7	17	
i	2	21	3	4	5.33333333333333	0	8	17	
i	2	24	3	4	5.33333333333333	0	9	17	
i	2	27	3	4	5.33333333333333	0	10	17	
i	2	30	3	4	5.33333333333333	0	11	17	
i	2	33	3	4	5.33333333333333	0	12	17	
i	2	36	3	4	5.33333333333333	0	13	17	
i	2	39	3	4	5.33333333333333	0	14	17	
i	2	42	3	4	5.33333333333333	0	15	17	
i	2	45	3	4	5.33333333333333	0	16	17	
i	2	48	3	4	5.33333333333333	0	17	17	
i	2	51	3	4	5.33333333333333	0	18	17	
i	2	54	3	4	5.33333333333333	0	19	51	; alates 19 kõik, va keelpillid 4:3
i	2	57	3	4	5.33333333333333	0	20	51	
i	2	60	3	4	5.33333333333333	0	21	51	
i	2	63	3	4	5.33333333333333	0	22	51	
i	2	66	3	4	5.33333333333333	0	23	51	; siiani 3/4 4:3
i	2	69	3	4	5.33333333333333	0	24	51	; 24: 4:3 + 1 /4
i	2	72	1	1	4	0	-24.5	51	
i	2	73	3	4	5.33333333333333	0	25	32	; klaver jätkab üksi 3:4
i	2	76	3	4	5.33333333333333	0	26	32	
i	2	79	3	4	5.33333333333333	0	27	32	
i	2	82	3	4	5.33333333333333	0	28	32	
i	2	85	3	4	5.33333333333333	0	29	32	
i	2	88	3	4	5.33333333333333	0	30	32	; 4:3 + 1/4
i	2	91	1	1	4	0	-30.5	32	
									
									
									
i	2	379	3	4	5.33333333333333	0	110	17	; fl + perc 4:3
i	2	382	3	4	5.33333333333333	0	111	17	
i	2	385	3	4	5.33333333333333	0	112	17	
i	2	388	3	4	5.33333333333333	0	113	17	
i	2	391	5	5	4	0	114	17	
i	2	396	3	4	5.33333333333333	0	115	17	
i	2	399	3	4	5.33333333333333	0	116	17	
i	2	402	3	4	5.33333333333333	0	117	17	
i	2	405	3	4	5.33333333333333	0	118	17	
i	2	408	8	8	4	0	119	17	
i	2	416	3	4	5.33333333333333	0	120	17	
i	2	419	3	4	5.33333333333333	0	121	17	
i	2	422	3	4	5.33333333333333	0	122	17	
i	2	425	3	4	5.33333333333333	0	123	17	
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
i	2	0	3	5	6.66666666666667	0	1	34	; cl & pf, 0b100010
i	2	3	3	5	6.66666666666667	0	2	34	; instr 66 = 32 + 2
i	2	6	3	5	6.66666666666667	0	3	34	
i	2	9	3	5	6.66666666666667	0	4	34	
i	2	12	3	5	6.66666666666667	0	5	34	
i	2	15	3	5	6.66666666666667	0	6	34	
i	2	18	3	5	6.66666666666667	0	7	34	
i	2	21	3	5	6.66666666666667	0	8	34	
i	2	24	3	5	6.66666666666667	0	9	34	
i	2	27	3	5	6.66666666666667	0	10	34	
i	2	30	3	5	6.66666666666667	0	11	34	
i	2	33	3	5	6.66666666666667	0	12	34	
i	2	36	3	5	6.66666666666667	0	13	34	
i	2	39	3	5	6.66666666666667	0	14	34	
i	2	42	3	5	6.66666666666667	0	15	34	
i	2	45	3	5	6.66666666666667	0	16	34	
i	2	48	3	5	6.66666666666667	0	17	34	
i	2	51	3	5	6.66666666666667	0	18	34	; siiani 3/4 5:3
									
									
									
i	2	379	3	5	6.66666666666667	0	110	34	; cl + pf 5:3
i	2	382	3	5	6.66666666666667	0	111	34	
i	2	385	3	5	6.66666666666667	0	112	34	
i	2	388	3	5	6.66666666666667	0	113	34	
i	2	391	5	5	4	0	114	34	
i	2	396	3	5	6.66666666666667	0	115	34	
i	2	399	3	5	6.66666666666667	0	116	34	
i	2	402	3	5	6.66666666666667	0	117	34	
i	2	405	3	5	6.66666666666667	0	118	34	
i	2	408	8	8	4	0	119	34	
i	2	416	3	5	6.66666666666667	0	120	34	
i	2	419	3	5	6.66666666666667	0	121	34	
i	2	422	3	5	6.66666666666667	0	122	34	
i	2	425	3	5	6.66666666666667	0	123	34	
									
									
									
									
									
									
									
i	2	0	3	3	4	0	1	12	; vl & vc, 0b001100
i	2	3	3	3	4	0	2	12	; instr 12 = 4 + 8
i	2	6	3	3	4	0	3	12	
i	2	9	3	3	4	0	4	12	
i	2	12	3	3	4	0	5	12	
i	2	15	3	3	4	0	6	12	
i	2	18	3	3	4	0	7	12	
i	2	21	3	3	4	0	8	12	
i	2	24	3	3	4	0	9	12	
i	2	27	3	3	4	0	10	12	
i	2	30	3	3	4	0	11	12	
i	2	33	3	3	4	0	12	12	
i	2	36	3	3	4	0	13	12	
i	2	39	3	3	4	0	14	12	
i	2	42	3	3	4	0	15	12	
i	2	45	3	3	4	0	16	12	
i	2	48	3	3	4	0	17	12	
i	2	51	3	3	4	0	18	12	
i	2	54	3	3	4	0	19	12	
i	2	57	3	3	4	0	20	12	
i	2	60	3	3	4	0	21	12	
i	2	63	3	3	4	0	22	12	
i	2	66	3	3	4	0	23	12	
i	2	69	4	4	4	0	24	12	
i	2	73	3	3	4	0	25	31	; va klaver
i	2	76	3	3	4	0	26	31	
i	2	79	3	3	4	0	27	31	
i	2	82	3	3	4	0	28	31	
i	2	85	3	3	4	0	29	31	
i	2	88	4	4	4	0	30	31	
i	2	92	3	3	4	0	31	$TUTTI	
i	2	95	4	4	4	0	32	$TUTTI	
i	2	99	3	3	4	0	33	$TUTTI	
i	2	102	3	3	4	0	34	$TUTTI	
i	2	105	3	3	4	0	35	$TUTTI	
i	2	108	3	3	4	0	36	$TUTTI	
i	2	111	3	3	4	0	37	$TUTTI	
i	2	114	4	4	4	0	38	$TUTTI	
i	2	118	3	3	4	0	39	$TUTTI	
i	2	121	4	4	4	0	40	$TUTTI	
i	2	125	3	3	4	0	41	$TUTTI	; tempo 80
i	2	128	3	3	4	0	42	$TUTTI	
i	2	131	3	3	4	0	43	$TUTTI	
i	2	134	3	3	4	0	44	$TUTTI	
i	2	137	4	4	4	0	45	$TUTTI	
i	2	141	3	3	4	0	46	$TUTTI	
i	2	144	3	3	4	0	47	$TUTTI	
i	2	147	3	3	4	0	48	$TUTTI	
i	2	150	3	3	4	0	49	$TUTTI	
i	2	153	3	3	4	0	50	$TUTTI	
i	2	156	4	4	4	0	51	$TUTTI	
i	2	160	3	3	4	0	52	$TUTTI	
i	2	163	3	3	4	0	53	$TUTTI	
i	2	166	3	3	4	0	54	$TUTTI	
i	2	169	4	4	4	0	55	$TUTTI	
i	2	173	3	3	4	0	56	$TUTTI	
i	2	176	3	3	4	0	57	$TUTTI	
i	2	179	3	3	4	0	58	$TUTTI	
i	2	182	3	3	4	0	59	$TUTTI	
i	2	185	3	3	4	0	60	$TUTTI	
i	2	188	3	3	4	0	61	$TUTTI	
i	2	191	4	4	4	0	62	$TUTTI	
i	2	195	4	4	4	0	63	$TUTTI	
i	2	199	4	4	4	0	64	$TUTTI	
i	2	203	4	4	4	0	65	$TUTTI	
i	2	207	4	4	4	0	66	$TUTTI	
i	2	211	5	5	4	0	67	$TUTTI	
i	2	216	4	4	4	0	68	$TUTTI	
i	2	220	4	4	4	0	69	$TUTTI	
i	2	224	4	4	4	0	70	$TUTTI	
i	2	228	4	4	4	0	71	$TUTTI	
i	2	232	4	4	4	0	72	$TUTTI	
i	2	236	4	4	4	0	73	$TUTTI	
i	2	240	4	4	4	0	74	$TUTTI	
i	2	244	4	4	4	0	75	$TUTTI	
i	2	248	6	6	4	0	76	$TUTTI	; fermaat  8/4
i	2	254	4	4	4	0	77	$TUTTI	
i	2	258	2	2	4	0	78	$TUTTI	
i	2	260	8	8	4	0	79	$TUTTI	; fermaat 10/4
i	2	268	3	3	4	0	80	$TUTTI	; tempo 90
i	2	271	3	3	4	0	81	$TUTTI	
i	2	274	4	4	4	0	82	$TUTTI	
i	2	278	4	4	4	0	83	$TUTTI	
i	2	282	4	4	4	0	84	$TUTTI	
i	2	286	4	4	4	0	85	$TUTTI	
i	2	290	4	4	4	0	86	$TUTTI	
i	2	294	3	3	4	0	87	$TUTTI	
i	2	297	3	3	4	0	88	$TUTTI	
i	2	300	6	6	4	0	89	$TUTTI	; fermaat 6/4
i	2	306	4	4	4	0	90	$TUTTI	
i	2	310	4	4	4	0	91	$TUTTI	
i	2	314	7	7	4	0	92	$TUTTI	; fermaat 7/4
i	2	321	4	4	4	0	93	$TUTTI	
i	2	325	2	2	4	0	94	$TUTTI	
i	2	327	3	3	4	0	95	$TUTTI	
i	2	330	3	3	4	0	96	$TUTTI	
i	2	333	3	3	4	0	97	$TUTTI	
i	2	336	2.5	5	8	0	98	$TUTTI	; tee 2 +3
i	2	338.5	3	3	4	0	99	$TUTTI	
i	2	341.5	4	4	4	0	100	$TUTTI	
i	2	345.5	3	3	4	0	101	$TUTTI	
i	2	348.5	3	3	4	0	102	$TUTTI	
i	2	351.5	3.5	7	8	0	103	$TUTTI	; tee 2+2+3
i	2	355	3	3	4	0	104	$TUTTI	
i	2	358	3	3	4	0	105	$TUTTI	
i	2	361	4	4	4	0	106	$TUTTI	
i	2	365	4	4	4	0	107	$TUTTI	
i	2	369	4	4	4	0	108	$TUTTI	
i	2	373	6	6	4	0	109	$TUTTI	; fermaat 6/4
i	2	379	3	3	4	0	110	12	; vl + vc
i	2	382	3	3	4	0	111	12	
i	2	385	3	3	4	0	112	12	
i	2	388	3	3	4	0	113	12	
i	2	391	5	5	4	0	114	12	; fermaat 5/4
i	2	396	3	3	4	0	115	12	
i	2	399	3	3	4	0	116	12	
i	2	402	3	3	4	0	117	12	
i	2	405	3	3	4	0	118	12	
i	2	408	8	8	4	0	119	12	; fermaat  8/4
i	2	416	3	3	4	0	120	12	
i	2	419	3	3	4	0	121	12	
i	2	422	3	3	4	0	122	12	
i	2	425	3	3	4	0	123	12	
i	2	428	3	3	4	0	124	$TUTTI	
i	2	431	3	3	4	0	125	$TUTTI	
i	2	434	3	3	4	0	126	$TUTTI	; lõpp
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
; NOTIFICATIONS									
									
i	"notification"	0.01	2	"Start"	0				
i	"notification"	0.01	2	"4:3"	17				
i	"notification"	0.01	2	"5:6"	34				
i	"notification"	0.01	2	"tavaline 3/4"	12				
