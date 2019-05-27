; vClick score template												
												
												
;count-down 												
												
												
#define TUTTI  #0#												
#define TEMPO60 #52#												
#define TEMPO1 #[56/60*$TEMPO60]#												
#define REPTEMPO #$TEMPO1# ; REPTEMPO for setting tempo for countdown (if starts from section in another tempo)												
#define TEMPO92 #[92/60 * $TEMPO60 ] #												
#define TEMPO120 #[110/60 * $TEMPO60 ] #												
#define TEMPO84 #[84/60 * $TEMPO60 ] #												
#define TEMPO52 #[52/60 * $TEMPO60 ] #												
#define TEMPO44 #[44/60 * $TEMPO60 ] #												
#define TEMPO66 #[66/60 * $TEMPO60 ] #												
#define TEMPO88 #[88/60 * $TEMPO60 ] #												
#define TEMPO115 #[100/60 * $TEMPO60 ] #												
#define TEMPO130 #[120/60 * $TEMPO60 ] #												
#define TEMPO80 #[80/60 * $TEMPO60 ] #												
#define TEMPO92 #[92/60 * $TEMPO60 ] #												
#define TEMPO48 #[48/60 * $TEMPO60 ] #												
#define TEMPO54 #[54/60 * $TEMPO60 ] #												
#define TEMPO70 #[70/60 * $TEMPO60 ] #												
#define TEMPO82 #[82/60 * $TEMPO60 ] #												
#define TEMPO76 #[76/60 * $TEMPO60 ] #												
#define TEMPO100 #[100/60 * $TEMPO60 ] #												
#define TEMPO69 #[69/60 * $TEMPO60 ] #												
#define TEMPO58 #[58/60 * $TEMPO60 ] #												
#define TEMPO63 #[63/60 * $TEMPO60 ] #												
#define TEMPO63 #[63/60 * $TEMPO60 ] #												
#define TEMPO50 #[50/60 * $TEMPO60 ] #												
#define TEMPO40 #[40/60 * $TEMPO60 ] #												
#define TEMPO68 #[68/60 * $TEMPO60 ] #												
												
t 0 $REPTEMPO												
i 1 0 0 $REPTEMPO 0												
i "countdown" 0 4 4 $TUTTI			; four click in four beats									
i "notification" 3 1  "READY"			; notification									
												
s												
												
												
t	0	$TEMPO1	46	$TEMPO1	46	$TEMPO92	57	$TEMPO92	57	$TEMPO120	\	
	85.25	$TEMPO120	88.25	$TEMPO92	147.75	$TEMPO92	152.75	$TEMPO84	152.75	$TEMPO92	\	
	161.75	$TEMPO92	169.75	$TEMPO52	173.75	$TEMPO52	173.75	$TEMPO44	236.75	$TEMPO44	\	
	238.75	$TEMPO60	243.75	$TEMPO60	243.75	$TEMPO44	\					
			251.75	$TEMPO44	251.75	$TEMPO60	255.75	$TEMPO60	255.75	$TEMPO66	\	
	257.75	$TEMPO66	263.5	$TEMPO88	268.5	$TEMPO88	268.5	$TEMPO115	284.5	$TEMPO115	\	
	284.5	$TEMPO130										
	296.5	$TEMPO130	296.5	$TEMPO120	300.5	$TEMPO120	300.5	$TEMPO80	408.5	$TEMPO80	\	
	408.5	$TEMPO92	489.25	$TEMPO92	501.25	$TEMPO52	508.25	$TEMPO52	508.25	$TEMPO44	\	
	559.25	$TEMPO44	559.25	$TEMPO48	563.25	$TEMPO48	563.25	$TEMPO54	567.25	$TEMPO54	\	;S
	567.25	$TEMPO60	569.25	$TEMPO60	569.25	$TEMPO70	573.25	$TEMPO70	573.25	$TEMPO82	\	
	576.25	$TEMPO82	576.25	$TEMPO92	581.25	$TEMPO92	587.25	$TEMPO60			\	
	609.25	$TEMPO60	609.25	$TEMPO69	613.75	$TEMPO69	\					
	613.75	$TEMPO76	616.75	$TEMPO76	616.75	$TEMPO84	622.75	$TEMPO84	624.75	$TEMPO60	\	
	627.75	$TEMPO60	627.75	$TEMPO66	631.75	$TEMPO66	631.75	$TEMPO76	635.75	$TEMPO92	\	
	639.75	$TEMPO92	639.75	$TEMPO100	643.75	$TEMPO100	643.75	$TEMPO115			\	
	653.75	$TEMPO115	653.75	$TEMPO100	658.75	$TEMPO100	658.75	$TEMPO92 	663.416666666667	$TEMPO92 	\	;e
	663.416666666667	$TEMPO80	671.416666666667	$TEMPO80	674.416666666667	$TEMPO60 	692.416666666667	$TEMPO60	695.416666666667	$TEMPO52	\	
	714.166666666667	$TEMPO52	714.166666666667	$TEMPO58	718.666666666667	$TEMPO58	718.666666666667	$TEMPO63	748.166666666667	$TEMPO63	\	; r
	752.666666666667	$TEMPO76	759.666666666667	$TEMPO76	759.666666666667	$TEMPO68	763.666666666667	$TEMPO68	763.666666666667	$TEMPO58	\	
	768.666666666667	$TEMPO58	768.666666666667	$TEMPO50	775.666666666667	$TEMPO50	775.666666666667	$TEMPO40	784.666666666667	$TEMPO40	\	
	784.666666666667	$TEMPO92										
												
												
												
												
												
												
												
i 	1	0	0	$TEMPO1	0	0	; set the tempo					
i 	1	46	0	$TEMPO92	0	0						
i 	1	57	0	$TEMPO120	0	0						
i 	1	85.25	3	$TEMPO120	$TEMPO92	3						
i 	1	88.25	0	$TEMPO92	0	0						
i 	1	147.75	5	$TEMPO92	$TEMPO84	5						
i 	1	152.75	0	$TEMPO84	0	0						
i 	1	161.75	8	$TEMPO92	$TEMPO52	8						
i 	1	169.75	0	$TEMPO52	0	0						
i 	1	152.75	0	$TEMPO92	0	0						
i 	1	173.75	0	$TEMPO44	0	0						
i 	1	236.75	2	$TEMPO44	$TEMPO60	2						
i 	1	238.75	0	$TEMPO60	0	0						
i 	1	243.75	0	$TEMPO44	0	0						
i 	1	251.75	0	$TEMPO60	0	0						
i 	1	255.75	0	$TEMPO66	0	0						
i 	1	257.75	5.75	$TEMPO66	$TEMPO88	5.75						
i 	1	263.5	0	$TEMPO88	0	0						
i 	1	268.5	0	$TEMPO115	0	0						
i 	1	284.5	0	$TEMPO130	0	0						
i 	1	296.5	0	$TEMPO120	0	0						
i 	1	300.5	0	$TEMPO80	0	0						
i 	1	408.5	0	$TEMPO92	0	0						
i 	1	489.25	12	$TEMPO92	$TEMPO52	12						
i 	1	501.25	0	$TEMPO52	0	0						
i 	1	508.25	0	$TEMPO44	0	0						
i 	1	559.25	0	$TEMPO48	0	0						
i 	1	563.25	0	$TEMPO54	0	0						
i 	1	567.25	0	$TEMPO60	0	0						
i 	1	569.25	0	$TEMPO70	0	0						
i 	1	573.25	0	$TEMPO82	0	0						
i 	1	576.25	0	$TEMPO92	0	0						
i 	1	581.25	6	$TEMPO92	$TEMPO60	6						
i 	1	587.25	0	$TEMPO60	0	0						
i 	1	609.25	0	$TEMPO69	0	0						
i 	1	613.75	0	$TEMPO76	0	0						
i 	1	616.75	0	$TEMPO84	0	0						
i 	1	622.75	2	$TEMPO84	$TEMPO60	2						
i 	1	624.75	0	$TEMPO60	0	0						
i 	1	627.75	0	$TEMPO66	0	0						
i 	1	631.75	4	$TEMPO76	$TEMPO92	4						
i 	1	635.75	0	$TEMPO92	0	0						
i 	1	639.75	0	$TEMPO100	0	0						
i 	1	643.75	0	$TEMPO115	0	0						
i 	1	653.75	0	$TEMPO100	0	0						
i 	1	643.75	0	$TEMPO115	0	0						
i 	1	653.75	0	$TEMPO100	0	0						
i 	1	658.75	0	$TEMPO92 	0	0						
i 	1	663.416666666667	0	$TEMPO80	0	0						
i 	1	671.416666666667	3	$TEMPO80	$TEMPO60 	3						
i 	1	692.416666666667	3	$TEMPO60 	$TEMPO52	3						
i 	1	695.416666666667	0	$TEMPO52	0	0						
i 	1	714.166666666667	0	$TEMPO58	0	0						
i 	1	718.666666666667	0	$TEMPO63	0	0						
i 	1	748.166666666667	4.5	$TEMPO63	$TEMPO76	4.5						
i 	1	752.666666666667	0	$TEMPO76	0	0						
i 	1	759.666666666667	0	$TEMPO68	0	0						
i 	1	763.666666666667	0	$TEMPO58	0	0						
i 	1	768.666666666667	0	$TEMPO50	0	0						
i 	1	775.666666666667	0	$TEMPO40	0	0						
i 	1	784.666666666667	0	$TEMPO92	0	0						
												
												
												
;ADVANCE		; do not change by hand!										
; a 0 0.01 < beats>												
												
; times bar by bar				19								
;i	instrnr	start	duration	number of beats	part of the whole note	subdivision	bar number	instruments				
i	2	0	1	1	4	0	1	$TUTTI	;H			
i	2	1	10	10	4	0	2	$TUTTI	; 10/4 for fermata			
i	2	11	3	3	4	0	3	$TUTTI				
i	2	14	3	3	4	0	4	$TUTTI				
i	2	17	3	3	4	0	5	$TUTTI				
i	2	20	4	4	4	0	6	$TUTTI				
i	2	24	3	3	4	0	7	$TUTTI				
i	2	27	4	4	4	0	8	$TUTTI				
i	2	31	3	3	4	0	9	$TUTTI				
i	2	34	4	4	4	0	10	$TUTTI	; 4/4 for fermata			
i	2	38	2	2	4	0	11	$TUTTI				
i	2	40	3	3	4	0	12	$TUTTI				
i	2	43	3	3	4	0	13	$TUTTI	; tempo92, kirjas nagu algaks selle takti viimases löögist			
i	2	46	2	2	4	0	14	$TUTTI				
i	2	48	3	3	4	0	15	$TUTTI				
i	2	51	2	2	4	0	16	$TUTTI				
i	2	53	2	2	4	0	17	$TUTTI				
i	2	55	2	2	4	0	18	$TUTTI				
i	2	57	3	3	4	0	19	$TUTTI	; tempo120			
i	2	60	2	2	4	0	20	$TUTTI	;a			
i	2	62	2	2	4	0	21	$TUTTI				
i	2	64	1	1	4	0	22	$TUTTI	;2 + 0.25 lööki			
i	2	65	1.25	1	3.2	0	-22.2	$TUTTI	;  duration of 5/16			
i	2	66.25	1	1	4	0	23	$TUTTI	; 1 + 3/4			
i	2	67.25	0.75	1	5.33333333333333	0	-23.2	$TUTTI				
i	2	68	2	2	4	0	24	$TUTTI				
i	2	70	2	2	4	0	25	$TUTTI				
i	2	72	1	1	4	0	26	$TUTTI	;2 +1/4			
i	2	73	1.25	1	3.2	0	-26.2	$TUTTI				
i	2	74.25	2	2	4	0	27	$TUTTI				
i	2	76.25	3	3	4	0	28	$TUTTI				
i	2	79.25	3	3	4	0	29	$TUTTI				
i	2	82.25	3	3	4	0	30	$TUTTI				
i	2	85.25	3	3	4	0	31	$TUTTI	; rall to 92 2nd beat -  no, next bar			
i	2	88.25	2	2	4	0	32	$TUTTI	;h ; tempo 92 from here			
i	2	90.25	3	3	4	0	33	$TUTTI				
i	2	93.25	3	3	4	0	34	$TUTTI				
i	2	96.25	4	4	4	0	35	$TUTTI				
i	2	100.25	4	4	4	0	36	$TUTTI				
i	2	104.25	4	4	4	0	37	$TUTTI				
i	2	108.25	4	4	4	0	38	$TUTTI				
i	2	112.25	4	4	4	0	39	$TUTTI				
i	2	116.25	0.75	1	5.33333333333333	0	40	$TUTTI	; 3/4 + 1			
i	2	117	1	1	4	0	-40.2	$TUTTI				
i	2	118	4	4	4	0	41	$TUTTI				
i	2	122	3	4	4	0	42	$TUTTI				
i	2	125	2	4	4	0	43	$TUTTI				
i	2	127	4	4	4	0	44	$TUTTI				
i	2	131	4	4	4	0	45	$TUTTI				
i	2	135	2	2	4	0	46	$TUTTI				
i	2	137	2	2	4	0	47	$TUTTI	; 2 + 3/4			
i	2	139	0.75	1	5.33333333333333	0	-47.3	$TUTTI				
i	2	139.75	4	4	4	0	48	$TUTTI				
i	2	143.75	4	4	4	0	49	$TUTTI				
i	2	147.75	2	2	4	0	50	$TUTTI	; poco rall (to 84?)			
i	2	149.75	3	3	4	0	51	$TUTTI				
i	2	152.75	4	4	4	0	52	$TUTTI	; tempo92 tagasi			
i	2	156.75	2	2	4	0	53	$TUTTI				
i	2	158.75	3	3	4	0	54	$TUTTI				
i	2	161.75	3	3	4	0	55	$TUTTI	; rall			
i	2	164.75	4	4	4	0	56	$TUTTI				
i	2	168.75	5	5	4	0	57	$TUTTI	; to 52 2nd beat			
i	2	173.75	3	3	4	0	58	$TUTTI	; n; tempo44			
i	2	176.75	3	3	4	0	59	$TUTTI				
i	2	179.75	5	5	4	0	60	$TUTTI	; 5/4 fermata			
i	2	184.75	5	5	4	0	61	$TUTTI	; 5/4 fermata			
i	2	189.75	4	4	4	0	62	$TUTTI				
i	2	193.75	6	6	4	0	63	$TUTTI				
i	2	199.75	4	4	4	0	64	$TUTTI	; 4/4 for fermata			
i	2	203.75	5	5	4	0	65	$TUTTI				
i	2	208.75	3	3	4	0	66	$TUTTI				
i	2	211.75	2	2	4	0	67	$TUTTI				
i	2	213.75	5	5	4	0	68	$TUTTI	; 5/4 fermata			
i	2	218.75	3	3	4	0	69	$TUTTI				
i	2	221.75	4	4	4	0	70	$TUTTI				
i	2	225.75	4	4	4	0	71	$TUTTI				
i	2	229.75	3	3	4	0	72	$TUTTI	; 3/4 fermata			
i	2	232.75	3	3	4	0	73	$TUTTI				
i	2	235.75	3	3	4	0	74	$TUTTI	; acc from 2nd beat			
i	2	238.75	3	3	4	0	75	$TUTTI	; tempo60			
i	2	241.75	2	2	4	0	76	$TUTTI				
i	2	243.75	4	4	4	0	77	$TUTTI	; tempo44			
i	2	247.75	4	4	4	0	78	$TUTTI				
i	2	251.75	4	4	4	0	79	$TUTTI	; tempo60			
i	2	255.75	3	3	4	0	80	$TUTTI	; tempo66 ; acc 3. löögist			
i	2	258.75	2	2	4	0	81	$TUTTI				
i	2	260.75	2	2	4	0	82	$TUTTI	; 2 + 3/4			
i	2	262.75	0.75	1	5.33333333333333	0	-82.3	$TUTTI				
i	2	263.5	3	3	4	0	83	$TUTTI	; tempo88			
i	2	266.5	2	2	4	0	84	$TUTTI				
i	2	268.5	2	2	4	0	85	$TUTTI	; l tempo 115			
i	2	270.5	2	2	4	0	86	$TUTTI	; 3+ 1/2			
i	2	272.5	1.5	1	2.66666666666667	0	-86.3	$TUTTI				
i	2	274	2	2	4	0	87	$TUTTI				
i	2	276	2	2	4	0	88	$TUTTI				
i	2	278	2	2	4	0	89	$TUTTI	; 3+ 1/2			
i	2	280	1.5	1	2.66666666666667	0	-89.3	$TUTTI				
i	2	281.5	3	3	4	0	90	$TUTTI				
i	2	284.5	2	2	4	0	91	$TUTTI	; tempo130			
i	2	286.5	2	2	4	0	92	$TUTTI				
i	2	288.5	3	3	4	0	93	$TUTTI				
i	2	291.5	3	3	4	0	94	$TUTTI				
i	2	294.5	2	2	4	0	95	$TUTTI				
i	2	296.5	2	2	4	0	96	$TUTTI	; tempo120			
i	2	298.5	2	2	4	0	97	$TUTTI				
i	2	300.5	2	2	4	0	98	$TUTTI	; tempo80			
i	2	302.5	2	2	4	0	99	$TUTTI				
i	2	304.5	3	3	4	0	100	$TUTTI				
i	2	307.5	2	2	4	0	101	$TUTTI				
i	2	309.5	3	3	4	0	102	$TUTTI				
i	2	312.5	3	3	4	0	103	$TUTTI				
i	2	315.5	2	2	4	0	104	$TUTTI				
i	2	317.5	3	3	4	0	105	$TUTTI				
i	2	320.5	2	2	4	0	106	$TUTTI	; 3 + 1/2			
i	2	322.5	1.5	1	2.66666666666667	0	-106.3	$TUTTI				
i	2	324	3	3	4	0	107	$TUTTI				
i	2	327	3	3	4	0	108	$TUTTI				
i	2	330	4	4	4	0	109	$TUTTI				
i	2	334	1	1	4	0	110	$TUTTI	; 2 +1/2			
i	2	335	1.5	1	2.66666666666667	0	-110.2	$TUTTI				
i	2	336.5	4	4	4	0	111	$TUTTI	; O 			
i	2	340.5	2	2	4	0	112	$TUTTI	; 3 + 1/2			
i	2	342.5	1.5	1	2.66666666666667	0	-112.3	$TUTTI				
i	2	344	4	4	4	0	113	$TUTTI				
i	2	348	3	3	4	0	114	$TUTTI				
i	2	351	3	3	4	0	115	$TUTTI				
i	2	354	3	3	4	0	116	$TUTTI				
i	2	357	2	2	4	0	117	$TUTTI				
i	2	359	2	2	4	0	118	$TUTTI				
i	2	361	3	3	4	0	119	$TUTTI				
i	2	364	3	3	4	0	120	$TUTTI				
i	2	367	2	2	4	0	121	$TUTTI	; 3 + ½			
i	2	369	1.5	1	2.66666666666667	0	-121.3	$TUTTI				
i	2	370.5	2	2	4	0	122	$TUTTI				
i	2	372.5	3	3	4	0	123	$TUTTI				
i	2	375.5	4	4	4	0	124	$TUTTI				
i	2	379.5	4	4	4	0	125	$TUTTI				
i	2	383.5	3	3	4	0	126	$TUTTI				
i	2	386.5	3	3	4	0	127	$TUTTI				
i	2	389.5	3	3	4	0	128	$TUTTI				
i	2	392.5	3	3	4	0	129	$TUTTI				
i	2	395.5	3	3	4	0	130	$TUTTI				
i	2	398.5	3	3	4	0	131	$TUTTI				
i	2	401.5	3	3	4	0	132	$TUTTI				
i	2	404.5	4	4	4	0	133	$TUTTI				
i	2	408.5	4	4	4	0	134	$TUTTI	; tempo92			
i	2	412.5	3	3	4	0	135	$TUTTI				
i	2	415.5	4	4	4	0	136	$TUTTI				
i	2	419.5	3	3	4	0	137	$TUTTI				
i	2	422.5	3	3	4	0	138	$TUTTI				
i	2	425.5	2	2	4	0	139	$TUTTI				
i	2	427.5	1	1	4	0	140	$TUTTI	; 2 + ½			
i	2	428.5	1.5	1	2.66666666666667	0	-140.2	$TUTTI				
i	2	430	2	2	4	0	141	$TUTTI				
i	2	432	3	3	4	0	142	$TUTTI				
i	2	435	3	3	4	0	143	$TUTTI				
i	2	438	3	3	4	0	144	$TUTTI				
i	2	441	3	3	4	0	145	$TUTTI		149		
i	2	444	2	2	4	0	146	$TUTTI	; 2 + ¾			
i	2	446	0.75	1	5.33333333333333	0	-146.3	$TUTTI				
i	2	446.75	4	4	4	0	147	$TUTTI				
i	2	450.75	4	4	4	0	148	$TUTTI				
i	2	454.75	4	4	4	0	149	$TUTTI				
i	2	458.75	5	5	4	0	150	$TUTTI				
i	2	463.75	2	2	4	0	151	$TUTTI				
i	2	465.75	2	2	4	0	152	$TUTTI	; 3+ ½			
i	2	467.75	1.5	1	2.66666666666667	0	-152.3	$TUTTI				
i	2	469.25	3	3	4	0	153	$TUTTI				
i	2	472.25	4	4	4	0	154	$TUTTI				
i	2	476.25	3	3	4	0	155	$TUTTI				
i	2	479.25	3	3	4	0	156	$TUTTI				
i	2	482.25	3	3	4	0	157	$TUTTI				
i	2	485.25	3	3	4	0	158	$TUTTI				
i	2	488.25	4	4	4	0	159	$TUTTI	; rall from 2nd beat			
i	2	492.25	3	3	4	0	160	$TUTTI				
i	2	495.25	3	3	4	0	161	$TUTTI				
i	2	498.25	3	3	4	0	162	$TUTTI				
i	2	501.25	3	3	4	0	163	$TUTTI	; fino tempo 52			
i	2	504.25	4	4	4	0	164	$TUTTI				
i	2	508.25	4	4	4	0	165	$TUTTI	; S tempo 44			
i	2	512.25	2	2	4	0	166	$TUTTI				
i	2	514.25	4	4	4	0	167	$TUTTI	; fermaat 4/4			
i	2	518.25	3	3	4	0	168	$TUTTI	; fermaat 3/4			
i	2	521.25	4	4	4	0	169	$TUTTI				
i	2	525.25	4	4	4	0	170	$TUTTI				
i	2	529.25	4	4	4	0	171	$TUTTI				
i	2	533.25	2	2	4	0	172	$TUTTI	; fermaat 2/4			
i	2	535.25	5	5	4	0	173	$TUTTI				
i	2	540.25	4	4	4	0	174	$TUTTI				
i	2	544.25	4	4	4	0	175	$TUTTI				
i	2	548.25	2	2	4	0	176	$TUTTI				
i	2	550.25	2	2	4	0	177	$TUTTI				
i	2	552.25	2	2	4	0	178	$TUTTI				
i	2	554.25	3	3	4	0	179	$TUTTI				
i	2	557.25	2	2	4	0	180	$TUTTI	; fermaat 2/4			
i	2	559.25	4	4	4	0	181	$TUTTI	; tempo 48			
i	2	563.25	4	4	4	0	182	$TUTTI	; tempo54			
i	2	567.25	2	2	4	0	183	$TUTTI	;tempo60			
i	2	569.25	4	4	4	0	184	$TUTTI	;tempo70			
i	2	573.25	3	3	4	0	185	$TUTTI	;tempo82			
i	2	576.25	2	2	4	0	186	$TUTTI	;tempo92			
i	2	578.25	3	3	4	0	187	$TUTTI				
i	2	581.25	3	3	4	0	188	$TUTTI	;rall			
i	2	584.25	3	3	4	0	189	$TUTTI				
i	2	587.25	3	3	4	0	190	$TUTTI	;fino tempo60			
i	2	590.25	4	4	4	0	191	$TUTTI				
i	2	594.25	2	2	4	0	192	$TUTTI	;fermaat 2/4			
i	2	596.25	3	3	4	0	193	$TUTTI				
i	2	599.25	3	3	4	0	194	$TUTTI				
i	2	602.25	3	3	4	0	195	$TUTTI				
i	2	605.25	4	4	4	0	196	$TUTTI				
i	2	609.25	3	3	4	0	197	$TUTTI	; tempo 69; 4 + ½			
i	2	612.25	1.5	1	2.66666666666667	0	-197.4	$TUTTI				
i	2	613.75	3	3	4	0	198	$TUTTI	;tempo76			
i	2	616.75	3	3	4	0	199	$TUTTI	;tempo84			
i	2	619.75	2	2	4	0	200	$TUTTI				
i	2	621.75	3	3	4	0	201	$TUTTI	; rall 2. löögist			
i	2	624.75	3	3	4	0	202	$TUTTI	;tempo60			
i	2	627.75	4	4	4	0	203	$TUTTI	;tempo66			
i	2	631.75	4	4	4	0	204	$TUTTI	;tempo76; acceler 2. löögist			
i	2	635.75	4	4	4	0	205	$TUTTI	; fino tempo92			
i	2	639.75	4	4	4	0	206	$TUTTI	;tempo100			
i	2	643.75	2	2	4	0	207	$TUTTI	; e tempo115			
i	2	645.75	1	1	4	0	208	$TUTTI	; 2 + ½			
i	2	646.75	1.5	1	2.66666666666667	0	-208.2	$TUTTI				
i	2	648.25	2	2	4	0	209	$TUTTI				
i	2	650.25	2	2	4	0	210	$TUTTI	; 3 + ½			
i	2	652.25	1.5	1	2.66666666666667	0	-210.3	$TUTTI				
i	2	653.75	3	3	4	0	211	$TUTTI	; tempo100			
i	2	656.75	2	2	4	0	212	$TUTTI				
i	2	658.75	2	2	4	0	213	$TUTTI	;tempo92			
i	2	660.75	2	2	4	0	214	$TUTTI	; 2 + 2/3			
i	2	662.75	0.666666666666667	1	6	0	-214.3	$TUTTI				
i	2	663.416666666667	4	4	4	0	215	$TUTTI	;tempo80			
i	2	667.416666666667	4	4	4	0	216	$TUTTI				
i	2	671.416666666667	3	3	4	0	217	$TUTTI	; rall			
i	2	674.416666666667	3	3	4	0	218	$TUTTI	; fino tempo60			
i	2	677.416666666667	3	3	4	0	219	$TUTTI				
i	2	680.416666666667	3	3	4	0	220	$TUTTI				
i	2	683.416666666667	3	3	4	0	221	$TUTTI				
i	2	686.416666666667	3	3	4	0	222	$TUTTI				
i	2	689.416666666667	3	3	4	0	223	$TUTTI				
i	2	692.416666666667	3	3	4	2	224	$TUTTI	; 4 + ½ ; rall			
i	2	695.416666666667	1.5	1	2.66666666666667	3	-224.4	$TUTTI	;fino tempo52			
i	2	696.916666666667	1	1	4	2	225	$TUTTI	;r 2 + ¼			
i	2	697.916666666667	1.25	1	3.2	0	-225.2	$TUTTI				
i	2	699.166666666667	3	3	4	2	226	$TUTTI				
i	2	702.166666666667	2	2	4	2	227	$TUTTI	; 2 + ¾			
i	2	704.166666666667	0.75	1	5.33333333333333	0	-227.3	$TUTTI				
i	2	704.916666666667	2	2	4	2	228	$TUTTI				
i	2	706.916666666667	1.5	1	2.66666666666667	3	229	$TUTTI	; ½ + 3			
i	2	708.416666666667	2	2	4	2	-229.2	$TUTTI				
i	2	710.416666666667	1.25	1	3.2	0	230	$TUTTI	; 5/4  			
i	2	711.666666666667	1.5	1	2.66666666666667	3	231	$TUTTI	; ½ +2			
i	2	713.166666666667	1	1	4	2	-231.2	$TUTTI				
i	2	714.166666666667	3	3	4	2	232	$TUTTI	; tempo58			
i	2	717.166666666667	1.5	1	2.66666666666667	3	233	$TUTTI	;3/2			
i	2	718.666666666667	3	3	4	0	234	$TUTTI	; tempo 63 ; tegelikult acc 2. löögiks			
i	2	721.666666666667	3	3	4	0	235	$TUTTI				
i	2	724.666666666667	1.5	1	2.66666666666667	0	236	$TUTTI	; 1 + ½ + 1 (3 + 2)			
i	2	726.166666666667	1	1	4	0	-236.2	$TUTTI				
i	2	727.166666666667	3	3	4	0	237	$TUTTI				
i	2	730.166666666667	3	3	4	0	238	$TUTTI				
i	2	733.166666666667	1.5	1	2.66666666666667	0	239	$TUTTI	; ½ + 1			
i	2	734.666666666667	3	3	4	0	240	$TUTTI				
i	2	737.666666666667	2	2	4	0	241	$TUTTI				
i	2	739.666666666667	1.5	1	2.66666666666667	0	-241.3	$TUTTI	; 3 + ½			
i	2	741.166666666667	3	3	4	0	242	$TUTTI				
i	2	744.166666666667	3	3	4	0	243	$TUTTI				
i	2	747.166666666667	1.5	1	2.66666666666667	0	244	$TUTTI	; ½ +2 ; acc 2. löögist			
i	2	748.666666666667	1	1	4	0	-244.2	$TUTTI				
i	2	749.666666666667	3	3	4	0	245	$TUTTI				
i	2	752.666666666667	3	3	4	0	246	$TUTTI	; fino tempo76			
i	2	755.666666666667	2	2	4	0	247	$TUTTI				
i	2	757.666666666667	2	2	4	0	248	$TUTTI				
i	2	759.666666666667	2	2	4	0	249	$TUTTI	; tempo68			
i	2	761.666666666667	2	2	4	0	250	$TUTTI				
i	2	763.666666666667	2	2	4	0	251	$TUTTI	; tempo58			
i	2	765.666666666667	3	3	4	0	252	$TUTTI				
i	2	768.666666666667	3	3	4	0	253	$TUTTI	; tempo50			
i	2	771.666666666667	4	4	4	0	254	$TUTTI				
i	2	775.666666666667	4	4	4	0	255	$TUTTI	; tempo40			
i	2	779.666666666667	5	5	4	0	256	$TUTTI				
i	2	784.666666666667	4	4	4	0	257	$TUTTI	; fermaat 244			
i	2	788.666666666667	3	3	4	0	258	$TUTTI	; tempo96			
i	2	791.666666666667	3	3	4	0	259	$TUTTI				
i	2	794.666666666667	3	3	4	0	260	$TUTTI				
i	2	797.666666666667	4	3	4	0	261	$TUTTI				
i	2	801.666666666667	6	4	4	0	262	$TUTTI	; fermaat 6/4			
												
												
												
												
												
												
												
												
; NOTIFICATIONS												
												
i	"notification"	0.05	2	"H"								
i	"notification"	60	2	"a"								
i	"notification"	88.25	2	"h"								
i	"notification"	268.5	2	"l"								
i	"notification"	336.5	2	"O"								
i	"notification"	508.25	2	"S"								
i	"notification"	643.75	2	"e"								
