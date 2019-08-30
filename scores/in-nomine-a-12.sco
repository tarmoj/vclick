; vClick score for B. Ferneyhough – In Nomine a 12											
											
											
;count-down 											
											
											
#define TUTTI  #0#											
#define TEMPO1 #25#											
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)											
											
											
											
											
											
											
											
											
t 0 $REPTEMPO											
i 1 0 0 $REPTEMPO 0											
i "countdown" 0 2 4 $TUTTI			; four click in two beats								
i "notification" 1.5 0.5 "READY"			; notification								
											
s											
											
											
t	0	$TEMPO1									
											
i 	1	0	0	$TEMPO1	0	0	; set the tempo				
											
											
											
											
											
;ADVANCE		; do not change by hand!									
; a 0 0.01 < beats>											
											
; times bar by bar											
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments			
i	2	0	3	6	8	0	1	$TUTTI			
i	2	3	0.75	2	10.6666666666667	0	2	$TUTTI	; 12/32  in 4: 16. + 16. + 8 + 16.		
i	2	3.75	0.5	1	8	0	-2.3	$TUTTI			
i	2	4.25	0.375	1	10.6666666666667	0	-2.4	$TUTTI			
i	2	4.625	1.2	3	10	0	3	$TUTTI	; 3/10		
i	2	5.825	1	5	20	0	4	$TUTTI			
i	2	6.825	0.888888888888889	2	9	0	5	$TUTTI			
i	2	7.71388888888889	1.66666666666667	5	12	0	6	$TUTTI			
i	2	9.38055555555555	0.75	2	10.6666666666667	0	7	$TUTTI	; 13/32 3 +3 +4 +3		
i	2	10.1305555555556	0.5	1	8	0	-7.3	$TUTTI			
i	2	10.6305555555556	0.375	1	10.6666666666667	0	-7.4	$TUTTI			
i	2	11.0055555555556	2.5	5	8	0	8	$TUTTI	;just 5/8		
i	2	13.5055555555556	1	2	8	0	9	$TUTTI	;11/32  in 3:  8 + 8 + 16.		
i	2	14.5055555555556	0.375	1	10.6666666666667	0	-9.3	$TUTTI			
i	2	14.8805555555556	2	4	8	0	10	$TUTTI	; 4/8		
i	2	16.8805555555556	1	2	8	0	11	$TUTTI	; 13/32 in 4:  8 + 8 + 16. + 16		
i	2	17.8805555555556	0.375	1	10.6666666666667	0	-11.3	$TUTTI			
i	2	18.2555555555556	0.25	1	16	0	-11.4	$TUTTI			
i	2	18.5055555555556	1.2	3	10	0	12	$TUTTI	; 3/10		
i	2	19.7055555555556	1.06666666666667	4	15	0	13	$TUTTI			
i	2	20.7722222222222	1.75	7	16	0	14	$TUTTI			
i	2	22.5222222222222	2.25	9	16	0	15	$TUTTI			
i	2	24.7722222222222	3	6	8	0	16	$TUTTI			
i	2	27.7722222222222	1.2	3	10	0	17	$TUTTI			
i	2	28.9722222222222	1	5	20	0	18	$TUTTI			
i	2	29.9722222222222	1.77777777777778	4	9	0	19	$TUTTI			
i	2	31.75	1	2	8	0	20	$TUTTI	; 11/32 in 3 : 8 + 8 + 16.		
i	2	32.75	0.375	1	10.6666666666667	0	-20.3	$TUTTI			
i	2	33.125	2	4	8	0	21	$TUTTI	;4/8		
i	2	35.125	1.125	3	10.6666666666667	0	22	$TUTTI	; 9/32 in 3 : 16. + 16. + 16.		
											
											
											
; NOTIFICATIONS											
											
i	"notification"	0	1	"Start"							
i	"notification"	3	1.5	"3+3+4+3"							
i	"notification"	9.38055555555555	1.5	"3+3+4+3"							
i	"notification"	13.5055555555556	1.5	"4+4+3"							
i	"notification"	16.8805555555556	1.5	"4+4+3+2"							
i	"notification"	31.75	1.5	"4+4+3"							
i	"notification"	35.125	1.5	"3+3+3"							
							
