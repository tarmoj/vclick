; murail winter fragments ettevalmistus																	
;NB! Numbers – Character English (muidu tulevad numbnritesse komad, mitte punktid, nagu Csoundil vaja!)																	
																	
																	
; TEMPO MAKROD																	
																	
#define TEMPO60  #60#																	
#define TEMPO50  #[50/60*$TEMPO60]#																	
#define TEMPO63 #[63/60*$TEMPO60]#																	
#define TEMPO66  #[66/60*$TEMPO60]#																	
#define TEMPO72  #[72/60*$TEMPO60]#																	
#define TEMPO80  #[80/60*$TEMPO60]#																	
#define TEMPO86  #[86/60*$TEMPO60]#																	
#define TEMPO96  #[96/60*$TEMPO60]#																	
#define TEMPO100  #[100/60*$TEMPO60]#																	
#define TEMPO76 #[76/60*$TEMPO60]#																	
#define TEMPO120  #[108/60*$TEMPO60]#																	
#define TEMPO90  #[90/60*$TEMPO60]#																	
#define TEMPO70  #[70/60*$TEMPO60]#																	
#define TEMPO92  #[92/60*$TEMPO60]#																	
#define TEMPO84  #[84/60*$TEMPO60]#																	
																	
;count-down 																	
#define TUTTI  #63#																	
#define BEGIN #5#																	
#define REPTEMPO #60#																	
t 0 $REPTEMPO																	
i 1 0 0 $REPTEMPO 0																	
i 18 [$BEGIN-4] 4 4 $TUTTI 1; 4 klikki 4 löögi jooksul																	
s																	
																	
																	
;I ========================================================================================																	
																	
																	
																	
;ADVANCE		; do not change or delete by hand!															
																	
t	0	$TEMPO60	148	$TEMPO60	148	$TEMPO63	157	$TEMPO63	157	$TEMPO66	160	$TEMPO66	160	$TEMPO72	163	$TEMPO72	\
	163	$TEMPO80	167	$TEMPO80	167	$TEMPO90	181	$TEMPO90	\								
	\																
	181	$TEMPO76	255	$TEMPO76	255	$TEMPO80	266.7	$TEMPO80	266.7	$TEMPO86	276.7	$TEMPO86	276.7	$TEMPO96	287.7	$TEMPO96	\
	\																
	287.7	$TEMPO120	306.7	$TEMPO120	310.7	$TEMPO100	314.7	$TEMPO90	318.7	$TEMPO80	322.7	$TEMPO70	\				
	326.7	$TEMPO60	331.7	$TEMPO60	331.7	$TEMPO120	370.7	$TEMPO120	374.7	$TEMPO100	383.95	$TEMPO90	\				
	386.95	$TEMPO80	391.45	$TEMPO60	398.45	$TEMPO50	456.45	$TEMPO50	456.45	$TEMPO90	463.45	$TEMPO90	466.45	$TEMPO70	498.95	$TEMPO70	\
	\																
	498.95	$TEMPO120	525.45	$TEMPO120	525.45	$TEMPO84	531.95	$TEMPO84	536.95	$TEMPO120	603.95	$TEMPO120	\				
	605.95	$TEMPO92	614.45	$TEMPO92	618.45	$TEMPO120	690.95	$TEMPO120	690.95	$TEMPO80	721.95	$TEMPO80	\				
	721.95	$TEMPO100	736.7	$TEMPO100	736.7	$TEMPO80	741.95	$TEMPO80	741.95	$TEMPO70	746.2	$TEMPO60	746.2	$TEMPO60	\		
	751.7	$TEMPO60	751.7	$TEMPO50	768.7	$TEMPO50	768.7	$TEMPO60	\								
	\																
	768.7	$TEMPO60	925.7	$TEMPO60	925.7	$TEMPO100	927.7	$TEMPO100	930.2	$TEMPO70	935.7	$TEMPO70	935.7	$TEMPO60			
																	
i	1	0	0	$TEMPO60													
i	1	148	0	$TEMPO63													
i	1	157	0	$TEMPO66													
i	1	160	0	$TEMPO72													
i	1	163	0	$TEMPO80													
i	1	167	0	$TEMPO90													
							; taktnr kujul OOttNN – osa, täht, nr; nt 010101 – I osa, a, 1 										
;i	instrnr	algus	kestus	löökide arv	mitmendikku	alajaotusi	takti nr	instrumendid 									
i	2	0	4	4	4	0	10101	$TUTTI	;1a								
i	2	4	4	4	4	0	10102	$TUTTI	; taktinumber 1000 – osa number 100 – täht, nr – takti number								
i	2	8	3	3	4	0	10103	$TUTTI	; parem ikka 3 ja 8 sa sama taktinumber								
i	2	11	8	8	4	0	10104	$TUTTI	;fermaat 8''								
i	2	19	4	4	4	0	10201	$TUTTI	;1b								
i	2	23	4	4	4	0	10202	$TUTTI									
i	2	27	4	4	4	0	10301	$TUTTI	;1c								
i	2	31	2	2	4	0	10302	$TUTTI									
i	2	33	3	3	4	0	10303	$TUTTI									
i	2	36	2	2	4	0	10304	$TUTTI									
i	2	38	5	5	4	0	10305	$TUTTI	;fermaat 5''								
i	2	43	2	2	4	0	10401	$TUTTI	;d								
i	2	45	5	5	4	0	10402	$TUTTI									
i	2	50	2	2	4	0	10403	$TUTTI									
i	2	52	3	3	4	0	10501	$TUTTI	;e								
i	2	55	4	4	4	0	10502	$TUTTI									
i	2	59	3	3	4	0	10503	$TUTTI									
i	2	62	4	4	4	0	10504	$TUTTI	;paus								
i	2	66	2	2	4	0	10601	$TUTTI	;f  								
i	2	68	4	4	4	0	10602	$TUTTI									
i	2	72	4	4	4	0	10603	$TUTTI									
i	2	76	3	3	4	0	10604	$TUTTI									
i	2	79	5	5	4	0	10605	$TUTTI	;5''								
i	2	84	1.5	3	8	0	10701	$TUTTI	;g								
i	2	85.5	3	3	4	0	10702	$TUTTI									
i	2	88.5	2	2	4	0	10703	$TUTTI									
i	2	90.5	4	4	4	0	10704	$TUTTI									
i	2	94.5	4	4	4	0	10705	$TUTTI									
i	2	98.5	3	3	4	0	10706	$TUTTI									
i	2	101.5	3	3	4	0	10801	$TUTTI	;h								
i	2	104.5	3	3	4	0	10802	$TUTTI									
i	2	107.5	3	3	4	0	10803	$TUTTI									
i	2	110.5	3	3	4	0	10804	$TUTTI									
i	2	113.5	3	3	4	0	10805	$TUTTI									
i	2	116.5	3	3	4	0	10806	$TUTTI									
i	2	119.5	3	3	4	0	10901	$TUTTI	;i								
i	2	122.5	3	3	4	0	10902	$TUTTI									
i	2	125.5	4	4	4	0	11001	$TUTTI	;j								
i	2	129.5	3	3	4	0	11002	$TUTTI									
i	2	132.5	3	3	4	0	11003	$TUTTI									
i	2	135.5	2.5	5	8	0	11004	$TUTTI									
i	2	138	3	3	4	0	11101	$TUTTI	;k								
i	2	141	4	4	4	0	11102	$TUTTI									
i	2	145	3	3	4	0	11103	$TUTTI									
i	2	148	2	2	4	0	11201	$TUTTI	;l TEMPO 63								
i	2	150	3	3	4	0	11202	$TUTTI									
i	2	153	4	4	4	0	11203	$TUTTI									
i	2	157	3	3	4	0	11301	$TUTTI	;m TEMPO 66 NB! 3/ mitte 4/4 nagu partituuris!4,								
i	2	160	3	3	4	0	11401	$TUTTI	; TEMPO 72								
i	2	163	2	2	4	0	11501	$TUTTI	; TEMPO 80								
i	2	165	2	2	4	0	11601	$TUTTI									
i	2	167	5	5	4	0	11701	$TUTTI	; TEMPO90								
i	2	172	9	9	4	0	11702	$TUTTI	;fermaat 6''								
																	
																	
; notifactions about the letters																	
i	"notification"	0	2	"a"	;a												
i	"notification"	19	2	"b"	;b												
i	"notification"	31	2	"c"	;c												
i	"notification"	43	2	"d"	;d												
i	"notification"	52	2	"e"	;e												
i	"notification"	66	2	"f"	;f												
i	"notification"	84	2	"g"	;g												
i	"notification"	101.5	2	"h"	;h												
i	"notification"	119.5	2	"i"	;i												
i	"notification"	125.5	2	"j"	;j												
i	"notification"	138	2	"k"	;k												
i	"notification"	148	2	"l"	;l												
i	"notification"	157	2	"m"	;m												
i	"notification"	160	2	"n"	;n												
i	"notification"	163	2	"o"	;o												
i	"notification"	165	2	"p"	;p												
i	"notification"	167	2	"q"	;q												
																	
;s	; end section																
																	
;II osa  ========================================================================================																	
																	
																	
																	
																	
																	
																	
;t	181	$TEMPO76	255	$TEMPO76	255	$TEMPO80	266.7	$TEMPO80	266.7	$TEMPO86	276.7	$TEMPO86	276.7	$TEMPO96			
																	
; kasuta skrpiti t-line.py  i1 genereerimiseks – ei see eeldab, et temod on numbrid!!																	
																	
i	1	181	0	$TEMPO76		;NB !!!! Siin pole valemid vaid arvud. Paranda!!!!											
i	1	255	0	$TEMPO80													
i	1	266.7	0	$TEMPO86													
i	1	276.7	0	$TEMPO96													
																	
																	
							; taktnr kujul OOttNN – osa, täht, nr; nt 010101 – I osa, a, 1 										
;i	instrnr	algus	kestus	löökide arv	mitmendikku	alajaotusi	takti nr	instrumendid 									
i	2	181	4	4	4	0	20101	$TUTTI	;a TEMPO 76								
i	2	185	2	2	4	0	20102	$TUTTI									
i	2	187	2	2	4	0	20103	$TUTTI									
i	2	189	3	3	4	0	20104	$TUTTI									
i	2	192	4	4	4	0	20201	$TUTTI	;b								
i	2	196	3	3	4	0	20202	$TUTTI									
i	2	199	3	3	4	0	20203	$TUTTI									
i	2	202	3	3	4	0	20204	$TUTTI									
i	2	205	3	3	4	0	20301	$TUTTI	;c								
i	2	208	3	3	4	0	20302	$TUTTI									
i	2	211	5	5	4	0	20303	$TUTTI	;   	VIGA	5/4 peaks olema C 3. takt						
i	2	216	4	4	4	0	20401	$TUTTI	; d peaks olema SIIN								
i	2	220	5	5	4	0	20402	$TUTTI									
i	2	225	3	3	4	0	20403	$TUTTI									
i	2	228	4	4	4	0	20404	$TUTTI									
i	2	232	4	4	4	0	20501	$TUTTI	;e								
i	2	236	3	3	4	0	20502	$TUTTI									
i	2	239	2	2	4	0	20601	$TUTTI	;f  								
i	2	241	2	2	4	0	20602	$TUTTI									
i	2	243	5	5	4	0	20603	$TUTTI									
i	2	248	3	3	4	0	20701	$TUTTI	;g								
i	2	251	4	4	4	0	20702	$TUTTI									
i	2	255	2	2	4	0	20801	$TUTTI	;H TEMPO 80								
i	2	257	4	4	4	0	20802	$TUTTI									
i	2	261	2	2	4	0	20803	$TUTTI									
i	2	263	4	4	4	0	20804	$TUTTI	; 3 + 2/3								
i	2	266.7	4	4	4	0	20901	$TUTTI	;I tempo 86 ; NB! Algus 1/3 lööki varem (eelmise viimane löök lühike								
i	2	270.7	6	6	4	0	20902	$TUTTI									
i	2	276.7	4	4	4	0	21001	$TUTTI	; J tempo 96								
i	2	280.7	3	3	4	0	21002	$TUTTI									
i	2	283.7	4	4	4	0	21003	$TUTTI									
																	
																	
																	
; TODO: notifications																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
																	
;III osa =========================================================================================																	
																	
													
																	
;t 	287.7	$TEMPO120	306.7	$TEMPO120	310.7	$TEMPO100	314.7	$TEMPO90	318.7	$TEMPO80	322.7	$TEMPO70	\				
;  	326.7	$TEMPO60	331.7	$TEMPO60	331.7	$TEMPO120	370.7	$TEMPO120	374.7	$TEMPO100	383.95	$TEMPO90	\				
;  	386.95	$TEMPO80	391.45	$TEMPO60	398.45	$TEMPO50	456.45	$TEMPO50	456.45	$TEMPO90	463.45	$TEMPO90	466.45	$TEMPO70			
																	
																	
																	
i	1	287.7	0	$TEMPO120													
i	1	306.7	4	$TEMPO120	$TEMPO100	4											
i	1	310.7	4	$TEMPO100	$TEMPO90	4											
i	1	314.7	4	$TEMPO90	$TEMPO80	4											
i	1	318.7	4	$TEMPO80	$TEMPO70	4											
i	1	322.7	4	$TEMPO70	$TEMPO60	4											
i	1	326.7	0	$TEMPO60													
i	1	331.7	0	$TEMPO120													
i	1	370.7	4	$TEMPO120	$TEMPO100	4											
i	1	374.7	9.25	$TEMPO100	$TEMPO90	9.25											
i	1	383.95	3	$TEMPO90	$TEMPO80	3											
i	1	386.95	4.25	$TEMPO80	$TEMPO60	4.25											
i	1	391.45	7	$TEMPO60	$TEMPO50	7											
i	1	398.45	0	$TEMPO50													
i	1	456.45	0	$TEMPO90													
i	1	463.45	3	$TEMPO90	$TEMPO70	3											
																	
							; taktnr kujul OOttNN – osa, täht, nr; nt 010101 – I osa, a, 1 										
;i	instrnr	algus	kestus	löökide arv	mitmendikku	alajaotusi	takti nr	instrumendid 									
i	2	287.7	4	4	4	0	30101	$TUTTI	; III osa a tempo 120 a								
i	2	291.7	3	3	4	0	30201	$TUTTI	;B								
i	2	294.7	4	4	4	0	30202	$TUTTI									
i	2	298.7	4	4	4	0	30301	$TUTTI	; puudu pdf-is; siin 6+4								
i	2	302.7	4	4	4	0	30302	$TUTTI									
i	2	306.7	3	3	4	0	30401	$TUTTI	;D								
i	2	309.7	3	3	4	0	30501	$TUTTI	; E 2. löögist tempo 100; sinna acc, alates millest? Dst								
i	2	312.7	3	3	4	0	30602	$TUTTI	; F 3. löök tempo 90 (rit)								
i	2	315.7	3	3	4	0	30701	$TUTTI	; g rit kuni jrg takti alguseni								
i	2	318.7	4	4	4	0	30801	$TUTTI	; h tempo 80, rit järgmisse temposse								
i	2	322.7	4	4	4	0	30901	$TUTTI	;i tempo 70, rit								
i	2	326.7	5	5	4	0	31001	$TUTTI	;j tempo 60								
i	2	331.7	3	3	4	0	31101	$TUTTI	;k tempo 120								
i	2	335.2	5	5	4	0	31201	$TUTTI	;l  0.5 lööki hiljem								
i	2	340.2	3	3	4	0	31301	$TUTTI	;m 								
i	2	343.2	4	4	4	0	31401	$TUTTI	;n								
i	2	347.2	3	3	4	0	31402	$TUTTI									
i	2	350.2	4	4	4	0	31501	$TUTTI	;o 								
i	2	354.2	5	5	4	0	31601	$TUTTI	;p  								
i	2	359.2	5	5	4	0	31602	$TUTTI									
i	2	364.2	3	3	4	0	31701	$TUTTI	;Q								
i	2	367.2	3	3	4	0	31801	$TUTTI	; r 2. löögist tempo 100; sinna acc, alates millest? Sist ; järgmine takt pool lööki varem sisse!								
i	2	370.7	3	3	4	0	31901	$TUTTI	; S pool lööki varem sisse!								
i	2	373.7	3	3	4	0	32001	$TUTTI	; T 2. löök 100, enne seda rit. Alates kust?								
i	2	376.7	2	2	4	0	32101	$TUTTI	; U								
i	2	378.7	3	3	4	0	32201	$TUTTI	; V viimane löök 5 16-kku ; järgmine takt 0.25 lööki hiljem!								
i	2	381.95	3	3	4	0	32301	$TUTTI	; W 3. löök tempo 90 								
i	2	384.95	1.25	1	4	0	32401	$TUTTI	;X  3 x 1 /4								
i	2	386.2	1	1	4	0	32401	$TUTTI	; TODO: muuda – negatiivne taktinumber vm!								
i	2	387.2	1.25	1	4	0	32401	$TUTTI									
i	2	388.45	3	3	4	0	32501	$TUTTI	; Y 0.25								
i	2	391.45	4	4	4	0	32601	$TUTTI	;Z  tempo 60								
i	2	395.45	1.5	3	8	0	32701	$TUTTI	; aa  2 x 1.5 pikkune löök võiks anda ka 2  [8/3]								
i	2	396.95	1.5	3	8	0	32702	$TUTTI									
i	2	398.45	2.5	5	8	0	32801	$TUTTI	;BB  tempo 50 järgmine takt 0.5 lööki hiljem (2 +3 /8)								
i	2	400.95	4	4	4	0	32901	$TUTTI	;CC 0.5 hiljem								
i	2	404.95	4	4	4	0	33001	$TUTTI	;DD								
i	2	408.95	4	4	4	0	33101	$TUTTI	;EE								
i	2	412.95	3	3	4	0	33201	$TUTTI	;FF								
i	2	415.95	1.5	3	8	0	33301	$TUTTI	; GG3/8								
i	2	417.45	4	4	4	0	33302	$TUTTI									
i	2	421.45	4	4	4	0	33303	$TUTTI									
i	2	425.45	4	4	4	0	33401	$TUTTI	;HH								
i	2	429.45	3	3	4	0	33402	$TUTTI									
i	2	432.45	3	3	4	0	33501	$TUTTI	;II								
i	2	435.45	4	4	4	0	33502	$TUTTI									
i	2	439.45	6	6	4	0	33601	$TUTTI	;JJ  6 sek								
i	2	445.45	11	11	4	0	33701	$TUTTI	; KK 11 sek								
i	2	456.45	2	2	4	0	33801	$TUTTI	;LL tempo 90								
i	2	458.45	4	4	4	0	33802	$TUTTI									
i	2	462.45	4	4	4	0	33803	$TUTTI	; rall alates 2. löök								
i	2	466.45	4	4	4	0	33901	$TUTTI	; mm kuni tempo 70								
i	2	470.45	4	4	4	0	33902	$TUTTI									
i	2	474.45	4	4	4	0	34001	$TUTTI	;NN								
i	2	478.45	4	4	4	0	34002	$TUTTI									
i	2	482.45	4	4	4	0	34003	$TUTTI									
i	2	486.45	5	5	4	0	34101	$TUTTI	;OO								
i	2	491.45	3	3	4	0	34201	$TUTTI	;PP								
i	2	494.45	3	3	4	0	34301	$TUTTI	;QQ								
i	2	497.45	1.5	3	8	0	34301	$TUTTI									
																	
																	
; s																	
																	
; IV osa =========================================================================================																	
																	
																	
																	
;t	498.95	$TEMPO120	525.45	$TEMPO120	525.45	$TEMPO84	531.95	$TEMPO84	536.95	$TEMPO120	603.95	$TEMPO120	\				
;  	605.95	$TEMPO92	614.45	$TEMPO92	618.45	$TEMPO120	690.95	$TEMPO120	690.95	$TEMPO80	721.95	$TEMPO80	\				
;  	721.95	$TEMPO100	736.7	$TEMPO100	736.7	$TEMPO80	741.95	$TEMPO80	741.95	$TEMPO70	746.2	$TEMPO60	\				
;  	751.7	$TEMPO60	751.7	$TEMPO50	768.7	$TEMPO50	768.7	$TEMPO60									
																	
; kasuta skrpiti t-line.py  i1 genereerimiseks – ei see eeldab, et temod on numbrid!!																	
i	1	498.95	0	$TEMPO120													
i	1	525.45	0	$TEMPO84													
i	1	531.95	5	$TEMPO84	$TEMPO120	5											
i	1	605.95	0	$TEMPO92													
i	1	614.45	4	$TEMPO92	$TEMPO120	4											
i	1	690.95	0	$TEMPO80													
i	1	721.95	0	$TEMPO100													
i	1	736.7	0	$TEMPO80													
i	1	741.95	0	$TEMPO70													
i	1	746.2	0	$TEMPO60													
i	1	751.7	0	$TEMPO50													
i	1	768.7	0	$TEMPO60													
																	
																	
;i	instrnr	algus	kestus	löökide arv	mitmendikku	alajaotusi	takti nr	instrumendid 									
i	2	498.95	5	5	4	0	40101	$TUTTI	;IV osa a tempo 120 a								
i	2	503.95	4	4	4	0	40201	$TUTTI	;B								
i	2	507.95	3	3	4	0	40202	$TUTTI									
i	2	510.95	2	2	4	0	40301	$TUTTI	;c 								
i	2	512.95	4	4	4	0	40302	$TUTTI									
i	2	516.95	3	3	4	0	40401	$TUTTI	; d 3/4 + 1kaheksandiks								
i	2	520.45	2	2	4	0	40501	$TUTTI	;e  algus 1/8 hiljem								
i	2	522.45	3	3	4	0	40502	$TUTTI									
i	2	525.45	5	5	4	0	40601	$TUTTI	; f 1/8 pikem TEMPO 84								
i	2	530.95	3	3	4	0	40701	$TUTTI	;g  1/8 hiljem 2. löögil algab accelerando								
i	2	533.95	3	3	4	0	40702	$TUTTI									
i	2	536.95	3	3	4	0	40801	$TUTTI	;h tempo 120								
i	2	539.95	3	3	4	0	40901	$TUTTI	;i   								
i	2	542.95	4	4	4	0	40902	$TUTTI									
i	2	546.95	4	4	4	0	40903	$TUTTI									
i	2	550.95	2	2	4	0	41001	$TUTTI	;j   								
i	2	552.95	3	3	4	0	41101	$TUTTI	;k  								
i	2	555.95	4	4	4	0	41102	$TUTTI									
i	2	559.95	5	5	4	0	41201	$TUTTI	;l 								
i	2	564.95	4	4	4	0	41301	$TUTTI	;m 								
i	2	568.95	2	2	4	0	41302	$TUTTI									
i	2	570.95	2	2	4	0	41401	$TUTTI	;n 								
i	2	572.95	3	3	4	0	41501	$TUTTI	;o 								
i	2	575.95	4	4	4	0	41502	$TUTTI									
i	2	579.95	4	4	4	0	41601	$TUTTI	;p  								
i	2	583.95	4	4	4	0	41701	$TUTTI	;q								
i	2	587.95	5	5	4	0	41702	$TUTTI									
i	2	592.95	2	2	4	0	41801	$TUTTI	;r								
i	2	594.95	3	3	4	0	41901	$TUTTI	;s   								
i	2	597.95	3	3	4	0	41902	$TUTTI									
i	2	600.95	5	5	4	0	41903	$TUTTI	; 4. löögil algab rall								
i	2	605.95	3	3	4	0	42001	$TUTTI	; T temposse 92								
i	2	608.95	3	3	4	0	42002	$TUTTI	; 1/8 pikem								
i	2	612.45	3	3	4	0	42101	$TUTTI	; u algab 1/8 hiljem ; 3. löögil accc								
i	2	615.45	3	3	4	0	42102	$TUTTI									
i	2	618.45	3	3	4	0	42201	$TUTTI	; v temponi 120								
i	2	621.45	3	3	4	0	42301	$TUTTI	;w 								
i	2	624.45	2	2	4	0	42302	$TUTTI									
i	2	626.45	4	4	4	0	42303	$TUTTI									
i	2	630.45	2	2	4	0	42401	$TUTTI	;x   								
i	2	632.45	5	5	4	0	42501	$TUTTI	;y								
i	2	637.45	4	4	4	0	42601	$TUTTI	;z   								
i	2	641.45	5	5	4	0	42602	$TUTTI									
i	2	646.45	4	4	4	0	42701	$TUTTI	;aa 								
i	2	650.45	6	6	4	0	42702	$TUTTI									
i	2	656.45	4	4	4	0	42801	$TUTTI	; bb paus 2 sekundit, 4 lööki								
i	2	660.45	2	2	4	0	42901	$TUTTI	;cc  								
i	2	662.45	5	5	4	0	43001	$TUTTI	;dd								
i	2	667.45	4	4	4	0	43002	$TUTTI	; 1/ 8 pikem								
i	2	671.95	5	5	4	0	43101	$TUTTI	; ee 0.5 lööki hiljem								
i	2	676.95	4	4	4	0	43201	$TUTTI	;ff								
i	2	680.95	5	5	4	0	43301	$TUTTI	;gg								
i	2	685.95	5	5	4	0	43302	$TUTTI	;orig. 2/4, fermaadti tõttu 5/4 lõpus väike fermaat								
i	2	690.95	4	4	4	0	43401	$TUTTI	; hh tempo 80								
i	2	694.95	4	4	4	0	43401	$TUTTI									
i	2	698.95	4	4	4	0	43402	$TUTTI									
i	2	702.95	5	5	4	0	43402	$TUTTI									
i	2	707.95	5	5	4	0	43501	$TUTTI	;ii 								
i	2	712.95	4	4	4	0	43502	$TUTTI									
i	2	716.95	5	5	4	0	43601	$TUTTI	; jj vaba pikkus, panin 5 lööki								
i	2	721.95	2	2	4	0	43701	$TUTTI	; kk tempo 100 1/8 pikem								
i	2	724.45	2	2	4	0	43801	$TUTTI	; ll 0.5 lööki hiljem								
i	2	726.95	2	2	4	0	43901	$TUTTI	; mm 0.5 lööki hiljem								
i	2	728.95	2	2	4	0	44001	$TUTTI	;nn								
i	2	730.95	2	2	4	0	44101	$TUTTI	;  oo 1/8 pikem								
i	2	733.45	3	3	4	0	44201	$TUTTI	; pp 0.5 lööki hiljem								
i	2	736.7	3	3	4	0	44301	$TUTTI	; qq 0.25 lööki hiljem TEMPO80								
i	2	739.7	1.25	1	4	0	44401	$TUTTI	; rr 3 X 1/4 erineva pikkusega								
i	2	740.95	1	1	4	0	44401	$TUTTI									
i	2	741.95	1.25	1	4	0	44401	$TUTTI	; TEMPO 70								
i	2	743.2	3	3	4	0	44501	$TUTTI	;ss								
i	2	746.2	3	6	8	0	44601	$TUTTI	;tt  tempo 60								
i	2	749.2	2.5	5	8	0	44701	$TUTTI	;uu								
i	2	751.7	4	4	4	0	44801	$TUTTI	; vv tempo50 								
i	2	755.7	5	5	4	0	44901	$TUTTI	;ww								
i	2	760.7	4	4	4	0	44801	$TUTTI	;xx	; NB! Erinevus PDF partituuriga, või siis minu viga...							
i	2	764.7	4	4	4	0	44802	$TUTTI									
i	2	768.7	6	6	4	0	44901	$TUTTI	;yy  TEMPO 60								
i	2	774.7	6	6	4	0	44902	$TUTTI									
i	2	780.7	7	7	4	0	44903	$TUTTI									
																	
; s 																	
																	
																	
; V osa  =========================================================================================																	
																	
																	
;t	787.7	$TEMPO60	925.7	$TEMPO60	925.7	$TEMPO100	927.7	$TEMPO100	930.2	$TEMPO70	935.7	$TEMPO70	935.7	$TEMPO60			
																	
																	
																	
i	1	787.7	0	$TEMPO60													
i	1	925.7	0	$TEMPO100													
i	1	927.7	2.5	$TEMPO100	$TEMPO70	2.5											
i	1	930.2	0	$TEMPO70													
i	1	935.7	0	$TEMPO60													
																	
																	
																	
;i	instrnr	algus	kestus	löökide arv	mitmendikku	alajaotusi	takti nr	instrumendid 									
i	2	787.7	12	12	4	0	50101	$TUTTI	;V osa a tempo 60 		lisa  takt 4 lööki						
i	2	799.7	4	4	4	0	50102	$TUTTI									
i	2	803.7	7	7	4	0	50201	$TUTTI	;b								
i	2	810.7	7	7	4	0	50301		;c  								
i	2	817.7	4	4	4	0	50401		;d								
i	2	821.7	3	3	4	0	50501	$TUTTI	;e   								
i	2	824.7	4	4	4	0	50502	$TUTTI									
i	2	828.7	4	4	4	0	50601	$TUTTI	;f  								
i	2	832.7	3	3	4	0	50602	$TUTTI									
i	2	835.7	3	3	4	0	50701	$TUTTI	;g								
i	2	838.7	3	3	4	0	50702	$TUTTI									
i	2	841.7	3	3	4	0	50703	$TUTTI									
i	2	844.7	4	4	4	0	50704	$TUTTI									
i	2	848.7	5	5	4	0	50801	$TUTTI	;h   								
i	2	853.7	5	5	4	0	50802	$TUTTI									
i	2	858.7	2	2	4	0	50803	$TUTTI									
i	2	860.7	5	5	4	0	50901	$TUTTI	; i   								
i	2	865.7	3	3	4	0	51001	$TUTTI	;j   								
i	2	868.7	3	3	4	0	51002	$TUTTI									
i	2	871.7	3	3	4	0	51003	$TUTTI									
i	2	874.7	4	4	4	0	51101	$TUTTI	;k  								
i	2	878.7	3	3	4	0	51102	$TUTTI									
i	2	881.7	4	4	4	0	51103	$TUTTI									
i	2	885.7	4	4	4	0	51201	$TUTTI	;l 								
i	2	889.7	3	3	4	0	51202	$TUTTI									
i	2	892.7	4	4	4	0	51301	$TUTTI	;m 								
i	2	896.7	5	5	4	0	51302	$TUTTI									
i	2	901.7	8	8	4	0	51303	$TUTTI									
i	2	909.7	5	5	4	0	51304	$TUTTI									
i	2	914.7	5	5	4	0	51401	$TUTTI	;n								
i	2	919.7	6	6	4	0	51402	$TUTTI									
i	2	925.7	4	4	4	0	51501	$TUTTI	;o tempo 100	; 3. löögil algab rall							
i	2	930.2	2	2	4	0	51601	$TUTTI	; p 0.5 lööki hiljem	; temponi 70							
i	2	932.7	3	3	4	0	51701	$TUTTI	;q 0.5 lööki hiljem								
i	2	935.7	1.5	3	8	0	51801	$TUTTI	;r  tempo60								
i	2	937.2	2	2	4	0	51802	$TUTTI									
i	2	939.45	2	2	4	0	51901	$TUTTI	; s 0.25 lööki hiljem								
i	2	941.45	1.5	3	8	0	51902	$TUTTI									
i	2	942.95	2	2	4	0	52001	$TUTTI	; t  1/16 pikem								
i	2	945.2	2.5	5	8	0	52002	$TUTTI	; 0.25 lööki hiljem								
i	2	947.7	4	4	4	0	52001	$TUTTI	;u 								
i	2	952.2	5	5	4	0	52201	$TUTTI	; v 0.5 lööki hiljem								
i	2	957.2	6	6	4	0	52301	$TUTTI	;w   								
i	2	963.2	8	8	4	0	52401	$TUTTI	;x   								
i	2	971.2	4	4	4	0	52402	$TUTTI									
i	2	975.2	12	12	4	0	52501	$TUTTI	;y 								
									;z -  nothing								
																	
																	
; notifactions about the letters																	
																	
; I I osa ülalpool																	
																	
; II osa																	
i	"notification"	181	2	"a"													
i	"notification"	192	2	"b"													
i	"notification"	205	2	"c"													
i	"notification"	216	2	"d"													
i	"notification"	232	2	"e"													
i	"notification"	239	2	"f"													
i	"notification"	248	2	"g"													
i	"notification"	255	2	"h"													
i	"notification"	266.7	2	"i"													
i	"notification"	276.7	2	"j"													
																	
																	
																	
																	
																	
																	
																	
																	
																	
;III osa  																	
																	
i	"notification"	287.7	2	"a"													
i	"notification"	291.7	2	"b"													
i	"notification"	298.7	2	"c"													
i	"notification"	306.7	2	"d"													
i	"notification"	309.7	2	"e"													
i	"notification"	312.7	2	"f"													
i	"notification"	315.7	2	"g"													
i	"notification"	318.7	2	"h"													
i	"notification"	322.7	2	"i"													
i	"notification"	326.7	2	"j"													
i	"notification"	331.7	2	"k"													
i	"notification"	335.2	2	"l"													
i	"notification"	340.2	2	"m"													
i	"notification"	343.2	2	"n"													
i	"notification"	350.2	2	"o"													
i	"notification"	354.2	2	"p"													
i	"notification"	364.2	2	"q"													
i	"notification"	367.2	2	"r"													
i	"notification"	370.7	2	"s"													
i	"notification"	373.7	2	"t"													
i	"notification"	376.7	2	"u"													
i	"notification"	378.7	2	"v"													
i	"notification"	381.95	2	"w"													
i	"notification"	384.95	2	"x"													
i	"notification"	388.45	2	"y"													
i	"notification"	391.45	2	"z"													
i	"notification"	395.45	2	"aa"													
i	"notification"	398.45	2	"bb"													
i	"notification"	400.95	2	"cc"													
i	"notification"	404.95	2	"dd"													
i	"notification"	412.95	2	"ee"													
i	"notification"	415.95	2	"ff"													
i	"notification"	415.95	2	"gg"													
i	"notification"	425.45	2	"hh"													
i	"notification"	432.45	2	"ii"													
i	"notification"	439.45	2	"jj"													
i	"notification"	445.45	2	"kk"													
i	"notification"	456.45	2	"ll"													
i	"notification"	466.45	2	"mm"													
i	"notification"	474.45	2	"nn"													
i	"notification"	486.45	2	"oo"													
i	"notification"	491.45	2	"pp"													
i	"notification"	494.45	2	"qq"													
																	
																	
; IV osa  																	
																	
i	"notification"	498.95	2	"a"													
i	"notification"	503.95	2	"b"													
i	"notification"	510.95	2	"c"													
i	"notification"	516.95	2	"d"													
i	"notification"	520.45	2	"e"													
i	"notification"	525.45	2	"f"													
i	"notification"	530.95	2	"g"													
i	"notification"	536.95	2	"h"													
i	"notification"	539.95	2	"i"													
i	"notification"	550.95	2	"j"													
i	"notification"	552.95	2	"k"													
i	"notification"	559.95	2	"l"													
i	"notification"	564.95	2	"m"													
i	"notification"	570.95	2	"n"													
i	"notification"	572.95	2	"o"													
i	"notification"	579.95	2	"p"													
i	"notification"	583.95	2	"q"													
i	"notification"	592.95	2	"r"													
i	"notification"	594.95	2	"s"													
i	"notification"	605.95	2	"t"													
i	"notification"	612.45	2	"u"													
i	"notification"	618.45	2	"v"													
i	"notification"	621.45	2	"w"													
i	"notification"	630.45	2	"x"													
i	"notification"	632.45	2	"y"													
i	"notification"	637.45	2	"z"													
i	"notification"	646.45	2	"aa"													
i	"notification"	656.45	2	"bb"													
i	"notification"	660.45	2	"cc"													
i	"notification"	662.45	2	"dd"													
i	"notification"	671.95	2	"ee"													
i	"notification"	676.95	2	"ff"													
i	"notification"	680.95	2	"gg"													
i	"notification"	690.95	2	"hh"													
i	"notification"	707.95	2	"ii"													
i	"notification"	716.95	2	"jj"													
i	"notification"	721.95	2	"kk"													
i	"notification"	724.45	2	"ll"													
i	"notification"	726.95	2	"mm"													
i	"notification"	728.95	2	"nn"													
i	"notification"	730.95	2	"oo"													
i	"notification"	733.45	2	"pp"													
i	"notification"	736.7	2	"qq"													
i	"notification"	739.7	2	"rr"													
i	"notification"	743.2	2	"ss"													
i	"notification"	746.2	2	"tt"													
i	"notification"	749.2	2	"uu"													
i	"notification"	751.7	2	"vv"													
i	"notification"	755.7	2	"ww"													
i	"notification"	760.7	2	"xx"													
i	"notification"	768.7	2	"yy"													
																	
; V osa   																	
i	"notification"	787.7	2	"a"													
i	"notification"	803.7	2	"b"													
i	"notification"	810.7	2	"c"													
i	"notification"	817.7	2	"d"													
i	"notification"	821.7	2	"e"													
i	"notification"	828.7	2	"f"													
i	"notification"	835.7	2	"g"													
i	"notification"	848.7	2	"h"													
i	"notification"	860.7	2	"i"													
i	"notification"	865.7	2	"j"													
i	"notification"	874.7	2	"k"													
i	"notification"	885.7	2	"l"													
i	"notification"	892.7	2	"m"													
i	"notification"	914.7	2	"n"													
i	"notification"	925.7	2	"o"													
i	"notification"	930.2	2	"p"													
i	"notification"	932.7	2	"q"													
i	"notification"	935.7	2	"r"													
i	"notification"	939.45	2	"s"													
i	"notification"	942.95	2	"t"													
i	"notification"	947.7	2	"u"													
i	"notification"	952.2	2	"v"													
i	"notification"	957.2	2	"w"													
i	"notification"	963.2	2	"x"													
i	"notification"	975.2	2	"y"													
i	"notification"	987.2	2	"z"													
