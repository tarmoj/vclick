; Peter Ablinger Piccolo und Rauschen								
								
								
;count-down 								
								
								
#define TUTTI  #0#								
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
i	2	4	6	6	4	0	1	$TUTTI
i	2	10	1.5	3	8	0	1	$TUTTI
								
; paus 11 sekundit								
i	18	22.5	4	4	$TUTTI			
i	2	26.5	4	4	4	0	2	$TUTTI
i	2	30.5	6	6	4	0	2	$TUTTI
i	2	36.5	1.5	3	8	0	2	$TUTTI
								
; paus 11 sekundit								
i	18	49	4	4	$TUTTI			
i	2	53	3	3	4	0	3	$TUTTI
								
; paus 11 sekundit LÕIK 4								
i	18	67	4	4	$TUTTI			
i	2	71	4	4	4	0	4	$TUTTI
i	2	75	4	4	4	0	4	$TUTTI
i	2	79	1.5	3	8	0	4	$TUTTI
i	2	80.5	2	2	4	0	4	$TUTTI
i	2	82.5	2	2	4	0	4	$TUTTI
i	2	84.5	4	4	4	0	4	$TUTTI
i	2	88.5	6	6	4	0	4	$TUTTI
								
; paus 11 sekundit LÕIK 5								
i	18	105.5	4	4	$TUTTI			
i	2	109.5	5	5	4	0	5	$TUTTI
i	2	114.5	5	5	4	0	5	$TUTTI
								
; paus 11 sekundit LÕIK 6								
i	18	130.5	4	4	$TUTTI			
i	2	134.5	4	4	4	0	6	$TUTTI
i	2	138.5	4	4	4	0	6	$TUTTI
i	2	142.5	2	2	4	0	6	$TUTTI
								
; CUES								
								
i	"playfile"	0	11.5	"Rauschen1.wav"	0	; t1		
i	"playfile"	26.5	11.5	"Rauschen1.wav"	0			
i	"playfile"	53	2.75	"Rauschen3.wav"	0			
i	"playfile"	71	23.5	"Rauschen4.wav"	0			
i	"playfile"	109.5	9	"Rauschen5.wav"	0			
i	"playfile"	134.5	10	"Rauschen6.wav"	0			
								

              
;NOTIFICATIONS
i	"notification"	0	2	"Start"
i	"notification"	11.5	2	"OFF"
i	"notification"	38	2	"OFF"
i	"notification"	55.75	2	"OFF"
i	"notification"	94.5	2	"OFF"
i	"notification"	119.5	2	"OFF"
i	"notification"	144.25	2	"OFF"
