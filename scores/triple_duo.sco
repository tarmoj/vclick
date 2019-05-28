; Elliott Carter Triple Duo kuni takt 70										
										
										
#define TUTTI  #0#										
#define TEMPO1 #72#										
#define TEMPO2 #[$TEMPO1*2/3]#										
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)										
#define BEGIN #5#										
										
										
t 0 $REPTEMPO										
i 1 0 0 $REPTEMPO 0										
i "countdown" 0 4 4 $TUTTI			; four click in four beats							
i "notification" 3 0.9 "READY"			; notification							
f 0 4 	; workaround – not to leave early – FIX IT									
s										
										
										
t	0	$TEMPO1	172	$TEMPO1	172	$TEMPO2	188	$TEMPO2	188	$TEMPO1
										
i 	1	0	0	$TEMPO1	0	0	; set the tempo			
i 	1	172	0	$TEMPO2	0	0				
i 	1	188	0	$TEMPO1	0	0				
										
										
										
;ADVANCE		; do not change by hand!								
; a 0 0.01 < beats>										
										
; times bar by bar										
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments		
i	2	0	4	4	4	0	1	$TUTTI		
i	2	4	4	4	4	0	2	$TUTTI		
i	2	8	4	4	4	0	3	$TUTTI		
i	2	12	4	4	4	0	4	$TUTTI		
i	2	16	4	4	4	0	5	$TUTTI		
i	2	20	4	4	4	0	6	$TUTTI		
i	2	24	4	4	4	0	7	$TUTTI		
i	2	28	4	4	4	0	8	$TUTTI		
i	2	32	4	4	4	0	9	$TUTTI		
i	2	36	4	4	4	0	10	$TUTTI		
i	2	40	4	4	4	0	11	$TUTTI		
i	2	44	4	4	4	0	12	$TUTTI		
i	2	48	4	4	4	0	13	$TUTTI		
i	2	52	4	4	4	0	14	$TUTTI		
i	2	56	4	4	4	0	15	$TUTTI		
i	2	60	4	4	4	0	16	$TUTTI		
i	2	64	4	4	4	0	17	$TUTTI		
i	2	68	4	4	4	0	18	$TUTTI		
i	2	72	4	4	4	0	19	$TUTTI		
i	2	76	4	4	4	0	20	$TUTTI		
i	2	80	4	4	4	0	21	$TUTTI		
i	2	84	4	4	4	0	22	$TUTTI		
i	2	88	4	2	2	0	23	$TUTTI	; tranquillo võibolla 2/2? Kuni?	
i	2	92	4	2	2	0	24	$TUTTI		
i	2	96	4	2	2	0	25	$TUTTI		
i	2	100	4	2	2	0	26	$TUTTI		
i	2	104	4	2	2	0	27	$TUTTI		
i	2	108	4	2	2	0	28	$TUTTI		
i	2	112	4	2	2	0	29	$TUTTI		
i	2	116	4	2	2	0	30	$TUTTI		
i	2	120	4	2	2	0	31	$TUTTI		
i	2	124	4	2	2	0	32	$TUTTI		
i	2	128	4	2	2	0	33	$TUTTI		
i	2	132	4	2	2	0	34	$TUTTI		
i	2	136	4	2	2	0	35	$TUTTI		
i	2	140	4	4	4	0	36	$TUTTI	; 4/4 tagasi	
i	2	144	4	4	4	0	37	$TUTTI		
i	2	148	4	4	4	0	38	$TUTTI		
i	2	152	4	4	4	0	39	$TUTTI		
i	2	156	4	4	4	0	40	$TUTTI		
i	2	160	4	4	4	0	41	$TUTTI		
i	2	164	4	4	4	0	42	$TUTTI		
i	2	168	4	4	4	0	43	$TUTTI		
i	2	172	2	2	4	0	44	$TUTTI	; 6/8 tempo 67)	
i	2	174	2	2	4	0	45	$TUTTI	; 6/8 2 peale on 3/4 kaheks	
i	2	176	2	2	4	0	46	$TUTTI		
i	2	178	2	2	4	0	47	$TUTTI		
i	2	180	2	2	4	0	48	$TUTTI		
i	2	182	2	2	4	0	49	$TUTTI		
i	2	184	2	2	4	0	50	$TUTTI		
i	2	186	2	2	4	0	51	$TUTTI		
i	2	188	4	4	4	0	52	$TUTTI	; Tempo1 (4/4) tagasi)	
i	2	192	4	4	4	0	53	$TUTTI		
i	2	196	4	4	4	0	54	$TUTTI		
i	2	200	4	4	4	0	55	$TUTTI		
i	2	204	4	4	4	0	56	$TUTTI		
i	2	208	4	4	4	0	57	$TUTTI		
i	2	212	4	4	4	0	58	$TUTTI		
i	2	216	4	4	4	0	59	$TUTTI		
i	2	220	4	4	4	0	60	$TUTTI		
i	2	224	4	4	4	0	61	$TUTTI		
i	2	228	4	4	4	0	62	$TUTTI		
i	2	232	4	4	4	0	63	$TUTTI		
i	2	236	4	4	4	0	64	$TUTTI		
i	2	240	4	4	4	0	65	$TUTTI		
i	2	244	4	4	4	0	66	$TUTTI		
i	2	248	4	4	4	0	67	$TUTTI		
i	2	252	2	2	4	0	68	$TUTTI		
i	2	254	3	3	4	0	69	$TUTTI		
i	2	257	4	4	4	0	70	$TUTTI		
										
										
; CUES										
										
;i	"playfile"	5	999	"filename with full path or relative path to server"	0	; t1				
										
										
										
										
; NOTIFICATIONS										
										
i	"notification"	0	2	"Start"						
i	"notification"	88	4	"Tranquillo"						
i	"notification"	257	4	"Lõpp"						
