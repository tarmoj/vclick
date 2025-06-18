

sr = 44100 ; since the sample files are in 48000
ksmps = 32 ; 128
nchnls = 2
0dbfs = 1

;; channels
;chnexport "tempo"



; channels for instruments
; #define FL #1# ; flute
; #define CL #2# ; clarinet
; #define VL #4# ; violin
; #define VC #8#
; #define PERC #32#
; #define PF #16#
; #define TUTTI #63#



#define HOST #"localhost"#
;#define HOST2 #"192.168.42.129"#


#define RED #0#
#define GREEN #1#
#define BLUE #2#
#define TUTTI #255# ; now 8 bits set to 1; think how to do it better...

;; globals

gkTempo init 60
gkBeat init 0
gkBar init 0
gkRedBlink init 0; duration of a blink
gkGreenBlink init 0
gkBlueBlink init 0
gSnotification init ""
gkChannels init 0 ; TODO: think how to send signals to different instruments (channels). Not implemented yet.
gkNewNotification init 0
gkVolume init 1

;; channels
gkTempo chnexport "tempo",1 ;  is this output? ? maybe safer to set 3?
gkBeat chnexport "beat",1
gkBar chnexport "bar",1
gkRedBlink chnexport "red", 1; duration of a blink
gkGreenBlink chnexport "green",1
gkBlueBlink chnexport "blue",1
gSnotification chnexport "notification",1
gkInstrument chnexport "channels",1 ; TODO: think how to send signals to different instruments, comes from "channels" - replace variable name. MAybe: voices
gkNewNotification chnexport "new_notification",1
gkVolume chnexport "volume", 1



; maybe sring channels to communicate...


instr 1, tempochange ; change tempo: i 1 0 <duration>|0 <starttempo> <endtempo>|0 <duration_of_change_beats>|0
  	istarttmp=p4
  	iendtmp=p5
  	ibeat1 = p6 ; time in beats of the segment, if accelerand/ritardando 
  	if (iendtmp!=istarttmp && iendtmp!=0 && ibeat1==0) then
	  	prints "Seems like you want to have a change of tempo. You have to give in p6, how much it lasts in beats!\n"
	  	turnoff
  	endif
  	print p3
  	if (iendtmp==0 || p3==0)then
  		gkTempo init istarttmp
  		;outvalue "tempo", gkTempo
  		;chnset istarttmp, "tempo"
  		turnoff
  	else
		; calculation by formulas of istvan varga
  		ktime timeinsts
  		ibtime0 = 60/istarttmp
  		ibtime1 = 60/iendtmp
  		ia = 0.5*  (ibtime1 - ibtime0) / ibeat1 
  		kbeat = (sqrt(ibtime0*ibtime0 - 4*ia*(0-ktime))-ibtime0) / (2*ia)
  		gkTempo = 60 / ( ibtime0 + (ibtime1-ibtime0)*kbeat / ibeat1)
  		;ktempo = 60 / ( ibtime0 + (ibtime1-ibtime0)*kbeat / ibeat1)  
		;gkTempo= ktempo  
	endif
endin	

	
instr 2, bar ; example i 2 <start> <dur> <beats_in_bar> <fraction of full note (4, 8, vms)> <subdivisions per beat: -2 -like eigtht notes, 3 - triplets etc> <barnumber> <channels> (bitwise flags - bit1 - istr1, bit2 instr2 etc). if barnumber negative, skip first beat startup (to be able te compose complex times le 3+2+3/8> 
	
	iBeats= p4	
	iMetro_rate=p5/4 ; 1 if quarternote, 2 if 8th note etc 
	iSubdivs=p6 ; 0 or 1 - none; 2 - half beat,3- third etc
	
	iBarno=p7 ; can be negative - don't show red for beat 1; or with fractional number - set the first beat number
	iFirstBeat = frac(p7)==0 ? 1 : abs(frac(p7))*10 ; sometimes necessary to set the beat number (in case of complec bars)
	print iBarno, iFirstBeat
	gkBar init abs(iBarno) ; since can be aslo negative
	iChannels=(p8==0) ? $TUTTI : p8 ; in binary form every bit according to one channel; think TUTTI if not set
	;print iChannels

	kmetrofreq=gkTempo/60*iMetro_rate
	kBeat_trig metro kmetrofreq
	
	kSubdivMetroRate init 1
	if (iSubdivs>1) then
		if (p4==1 && p5==4) then
			kSubdivMetroRate = iSubdivs/p3 ; allow various lengths for 1/4 time
		else
			kSubdivMetroRate = kmetrofreq*iSubdivs
		endif
		kSubdiv_trig metro kSubdivMetroRate
		printf "SUBDIV %f\n", kSubdiv_trig, kSubdivMetroRate
	endif
	
	kBeat init iFirstBeat

	kKlick_type init 0

	if (kBeat_trig==1) then	

		gkBeat = kBeat
		;schedkwhen kBeat_trig,0,0,"oscnumbers",0,0.1,iBarno,kBeat,iChannels
		
		if (kBeat==1 && iBarno>=0) then ; if the first beat and not signalled otherwise (negative barno), use RED led
			if (p4==1 && p5==4) then
				gkRedBlink = p3 ; allow 1/4 bars to be of any given length (say 1.5 seconds...)
			else
				gkRedBlink = 1/kmetrofreq ; set the duration in seconds. Host should take care of seting it to 0 after the value is read.
			endif
		else 
			if (p4==1 && p5==4) then
				gkGreenBlink = p3 ; for 1/4 time
			else
				gkGreenBlink = 1/kmetrofreq
			endif
		endif
		kBeat += 1
; uncommented since eats last subidivision up:		
;		if (kBeat>iBeats) then ; Is is sometimes necessary to play 4/8 but start counting from say 3?
;			turnoff ; all beats have been played
;		endif
	endif	
	
	if (kSubdiv_trig==1 && kBeat_trig==0) then ; only offbeats
		gkBlueBlink = 1/kmetrofreq
	endif
	
endin





instr 18, countdown ; count-down i 18 0 <dur> <klicks> <channels>  -  given amount of ticks during given time. last tick is green, before that blue
	iKlicks= p4 
	iDur=p3
	iChannels=(p5==0) ? $TUTTI : p5 ; in binary form every bit according to one channel; think TUTTI if not set
	
	kKlick init 0
	print iKlicks, iDur
	iMetro_rate= iKlicks/iDur; how many klicks per duration 
	gkBar init 0 ; erase old number
	gkBeat init 0 ;
	gkGreenBlink init 0 ; for any case
	gkBlueBlink init 0 

	kBeat_trig metro iMetro_rate ; implies that tempo is constant
	if (kBeat_trig==1) then	
		gkBeat = -(iKlicks - kKlick) ; show as negative numbers -4, -3, -2, -1
		kKlick += 1
		if (kKlick==iKlicks) then
			gkGreenBlink = 1/(gkTempo/60) ; last click blue
			turnoff
		else
			gkBlueBlink = 1/(gkTempo/60)	    
	    endif
	    
		/*if (kKlick==iKlicks) then
			turnoff ;turn off after last click
		endif*/    		
	endif 
endin


instr 19, nb ; NB instrument - lit red led. Not sure, if it was ever used... Let's keep for safety.

	iChannels=(p4==0) ? $TUTTI : p4 ; in binary form every bit according to one channel; think TUTTI if not set
	gkRedBlink = p3
	
endin



instr 20, notification
	ichannels = (p5==0) ? $TUTTI : p5
	gSnotification strget p4
	iduration = (p3==0) ? 4 : p3 
	prints gSnotification
	print p3
	gkNewNotification init iduration ; must be reset to 0 by host
	turnoff
endin	



instr 30, playfile ; plays both sndfile (wav, aif,, oggg etc) and mp3 files. Files Must be stereo. p4- file name. p5 - start position in second. If p3==999, use file length, otherwise given p3
	Sfilename strget p4
	
	; TODO: safety check for non-stereo files!
	
	;prints Sfilename
	if (p3==999) then ; 999 signals that use the file length
		p3 filelen Sfilename 
	endif
	iskiptime = p5
	if (strindex(Sfilename ,".mp3")>0) then
		aL,aR mp3in Sfilename,iskiptime	
	else
		aL,aR soundin Sfilename, iskiptime
	endif
	aenv linen gkVolume,0.01,p3,0.01
	outs aL*aenv,aR*aenv 
endin

;schedule "test",0,-1
instr 999, test
	;printk2 gkVolume
	printf "Bar: %d\n", changed(gkBar), gkBar
 	printf "Beat: %d\n", changed(gkBeat), gkBeat
; 	printf "Tempo: %.3f\n", changed(gkTempo), gkTempo
; 	
; 	printf "Red: %.3f\n", changed(gkRedBlink)&gkRedBlink, gkRedBlink
; 	printf "Green: %.3f\n", changed(gkGreenBlink)&gkGreenBlink, gkGreenBlink ; don't show, when 0
; 	printf "Blue: %.3f\n", changed(gkBlueBlink)&gkBlueBlink, gkBlueBlink
; 	gkGreenBlink = 0 ; reset (back to 0) must be done by host!
; 	gkBlueBlink = 0
; 	gkRedBlink = 0 
	
	
endin












































<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>0</x>
 <y>0</y>
 <width>0</width>
 <height>0</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
