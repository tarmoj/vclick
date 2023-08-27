; vClick score for Brian Ferneyhough – Mort subite									
; written by Tarmo Johannes trmjhnns@gmail.com									
									
;count-down 									
									
									
#define TUTTI  #0#									
#define SPEED #1#									
#define TEMPO1 #[30 * $SPEED]#									
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)									
									
#define TEMPO60 #[30*$SPEED]#									
									
#define FL_PF #[1+16]#									
#define CL_PERC #[2+32]#									
									
									
									
									
t 0 $REPTEMPO									
i 1 0 0 $REPTEMPO 0									
i "countdown" 0 2 4 $TUTTI			; four click in four beats						
i "notification" 1.5 0.5  "READY"			; notification						
									
s									
									
									
t	0	$TEMPO1							\
									
									
									
									
									
									
									
i 	1	0	0	$TEMPO1	0	0	; set the tempo		
									
									
									
									
;ADVANCE		; do not change by hand!							
; a 0 0.01 < beats>									
									
; times bar by bar									
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	
i	2	0	2.5	5	8	0	1	$FL_PF	; 1
i	2	2.5	2.5	5	8	0	2	$FL_PF	
i	2	5	2.5	5	8	0	3	$FL_PF	
i	2	7.5	2.5	5	8	0	4	$FL_PF	
i	2	10	2.5	5	8	0	5	$FL_PF	; 2
i	2	12.5	2.5	5	8	0	6	$FL_PF	
i	2	15	2.5	5	8	0	7	$FL_PF	
i	2	17.5	2.5	5	8	0	8	$FL_PF	
i	2	20	2.5	5	8	0	9	$FL_PF	;3
i	2	22.5	2	4	8	0	10	$FL_PF	
i	2	24.5	1.5	3	8	0	11	$FL_PF	
i	2	26	1	2	8	0	12	$FL_PF	
i	2	27	1.5	3	8	0	13	$FL_PF	
i	2	28.5	1.5	3	8	0	14	$FL_PF	
i	2	30	2.5	5	8	0	15	$FL_PF	;4
i	2	32.5	2	4	8	0	16	$FL_PF	
i	2	34.5	1.5	3	8	0	17	$FL_PF	
i	2	36	1	2	8	0	18	$FL_PF	
i	2	37	1.5	3	8	0	19	$FL_PF	
i	2	38.5	1.5	3	8	0	20	$FL_PF	
i	2	40	2.5	5	8	0	21	$FL_PF	;5
i	2	42.5	2	3	6	0	22	$FL_PF	; 3:4
i	2	44.5	1.5	3	8	0	23	$FL_PF	
i	2	46	1	2	8	0	24	$FL_PF	
i	2	47	1.5	3	8	0	25	$FL_PF	
i	2	48.5	1.5	3	8	0	26	$FL_PF	
i	2	50	0.5	1	8	2	27	$FL_PF	;6
i	2	50.5	1	2	8	2	28	$FL_PF	
i	2	51.5	1.5	2	5.33333333333333	0	29	$FL_PF	
i	2	53	2	3	6	0	30	$FL_PF	; 3:4
i	2	55	2.5	4	6.4	0	31	$FL_PF	; 4:5
i	2	57.5	1.5	5	13.3333333333333	0	32	$FL_PF	; 5:3
i	2	59	2	3	6	0	33	$FL_PF	; 3:2
									
									
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	
i	2	0	2	5	10	0	101	$CL_PERC	; 1
i	2	2	2	5	10	0	102	$CL_PERC	
i	2	4	2	5	10	0	103	$CL_PERC	
i	2	6	2	5	10	0	104	$CL_PERC	
i	2	8	2	5	10	0	105	$CL_PERC	
i	2	10	2	5	10	0	106	$CL_PERC	;2
i	2	12	1.6	4	10	0	107	$CL_PERC	
i	2	13.6	1.2	3	10	0	108	$CL_PERC	
i	2	14.8	0.8	2	10	0	109	$CL_PERC	
i	2	15.6	0.4	1	10	0	110	$CL_PERC	
i	2	16	0.333333333333333	1	12	0	111	$CL_PERC	
i	2	16.3333333333333	0.666666666666667	2	12	0	112	$CL_PERC	
i	2	17	1	3	12	0	113	$CL_PERC	
i	2	18	1.33333333333333	4	12	0	114	$CL_PERC	
i	2	19.3333333333333	0.666666666666667	2	12	0	115	$CL_PERC	
i	2	20	2	5	10	0	116	$CL_PERC	;3
i	2	22	1.6	4	10	0	117	$CL_PERC	
i	2	23.6	1.2	3	10	0	118	$CL_PERC	
i	2	24.8	0.8	2	10	0	119	$CL_PERC	
i	2	25.6	0.4	1	10	0	120	$CL_PERC	
i	2	26	0.333333333333333	1	12	0	121	$CL_PERC	
i	2	26.3333333333333	0.666666666666667	2	12	0	122	$CL_PERC	
i	2	27	1	3	12	0	123	$CL_PERC	
i	2	28	1.33333333333333	4	12	0	124	$CL_PERC	
i	2	29.3333333333333	0.666666666666667	2	12	0	125	$CL_PERC	
i	2	30	2	4	8	0	126	$CL_PERC	; 4 4:5
i	2	32	1.6	3	7.5	0	127	$CL_PERC	: 3:2
i	2	33.6	1.2	2	6.66666666666667	0	128	$CL_PERC	
i	2	34.8	0.8	2	10	0	129	$CL_PERC	
i	2	35.6	0.4	1	10	0	130	$CL_PERC	
i	2	36	0.333333333333333	1	12	3	131	$CL_PERC	; A 3
i	2	36.3333333333333	0.666666666666667	2	12	0	132	$CL_PERC	
i	2	37	1	4	16	0	133	$CL_PERC	; 4:3
i	2	38	1.33333333333333	5	15	0	134	$CL_PERC	, 5:4
i	2	39.3333333333333	0.666666666666667	2	12	2	135	$CL_PERC	
i	2	40	2	4	8	0	136	$CL_PERC	;5  4:5
i	2	42	1.6	4	10	0	137	$CL_PERC	
i	2	43.6	1.2	2	6.66666666666667	0	138	$CL_PERC	: IN 2
i	2	44.8	0.8	2	10	0	139	$CL_PERC	
i	2	45.6	0.4	1	10	2	140	$CL_PERC	
i	2	46	0.333333333333333	1	12	0	141	$CL_PERC	
i	2	46.3333333333333	0.666666666666667	2	12	0	142	$CL_PERC	
i	2	47	1	3	12	0	143	$CL_PERC	
i	2	48	1.33333333333333	5	15	0	144	$CL_PERC	; 5:4
i	2	49.3333333333333	0.666666666666667	2	12	0	145	$CL_PERC	
i	2	50	0.666666666666667	2	12	0	146	$CL_PERC	; 6
i	2	50.6666666666667	1.6	4	10	0	147	$CL_PERC	
i	2	52.2666666666667	0.666666666666667	2	12	0	148	$CL_PERC	
i	2	52.9333333333334	1.2	3	10	0	149	$CL_PERC	
i	2	54.1333333333334	1.33333333333333	5	15	0	150	$CL_PERC	; 5:4
i	2	55.4666666666667	2	3	6	0	151	$CL_PERC	; 3:5
i	2	57.4666666666667	0.333333333333333	1	12	0	152	$CL_PERC	
i	2	57.8	0.4	1	10	0	153	$CL_PERC	
i	2	58.2	1	3	12	0	154	$CL_PERC	
i	2	59.2	0.8	2	10	0	155	$CL_PERC	
									
									
; NOTIFICATIONS									
									
i	"notification"	0.01	2	"Start"					
i	"notification"	10	2	"2"					
i	"notification"	20	2	"3"					
i	"notification"	30	2	"4"					
i	"notification"	40	2	"5"					
i	"notification"	40	2	"6"					
