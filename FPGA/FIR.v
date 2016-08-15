module myModule_tb(); 
    `timescale 1ns/1ns
    wire signed[15:0] d_out; //Final output
    reg reset;               //Reset - active high
    reg signed[15:0] x;      //16-bit conversion of generated wave
    reg valid;               //Valid signal - active high
    reg clk;                 //Standard clock
    wire [31:0] wave;        //32 bit output from DDS
    
    always begin
 #8 clk =!clk;               //125MHz clock
    reset = 0;
    x<=wave[15:0];           //Take lower 16 bits of wave (only these should be populated)
    valid = 1;               //Begin recording data
    $display (x,"   ",d_out);            //Prints given value to console
    end
     
    initial begin
 //Initialize clock and reset
 clk = 0;
 reset = 1;
     
 //End simulation
 #80000
 $finish;
    end
     
fir_filter fir_filter(d_out, x, clk, reset, valid);
    
wave_generator wave_generator(
    .aclk(clk),
    .m_axis_data_tdata(wave)
);    

endmodule



module fir_filter(d_out,x,clk,reset,valid); 
//output filtered signal
output signed[15:0] d_out;

//input signals
input signed [15:0] x;
input clk,reset,valid;

//Define 195 16-bit coefficients for FIR filter
wire signed[15:0] b[0:194];

//Coefficient to record number of stored values.
reg[7:0] coeff_add;

//Storage for coefficient multiplication results
reg signed [31:0] temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,
temp9,temp10,temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,
temp19,temp20,temp21,temp22,temp23,temp24,temp25,temp26,temp27,temp28,
temp29,temp30,temp31,temp32,temp33,temp34,temp35,temp36,temp37,temp38,
temp39,temp40,temp41,temp42,temp43,temp44,temp45,temp46,temp47,temp48,
temp49,temp50,temp51,temp52,temp53,temp54,temp55,temp56,temp57,temp58,
temp59,temp60,temp61,temp62,temp63,temp64,temp65,temp66,temp67,temp68,
temp69,temp70,temp71,temp72,temp73,temp74,temp75,temp76,temp77,temp78,
temp79,temp80,temp81,temp82,temp83,temp84,temp85,temp86,temp87,temp88,
temp89,temp90,temp91,temp92,temp93,temp94,temp95,temp96,temp97,temp98,
temp99,temp100,temp101,temp102,temp103,temp104,temp105,temp106,temp107,
temp108,temp109,temp110,temp111,temp112,temp113,temp114,temp115,temp116,
temp117,temp118,temp119,temp120,temp121,temp122,temp123,temp124,temp125,
temp126,temp127,temp128,temp129,temp130,temp131,temp132,temp133,temp134,
temp135,temp136,temp137,temp138,temp139,temp140,temp141,temp142,temp143,
temp144,temp145,temp146,temp147,temp148,temp149,temp150,temp151,temp152,
temp153,temp154,temp155,temp156,temp157,temp158,temp159,temp160,temp161,
temp162,temp163,temp164,temp165,temp166,temp167,temp168,temp169,temp170,
temp171,temp172,temp173,temp174,temp175,temp176,temp177,temp178,temp179,
temp180,temp181,temp182,temp183,temp184,temp185,temp186,temp187,temp188,
temp189,temp190,temp191,temp192,temp193,temp194;

//Store for sum
reg signed [15:0] y;

//Input buffer
reg signed [15:0] z0,z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,
z16,z17,z18,z19,z20,z21,z22,z23,z24,z25,z26,z27,z28,z29,z30,z31,z32,z33,z34,
z35,z36,z37,z38,z39,z40,z41,z42,z43,z44,z45,z46,z47,z48,z49,z50,z51,z52,z53,
z54,z55,z56,z57,z58,z59,z60,z61,z62,z63,z64,z65,z66,z67,z68,z69,z70,z71,z72,
z73,z74,z75,z76,z77,z78,z79,z80,z81,z82,z83,z84,z85,z86,z87,z88,z89,z90,z91,
z92,z93,z94,z95,z96,z97,z98,z99,z100,z101,z102,z103,z104,z105,z106,z107,z108,
z109,z110,z111,z112,z113,z114,z115,z116,z117,z118,z119,z120,z121,z122,z123,
z124,z125,z126,z127,z128,z129,z130,z131,z132,z133,z134,z135,z136,z137,z138,
z139,z140,z141,z142,z143,z144,z145,z146,z147,z148,z149,z150,z151,z152,z153,
z154,z155,z156,z157,z158,z159,z160,z161,z162,z163,z164,z165,z166,z167,z168,
z169,z170,z171,z172,z173,z174,z175,z176,z177,z178,z179,z180,z181,z182,z183,
z184,z185,z186,z187,z188,z189,z190,z191,z192,z193,z194;

//Set up FIR coefficients generated with SciPy
assign b[	0	]=16'h	0019	;
assign b[	1	]=16'h	0019	;
assign b[	2	]=16'h	0019	;
assign b[	3	]=16'h	001A	;
assign b[	4	]=16'h	001A	;
assign b[	5	]=16'h	001B	;
assign b[	6	]=16'h	001C	;
assign b[	7	]=16'h	001D	;
assign b[	8	]=16'h	001E	;
assign b[	9	]=16'h	001F	;
assign b[	10	]=16'h	0020	;
assign b[	11	]=16'h	0022	;
assign b[	12	]=16'h	0024	;
assign b[	13	]=16'h	0026	;
assign b[	14	]=16'h	0028	;
assign b[	15	]=16'h	002A	;
assign b[	16	]=16'h	002C	;
assign b[	17	]=16'h	002E	;
assign b[	18	]=16'h	0031	;
assign b[	19	]=16'h	0033	;
assign b[	20	]=16'h	0036	;
assign b[	21	]=16'h	0039	;
assign b[	22	]=16'h	003C	;
assign b[	23	]=16'h	003F	;
assign b[	24	]=16'h	0042	;
assign b[	25	]=16'h	0046	;
assign b[	26	]=16'h	0049	;
assign b[	27	]=16'h	004D	;
assign b[	28	]=16'h	0050	;
assign b[	29	]=16'h	0054	;
assign b[	30	]=16'h	0058	;
assign b[	31	]=16'h	005C	;
assign b[	32	]=16'h	0060	;
assign b[	33	]=16'h	0064	;
assign b[	34	]=16'h	0068	;
assign b[	35	]=16'h	006C	;
assign b[	36	]=16'h	0070	;
assign b[	37	]=16'h	0074	;
assign b[	38	]=16'h	0079	;
assign b[	39	]=16'h	007D	;
assign b[	40	]=16'h	0082	;
assign b[	41	]=16'h	0086	;
assign b[	42	]=16'h	008B	;
assign b[	43	]=16'h	008F	;
assign b[	44	]=16'h	0094	;
assign b[	45	]=16'h	0099	;
assign b[	46	]=16'h	009D	;
assign b[	47	]=16'h	00A2	;
assign b[	48	]=16'h	00A6	;
assign b[	49	]=16'h	00AB	;
assign b[	50	]=16'h	00B0	;
assign b[	51	]=16'h	00B4	;
assign b[	52	]=16'h	00B9	;
assign b[	53	]=16'h	00BE	;
assign b[	54	]=16'h	00C2	;
assign b[	55	]=16'h	00C7	;
assign b[	56	]=16'h	00CB	;
assign b[	57	]=16'h	00D0	;
assign b[	58	]=16'h	00D4	;
assign b[	59	]=16'h	00D9	;
assign b[	60	]=16'h	00DD	;
assign b[	61	]=16'h	00E1	;
assign b[	62	]=16'h	00E6	;
assign b[	63	]=16'h	00EA	;
assign b[	64	]=16'h	00EE	;
assign b[	65	]=16'h	00F2	;
assign b[	66	]=16'h	00F6	;
assign b[	67	]=16'h	00FA	;
assign b[	68	]=16'h	00FE	;
assign b[	69	]=16'h	0101	;
assign b[	70	]=16'h	0105	;
assign b[	71	]=16'h	0109	;
assign b[	72	]=16'h	010C	;
assign b[	73	]=16'h	010F	;
assign b[	74	]=16'h	0112	;
assign b[	75	]=16'h	0116	;
assign b[	76	]=16'h	0119	;
assign b[	77	]=16'h	011B	;
assign b[	78	]=16'h	011E	;
assign b[	79	]=16'h	0121	;
assign b[	80	]=16'h	0123	;
assign b[	81	]=16'h	0126	;
assign b[	82	]=16'h	0128	;
assign b[	83	]=16'h	012A	;
assign b[	84	]=16'h	012C	;
assign b[	85	]=16'h	012E	;
assign b[	86	]=16'h	0130	;
assign b[	87	]=16'h	0131	;
assign b[	88	]=16'h	0132	;
assign b[	89	]=16'h	0134	;
assign b[	90	]=16'h	0135	;
assign b[	91	]=16'h	0136	;
assign b[	92	]=16'h	0137	;
assign b[	93	]=16'h	0137	;
assign b[	94	]=16'h	0138	;
assign b[	95	]=16'h	0138	;
assign b[	96	]=16'h	0138	;
assign b[	97	]=16'h	0139	;
assign b[	98	]=16'h	0138	;
assign b[	99	]=16'h	0138	;
assign b[	100	]=16'h	0138	;
assign b[	101	]=16'h	0137	;
assign b[	102	]=16'h	0137	;
assign b[	103	]=16'h	0136	;
assign b[	104	]=16'h	0135	;
assign b[	105	]=16'h	0134	;
assign b[	106	]=16'h	0132	;
assign b[	107	]=16'h	0131	;
assign b[	108	]=16'h	0130	;
assign b[	109	]=16'h	012E	;
assign b[	110	]=16'h	012C	;
assign b[	111	]=16'h	012A	;
assign b[	112	]=16'h	0128	;
assign b[	113	]=16'h	0126	;
assign b[	114	]=16'h	0123	;
assign b[	115	]=16'h	0121	;
assign b[	116	]=16'h	011E	;
assign b[	117	]=16'h	011B	;
assign b[	118	]=16'h	0119	;
assign b[	119	]=16'h	0116	;
assign b[	120	]=16'h	0112	;
assign b[	121	]=16'h	010F	;
assign b[	122	]=16'h	010C	;
assign b[	123	]=16'h	0109	;
assign b[	124	]=16'h	0105	;
assign b[	125	]=16'h	0101	;
assign b[	126	]=16'h	00FE	;
assign b[	127	]=16'h	00FA	;
assign b[	128	]=16'h	00F6	;
assign b[	129	]=16'h	00F2	;
assign b[	130	]=16'h	00EE	;
assign b[	131	]=16'h	00EA	;
assign b[	132	]=16'h	00E6	;
assign b[	133	]=16'h	00E1	;
assign b[	134	]=16'h	00DD	;
assign b[	135	]=16'h	00D9	;
assign b[	136	]=16'h	00D4	;
assign b[	137	]=16'h	00D0	;
assign b[	138	]=16'h	00CB	;
assign b[	139	]=16'h	00C7	;
assign b[	140	]=16'h	00C2	;
assign b[	141	]=16'h	00BE	;
assign b[	142	]=16'h	00B9	;
assign b[	143	]=16'h	00B4	;
assign b[	144	]=16'h	00B0	;
assign b[	145	]=16'h	00AB	;
assign b[	146	]=16'h	00A6	;
assign b[	147	]=16'h	00A2	;
assign b[	148	]=16'h	009D	;
assign b[	149	]=16'h	0099	;
assign b[	150	]=16'h	0094	;
assign b[	151	]=16'h	008F	;
assign b[	152	]=16'h	008B	;
assign b[	153	]=16'h	0086	;
assign b[	154	]=16'h	0082	;
assign b[	155	]=16'h	007D	;
assign b[	156	]=16'h	0079	;
assign b[	157	]=16'h	0074	;
assign b[	158	]=16'h	0070	;
assign b[	159	]=16'h	006C	;
assign b[	160	]=16'h	0068	;
assign b[	161	]=16'h	0064	;
assign b[	162	]=16'h	0060	;
assign b[	163	]=16'h	005C	;
assign b[	164	]=16'h	0058	;
assign b[	165	]=16'h	0054	;
assign b[	166	]=16'h	0050	;
assign b[	167	]=16'h	004D	;
assign b[	168	]=16'h	0049	;
assign b[	169	]=16'h	0046	;
assign b[	170	]=16'h	0042	;
assign b[	171	]=16'h	003F	;
assign b[	172	]=16'h	003C	;
assign b[	173	]=16'h	0039	;
assign b[	174	]=16'h	0036	;
assign b[	175	]=16'h	0033	;
assign b[	176	]=16'h	0031	;
assign b[	177	]=16'h	002E	;
assign b[	178	]=16'h	002C	;
assign b[	179	]=16'h	002A	;
assign b[	180	]=16'h	0028	;
assign b[	181	]=16'h	0026	;
assign b[	182	]=16'h	0024	;
assign b[	183	]=16'h	0022	;
assign b[	184	]=16'h	0020	;
assign b[	185	]=16'h	001F	;
assign b[	186	]=16'h	001E	;
assign b[	187	]=16'h	001D	;
assign b[	188	]=16'h	001C	;
assign b[	189	]=16'h	001B	;
assign b[	190	]=16'h	001A	;
assign b[	191	]=16'h	001A	;
assign b[	192	]=16'h	0019	;
assign b[	193	]=16'h	0019	;
assign b[	194	]=16'h	0019	;

//Resets anbd runs counter
always @ (posedge clk)	
begin
if(reset)	
coeff_add<=8'd0; 
else if(coeff_add==8'd194)	
coeff_add<=8'd1;	
else if(valid)	
coeff_add<=coeff_add + 1'd1; 
end

//Reset and record data
always @ (posedge clk)	
begin	
if(reset)	
begin
temp0<=16'd0;temp1<=16'd0;temp2<=16'd0;temp3<=16'd0;temp4<=16'd0;
temp5<=16'd0;temp6<=16'd0;temp7<=16'd0;temp8<=16'd0;temp9<=16'd0;
temp10<=16'd0;temp11<=16'd0;temp12<=16'd0;temp13<=16'd0;temp14<=16'd0;
temp15<=16'd0;temp16<=16'd0;temp17<=16'd0;temp18<=16'd0;temp19<=16'd0;
temp20<=16'd0;temp21<=16'd0;temp22<=16'd0;temp23<=16'd0;temp24<=16'd0;
temp25<=16'd0;temp26<=16'd0;temp27<=16'd0;temp28<=16'd0;temp29<=16'd0;
temp30<=16'd0;temp31<=16'd0;temp32<=16'd0;temp33<=16'd0;temp34<=16'd0;
temp35<=16'd0;temp36<=16'd0;temp37<=16'd0;temp38<=16'd0;temp39<=16'd0;
temp40<=16'd0;temp41<=16'd0;temp42<=16'd0;temp43<=16'd0;temp44<=16'd0;
temp45<=16'd0;temp46<=16'd0;temp47<=16'd0;temp48<=16'd0;temp49<=16'd0;
temp50<=16'd0;temp51<=16'd0;temp52<=16'd0;temp53<=16'd0;temp54<=16'd0; 
temp55<=16'd0;temp56<=16'd0;temp57<=16'd0;temp58<=16'd0;temp59<=16'd0; 
temp60<=16'd0;temp61<=16'd0;temp62<=16'd0;temp63<=16'd0;temp64<=16'd0;
temp65<=16'd0;temp66<=16'd0;temp67<=16'd0;temp68<=16'd0;temp69<=16'd0;
temp70<=16'd0;temp71<=16'd0;temp72<=16'd0;temp73<=16'd0;temp74<=16'd0;
temp75<=16'd0;temp76<=16'd0;temp77<=16'd0;temp78<=16'd0;temp79<=16'd0; 
temp80<=16'd0;temp81<=16'd0;temp82<=16'd0;temp83<=16'd0;temp84<=16'd0;
temp85<=16'd0;temp86<=16'd0;temp87<=16'd0;temp88<=16'd0;temp89<=16'd0; 
temp90<=16'd0;temp91<=16'd0;temp92<=16'd0;temp93<=16'd0;temp94<=16'd0; 
temp95<=16'd0;temp96<=16'd0;temp97<=16'd0;temp98<=16'd0;temp99<=16'd0;
temp100<=16'd0;temp101<=16'd0;temp102<=16'd0;temp103<=16'd0;temp104<=16'd0;
temp105<=16'd0;temp106<=16'd0;temp107<=16'd0;temp108<=16'd0;temp109<=16'd0;
temp110<=16'd0;temp111<=16'd0;temp112<=16'd0;temp113<=16'd0;temp114<=16'd0;
temp115<=16'd0;temp116<=16'd0;temp117<=16'd0;temp118<=16'd0;temp119<=16'd0;
temp120<=16'd0;temp121<=16'd0;temp122<=16'd0;temp123<=16'd0;temp124<=16'd0;
temp125<=16'd0;temp126<=16'd0;temp127<=16'd0;temp128<=16'd0;temp129<=16'd0;
temp130<=16'd0;temp131<=16'd0;temp132<=16'd0;temp133<=16'd0;temp134<=16'd0;
temp135<=16'd0;temp136<=16'd0;temp137<=16'd0;temp138<=16'd0;temp139<=16'd0;
temp140<=16'd0;temp141<=16'd0;temp142<=16'd0;temp143<=16'd0;temp144<=16'd0;
temp145<=16'd0;temp146<=16'd0;temp147<=16'd0;temp148<=16'd0;temp149<=16'd0;
temp150<=16'd0;temp151<=16'd0;temp152<=16'd0;temp153<=16'd0;temp154<=16'd0;
temp155<=16'd0;temp156<=16'd0;temp157<=16'd0;temp158<=16'd0;temp159<=16'd0;
temp160<=16'd0;temp161<=16'd0;temp162<=16'd0;temp163<=16'd0;temp164<=16'd0;
temp165<=16'd0;temp166<=16'd0;temp167<=16'd0;temp168<=16'd0;temp169<=16'd0;
temp170<=16'd0;temp171<=16'd0;temp172<=16'd0;temp173<=16'd0;temp174<=16'd0;
temp175<=16'd0;temp176<=16'd0;temp177<=16'd0;temp178<=16'd0;temp179<=16'd0;
temp180<=16'd0;temp181<=16'd0;temp182<=16'd0;temp183<=16'd0;temp184<=16'd0;
temp185<=16'd0;temp186<=16'd0;temp187<=16'd0;temp188<=16'd0;temp189<=16'd0;
temp190<=16'd0;temp191<=16'd0;temp192<=16'd0;temp193<=16'd0;temp194<=16'd0;

y<=16'd0;	//reset y

//reset stored values
z0<=16'd0;z1<=16'd0;z2<=16'd0;z3<=16'd0;z4<=16'd0;z5<=16'd0;
z6<=16'd0;z7<=16'd0;z8<=16'd0;z9<=16'd0;z10<=16'd0;z11<=16'd0;
z12<=16'd0;z13<=16'd0;z14<=16'd0;z15<=16'd0;z16<=16'd0;z17<=16'd0;
z18<=16'd0;z19<=16'd0;z20<=16'd0;z21<=16'd0;z22<=16'd0;z23<=16'd0;
z24<=16'd0;z25<=16'd0;z26<=16'd0;z27<=16'd0;z28<=16'd0;z29<=16'd0;
z30<=16'd0;z31<=16'd0;z32<=16'd0;z33<=16'd0;z34<=16'd0;z35<=16'd0;
z36<=16'd0;z37<=16'd0;z38<=16'd0;z39<=16'd0;z40<=16'd0;z41<=16'd0;
z42<=16'd0;z43<=16'd0;z44<=16'd0;z45<=16'd0;z46<=16'd0;z47<=16'd0;
z48<=16'd0;z49<=16'd0;z50<=16'd0;z51<=16'd0;z52<=16'd0;z53<=16'd0;z54<=16'd0; 
z55<=16'd0;z56<=16'd0;z57<=16'd0;z58<=16'd0;z59<=16'd0; 
z60<=16'd0;z61<=16'd0;z62<=16'd0;z63<=16'd0;z64<=16'd0;
z65<=16'd0;z66<=16'd0;z67<=16'd0;z68<=16'd0;z69<=16'd0;
z70<=16'd0;z71<=16'd0;z72<=16'd0;z73<=16'd0;z74<=16'd0;
z75<=16'd0;z76<=16'd0;z77<=16'd0;z78<=16'd0;z79<=16'd0; 
z80<=16'd0;z81<=16'd0;z82<=16'd0;z83<=16'd0;z84<=16'd0;
z85<=16'd0;z86<=16'd0;z87<=16'd0;z88<=16'd0;z89<=16'd0; 
z90<=16'd0;z91<=16'd0;z92<=16'd0;z93<=16'd0;z94<=16'd0; 
z95<=16'd0;z96<=16'd0;z97<=16'd0;z98<=16'd0;z99<=16'd0;
z100<=16'd0;z101<=16'd0;z102<=16'd0;z103<=16'd0;z104<=16'd0;
z105<=16'd0;z106<=16'd0;z107<=16'd0;z108<=16'd0;z109<=16'd0;
z110<=16'd0;z111<=16'd0;z112<=16'd0;z113<=16'd0;z114<=16'd0;
z115<=16'd0;z116<=16'd0;z117<=16'd0;z118<=16'd0;z119<=16'd0;
z120<=16'd0;z121<=16'd0;z122<=16'd0;z123<=16'd0;z124<=16'd0;
z125<=16'd0;z126<=16'd0;z127<=16'd0;z128<=16'd0;z129<=16'd0;
z130<=16'd0;z131<=16'd0;z132<=16'd0;z133<=16'd0;z134<=16'd0;
z135<=16'd0;z136<=16'd0;z137<=16'd0;z138<=16'd0;z139<=16'd0;
z140<=16'd0;z141<=16'd0;z142<=16'd0;z143<=16'd0;z144<=16'd0;
z145<=16'd0;z146<=16'd0;z147<=16'd0;z148<=16'd0;z149<=16'd0;
z150<=16'd0;z151<=16'd0;z152<=16'd0;z153<=16'd0;z154<=16'd0;
z155<=16'd0;z156<=16'd0;z157<=16'd0;z158<=16'd0;z159<=16'd0;
z160<=16'd0;z161<=16'd0;z162<=16'd0;z163<=16'd0;z164<=16'd0;
z165<=16'd0;z166<=16'd0;z167<=16'd0;z168<=16'd0;z169<=16'd0;
z170<=16'd0;z171<=16'd0;z172<=16'd0;z173<=16'd0;z174<=16'd0;
z175<=16'd0;z176<=16'd0;z177<=16'd0;z178<=16'd0;z179<=16'd0;
z180<=16'd0;z181<=16'd0;z182<=16'd0;z183<=16'd0;z184<=16'd0;
z185<=16'd0;z186<=16'd0;z187<=16'd0;z188<=16'd0;z189<=16'd0;
z190<=16'd0;z191<=16'd0;z192<=16'd0;z193<=16'd0;z194<=16'd0;
end

//Move data through buffer on each cycle
else if(valid)	
begin	
z0<=x;z1<=z0;z2<=z1;z3<=z2;z4<=z3;z5<=z4;z6<=z5;
z7<=z6;z8<=z7;z9<=z8;z10<=z9;z11<=z10;z12<=z11;
z13<=z12;z14<=z13;z15<=z14;z16<=z15;z17<=z16;
z18<=z17;z19<=z18;z20<=z19;z21<=z20;z22<=z21;
z23<=z22;z24<=z23;z25<=z24;z26<=z25;z27<=z26;
z28<=z27;z29<=z28;z30<=z29;z31<=z30;z32<=z31;
z33<=z32;z34<=z33;z35<=z34;z36<=z35;z37<=z36;
z38<=z37;z39<=z38;z40<=z39;z41<=z40;z42<=z41;
z43<=z42;z44<=z43;z45<=z44;z46<=z45;z47<=z46;
z48<=z47;z49<=z48;z50<=z49;z50<=z49;z51<=z50;
z52<=z51;z53<=z52;z54<=z53;z55<=z54;z56<=z55;
z57<=z56;z58<=z57;z59<=z58;z60<=z59;z61<=z60;
z62<=z61;z63<=z62;z64<=z63;z65<=z64;z66<=z65;
z67<=z66;z68<=z67;z69<=z68;z70<=z69;z71<=z70;
z72<=z71;z73<=z72;z74<=z73;z75<=z74;z76<=z75;
z77<=z76;z78<=z77;z79<=z78;z80<=z79;z81<=z80;
z82<=z81;z83<=z82;z84<=z83;z85<=z84;z86<=z85;
z87<=z86;z88<=z87;z89<=z88;z90<=z89;z91<=z90;
z92<=z91;z93<=z92;z94<=z93;z95<=z94;z96<=z95;
z97<=z96;z98<=z97;z99<=z98;z100<=z99;z101<=z100;
z102<=z101;z103<=z102;z104<=z103;z105<=z104;
z106<=z105;z107<=z106;z108<=z107;z109<=z108;
z110<=z109;z111<=z110;z112<=z111;z113<=z112;
z114<=z113;z115<=z114;z116<=z115;z117<=z116;
z118<=z117;z119<=z118;z120<=z119;z121<=z120;
z122<=z121;z123<=z122;z124<=z123;z125<=z124;
z126<=z125;z127<=z126;z128<=z127;z129<=z128;
z130<=z129;z131<=z130;z132<=z131;z133<=z132;
z134<=z133;z135<=z134;z136<=z135;z137<=z136;
z138<=z137;z139<=z138;z140<=z139;z141<=z140;
z142<=z141;z143<=z142;z144<=z143;z145<=z144;
z146<=z145;z147<=z146;z148<=z147;z149<=z148;
z150<=z149;z151<=z150;z152<=z151;z153<=z152;
z154<=z153;z155<=z154;z156<=z155;z157<=z156;
z158<=z157;z159<=z158;z160<=z159;z161<=z160;
z162<=z161;z163<=z162;z164<=z163;z165<=z164;
z166<=z165;z167<=z166;z168<=z167;z169<=z168;
z170<=z169;z171<=z170;z172<=z171;z173<=z172;
z174<=z173;z175<=z174;z176<=z175;z177<=z176;
z178<=z177;z179<=z178;z180<=z179;z181<=z180;
z182<=z181;z183<=z182;z184<=z183;z185<=z184;
z186<=z185;z187<=z186;z188<=z187;z189<=z188;
z190<=z189;z191<=z190;z192<=z191;z193<=z192;
z194<=z193;

//Do multiplications
temp0<=z0 * b[0]; 
temp1<=z1 * b[1]; 
temp2<=z2 * b[2]; 
temp3<=z3 * b[3]; 
temp4<=z4 * b[4]; 
temp5<=z5 * b[5]; 
temp6<=z6 * b[6];
temp7<=z7 * b[7]; 
temp8<=z8 * b[8];
temp9<=z9 * b[9];	
temp10<=z10 * b[10]; 
temp11<=z11 * b[11]; 
temp12<=z12 * b[12]; 
temp13<=z13 * b[13]; 
temp14<=z14 * b[14]; 
temp15<=z15 * b[15]; 
temp16<=z16 * b[16]; 
temp17<=z17 * b[17]; 
temp18<=z18 * b[18]; 
temp19<=z19 * b[19]; 
temp20<=z20 * b[20]; 
temp21<=z21 * b[21]; 
temp22<=z22 * b[22]; 
temp23<=z23 * b[23]; 
temp24<=z24 * b[24]; 
temp25<=z25 * b[25]; 
temp26<=z26 * b[26]; 
temp27<=z27 * b[27]; 
temp28<=z28 * b[28]; 
temp29<=z29 * b[29]; 
temp30<=z30 * b[30]; 
temp31<=z31 * b[31]; 
temp32<=z32 * b[32]; 
temp33<=z33 * b[33]; 
temp34<=z34 * b[34]; 
temp35<=z35 * b[35]; 
temp36<=z36 * b[36]; 
temp37<=z37 * b[37]; 
temp38<=z38 * b[38]; 
temp39<=z39 * b[39]; 
temp40<=z40 * b[40]; 
temp41<=z41 * b[41]; 
temp42<=z42 * b[42]; 
temp43<=z43 * b[43]; 
temp44<=z44 * b[44]; 
temp45<=z45 * b[45]; 
temp46<=z46 * b[46]; 
temp47<=z47 * b[47]; 
temp48<=z48 * b[48]; 
temp49<=z49 * b[49]; 
temp50<=z50 * b[50];
temp51<=z51	* b[51];
temp52<=z52	* b[52];
temp53<=z53	* b[53];
temp54<=z54	* b[54];
temp55<=z55	* b[55];
temp56<=z56	* b[56];
temp57<=z57	* b[57];
temp58<=z58	* b[58];
temp59<=z59	* b[59];
temp60<=z60	* b[60];
temp61<=z61	* b[61];
temp62<=z62	* b[62];
temp63<=z63	* b[63];
temp64<=z64	* b[64];
temp65<=z65	* b[65];
temp66<=z66	* b[66];
temp67<=z67	* b[67];
temp68<=z68	* b[68];
temp69<=z69	* b[69];
temp70<=z70	* b[70];
temp71<=z71	* b[71];
temp72<=z72	* b[72];
temp73<=z73	* b[73];
temp74<=z74	* b[74];
temp75<=z75	* b[75];
temp76<=z76	* b[76];
temp77<=z77	* b[77];
temp78<=z78	* b[78];
temp79<=z79	* b[79];
temp80<=z80	* b[80];
temp81<=z81	* b[81];
temp82<=z82	* b[82];
temp83<=z83	* b[83];
temp84<=z84	* b[84];
temp85<=z85	* b[85];
temp86<=z86	* b[86];
temp87<=z87	* b[87];
temp88<=z88	* b[88];
temp89<=z89	* b[89];
temp90<=z90	* b[90];
temp91<=z91	* b[91];
temp92<=z92	* b[92];
temp93<=z93	* b[93];
temp94<=z94	* b[94];
temp95<=z95	* b[95];
temp96<=z96	* b[96];
temp97<=z97	* b[97];
temp98<=z98	* b[98];
temp99<=z99	* b[99];
temp100<=z100 * b[100];
temp101<=z101 *	b[101];
temp102<=z102 *	b[102];
temp103<=z103 *	b[103];
temp104<=z104 *	b[104];
temp105<=z105 *	b[105];
temp106<=z106 *	b[106];
temp107<=z107 *	b[107];
temp108<=z108 *	b[108];
temp109<=z109 *	b[109];
temp110<=z110 *	b[110];
temp111<=z111 *	b[111];
temp112<=z112 *	b[112];
temp113<=z113 *	b[113];
temp114<=z114 *	b[114];
temp115<=z115 *	b[115];
temp116<=z116 *	b[116];
temp117<=z117 *	b[117];
temp118<=z118 *	b[118];
temp119<=z119 *	b[119];
temp120<=z120 *	b[120];
temp121<=z121 *	b[121];
temp122<=z122 *	b[122];
temp123<=z123 *	b[123];
temp124<=z124 *	b[124];
temp125<=z125 *	b[125];
temp126<=z126 *	b[126];
temp127<=z127 *	b[127];
temp128<=z128 *	b[128];
temp129<=z129 *	b[129];
temp130<=z130 *	b[130];
temp131<=z131 *	b[131];
temp132<=z132 *	b[132];
temp133<=z133 *	b[133];
temp134<=z134 *	b[134];
temp135<=z135 *	b[135];
temp136<=z136 *	b[136];
temp137<=z137 *	b[137];
temp138<=z138 *	b[138];
temp139<=z139 *	b[139];
temp140<=z140 *	b[140];
temp141<=z141 *	b[141];
temp142<=z142 *	b[142];
temp143<=z143 *	b[143];
temp144<=z144 *	b[144];
temp145<=z145 *	b[145];
temp146<=z146 *	b[146];
temp147<=z147 *	b[147];
temp148<=z148 *	b[148];
temp149<=z149 *	b[149];
temp150<=z150 *	b[150];
temp151<=z151 *	b[151];
temp152<=z152 *	b[152];
temp153<=z153 *	b[153];
temp154<=z154 *	b[154];
temp155<=z155 *	b[155];
temp156<=z156 *	b[156];
temp157<=z157 *	b[157];
temp158<=z158 *	b[158];
temp159<=z159 *	b[159];
temp160<=z160 *	b[160];
temp161<=z161 *	b[161];
temp162<=z162 *	b[162];
temp163<=z163 *	b[163];
temp164<=z164 *	b[164];
temp165<=z165 *	b[165];
temp166<=z166 *	b[166];
temp167<=z167 *	b[167];
temp168<=z168 *	b[168];
temp169<=z169 *	b[169];
temp170<=z170 *	b[170];
temp171<=z171 *	b[171];
temp172<=z172 *	b[172];
temp173<=z173 *	b[173];
temp174<=z174 *	b[174];
temp175<=z175 *	b[175];
temp176<=z176 *	b[176];
temp177<=z177 *	b[177];
temp178<=z178 *	b[178];
temp179<=z179 *	b[179];
temp180<=z180 *	b[180];
temp181<=z181 *	b[181];
temp182<=z182 *	b[182];
temp183<=z183 *	b[183];
temp184<=z184 *	b[184];
temp185<=z185 *	b[185];
temp186<=z186 *	b[186];
temp187<=z187 *	b[187];
temp188<=z188 *	b[188];
temp189<=z189 *	b[189];
temp190<=z190 *	b[190];
temp191<=z191 *	b[191];
temp192<=z192 *	b[192];
temp193<=z193 *	b[193];
temp194<=z194 *	b[194];

//Do sum
y<= temp0[30:15] + temp1[30:15] + temp2[30:15] +temp3[30:15] + temp4[30:15] + temp5 [30:15] + temp6[30:15] + temp7[30:15] + 
temp8[30:15] + temp9[30:15] + temp10 [30:15] + temp11[30:15] + temp12[30:15] + temp13[30:15] + temp14[30:15] + temp15 [30:15] +
temp16[30:15] + temp17[30:15] + temp18[30:15] + temp19[30:15] + temp20 [30:15] + temp21[30:15] + temp22[30:15] + temp23[30:15] +
temp24[30:15] + temp25 [30:15] + temp26[30:15] + temp27[30:15] + temp28[30:15] + temp29[30:15] + temp30 [30:15] + temp31[30:15] +
temp32[30:15] +temp33[30:15] + temp34[30:15] + temp35 [30:15] + temp36[30:15] + temp37[30:15] + temp38[30:15] + temp39[30:15] +
temp40 [30:15] + temp41 [30:15] + temp42[30:15] + temp43[30:15] + temp44[30:15] + temp45 [30:15] + temp46[30:15] + temp47[30:15] +
temp48[30:15] + temp49[30:15] + temp50[30:15] + temp51[30:15] + temp52 [30:15] + temp53[30:15] + temp54[30:15] + temp55[30:15]
 + temp56[30:15] + temp57[30:15] + temp58[30:15] + temp59[30:15] + temp60[30:15] + temp61[30:15] + temp62[30:15] + temp63[30:15]
 + temp64[30:15] + temp65[30:15] + temp66[30:15] + temp67[30:15] + temp68[30:15] + temp69[30:15] + temp70[30:15] + temp71[30:15]
 + temp72[30:15] + temp73[30:15] + temp74[30:15] + temp75[30:15] + temp76[30:15] + temp77[30:15] + temp78[30:15] + temp79[30:15]
 + temp80[30:15] + temp81[30:15] + temp82[30:15] + temp83[30:15] + temp84[30:15] + temp85[30:15] + temp86[30:15] + temp87[30:15]
 + temp88[30:15] + temp89[30:15] + temp90[30:15] + temp91[30:15] + temp92[30:15] + temp93[30:15] + temp94[30:15] + temp95[30:15]
 + temp96[30:15] + temp97[30:15] + temp98[30:15] + temp99[30:15] + temp100[30:15] + temp101[30:15] + temp102[30:15] + temp103[30:15]
 + temp104[30:15] + temp105[30:15] + temp106[30:15] + temp107[30:15] + temp108[30:15] + temp109[30:15] + temp110[30:15] + temp111[30:15]
 + temp112[30:15] + temp113[30:15] + temp114[30:15] + temp115[30:15] + temp116[30:15] + temp117[30:15] + temp118[30:15] + temp119[30:15]
 + temp120[30:15] + temp121[30:15] + temp122[30:15] + temp123[30:15] + temp124[30:15] + temp125[30:15] + temp126[30:15] + temp127[30:15]
 + temp128[30:15] + temp129[30:15] + temp130[30:15] + temp131[30:15] + temp132[30:15] + temp133[30:15] + temp134[30:15] + temp135[30:15]
 + temp136[30:15] + temp137[30:15] + temp138[30:15] + temp139[30:15] + temp140[30:15] + temp141[30:15] + temp142[30:15] + temp143[30:15]
 + temp144[30:15] + temp145[30:15] + temp146[30:15] + temp147[30:15] + temp148[30:15] + temp149[30:15] + temp150[30:15] + temp151[30:15]
 + temp152[30:15] + temp153[30:15] + temp154[30:15] + temp155[30:15] + temp156[30:15] + temp157[30:15] + temp158[30:15] + temp159[30:15]
 + temp160[30:15] + temp161[30:15] + temp162[30:15] + temp163[30:15] + temp164[30:15] + temp165[30:15] + temp166[30:15] + temp167[30:15]
 + temp168[30:15] + temp169[30:15] + temp170[30:15] + temp171[30:15] + temp172[30:15] + temp173[30:15] + temp174[30:15] + temp175[30:15]
 + temp176[30:15] + temp177[30:15] + temp178[30:15] + temp179[30:15] + temp180[30:15] + temp181[30:15] + temp182[30:15] + temp183[30:15]
 + temp184[30:15] + temp185[30:15] + temp186[30:15] + temp187[30:15] + temp188[30:15] + temp189[30:15] + temp190[30:15] + temp191[30:15]
 + temp192[30:15] + temp193[30:15] + temp194[30:15]; 
end	
end	

assign d_out=y;	//Set output to sum
endmodule