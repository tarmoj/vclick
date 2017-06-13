; vClick score template								
								
								
;count-down 								
								
								
#define TUTTI  #63#								
#define TEMPO1 #60#								
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)								
#define BEGIN #5#								
								
								
t 0 $REPTEMPO								
i 1 0 0 $REPTEMPO 0								
i "countdown" 0 4 4 $TUTTI			; four click in four beats					
i "notification" 3 0.9 "READY"			; notification					
f 0 4 	; workaround – not to leave early – FIX IT							
s								
								
								
t	0	$TEMPO1						
								
i 	1	0	0	$TEMPO1	0	0	; set the tempo	
								
								
								
								
								
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
i	2	48	4	4	4	0	13	
i	2	52	4	4	4	0	14	
i	2	56	4	4	4	0	15	
i	2	60	4	4	4	0	16	
i	2	64	4	4	4	0	17	
i	2	68	4	4	4	0	18	
i	2	72	4	4	4	0	19	
i	2	76	4	4	4	0	20	
i	2	80	4	4	4	0	21	
i	2	84	4	4	4	0	22	
i	2	88	4	4	4	0	23	
i	2	92	4	4	4	0	24	
i	2	96	4	4	4	0	25	
i	2	100	4	4	4	0	26	
i	2	104	4	4	4	0	27	
i	2	108	4	4	4	0	28	
i	2	112	4	4	4	0	29	
i	2	116	4	4	4	0	30	
i	2	120	4	4	4	0	31	
i	2	124	4	4	4	0	32	
i	2	128	4	4	4	0	33	
i	2	132	4	4	4	0	34	
i	2	136	4	4	4	0	35	
i	2	140	4	4	4	0	36	
i	2	144	4	4	4	0	37	
i	2	148	4	4	4	0	38	
i	2	152	4	4	4	0	39	
i	2	156	4	4	4	0	40	
i	2	160	4	4	4	0	41	
i	2	164	4	4	4	0	42	
i	2	168	4	4	4	0	43	
i	2	172	4	4	4	0	44	
i	2	176	4	4	4	0	45	
i	2	180	4	4	4	0	46	
i	2	184	4	4	4	0	47	
i	2	188	4	4	4	0	48	
i	2	192	4	4	4	0	49	
i	2	196	4	4	4	0	50	
								
								
								
; CUES								
								
;i	"playfile"	5	999	"filename with full path or relative path to server"	0	; t1		
								
								
								
								
; NOTIFICATIONS								
								
i	"notification"	0	2	"Start"				
