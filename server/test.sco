

; eClick score - for test and demo


#define TUTTI #63#
#define TEMPO1 #80#
#define TEMPO2 #52#
#define BEGIN #9#
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting countdown to right tempo


t 0 $TEMPO1
i 1 0 0 $TEMPO1 0 ; set tempo  
i "countdown" 0 4 4 $TUTTI
i "notification" 3 1 "READY"
;f 0 4 ; workaround for not leaveing too early
s


;ADVANCE		; Don't change or remove this line!																

t 0 $TEMPO1 4 $TEMPO1 12 $TEMPO2
i1 4 8 $TEMPO1 $TEMPO2 8
i1 12 0 $TEMPO2 0  

; times bar by bar																				
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments											
i	2	0	4	4	4	0	1	$TUTTI					
i	2	4	4	4	4	0	2	$TUTTI					
i	2	8	4	4	4	0	3	$TUTTI					
i	2	12	4	4	4	0	4	$TUTTI					

;	complex	bars:	1)	2+3+2/8	(7/8)								

i	2	18	1	1	4	0	5	$TUTTI	; 2/8 as 1 quarter
i	2	19	1.5	1	4	0	-5.2	$TUTTI;	3/8 as one beat, don't show red for	1, beeat
i	2	20.5	1	1	4	0	-5.3	$TUTTI	; 2/8 as one beat, don't	show red for 1,	beat 3
																				
i	2	21.5	0.5	1	4	0	6	$TUTTI	; 5/16 first beat "short"
i	2	22	0.75	1	4	0	-6.2	$TUTTI	;	second	"long"									
i	2	22.75	0.5	1	4	0	7	$TUTTI	; first	beat "short"
i	2	23.25	0.75	1	4	0	-7.2	$TUTTI	;	second	"long"

i	2	24	0.75	1	4	0	8	$TUTTI	; 5/16	first	beat	"long"	
i	2	24.75	0.5	1	4	0	-8.2	$TUTTI	;	second	"short"

i	2	25.25	0.75	1	4	0	9	$TUTTI	;	first	beat	"long"	
i	2	26	0.5	1	4	0	-9.2	$TUTTI	;	second	"short"	


; notifications				
				
i	"notification"	0	2	"Go!"
i	"notification"	4	8	"Ritenuto"
i	"notification"	16	2	"Complex"
i	"notification"	18	3	"2+3+2/8"
i	"notification"	21.5	3	"5/16"
