

; teastiks 


#define TUTTI #63#
#define TEMPO1 #80#
#define TEMPO2 #52#
#define BEGIN #9#
#define REPTEMPO #$TEMPO1# ; REPTEMPO selleks, et ettelugemine oleks õiges tempos


t 0 $TEMPO1
i 1 0 0 $TEMPO1 0 ; set tempo  
i "countdown" 0 4 4 $TUTTI
i "notification" 3 0.9 "READY"
s

;ADVANCE		; Don't change or remove this line!																

t 0 $TEMPO1 4 $TEMPO1 12 $TEMPO2
i "tempochange" 4 8 $TEMPO1 $TEMPO2 8

i 2 0 4 4 4 0 1 $TUTTI

i 2 4 4 4 4 0 2 $TUTTI
i 2 8 4 4 4 0 3 $TUTTI
i 2 12 4 4 4 0 4 $TUTTI


i "notification" 0 2 "Go!"
i "notification" 4 8 "Ritenuto"
;i "notification" 4 4 "Ritenuto" ;NB! in some reason punctuation marks like . and ! mess up the messages!


e

; DOES NOT WORK YET.....

t 0 $TEMPO1
; a complex bars: 1) 2+3+2/8 (7/8)
i 2 0 1 1 4 0 5 $TUTTI ; 2/8 as 1 quarter
i 2 + 1.5 1 4 0 -5.2 $TUTTI; 3/8 as one beat, don't show red for 1, best 2
i 2 + 1 1 4 0 -5.3 $TUTTI ; 2/8 as one beat, don't show red for 1, beat 3 

i 2 + 4 4 4 0 6 $TUTTI

