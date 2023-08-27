; vClick score for Udo Kasemets „Trigon” (nonet, in trimple slower tempo)									
; written by Tarmo Johannes trmjhnns@gmail.com									
									
;count-down 									
									
									
#define TUTTI  #0#									
#define SPEED #1#									
#define TEMPO1 #[20 * $SPEED]#									
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)									
									
									
									
t 0 $REPTEMPO									
i 1 0 0 $REPTEMPO 0									
i "countdown" 0 1 3 $TUTTI			; four click in four beats						
i "notification" 0.6666 0.3333  "Valmis"			; notification						
									
s									
									
									
t	0	$TEMPO1							\
									
									
									
i 	1	0	0	$TEMPO1	0	0	; set the tempo		
									
									
;ADVANCE		; do not change by hand!							
; a 0 0.01 < beats>									
									
; times bar by bar									
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	
i	2	0	7	7	4	3	1	$TUTTI	; every row 7/4
i	2	7	7	7	4	3	2	$TUTTI	
i	2	14	7	7	4	3	3	$TUTTI	
i	2	21	7	7	4	3	4	$TUTTI	
i	2	28	7	7	4	3	5	$TUTTI	
i	2	35	7	7	4	3	6	$TUTTI	
i	2	42	7	7	4	3	7	$TUTTI	
i	2	49	7	7	4	3	21	$TUTTI	
i	2	56	7	7	4	3	22	$TUTTI	
i	2	63	7	7	4	3	23	$TUTTI	
i	2	70	7	7	4	3	24	$TUTTI	
i	2	77	7	7	4	3	25	$TUTTI	
i	2	84	7	7	4	3	26	$TUTTI	
i	2	91	7	7	4	3	27	$TUTTI	
i	2	98	7	7	4	3	31	$TUTTI	
i	2	105	7	7	4	3	32	$TUTTI	
i	2	112	7	7	4	3	33	$TUTTI	
i	2	119	7	7	4	3	34	$TUTTI	
i	2	126	7	7	4	3	35	$TUTTI	
i	2	133	7	7	4	3	36	$TUTTI	
i	2	140	7	7	4	3	37	$TUTTI	
i	2	147	7	7	4	3	41	$TUTTI	
i	2	154	7	7	4	3	42	$TUTTI	
i	2	161	7	7	4	3	43	$TUTTI	
i	2	168	7	7	4	3	44	$TUTTI	
i	2	175	7	7	4	3	45	$TUTTI	
i	2	182	7	7	4	3	46	$TUTTI	
i	2	189	7	7	4	3	47	$TUTTI	
i	2	196	7	7	4	3	51	$TUTTI	
i	2	203	7	7	4	3	52	$TUTTI	
i	2	210	7	7	4	3	53	$TUTTI	
i	2	217	7	7	4	3	54	$TUTTI	
i	2	224	7	7	4	3	55	$TUTTI	
i	2	231	7	7	4	3	56	$TUTTI	
i	2	238	7	7	4	3	57	$TUTTI	
i	2	245	7	7	4	3	61	$TUTTI	
i	2	252	7	7	4	3	62	$TUTTI	
i	2	259	7	7	4	3	63	$TUTTI	
i	2	266	7	7	4	3	64	$TUTTI	
i	2	273	7	7	4	3	65	$TUTTI	
i	2	280	7	7	4	3	66	$TUTTI	
i	2	287	7	7	4	3	67	$TUTTI	
i	2	294	7	7	4	3	71	$TUTTI	
i	2	301	7	7	4	3	72	$TUTTI	
i	2	308	7	7	4	3	73	$TUTTI	
i	2	315	7	7	4	3	74	$TUTTI	
i	2	322	7	7	4	3	75	$TUTTI	
i	2	329	7	7	4	3	76	$TUTTI	
i	2	336	7	7	4	3	77	$TUTTI	
									
									
									
									
; NOTIFICATIONS									
									
i	"notification"	0.01	1	"1"					
i	"notification"	49	1	"2"					
i	"notification"	98	1	"3"					
i	"notification"	147	1	"4"					
i	"notification"	196	1	"5"					
i	"notification"	245	1	"6"					
i	"notification"	294	1	"7"
i	"notification"	343	1	"Valmis"
					
