; Scott Miller Accretion																		
																		
;ÄRA KASUTA; VAID TAKT 0 selle asemel																		
;count-down 																		
																		
																		
#define TUTTI  #0#																		
#define TEMPO1 #120#			; orig 136															
#define TEMPO2 #[$TEMPO1*1.0588]#																		
#define TEMPO3 #152#																		
#define TEMPO4 #[$TEMPO1*0.7941]#																		
#define TEMPO5 #124#																		
#define REPTEMPO #$TEMPO1# ; REPTEMPO selleks, et ettelugemine oleks õiges tempos																		
#define BEGIN #5#																		
																		
																		
t 0 $REPTEMPO																		
i 1 0 0 $REPTEMPO 0																		
;i 18 [$BEGIN-4] 4 4 $TUTTI 1; 4 klikki 4 löögi jooksul																		
i 	2	[$BEGIN-4]	4	4	4	0	-1	$TUTTI	; sisuliselt countdown									
s																		
																		
																		
t	0	$TEMPO1	274.5	$TEMPO1	274.5	$TEMPO2	466.75	$TEMPO2	466.75	$TEMPO3	617	$TEMPO3	617	$TEMPO4	781	$TEMPO4	781	$TEMPO5
																		
;TODO: genereeri t järgi i1 read või vastupidi; võibolla isegi vastupidi...																		
i 	1	0	0	$TEMPO1	0	0	; sea tempo											
i 	1	274.5	0	$TEMPO2	0	0												
i 	1	466.75	0	$TEMPO3	0	0												
i 	1	617	0	$TEMPO4	0	0												
i 	1	781	0	$TEMPO5	0	0												
																		
;ADVANCE		; ära muuda seda rida käsitsi!																
; a 0 0.01 < lööke>																		
; NB! Kui algab kuskilt keskelt, kanna hoolt, et i1 seaks tempo!																		
																		
; TAKTIMÕÕDUD																		
;i	instrnr	algus	kestus	löökide arv	mitmendikku	alajaotusi	takti nr	instrumendid 										
i	2	0	4	4	4	0	0	$TUTTI	; EELTAKT									
i	2	4	4	4	4	0	1	$TUTTI										
i	2	8	4	4	4	0	2	$TUTTI										
i	2	12	4	4	4	0	3	$TUTTI										
i	2	16	4	4	4	0	4	$TUTTI										
i	2	20	4	4	4	0	5	$TUTTI										
i	2	24	4	4	4	0	6	$TUTTI										
i	2	28	4	4	4	0	7	$TUTTI										
i	2	32	4	4	4	0	8	$TUTTI										
i	2	36	4	4	4	0	9	$TUTTI										
i	2	40	4	4	4	0	10	$TUTTI										
i	2	44	4	4	4	0	11	$TUTTI										
i	2	48	4	4	4	0	12	$TUTTI										
i	2	52	4	4	4	0	13	$TUTTI										
i	2	56	4	4	4	0	14	$TUTTI										
i	2	60	4	4	4	0	15	$TUTTI										
i	2	64	4	4	4	0	16	$TUTTI										
i	2	68	4	4	4	0	17	$TUTTI										
i	2	72	4	4	4	0	18	$TUTTI										
i	2	76	4	4	4	0	19	$TUTTI										
i	2	80	4	4	4	0	20	$TUTTI										
i	2	84	4	4	4	0	21	$TUTTI										
i	2	88	4	4	4	0	22	$TUTTI										
i	2	92	4	4	4	0	23	$TUTTI										
i	2	96	4	4	4	0	24	$TUTTI										
i	2	100	4	4	4	0	25	$TUTTI										
i	2	104	4	4	4	0	26	$TUTTI										
i	2	108	4	4	4	0	27	$TUTTI										
i	2	112	4	4	4	0	28	$TUTTI										
i	2	116	1.5	1	2.66666666666667	0	29	$TUTTI	; PAREM VAJA TEHA 2/4 pikem …									
i	2	117.5	1	1	4	0	-29.2	$TUTTI										
i	2	118.5	4	4	4	0	30	$TUTTI										
i	2	122.5	4	4	4	0	31	$TUTTI										
i	2	126.5	4	4	4	0	32	$TUTTI										
i	2	130.5	4	4	4	0	33	$TUTTI										
i	2	134.5	4	4	4	0	34	$TUTTI										
i	2	138.5	3	3	4	0	35	$TUTTI										
i	2	141.5	4	4	4	0	36	$TUTTI										
i	2	145.5	4	4	4	0	37	$TUTTI										
i	2	149.5	4	4	4	0	38	$TUTTI										
i	2	153.5	4	4	4	0	39	$TUTTI										
i	2	157.5	4	4	4	0	40	$TUTTI										
i	2	161.5	4	4	4	0	41	$TUTTI										
i	2	165.5	4	4	4	0	42	$TUTTI										
i	2	169.5	4	4	4	0	43	$TUTTI										
i	2	173.5	4	4	4	0	44	$TUTTI										
i	2	177.5	4	4	4	0	45	$TUTTI										
i	2	181.5	4	4	4	0	46	$TUTTI										
i	2	185.5	4	4	4	0	47	$TUTTI										
i	2	189.5	4	4	4	0	48	$TUTTI										
i	2	193.5	4	4	4	0	49	$TUTTI										
i	2	197.5	4	4	4	0	50	$TUTTI										
i	2	201.5	4	4	4	0	51	$TUTTI										
i	2	205.5	4	4	4	0	52	$TUTTI										
i	2	209.5	4	4	4	0	53	$TUTTI										
i	2	213.5	4	4	4	0	54	$TUTTI										
i	2	217.5	4	4	4	0	55	$TUTTI										
i	2	221.5	4	4	4	0	56	$TUTTI										
i	2	225.5	4	4	4	0	57	$TUTTI										
i	2	229.5	4	4	4	0	58	$TUTTI										
i	2	233.5	4	4	4	0	59	$TUTTI										
i	2	237.5	4	4	4	0	60	$TUTTI										
i	2	241.5	4	4	4	0	61	$TUTTI										
i	2	245.5	4	4	4	0	62	$TUTTI										
i	2	249.5	4	4	4	0	63	$TUTTI										
i	2	253.5	4	4	4	0	64	$TUTTI										
i	2	257.5	4	4	4	0	65	$TUTTI										
i	2	261.5	4	4	4	0	66	$TUTTI										
i	2	265.5	4	4	4	0	67	$TUTTI										
i	2	269.5	2	2	4	0	68	$TUTTI										
i	2	271.5	3	3	4	0	69	$TUTTI										
i	2	274.5	4	4	4	0	70	$TUTTI	; TEMPO 144									
i	2	278.5	4	4	4	0	71	$TUTTI										
i	2	282.5	4	4	4	0	72	$TUTTI										
i	2	286.5	4	4	4	0	73	$TUTTI										
i	2	290.5	4	4	4	0	74	$TUTTI										
i	2	294.5	4	4	4	0	75	$TUTTI										
i	2	298.5	4	4	4	0	76	$TUTTI										
i	2	302.5	4	4	4	0	77	$TUTTI										
i	2	306.5	4	4	4	0	78	$TUTTI										
i	2	310.5	2	2	4	0	79	$TUTTI										
i	2	312.5	3	3	4	0	80	$TUTTI										
i	2	315.5	4	4	4	0	81	$TUTTI										
i	2	319.5	3	3	4	0	82	$TUTTI										
i	2	322.5	2	2	4	0	83	$TUTTI										
i	2	324.5	1.75	1	2.28571428571429	0	84	$TUTTI	; oli 7/16									
i	2	326.25	4	4	4	0	85	$TUTTI										
i	2	330.25	3	3	4	0	86	$TUTTI										
i	2	333.25	3	3	4	0	87	$TUTTI										
i	2	336.25	1.25	1	3.2	0	88	$TUTTI	; oli 5/16									
i	2	337.5	3	3	4	0	89	$TUTTI										
i	2	340.5	4	4	4	0	90	$TUTTI										
i	2	344.5	4	4	4	0	91	$TUTTI										
i	2	348.5	4	4	4	0	92	$TUTTI										
i	2	352.5	2	2	4	0	93	$TUTTI										
i	2	354.5	3	3	4	0	94	$TUTTI										
i	2	357.5	4	4	4	0	95	$TUTTI										
i	2	361.5	4	4	4	0	96	$TUTTI										
i	2	365.5	2	2	4	0	97	$TUTTI										
i	2	367.5	1.5	1	2.66666666666667	0	98	$TUTTI	; oli 3/8									
i	2	369	4	4	4	0	99	$TUTTI										
i	2	373	4	4	4	0	100	$TUTTI										
i	2	377	4	4	4	0	101	$TUTTI										
i	2	381	4	4	4	0	102	$TUTTI										
i	2	385	2	2	4	0	103	$TUTTI										
i	2	387	1.25	1	3.2	0	104	$TUTTI	; 5/16									
i	2	388.25	2	2	4	0	105	$TUTTI										
i	2	390.25	1.5	1	2.66666666666667	0	106	$TUTTI										
i	2	391.75	4	4	4	0	107	$TUTTI										
i	2	395.75	4	4	4	0	108	$TUTTI										
i	2	399.75	4	4	4	0	109	$TUTTI										
i	2	403.75	1.5	1	2.66666666666667	0	110	$TUTTI										
i	2	405.25	1	1	4	0	-110.2	$TUTTI										
i	2	406.25	3	3	4	0	111	$TUTTI										
i	2	409.25	4	4	4	0	112	$TUTTI										
i	2	413.25	4	4	4	0	113	$TUTTI										
i	2	417.25	4	4	4	0	114	$TUTTI										
i	2	421.25	3	3	4	0	115	$TUTTI										
i	2	424.25	4	4	4	0	116	$TUTTI										
i	2	428.25	4	4	4	0	117	$TUTTI										
i	2	432.25	1.5	1	2.66666666666667	0	118	$TUTTI	; oli 5/8, tee 2 lööki									
i	2	433.75	1	1	4	0	-118.2	$TUTTI										
i	2	434.75	4	4	4	0	119	$TUTTI										
i	2	438.75	3	3	4	0	120	$TUTTI										
i	2	441.75	4	4	4	0	121	$TUTTI										
i	2	445.75	3	3	4	0	122	$TUTTI										
i	2	448.75	4	4	4	0	123	$TUTTI										
i	2	452.75	3	3	4	0	124	$TUTTI										
i	2	455.75	3	3	4	0	125	$TUTTI										
i	2	458.75	4	4	4	0	126	$TUTTI										
i	2	462.75	4	4	4	0	127	$TUTTI										
i	2	466.75	2	2	4	0	128	$TUTTI	; TEMPO 152									
i	2	468.75	3	3	4	0	129	$TUTTI										
i	2	471.75	4	4	4	0	130	$TUTTI										
i	2	475.75	1.25	1	3.2	0	131	$TUTTI	; 5/16									
i	2	477	4	4	4	0	132	$TUTTI										
i	2	481	4	4	4	0	133	$TUTTI										
i	2	485	4	4	4	0	134	$TUTTI										
i	2	489	4	4	4	0	135	$TUTTI	; J									
i	2	493	2	2	4	0	136	$TUTTI										
i	2	495	1.5	1	2.66666666666667	0	137	$TUTTI	; 3/8									
i	2	496.5	1.5	1	2.66666666666667	0	138	$TUTTI	;3/8									
i	2	498	4	4	4	0	139	$TUTTI										
i	2	502	4	4	4	0	140	$TUTTI										
i	2	506	3	3	4	0	141	$TUTTI										
i	2	509	4	4	4	0	142	$TUTTI										
i	2	513	4	4	4	0	143	$TUTTI										
i	2	517	3	3	4	0	144	$TUTTI										
i	2	520	4	4	4	0	145	$TUTTI										
i	2	524	4	4	4	0	146	$TUTTI										
i	2	528	4	4	4	0	147	$TUTTI										
i	2	532	4	4	4	0	148	$TUTTI										
i	2	536	4	4	4	0	149	$TUTTI										
i	2	540	3	3	4	0	150	$TUTTI										
i	2	543	4	4	4	0	151	$TUTTI										
i	2	547	4	4	4	0	152	$TUTTI										
i	2	551	4	4	4	0	153	$TUTTI										
i	2	555	4	4	4	0	154	$TUTTI										
i	2	559	4	4	4	0	155	$TUTTI										
i	2	563	4	4	4	0	156	$TUTTI										
i	2	567	4	4	4	0	157	$TUTTI										
i	2	571	4	4	4	0	158	$TUTTI										
i	2	575	4	4	4	0	159	$TUTTI										
i	2	579	4	4	4	0	160	$TUTTI										
i	2	583	4	4	4	0	161	$TUTTI										
i	2	587	4	4	4	0	162	$TUTTI										
i	2	591	4	4	4	0	163	$TUTTI										
i	2	595	4	4	4	0	164	$TUTTI										
i	2	599	4	4	4	0	165	$TUTTI										
i	2	603	4	4	4	0	166	$TUTTI										
i	2	607	10	5	2	0	167	$TUTTI	; PIKK FERMAAT; u 4 skundit 10 lööki, 5/2									
i	2	617	4	4	4	0	168	$TUTTI	;TEMPO 108									
i	2	621	4	4	4	0	169	$TUTTI										
i	2	625	4	4	4	0	170	$TUTTI										
i	2	629	4	4	4	0	171	$TUTTI										
i	2	633	4	4	4	0	172	$TUTTI										
i	2	637	4	4	4	0	173	$TUTTI										
i	2	641	4	4	4	0	174	$TUTTI										
i	2	645	4	4	4	0	175	$TUTTI										
i	2	649	4	4	4	0	176	$TUTTI										
i	2	653	4	4	4	0	177	$TUTTI										
i	2	657	4	4	4	0	178	$TUTTI										
i	2	661	4	4	4	0	179	$TUTTI										
i	2	665	4	4	4	0	180	$TUTTI										
i	2	669	4	4	4	0	181	$TUTTI										
i	2	673	4	4	4	0	182	$TUTTI										
i	2	677	4	4	4	0	183	$TUTTI										
i	2	681	4	4	4	0	184	$TUTTI										
i	2	685	4	4	4	0	185	$TUTTI										
i	2	689	4	4	4	0	186	$TUTTI										
i	2	693	4	4	4	0	187	$TUTTI										
i	2	697	4	4	4	0	188	$TUTTI										
i	2	701	4	4	4	0	189	$TUTTI										
i	2	705	4	4	4	0	190	$TUTTI										
i	2	709	4	4	4	0	191	$TUTTI										
i	2	713	4	4	4	0	192	$TUTTI										
i	2	717	4	4	4	0	193	$TUTTI										
i	2	721	4	4	4	0	194	$TUTTI										
i	2	725	4	4	4	0	195	$TUTTI										
i	2	729	4	4	4	0	196	$TUTTI										
i	2	733	4	4	4	0	197	$TUTTI										
i	2	737	4	4	4	0	198	$TUTTI										
i	2	741	4	4	4	0	199	$TUTTI										
i	2	745	4	4	4	0	200	$TUTTI										
i	2	749	4	4	4	0	201	$TUTTI										
i	2	753	4	4	4	0	202	$TUTTI										
i	2	757	4	4	4	0	203	$TUTTI										
i	2	761	4	4	4	0	204	$TUTTI										
i	2	765	4	4	4	0	205	$TUTTI										
i	2	769	4	4	4	0	206	$TUTTI										
i	2	773	4	4	4	0	207	$TUTTI										
i	2	777	4	4	4	0	208	$TUTTI										
i	2	781	4	2	2	0	209	$TUTTI	;Timeless TEMPO   poolnoot=62									
i	2	785	4	2	2	0	210	$TUTTI										
i	2	789	4	2	2	0	211	$TUTTI										
i	2	793	4	2	2	0	212	$TUTTI										
i	2	797	4	2	2	0	213	$TUTTI										
i	2	801	4	2	2	0	214	$TUTTI										
i	2	805	4	2	2	0	215	$TUTTI										
i	2	809	4	2	2	0	216	$TUTTI										
i	2	813	4	2	2	0	217	$TUTTI										
i	2	817	4	2	2	0	218	$TUTTI										
i	2	821	4	2	2	0	219	$TUTTI										
i	2	825	4	2	2	0	220	$TUTTI										
i	2	829	4	2	2	0	221	$TUTTI										
i	2	833	4	2	2	0	222	$TUTTI										
i	2	837	4	2	2	0	223	$TUTTI										
i	2	841	4	2	2	0	224	$TUTTI										
i	2	845	4	2	2	0	225	$TUTTI										
i	2	849	4	2	2	0	226	$TUTTI										
i	2	853	4	2	2	0	227	$TUTTI										
i	2	857	4	2	2	0	228	$TUTTI										
i	2	861	4	2	2	0	229	$TUTTI										
i	2	865	4	2	2	0	230	$TUTTI										
i	2	869	4	2	2	0	231	$TUTTI										
i	2	873	4	2	2	0	232	$TUTTI										
i	2	877	4	2	2	0	233	$TUTTI										
i	2	881	4	2	2	0	234	$TUTTI										
i	2	885	4	2	2	0	235	$TUTTI										
i	2	889	4	2	2	0	236	$TUTTI										
i	2	893	4	2	2	0	237	$TUTTI										
i	2	897	4	2	2	0	238	$TUTTI										
i	2	901	4	2	2	0	239	$TUTTI										
i	2	905	4	2	2	0	240	$TUTTI										
i	2	909	4	2	2	0	241	$TUTTI										
i	2	913	4	2	2	0	242	$TUTTI										
i	2	917	4	2	2	0	243	$TUTTI										
i	2	921	4	2	2	0	244	$TUTTI										
i	2	925	4	2	2	0	245	$TUTTI										
i	2	929	4	2	2	0	246	$TUTTI										
i	2	933	4	2	2	0	247	$TUTTI										
i	2	937	4	2	2	0	248	$TUTTI										
i	2	941	4	2	2	0	249	$TUTTI										
i	2	945	4	2	2	0	250	$TUTTI										
i	2	949	4	2	2	0	251	$TUTTI										
i	2	953	4	2	2	0	252	$TUTTI										
i	2	957	4	2	2	0	253	$TUTTI										
i	2	961	4	2	2	0	254	$TUTTI										
i	2	965	4	2	2	0	255	$TUTTI										
i	2	969	4	2	2	0	256	$TUTTI										
i	2	973	4	2	2	0	257	$TUTTI										
i	2	977	4	2	2	0	258	$TUTTI										
i	2	981	4	2	2	0	259	$TUTTI										
i	2	985	4	2	2	0	260	$TUTTI										
i	2	989	4	2	2	0	261	$TUTTI										
i	2	993	4	2	2	0	262	$TUTTI										
i	2	997	4	2	2	0	263	$TUTTI										
i	2	1001	4	2	2	0	264	$TUTTI										
i	2	1005	4	4	4	0	265	$TUTTI	;TEMPO 124 -  sisult sama, mis eelmine									
i	2	1009	4	4	4	0	266	$TUTTI										
i	2	1013	4	4	4	0	267	$TUTTI										
i	2	1017	4	4	4	0	268	$TUTTI										
i	2	1021	4	4	4	0	269	$TUTTI										
i	2	1025	4	4	4	0	270	$TUTTI										
i	2	1029	4	4	4	0	271	$TUTTI										
i	2	1033	4	4	4	0	272	$TUTTI										
i	2	1037	4	4	4	0	273	$TUTTI										
i	2	1041	4	4	4	0	274	$TUTTI										
i	2	1045	4	4	4	0	275	$TUTTI										
i	2	1049	4	4	4	0	276	$TUTTI										
i	2	1053	4	4	4	0	277	$TUTTI										
i	2	1057	4	4	4	0	278	$TUTTI										
i	2	1061	4	4	4	0	279	$TUTTI										
i	2	1065	4	4	4	0	280	$TUTTI										
i	2	1069	4	4	4	0	281	$TUTTI										
i	2	1073	4	4	4	0	282	$TUTTI										
i	2	1077	4	4	4	0	283	$TUTTI										
i	2	1081	4	4	4	0	284	$TUTTI										
i	2	1085	4	4	4	0	285	$TUTTI										
i	2	1089	4	4	4	0	286	$TUTTI										
i	2	1093	4	4	4	0	287	$TUTTI										
i	2	1097	4	4	4	0	288	$TUTTI										
i	2	1101	4	4	4	0	289	$TUTTI										
i	2	1105	4	4	4	0	290	$TUTTI										
i	2	1109	4	4	4	0	291	$TUTTI										
i	2	1113	4	4	4	0	292	$TUTTI										
i	2	1117	4	4	4	0	293	$TUTTI										
i	2	1121	4	4	4	0	294	$TUTTI										
i	2	1125	4	4	4	0	295	$TUTTI										
i	2	1129	4	4	4	0	296	$TUTTI										
i	2	1133	4	4	4	0	297	$TUTTI										
i	2	1137	4	4	4	0	298	$TUTTI										
i	2	1141	4	4	4	0	299	$TUTTI										
i	2	1145	4	4	4	0	300	$TUTTI										
i	2	1149	4	4	4	0	301	$TUTTI										
																		
																		
; CUES																		
																		
i	"playfile"	5	999	"01.wav"	0	; t1												
i	"playfile"	30	999	"02.wav"	0	; t 7												
i	"playfile"	64	999	"03.wav"	0	; t16												
i	"playfile"	81.5	999	"04.wav"	0	; t 20 1.5												
i	"playfile"	104.25	999	"05.wav"	0	; t  26 + 1/16												
i	"playfile"	118.5	999	"06.wav"	0	;  t 30												
i	"playfile"	161.5	999	"07.wav"	0	; t 41												
i	"playfile"	212.5	999	"08.wav"	0	; t 53 4. löök												
i	"playfile"	274.5	999	"09.wav"	0	; t 70 (uus tempo)												
i	"playfile"	291.5	999	"10.wav"	0	; t 74 2. löök												
i	"playfile"	315.5	999	"11.wav"		;  t 81												
i	"playfile"	333.25	999	"12.wav"		; t 87												
i	"playfile"	340.5	999	"13.wav"		; t 90												
i	"playfile"	369	999	"14.wav"		;t 99												
i	"playfile"	406.25	999	"15.wav"		;t 111												
i	"playfile"	466.75	140.25	"16.wav"		; t 128 -  peab peatuma taktis 167												
i	"playfile"	575	32	"17.wav"		; t159 peab peatuma takti 167 alguses												
;i  	"playfile"	607	999	"18.wav"		;t 167 – see on vaikus, seda ei ole vaja												
i	"playfile"	617	999	"19.wav"		; t 168												
i	"playfile"	624.5	999	"20.wav"		; 8ndik enne 170												
i	"playfile"	637	999	"21.wav"		; 173												
i	"playfile"	642.75	999	"22.wav"		; t 174 2. löögi viimane 16ndik												
i	"playfile"	666	999	"23.wav"		; 180 2. löök												
i	"playfile"	711	999	"24.wav"		; t191 3. löök												
i	"playfile"	721	999	"25.wav"		; t 194 algus												
i	"playfile"	733	999	"26.wav"		;; t197												
i	"playfile"	738	999	"27.wav"		; 198 2. l												
i	"playfile"	746	999	"28.wav"		; t 200 2.												
i	"playfile"	752.75	999	"29.wav"		; t202 – 1/16												
i	"playfile"	762	999	"30.wav"		; t204 2. l												
i	"playfile"	770	999	"31.wav"		; t206 2												
i	"playfile"	781	999	"32.wav"		;timeless t 209 – pikk												
i	"playfile"	821	999	"33.wav"		; t219												
																		
																		
; NOTIFICATIONS																		
																		
i	"notification"	32	0	"A"	; t 8													
i	"notification"	64	0	"B"	;t 16													
i	"notification"	122.5	0	"C"	; t 31													
i	"notification"	189.5	0	"D"	; t48													
i	"notification"	253.5	0	"E"	; t64													
i	"notification"	319.5	0	"F"	;t82													
i	"notification"	369	0	"G"	; 99													
i	"notification"	406.25	0	"H"	;111													
i	"notification"	434.75	0	"I"	;119													
i	"notification"	489	0	"J"	;135													
i	"notification"	543	0	"K"	;151													
i	"notification"	579	0	"L"	;160													
i	"notification"	673	0	"M"	; 182													
i	"notification"	733	0	"N"	;197													
i	"notification"	821	0	"O"	;219													
i	"notification"	865	0	"P"	;230													
i	"notification"	913	0	"Q"	;242													
i	"notification"	1061	0	"R"	;279													
i	"notification"	1157	0	"end"	; löpp													
