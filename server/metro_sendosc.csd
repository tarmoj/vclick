; orchestra file for vClick clicktrack system
; Licence: GNU GPL 3.0
; (c) Tarmo Johannes 2017, trmjhnns@gmail.com 

sr = 44100 
ksmps = 128
nchnls = 2
0dbfs = 1


#define RED #0#
#define GREEN #1#
#define BLUE #2#
#define TUTTI #0xFFFF# ; now 32 bits set to 1; think how to do it better...

#define OSCPORT #57878# ; was 87878 in verion 1

#define BEATBAR #0#
#define LED #1#
#define TEMPO #2#
#define NOTIFICATION #3#


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

gSclients[] init 100
;gSclients fillarray "1:127.0.0.1" ; in format [<channel>:]<IP>

giClientsCount init 0 ; was 1 for localhost


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
  	
  	
  	schedule "send",0,0,$TEMPO, 0, istarttmp,0
  	
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
	
	; double now global and local variables to be able to works with previous version of vClick server (reading global variables as channels)
	kbar init abs(iBarno)
	ichannels=(p8==0) ? $TUTTI : p8 ; in binary form every bit according to one channel; think TUTTI if not set
	;print ichannels
	
	kReadBlink init 0
	kGreenBlink init 0
	kBlueBlink init 0
	
	kmetrofreq=gkTempo/60*iMetro_rate
	kBeat_trig metro kmetrofreq
	if (iSubdivs>1) then
		kSubdiv_trig metro kmetrofreq*iSubdivs
	endif
	
	kBeat init iFirstBeat

	kKlick_type init 0

    	
	if (kBeat_trig==1) then	
		
		gkBeat = kBeat
		schedkwhen kBeat_trig,0,0,"send",0,0,$BEATBAR, ichannels, iBarno,kBeat
		if (changed(gkTempo)==1) then 
			;event "i","send",0,0,$TEMPO, ichannels, gkTempo,0 ; why is this sent every bar?
		endif
		
		
		if (kBeat==1 && iBarno>=0) then ; if the first beat and not signalled otherwise (negative barno), use RED led
			if (p4==1 && p5==4) then
				gkRedBlink = p3 ; allow 1/4 bars to be of any given length (say 1.5 seconds...)
				kRedBlink = p3				
			else
				gkRedBlink = 1/kmetrofreq ; set the duration in seconds. Host should take care of seting it to 0 after the value is read.
				kRedBlink = 1/kmetrofreq
			endif
			event "i", "send",0, 0, $LED, ichannels,   $RED, kRedBlink
		else 
			if (p4==1 && p5==4) then
				gkGreenBlink = p3 ; for 1/4 time
				kGreenBlink = p3
			else
				gkGreenBlink = 1/kmetrofreq
				kGreenBlink = 1/kmetrofreq
			endif
			event "i", "send",0, 0, $LED, ichannels, $GREEN, kGreenBlink
		endif
		kBeat += 1
	endif	
	
	if (kSubdiv_trig==1 && kBeat_trig==0) then ; only offbeats
		gkBlueBlink = 1/kmetrofreq
		kBlueBlink = 1/kmetrofreq ; või peaks see olema pigem 1/kmetrofreq*iSubdivs
		event "i", "send",0, 0, $LED, ichannels, $BLUE, kBlueBlink
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
	
	; kuskohas tehakse negatiivseks? serveris?
	if (kBeat_trig==1) then	
		;gkBeat = iKlicks - kKlick
		gkBeat = -(iKlicks - kKlick) ; show as negative numbers -4, -3, -2, -1
		schedkwhen kBeat_trig,0,0,"send", 0,0, $BEATBAR, iChannels, 0,  -(iKlicks - kKlick)
		kKlick += 1
		if (kKlick==iKlicks) then
			gkGreenBlink = 1/(gkTempo/60) ; last click blue
			schedkwhen kBeat_trig,0,0,"send", 0,0, $LED, iChannels, $GREEN, 1/(gkTempo/60)
			;turnoff ; maybe this was reason for shorter countdowns in s section???
		else
			gkBlueBlink = 1/(gkTempo/60)	    
	    	schedkwhen kBeat_trig,0,0,"send", 0,0, $LED, iChannels, $BLUE, 1/(gkTempo/60)
	    endif
	    
		/*if (kKlick==iKlicks) then
			turnoff ;turn off after last click
		endif*/    		
	endif 
endin


instr 20, notification
	ichannels = (p5==0) ? $TUTTI : p5
	Snotification strget p4
	gSnotification = Snotification
	iduration = (p3==0) ? 4 : p3 
	;prints gSnotification
	;print p3
	gkNewNotification init iduration ; must be reset to 0 by host
	schedule "send",0,0,$NOTIFICATION,ichannels,Snotification,iduration
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
	aenv linen gkVolume,0.1,p3,0.1
	outs aL*aenv,aR*aenv 
endin

instr send ; macroinstrument for sending different OSC messages; p4 -  iwhat, p5 - channels, p6 - param1, p7 -  param 2 
	iwhat = p4 ; 0 - BEATBAR; 1 - LED, 2 - TEMPO, 3 - NOTIFICATION
	p3 = 1/kr ; must have some duration. Does it?	
	ichannels = (p5==0) ? $TUTTI : p5

	index = 0
	while (index<giClientsCount) do
		icolonPosition strindex gSclients[index], ":"
		ilength strlen gSclients[index]
		if (icolonPosition>0) then 
			Schannel strsub gSclients[index],0,icolonPosition
			ichannel strtol Schannel
		else
			ichannel = 0
		endif
		SIP strsub gSclients[index], icolonPosition+1, ilength
		isend = 0
		if (ichannel>0) then 
			isend = 1<<(ichannel-1)&ichannels ; bitwise test for the given channel. send if set or if channel 0
			;print isend
		endif
		if (ichannel==0 && ichannels==$TUTTI) then
		    isend = 1
			;print isend, ichannels
		endif
		if (isend>0) then
			if (iwhat==$BEATBAR) then
                                schedule  "mySendOsc", 0, 1/kr, SIP, "/metronome/beatbar", "ii", abs(p6), p7
			elseif (iwhat==$LED) then
				schedule  "mySendOsc", 0, 1/kr, SIP, "/metronome/led", "if", p6, p7
			elseif (iwhat==$TEMPO) then
				schedule  "mySendOsc", 0, 1/kr, SIP, "/metronome/tempo", "f", p6, 0
			elseif (iwhat==$NOTIFICATION ) then
				Smessage strget p6
				schedule  "mySendOsc", 0, 1/kr, SIP, "/metronome/notification", "sf", Smessage, p7 ; p7 duration in that case
			endif
		endif		
		index +=1
	od
endin

; stupid instrument, but necessary - since OSCsend must have String of IP address in INIT time, but kwhen in k-time. Impossible to have both in either k- or i-cycles.
instr mySendOsc
	p3=1/kr
	Shost strget p4
	Sdestination strget p5
	Stype strget p6
	
	;printf_i "IP: %s dest: %s type: %s p1 %d p2: %f\n", 1,   Shost, Sdestination, Stype, p7, p8
	
	if (strcmp(Stype,"sf")==0) then ; notification
		Smessage strget p7
		idur = p8
                OSCsend_lo 1, Shost, $OSCPORT,Sdestination, Stype, Smessage, idur ; liblo OSC seems to be more stable, thoug, internal OSCsend sometimes "Could not create socket" OSCsend if Csound<6.09!!!
	elseif (strcmp(Stype,"f")==0) then ; tempo
		itempo = p7
                OSCsend_lo 1, Shost, $OSCPORT,Sdestination, Stype, itempo
        else ; beatbar and led send two bumbers
		ip1 = p7
		ip2 = p8
                OSCsend_lo 1, Shost, $OSCPORT,Sdestination, Stype, ip1, ip2
	endif
		
endin


;schedule "test",0,-1
instr 999, test
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
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
