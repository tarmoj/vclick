; eClick multiple clients test (polyrythms)									
									
									
;count-down 									
									
									
#define TUTTI  #0#									
#define TEMPO1 #60#									
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)									
									
									
									
t 0 $REPTEMPO									
i 1 0 0 $REPTEMPO 0									
i "countdown" 0 4 4 $TUTTI			; four click in four beats						
i "notification" 3 1 "READY"			; notification						
									
s									
									
									
t	0	$TEMPO1							
									
i 	1	0	0	$TEMPO1	0	0	; set the tempo		
									
									
									
									
									
;ADVANCE		; do not change by hand!							
; a 0 0.01 < beats>									
									
; times bar by bar									
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments	
i	2	0	4	4	4	0	1	$TUTTI	
									
									
									
; 1 – 3:4									
i	2	4	4	3	3	0	2	1	; 3:4
i	2	8	4	3	3	0	3	1	
i	2	12	4	3	3	0	4	1	
; 2 -  5:4									
i	2	4	4	5	5	0	2	2	; 5:4
i	2	8	4	5	5	0	3	2	
i	2	12	4	5	5	0	4	2	
									
									
i	2	4	4	7	7	0	2	4	; 7:4
i	2	8	4	7	7	0	3	4	
i	2	12	4	7	7	0	4	4	
									
; 5:6									
i	2	4	6	5	3.33333333333333	0	2	8	; 5:6
i	2	10	6	5	3.33333333333333	0	3	8	
									
									
; 4:6									
i	2	4	6	4	2.66666666666667	0	2	16	; 4:6
i	2	10	6	4	2.66666666666667	0	3	16	
									
									
; 7:6									
i	2	4	6	7	4.66666666666667	0	2	32	; 7:6
i	2	10	6	7	4.66666666666667	0	3	32	
									
; tutti 4/4 again									
i	2	16	4	4	4	0	5	$TUTTI	
									
; groups: voices 1, 3, 5 together, 2, 4, 6 together									
									
i	2	20	4	4	4	2	6	21	
									
i	2	20	4	2	2	2	6	42	
									
									
; NOTIFICATIONS									
					; channels				
i	"notification"	0	2	"Tutti"	0				
									
i	"notification"	4	2	"3:4"	1				
i	"notification"	4	2	"5:4"	2				
i	"notification"	4	2	"7:4"	4				
i	"notification"	4	2	"5:6"	8				
i	"notification"	4	2	"4:6"	16				
i	"notification"	4	2	"7:6"	32				
									
i	"notification"	16	2	"Tutti"	0				
									
i	"notification"	20	2	"Group 1"	21				
i	"notification"	20	2	"Group 2"	42				
