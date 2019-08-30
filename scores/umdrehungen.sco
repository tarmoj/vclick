; eClick score													
; Karola Obermüller  - Umdrehungen													
													
;count-down 													
													
													
#define TUTTI  #0#													
#define TEMPO1 #42#													
#define TEMPO2 #46#													
#define TEMPO3 #52#													
#define TEMPO4 #62#													
#define TEMPO5 #82#													
#define TEMPO6 #120#													
#define TEMPO80 #80#													
#define TEMPO_63 #63#													
#define TEMPO_58 #58#													
#define TEMPO_54 #54#													
#define TEMPO_50 #50#													
#define TEMPO_46 #46#													
													
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)													
#define BEGIN #5#													
													
													
t 0 $REPTEMPO													
i 1 0 0 $REPTEMPO 0													
i "countdown" 0 4 4 $TUTTI			; four click in four beats										
i "notification" 3 0.9 "READY"			; notification										
f 0 4 	; workaround – not to leave early – FIX IT												
s													
													
													
t	0	$TEMPO1	24.5	$TEMPO1	24.5	$TEMPO2	42.5	$TEMPO2	46.5	$TEMPO3	62.5	$TEMPO3	\
	69.5	$TEMPO4	86	$TEMPO4	93.5	$TEMPO5	107.5	$TEMPO5	120.5	$TEMPO6	\		
	280.25	$TEMPO6	280.25	$TEMPO80	283.25	$TEMPO_63	283.25	$TEMPO6	\				
	310.25	$TEMPO6	310.25	$TEMPO80	314.25	$TEMPO_58	314.25	$TEMPO6	\				
	338.25	$TEMPO6	338.25	$TEMPO80	343.25	$TEMPO_54	343.25	$TEMPO6	\				
	364.25	$TEMPO6	364.25	$TEMPO80	370.25	$TEMPO_50	370.25	$TEMPO6	\				
	388.25	$TEMPO6	388.25	$TEMPO80	394.25	$TEMPO_46							
													
													
i 	1	0	0	$TEMPO1	0	0	; set the tempo						
													
i	1	24.5	0	$TEMPO2	0	0							
i	1	42.5	4	$TEMPO2	$TEMPO3	4							
i	1	46.5	0	$TEMPO3	0	0							
i	1	62.5	7	$TEMPO3	$TEMPO4	7							
i	1	69.5	0	$TEMPO4	0	0							
i	1	86	7.5	$TEMPO4	$TEMPO5	7.5							
i	1	93.5	0	$TEMPO5	0	0							
i	1	107.5	13	$TEMPO5	$TEMPO6	13							
i	1	120.5	0	$TEMPO6	0	0							
i	1	280.25	3	$TEMPO80	$TEMPO_63	3							
i	1	283.25	0	$TEMPO6	0	0							
i	1	310.25	4	$TEMPO80	$TEMPO_58	4							
i	1	314.25	0	$TEMPO6	0	0							
i 	1	338.25	5	$TEMPO80	$TEMPO_54	5							
i	1	343.25	0	$TEMPO6	0	0							
i 	1	364.25	6	$TEMPO80	$TEMPO_50	6							
i	1	370.25	0	$TEMPO6	0	0							
i	1	388.25	6	$TEMPO80	$TEMPO_46	6							
i	1	394.25	0	$TEMPO_46	0	0							
													
													
;ADVANCE		; do not change by hand!											
; a 0 0.01 < beats>													
													
; times bar by bar													
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments					
i	2	0	4	4	4	0	1	$TUTTI					
i	2	4	4	4	4	0	2	$TUTTI					
i	2	8	4	4	4	0	3	$TUTTI					
i	2	12	4	4	4	0	4	$TUTTI					
i	2	16	4.5	9	8	0	5	$TUTTI					
i	2	20.5	4	4	4	0	6	$TUTTI					
i	2	24.5	5	5	4	0	7	$TUTTI	; tempo 46				
i	2	29.5	4	4	4	0	8	$TUTTI					
i	2	33.5	4	4	4	0	9	$TUTTI					
i	2	37.5	5	4	4	0	10	$TUTTI					
i	2	42.5	4	4	4	0	11	$TUTTI	; poco accel				
i	2	46.5	4.5	9	8	0	12	$TUTTI	; tempo 52	PEAKS OLEMA 9/8!			
i	2	51	4	4	4	0	13	$TUTTI					
i	2	55	4	4	4	0	14	$TUTTI					
i	2	59	3.5	7	8	0	15	$TUTTI					
i	2	62.5	4	4	4	0	16	$TUTTI	; accel				
i	2	66.5	3	3	4	0	17	$TUTTI					
i	2	69.5	4	4	4	0	18	$TUTTI	; tempo 62				
i	2	73.5	3	3	4	0	19	$TUTTI					
i	2	76.5	3.5	7	8	0	20	$TUTTI					
i	2	80	3	3	4	0	21	$TUTTI					
i	2	83	3	3	4	0	22	$TUTTI					
i	2	86	3	3	4	0	23	$TUTTI	; accel				
i	2	89	1.5	3	8	0	24	$TUTTI					
i	2	90.5	3	3	4	0	25	$TUTTI					
i	2	93.5	2	2	4	0	26	$TUTTI	;tempo 82				
i	2	95.5	2.5	5	8	0	27	$TUTTI					
i	2	98	2	2	4	0	28	$TUTTI					
i	2	100	2	2	4	0	29	$TUTTI					
i	2	102	2	2	4	0	30	$TUTTI					
i	2	104	3.5	7	8	0	31	$TUTTI					
i	2	107.5	3	3	4	0	32	$TUTTI	; molto accel				
i	2	110.5	2.5	5	8	0	33	$TUTTI					
i	2	113	2	2	4	0	34	$TUTTI					
i	2	115	2.5	5	8	0	35	$TUTTI					
i	2	117.5	3	3	4	0	36	$TUTTI					
i	2	120.5	3	3	4	0	37	$TUTTI	; tempo 120 LIGHTS ON				
i	2	123.5	3	3	4	0	38	$TUTTI					
i	2	126.5	3	3	4	0	39	$TUTTI					
i	2	129.5	3	3	4	0	40	$TUTTI					
i	2	132.5	3	3	4	0	41	$TUTTI					
i	2	135.5	3	3	4	0	42	$TUTTI					
i	2	138.5	3	3	4	0	43	$TUTTI					
i	2	141.5	3	3	4	0	44	$TUTTI					
i	2	144.5	4	4	4	0	45	$TUTTI					
i	2	148.5	3	3	4	0	46	$TUTTI					
i	2	151.5	3	3	4	0	47	$TUTTI					
i	2	154.5	3	3	4	0	48	$TUTTI					
i	2	157.5	3	3	4	0	49	$TUTTI					
i	2	160.5	3	3	4	0	50	$TUTTI					
i	2	163.5	3	3	4	0	51	$TUTTI					
i	2	166.5	3	3	4	0	52	$TUTTI					
i	2	169.5	3	3	4	0	53	$TUTTI					
i	2	172.5	3	3	4	0	54	$TUTTI					
i	2	175.5	4	4	4	0	55	$TUTTI					
i	2	179.5	3	3	4	0	56	$TUTTI					
i	2	182.5	3	3	4	0	57	$TUTTI					
i	2	185.5	3	3	4	0	58	$TUTTI					
i	2	188.5	3	3	4	0	59	$TUTTI					
i	2	191.5	3	3	4	0	60	$TUTTI					
i	2	194.5	3	3	4	0	61	$TUTTI					
i	2	197.5	3	3	4	0	62	$TUTTI					
i	2	200.5	3	3	4	0	63	$TUTTI					
i	2	203.5	3	3	4	0	64	$TUTTI					
i	2	206.5	3	3	4	0	65	$TUTTI					
i	2	209.5	4	4	4	0	66	$TUTTI					
i	2	213.5	3	3	4	0	67	$TUTTI					
i	2	216.5	3	3	4	0	68	$TUTTI					
i	2	219.5	3	3	4	0	69	$TUTTI					
i	2	222.5	3	3	4	0	70	$TUTTI					
i	2	225.5	3	3	4	0	71	$TUTTI					
i	2	228.5	3	3	4	0	72	$TUTTI					
i	2	231.5	3	3	4	0	73	$TUTTI					
i	2	234.5	3	3	4	0	74	$TUTTI					
i	2	237.5	3	3	4	0	75	$TUTTI					
i	2	240.5	3	3	4	0	76	$TUTTI					
i	2	243.5	3	3	4	0	77	$TUTTI					
i	2	246.5	3	3	4	0	78	$TUTTI					
i	2	249.5	3.75	5	5.33333333333333	0	79	$TUTTI	; 5 x 3/16				
i	2	253.25	3	3	4	0	80	$TUTTI					
i	2	256.25	3	3	4	0	81	$TUTTI					
i	2	259.25	3	3	4	0	82	$TUTTI					
i	2	262.25	3	3	4	0	83	$TUTTI					
i	2	265.25	3	3	4	0	84	$TUTTI					
i	2	268.25	3	3	4	0	85	$TUTTI					
i	2	271.25	3	3	4	0	86	$TUTTI					
i	2	274.25	3	3	4	0	87	$TUTTI					
i	2	277.25	3	3	4	0	88	$TUTTI					
i	2	280.25	3	3	4	0	89	$TUTTI	; tempo 80 rit ..63				
i	2	283.25	3	3	4	0	90	$TUTTI	; a tempo (120)				
i	2	286.25	3	3	4	0	91	$TUTTI					
i	2	289.25	3	3	4	0	92	$TUTTI					
i	2	292.25	3	3	4	0	93	$TUTTI					
i	2	295.25	3	3	4	0	94	$TUTTI					
i	2	298.25	3	3	4	0	95	$TUTTI					
i	2	301.25	3	3	4	0	96	$TUTTI					
i	2	304.25	3	3	4	0	97	$TUTTI					
i	2	307.25	3	3	4	0	98	$TUTTI					
i	2	310.25	4	4	4	0	99	$TUTTI	; ritenuto 80..58				
i	2	314.25	3	3	4	0	100	$TUTTI	; tempo 120   				
i	2	317.25	3	3	4	0	101	$TUTTI					
i	2	320.25	3	3	4	0	102	$TUTTI					
i	2	323.25	3	3	4	0	103	$TUTTI					
i	2	326.25	3	3	4	0	104	$TUTTI					
i	2	329.25	3	3	4	0	105	$TUTTI					
i	2	332.25	3	3	4	0	106	$TUTTI					
i	2	335.25	3	3	4	0	107	$TUTTI					
i	2	338.25	5	5	4	0	108	$TUTTI	; ritenuto 80..54				
i	2	343.25	3	3	4	0	109	$TUTTI	; tempo 120   				
i	2	346.25	3	3	4	0	110	$TUTTI					
i	2	349.25	3	3	4	0	111	$TUTTI					
i	2	352.25	3	3	4	0	112	$TUTTI					
i	2	355.25	3	3	4	0	113	$TUTTI					
i	2	358.25	3	3	4	0	114	$TUTTI					
i	2	361.25	3	3	4	0	115	$TUTTI					
i	2	364.25	3	3	4	0	116	$TUTTI	; rit 80..50				
i	2	367.25	3	3	4	0	117	$TUTTI					
i	2	370.25	3	3	4	0	118	$TUTTI	; tempo 120   				
i	2	373.25	3	3	4	0	119	$TUTTI					
i	2	376.25	3	3	4	0	120	$TUTTI					
i	2	379.25	3	3	4	0	121	$TUTTI					
i	2	382.25	3	3	4	0	122	$TUTTI					
i	2	385.25	3	3	4	0	123	$TUTTI					
i	2	388.25	4	4	4	0	124	$TUTTI	; rit 80..46				
i	2	392.25	4	3	4	0	125	$TUTTI	; 46 3. löögiks				
i	2	396.25	4	3	4	0	126	$TUTTI					
i	2	400.25	4	3	4	0	127	$TUTTI					
i	2	404.25	4	3	4	0	128	$TUTTI					
i	2	408.25	4	3	4	0	129	$TUTTI					
i	2	412.25	4	3	4	0	130	$TUTTI					
i	2	416.25	4	3	4	0	131	$TUTTI					
i	2	420.25	4	3	4	0	132	$TUTTI					
													
													
													
													
													
													
; CUES													
													
;i	"playfile"	5	999	"filename with full path or relative path to server"	0	; t1							
													
													
													
													
; NOTIFICATIONS													
													
i	"notification"	0	2	"Start"									
i	"notification"	0	2	"Start"
i	"notification"	120.5	6	"Lights On"
i	"notification"	249.5	3	"5 x 3/16"
i	"notification"	280.25	3	"Slow"
i	"notification"	310.25	3	"Slow"
i	"notification"	338.25	3	"Slow"
i	"notification"	364.25	3	"Slow"
i	"notification"	388.25	3	"Slow"
