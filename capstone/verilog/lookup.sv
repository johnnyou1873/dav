module lookup_table_array (
    input  wire [2:0] addr,
    output wire [7:0] data
);
    reg [7:0] lut [0:7];

    initial begin
        lut[0] = 11'b010010110000;
        lut[1] = 11'b0100110;
        lut[2] = 11'b110;
        lut[3] = 11'b0100101;
        lut[4] = 11'b111;
        lut[5] = 11'b0100100;
        lut[6] = 11'b1100;
        lut[7] = 11'b0100111;
        lut[8] = 11'b11;
        lut[9] = 11'b0100011000;
        lut[10] = 11'b0100011;
        lut[11] = 11'b01;
        lut[12] = 11'b1101;
        lut[13] = 11'b0100001;
        lut[14] = 11'b010;
        lut[15] = 11'b0100010;
        lut[16] = 11'b011;
        lut[17] = 11'b0101000;
        lut[18] = 11'b010100000;
        lut[19] = 11'b011101;
        lut[20] = 11'b0110;
        lut[21] = 11'b0101;
        lut[22] = 11'b0100;
        lut[23] = 11'b011110;
        lut[24] = 11'b011111;
        lut[25] = 11'b0100000;
        lut[26] = 11'b11001;
        lut[27] = 11'b11000;
        lut[28] = 11'b1111;
        lut[29] = 11'b0111;
        lut[30] = 11'b011010;
        lut[31] = 11'b1110;
        lut[32] = 11'b01101001;
        lut[33] = 11'b01010000;
        lut[34] = 11'b011011;
        lut[35] = 11'b010011011;
        lut[36] = 11'b010011111;
        lut[37] = 11'b01110;
        lut[38] = 11'b010111;
        lut[39] = 11'b01111;
        lut[40] = 11'b010110;
        lut[41] = 11'b010101;
        lut[42] = 11'b01010;
        lut[43] = 11'b01011;
        lut[44] = 11'b011001;
        lut[45] = 11'b01001;
        lut[46] = 11'b011100;
        lut[47] = 11'b011000;
        lut[48] = 11'b010100;
        lut[49] = 11'b010000;
        lut[50] = 11'b010001;
        lut[51] = 11'b01101;
        lut[52] = 11'b01100;
        lut[53] = 11'b010010;
        lut[54] = 11'b010011;
        lut[55] = 11'b010011101;
        lut[56] = 11'b01111001;
        lut[57] = 11'b01000;
        lut[58] = 11'b0101001;
        lut[59] = 11'b01100101;
        lut[60] = 11'b01000001;
        lut[61] = 11'b01001100;
        lut[62] = 11'b01000000;
        lut[63] = 11'b0110110;
        lut[64] = 11'b01011101;
        lut[65] = 11'b01010001;
        lut[66] = 11'b01111000;
        lut[67] = 11'b0110101;
        lut[68] = 11'b01000011;
        lut[69] = 11'b01001110;
        lut[70] = 11'b01011010;
        lut[71] = 11'b01000110;
        lut[72] = 11'b010010100;
        lut[73] = 11'b0110100;
        lut[74] = 11'b01000010;
        lut[75] = 11'b0110001;
        lut[76] = 11'b01110111;
        lut[77] = 11'b01101110;
        lut[78] = 11'b01001101;
        lut[79] = 11'b0110011;
        lut[80] = 11'b01011100;
        lut[81] = 11'b0110000;
        lut[82] = 11'b01000111;
        lut[83] = 11'b01010111;
        lut[84] = 11'b010100001;
        lut[85] = 11'b0110111;
        lut[86] = 11'b01011011;
        lut[87] = 11'b0110010;
        lut[88] = 11'b01101101;
        lut[89] = 11'b01001111;
        lut[90] = 11'b011111000;
        lut[91] = 11'b0101111;
        lut[92] = 11'b01010010;
        lut[93] = 11'b01011000;
        lut[94] = 11'b01010110;
        lut[95] = 11'b01010100;
        lut[96] = 11'b01001000;
        lut[97] = 11'b01101111;
        lut[98] = 11'b01101000;
        lut[99] = 11'b01110000;
        lut[100] = 11'b01110101;
        lut[101] = 11'b0101010;
        lut[102] = 11'b0111111;
        lut[103] = 11'b0111000;
        lut[104] = 11'b01000101;
        lut[105] = 11'b01101100;
        lut[106] = 11'b0111010;
        lut[107] = 11'b01001001;
        lut[108] = 11'b0101101;
        lut[109] = 11'b010101010;
        lut[110] = 11'b010010101;
        lut[111] = 11'b010000001;
        lut[112] = 11'b010101011;
        lut[113] = 11'b0101011;
        lut[114] = 11'b011101111;
        lut[115] = 11'b01011110;
        lut[116] = 11'b01010011;
        lut[117] = 11'b010011001;
        lut[118] = 11'b010100100;
        lut[119] = 11'b01100100;
        lut[120] = 11'b011001000;
        lut[121] = 11'b0101100;
        lut[122] = 11'b01110110;
        lut[123] = 11'b0101110;
        lut[124] = 11'b010010001;
        lut[125] = 11'b010010111;
        lut[126] = 11'b01010101;
        lut[127] = 11'b01100010;
        lut[128] = 11'b010100101;
        lut[129] = 11'b01011111;
        lut[130] = 11'b010010000;
        lut[131] = 11'b010110000;
        lut[132] = 11'b010010010;
        lut[133] = 11'b0101011111;
        lut[134] = 11'b01100000;
        lut[135] = 11'b010011110;
        lut[136] = 11'b0100011001;
        lut[137] = 11'b010110110;
        lut[138] = 11'b01110010;
        lut[139] = 11'b011000001;
        lut[140] = 11'b01100111;
        lut[141] = 11'b0100010000;
        lut[142] = 11'b01000100;
        lut[143] = 11'b01100110;
        lut[144] = 11'b011000101;
        lut[145] = 11'b01001011;
        lut[146] = 11'b010001011;
        lut[147] = 11'b01001010;
        lut[148] = 11'b01111101;
        lut[149] = 11'b010010011;
        lut[150] = 11'b010000010;
        lut[151] = 11'b010111111;
        lut[152] = 11'b011000011;
        lut[153] = 11'b01011001;
        lut[154] = 11'b011011010;
        lut[155] = 11'b01100001;
        lut[156] = 11'b011000110;
        lut[157] = 11'b0100010010;
        lut[158] = 11'b01111011;
        lut[159] = 11'b010001100;
        lut[160] = 11'b0100010100;
        lut[161] = 11'b011001001;
        lut[162] = 11'b01101010;
        lut[163] = 11'b011000000;
        lut[164] = 11'b01101011;
        lut[165] = 11'b0111101;
        lut[166] = 11'b01110001;
        lut[167] = 11'b011000010;
        lut[168] = 11'b01110100;
        lut[169] = 11'b011000111;
        lut[170] = 11'b010011100;
        lut[171] = 11'b010010110;
        lut[172] = 11'b0111011;
        lut[173] = 11'b01111110;
        lut[174] = 11'b0111110;
        lut[175] = 11'b011001010;
        lut[176] = 11'b010001111;
        lut[177] = 11'b011101100;
        lut[178] = 11'b010001010;
        lut[179] = 11'b0101010100;
        lut[180] = 11'b010100111;
        lut[181] = 11'b010111101;
        lut[182] = 11'b01000001000;
        lut[183] = 11'b011001101;
        lut[184] = 11'b010101001;
        lut[185] = 11'b0111100;
        lut[186] = 11'b011010111;
        lut[187] = 11'b011100110;
        lut[188] = 11'b010001110;
        lut[189] = 11'b0100000010;
        lut[190] = 11'b0101101111;
        lut[191] = 11'b0110000101;
        lut[192] = 11'b0101010001;
        lut[193] = 11'b0101010110;
        lut[194] = 11'b011100111;
        lut[195] = 11'b010000111;
        lut[196] = 11'b0101000100;
        lut[197] = 11'b0100001000;
        lut[198] = 11'b010001001;
        lut[199] = 11'b010101000;
        lut[200] = 11'b011110001;
        lut[201] = 11'b0110100111;
        lut[202] = 11'b010111000;
        lut[203] = 11'b0100001110;
        lut[204] = 11'b011010001;
        lut[205] = 11'b010000011;
        lut[206] = 11'b0100101100;
        lut[207] = 11'b0100100000;
        lut[208] = 11'b011011101;
        lut[209] = 11'b0101000101;
        lut[210] = 11'b011101110;
        lut[211] = 11'b010110100;
        lut[212] = 11'b0101001001;
        lut[213] = 11'b0100001100;
        lut[214] = 11'b0101000001;
        lut[215] = 11'b0100011111;
        lut[216] = 11'b01010110111;
        lut[217] = 11'b0100101001;
        lut[218] = 11'b01010010100;
        lut[219] = 11'b0101111111;
        lut[220] = 11'b01000101100;
        lut[221] = 11'b010111100;
        lut[222] = 11'b0101100100;
        lut[223] = 11'b01011101001;
        lut[224] = 11'b01001101010;
        lut[225] = 11'b0110001010;
        lut[226] = 11'b01100110000;
        lut[227] = 11'b011101010;
        lut[228] = 11'b011110000;
        lut[229] = 11'b01001001101;
        lut[230] = 11'b0110100011;
        lut[231] = 11'b0110100100;
        lut[232] = 11'b0111001;
        lut[233] = 11'b0101101001;
        lut[234] = 11'b010000101;
        lut[235] = 11'b0100101000;
        lut[236] = 11'b010111001;
        lut[237] = 11'b0110001011;
        lut[238] = 11'b0100001111;
        lut[239] = 11'b011010110;
        lut[240] = 11'b0100000000;
        lut[241] = 11'b0100110010;
        lut[242] = 11'b011100011;
        lut[243] = 11'b010000000;
        lut[244] = 11'b011000100;
        lut[245] = 11'b0101101010;
        lut[246] = 11'b011110110;
        lut[247] = 11'b01001010011;
        lut[248] = 11'b011001011;
        lut[249] = 11'b011010101;
        lut[250] = 11'b11010;
        lut[251] = 11'b01111010;
        lut[252] = 11'b110100;
        lut[253] = 11'b110011;
        lut[254] = 11'b11100;
        lut[255] = 11'b11011;
        lut[256] = 11'b11111;
        lut[257] = 11'b110010;
        lut[258] = 11'b110110;
        lut[259] = 11'b11101;
        lut[260] = 11'b11110;
        lut[261] = 11'b0100110011;
        lut[262] = 11'b110000;
        lut[263] = 11'b01110110110;
        lut[264] = 11'b010010011101;
        lut[265] = 11'b010000100101;
        lut[266] = 11'b01110101100;
        lut[267] = 11'b01101011010;
        lut[268] = 11'b01011100010;
        lut[269] = 11'b0100101010;
        lut[270] = 11'b01000011010;
        lut[271] = 11'b0101111011;
        lut[272] = 11'b0111001001;
        lut[273] = 11'b0111001011;
        lut[274] = 11'b0101111010;
        lut[275] = 11'b0111110100;
        lut[276] = 11'b0101010000;
        lut[277] = 11'b01001000100;
        lut[278] = 11'b0100100111;
        lut[279] = 11'b01001101100;
        lut[280] = 11'b01010010101;
        lut[281] = 11'b01111111;
        lut[282] = 11'b010110001;
        lut[283] = 11'b01011000000;
        lut[284] = 11'b01010010011;
        lut[285] = 11'b01001101011;
        lut[286] = 11'b011011001;
        lut[287] = 11'b01000011100;
        lut[288] = 11'b0111001100;
        lut[289] = 11'b0101111001;
        lut[290] = 11'b0110100010;
        lut[291] = 11'b0101010010;
        lut[292] = 11'b0111110000;
        lut[293] = 11'b0100101011;
        lut[294] = 11'b01000011000;
        lut[295] = 11'b0111110010;
        lut[296] = 11'b0111110001;
        lut[297] = 11'b0101010011;
        lut[298] = 11'b0111001000;
        lut[299] = 11'b0110000001;
        lut[300] = 11'b0110100000;
        lut[301] = 11'b0101111101;
        lut[302] = 11'b0110011111;
        lut[303] = 11'b0110100110;
        lut[304] = 11'b0101110110;
        lut[305] = 11'b0111010001;
        lut[306] = 11'b0101001111;
        lut[307] = 11'b0111001101;
        lut[308] = 11'b0111001110;
        lut[309] = 11'b1100110;
        lut[310] = 11'b110111;
        lut[311] = 11'b110001;
        lut[312] = 11'b111011;
        lut[313] = 11'b111100;
        lut[314] = 11'b111101;
        lut[315] = 11'b111110;
        lut[316] = 11'b1100000;
        lut[317] = 11'b1100011;
        lut[318] = 11'b1100000000;
        lut[319] = 11'b0100101101;
        lut[320] = 11'b010100010;
        lut[321] = 11'b0100111000;
        lut[322] = 11'b110101;
        lut[323] = 11'b011100000;
        lut[324] = 11'b0100111010;
        lut[325] = 11'b1100100;
        lut[326] = 11'b1100101;
        lut[327] = 11'b010100011;
        lut[328] = 11'b011010011;
        lut[329] = 11'b0100100110;
        lut[330] = 11'b01110011;
        lut[331] = 11'b0101001110;
        lut[332] = 11'b011110101;
        lut[333] = 11'b0100000001;
        lut[334] = 11'b0110111101;
        lut[335] = 11'b0110010101;
        lut[336] = 11'b010011010;
        lut[337] = 11'b01111100;
        lut[338] = 11'b011001100;
        lut[339] = 11'b01100011;
        lut[340] = 11'b011100100;
        lut[341] = 11'b010101101;
        lut[342] = 11'b010110011;
        lut[343] = 11'b0100001011;
        lut[344] = 11'b010001101;
        lut[345] = 11'b011100010;
        lut[346] = 11'b0100010001;
        lut[347] = 11'b011011000;
        lut[348] = 11'b010011000;
        lut[349] = 11'b011011110;
        lut[350] = 11'b010101110;
        lut[351] = 11'b0101011011;
        lut[352] = 11'b011011011;
        lut[353] = 11'b011100001;
        lut[354] = 11'b0101001101;
        lut[355] = 11'b0100101111;
        lut[356] = 11'b010000100;
        lut[357] = 11'b010110111;
        lut[358] = 11'b011101011;
        lut[359] = 11'b010111011;
        lut[360] = 11'b010101111;
        lut[361] = 11'b011011111;
        lut[362] = 11'b010111010;
        lut[363] = 11'b011011100;
        lut[364] = 11'b0110011011;
        lut[365] = 11'b0100110111;
        lut[366] = 11'b0110001000;
        lut[367] = 11'b010111110;
        lut[368] = 11'b0111000011;
        lut[369] = 11'b0110110100;
        lut[370] = 11'b0111000100;
        lut[371] = 11'b010000110;
        lut[372] = 11'b0100000110;
        lut[373] = 11'b0111101101;
        lut[374] = 11'b0101111110;
        lut[375] = 11'b011111011;
        lut[376] = 11'b0101011110;
        lut[377] = 11'b0110000000;
        lut[378] = 11'b0111000001;
        lut[379] = 11'b011110011;
        lut[380] = 11'b010100110;
        lut[381] = 11'b011110111;
        lut[382] = 11'b0110010011;
        lut[383] = 11'b0100110101;
        lut[384] = 11'b011001110;
        lut[385] = 11'b0100111110;
        lut[386] = 11'b0100000011;
        lut[387] = 11'b011001111;
        lut[388] = 11'b011010100;
        lut[389] = 11'b0110000111;
        lut[390] = 11'b0101011100;
        lut[391] = 11'b0101011101;
        lut[392] = 11'b0100101110;
        lut[393] = 11'b011101101;
        lut[394] = 11'b0101010101;
        lut[395] = 11'b011111110;
        lut[396] = 11'b0111000111;
        lut[397] = 11'b01000111101;
        lut[398] = 11'b0100000101;
        lut[399] = 11'b0110011101;
        lut[400] = 11'b0111001111;
        lut[401] = 11'b0101110101;
        lut[402] = 11'b0111110110;
        lut[403] = 11'b111001;
        lut[404] = 11'b111010;
        lut[405] = 11'b1100001;
        lut[406] = 11'b1100111;
        lut[407] = 11'b1100010;
        lut[408] = 11'b0101000000;
        lut[409] = 11'b01100110011;
        lut[410] = 11'b01110000000;
        lut[411] = 11'b01111010010;
        lut[412] = 11'b01111110111;
        lut[413] = 11'b010000011011;
        lut[414] = 11'b010001000010;
        lut[415] = 11'b01111110101;
        lut[416] = 11'b01101111011;
        lut[417] = 11'b01001011111;
        lut[418] = 11'b01000011111;
        lut[419] = 11'b0111101100;
        lut[420] = 11'b01000100001;
        lut[421] = 11'b0111111010;
        lut[422] = 11'b0110100001;
        lut[423] = 11'b0110101010;
        lut[424] = 11'b0110000011;
        lut[425] = 11'b0100110100;
        lut[426] = 11'b0101110011;
        lut[427] = 11'b0101100011;
        lut[428] = 11'b0101110001;
        lut[429] = 11'b0101110000;
        lut[430] = 11'b0101001000;
        lut[431] = 11'b0101000111;
        lut[432] = 11'b0101101110;
        lut[433] = 11'b0101000110;
        lut[434] = 11'b0110001100;
        lut[435] = 11'b011010000;
        lut[436] = 11'b011010010;
        lut[437] = 11'b010101100;
        lut[438] = 11'b0100010011;
        lut[439] = 11'b010001000;
        lut[440] = 11'b010110010;
        lut[441] = 11'b0100110000;
        lut[442] = 11'b0110110110;
        lut[443] = 11'b01001010000;
        lut[444] = 11'b011111100;
        lut[445] = 11'b01000000001;
        lut[446] = 11'b01001011011;
        lut[447] = 11'b0101100111;
        lut[448] = 11'b0110000100;
        lut[449] = 11'b0100000100;
        lut[450] = 11'b010110101;
        lut[451] = 11'b011111111;
        lut[452] = 11'b0100100100;
        lut[453] = 11'b0101001011;
        lut[454] = 11'b0110011110;
        lut[455] = 11'b0100011010;
        lut[456] = 11'b0100000111;
        lut[457] = 11'b0111101111;
        lut[458] = 11'b011101001;
        lut[459] = 11'b0101101011;
        lut[460] = 11'b011101000;
        lut[461] = 11'b0100001010;
        lut[462] = 11'b0100001001;
        lut[463] = 11'b01010110110;
        lut[464] = 11'b01101010110;
        lut[465] = 11'b01010110101;
        lut[466] = 11'b01000010110;
        lut[467] = 11'b0101111000;
        lut[468] = 11'b01001000010;
        lut[469] = 11'b01011100011;
        lut[470] = 11'b01100001011;
        lut[471] = 11'b01100110101;
        lut[472] = 11'b0111110011;
        lut[473] = 11'b0111101110;
        lut[474] = 11'b11010110101;
        lut[475] = 11'b01010110100;
        lut[476] = 11'b01010110011;
        lut[477] = 11'b01010110001;
        lut[478] = 11'b01001101001;
        lut[479] = 11'b0110011100;
        lut[480] = 11'b0110011001;
        lut[481] = 11'b0100100101;
        lut[482] = 11'b01000011011;
        lut[483] = 11'b0111000110;
        lut[484] = 11'b0101110100;
        lut[485] = 11'b0100110001;
        lut[486] = 11'b01001101000;
        lut[487] = 11'b01010111111;
        lut[488] = 11'b01001101110;
        lut[489] = 11'b01000111111;
        lut[490] = 11'b0101110111;
        lut[491] = 11'b0100111001;
        lut[492] = 11'b0110010111;
        lut[493] = 11'b011111001;
        lut[494] = 11'b0111000010;
        lut[495] = 11'b01001100000;
        lut[496] = 11'b011111010;
        lut[497] = 11'b01001011110;
        lut[498] = 11'b0111010110;
        lut[499] = 11'b01001100101;
        lut[500] = 11'b01001000101;
        lut[501] = 11'b0111000101;
        lut[502] = 11'b0111111100;
        lut[503] = 11'b0111011000;
        lut[504] = 11'b01000011101;
        lut[505] = 11'b01000000110;
        lut[506] = 11'b01000010011;
        lut[507] = 11'b01000100000;
        lut[508] = 11'b01000000011;
        lut[509] = 11'b0110110101;
        lut[510] = 11'b0100111101;
        lut[511] = 11'b0100010110;
        lut[512] = 11'b0111100001;
        lut[513] = 11'b011110010;
        lut[514] = 11'b01010101111;
        lut[515] = 11'b011100101;
        lut[516] = 11'b01001110101;
        lut[517] = 11'b0100111100;
        lut[518] = 11'b01001110001;
        lut[519] = 11'b0101100000;
        lut[520] = 11'b0101011010;
        lut[521] = 11'b0101001010;
        lut[522] = 11'b0110111000;
        lut[523] = 11'b0101001100;
        lut[524] = 11'b0110011000;
        lut[525] = 11'b0110001111;
        lut[526] = 11'b01000110001;
        lut[527] = 11'b0111010000;
        lut[528] = 11'b0111100011;
        lut[529] = 11'b0100110110;
        lut[530] = 11'b011111101;
        lut[531] = 11'b0100111111;
        lut[532] = 11'b01001001001;
        lut[533] = 11'b01010011000;
        lut[534] = 11'b0101110010;
        lut[535] = 11'b111000;
        lut[536] = 11'b0110001001;
        lut[537] = 11'b0100011011;
        lut[538] = 11'b0101000010;
        lut[539] = 11'b0101101000;
        lut[540] = 11'b0100111011;
        lut[541] = 11'b0110111010;
        lut[542] = 11'b0110010000;
        lut[543] = 11'b0110100101;
        lut[544] = 11'b0101010111;
        lut[545] = 11'b0110011010;
        lut[546] = 11'b0101011000;
        lut[547] = 11'b0110101001;
        lut[548] = 11'b0100100011;
        lut[549] = 11'b0111010100;
        lut[550] = 11'b0100001101;
        lut[551] = 11'b0101100110;
        lut[552] = 11'b0101100001;
        lut[553] = 11'b0100100001;
        lut[554] = 11'b010001110001;
        lut[555] = 11'b010000100001;
        lut[556] = 11'b01110101010;
        lut[557] = 11'b01110000001;
        lut[558] = 11'b01101011001;
        lut[559] = 11'b01100001001;
        lut[560] = 11'b01010111001;
        lut[561] = 11'b01000011001;
        lut[562] = 11'b0100010111;
        lut[563] = 11'b01010010001;
        lut[564] = 11'b01100010001;
        lut[565] = 11'b01001110000;
        lut[566] = 11'b01011000001;
        lut[567] = 11'b0110111001;
        lut[568] = 11'b01001100111;
        lut[569] = 11'b010010010110;
        lut[570] = 11'b01110000111;
        lut[571] = 11'b01111010111;
        lut[572] = 11'b01001000110;
        lut[573] = 11'b0111111000;
        lut[574] = 11'b0111110111;
        lut[575] = 11'b01000110100;
        lut[576] = 11'b0101101100;
        lut[577] = 11'b0111100100;
        lut[578] = 11'b01001111011;
        lut[579] = 11'b01100101101;
        lut[580] = 11'b0100011100;
        lut[581] = 11'b01000010111;
        lut[582] = 11'b0101100101;
        lut[583] = 11'b0111011011;
        lut[584] = 11'b01001011000;
        lut[585] = 11'b0111011111;
        lut[586] = 11'b01001100001;
        lut[587] = 11'b0111111111;
        lut[588] = 11'b01000110000;
        lut[589] = 11'b01000100111;
        lut[590] = 11'b0111100000;
        lut[591] = 11'b01000101001;
        lut[592] = 11'b01001001100;
        lut[593] = 11'b01001001010;
        lut[594] = 11'b0100011101;
        lut[595] = 11'b0110110111;
        lut[596] = 11'b01010011001;
        lut[597] = 11'b01000111110;
        lut[598] = 11'b01010001111;
        lut[599] = 11'b01001010001;
        lut[600] = 11'b0100010101;
        lut[601] = 11'b0110001110;
        lut[602] = 11'b01000000111;
        lut[603] = 11'b01000101111;
        lut[604] = 11'b01001010010;
        lut[605] = 11'b01000000010;
        lut[606] = 11'b01100100110;
        lut[607] = 11'b0110000110;
        lut[608] = 11'b01010000111;
        lut[609] = 11'b0110101110;
        lut[610] = 11'b01010001010;
        lut[611] = 11'b01000100101;
        lut[612] = 11'b01010000101;
        lut[613] = 11'b0110000010;
        lut[614] = 11'b01001101111;
        lut[615] = 11'b01000100011;
        lut[616] = 11'b01001011101;
        lut[617] = 11'b0111010111;
        lut[618] = 11'b01010101110;
        lut[619] = 11'b01000000000;
        lut[620] = 11'b01000110110;
        lut[621] = 11'b0101011001;
        lut[622] = 11'b01101000101;
        lut[623] = 11'b01100011111;
        lut[624] = 11'b01101101111;
        lut[625] = 11'b010001011110;
        lut[626] = 11'b010010001000;
        lut[627] = 11'b010010001010;
        lut[628] = 11'b01111000000;
        lut[629] = 11'b0111011101;
        lut[630] = 11'b0111000000;
        lut[631] = 11'b01001111100;
        lut[632] = 11'b0110101111;
        lut[633] = 11'b0110010010;
        lut[634] = 11'b0110101011;
        lut[635] = 11'b01101000010;
        lut[636] = 11'b0111011010;
        lut[637] = 11'b010000110110;
        lut[638] = 11'b0100011110;
        lut[639] = 11'b0100100010;
        lut[640] = 11'b0110101101;
        lut[641] = 11'b01010110010;
        lut[642] = 11'b01011110000;
        lut[643] = 11'b0111111110;
        lut[644] = 11'b01001000001;
        lut[645] = 11'b01001001110;
        lut[646] = 11'b01001110110;
        lut[647] = 11'b01100101011;
        lut[648] = 11'b01001000011;
        lut[649] = 11'b0110010001;
        lut[650] = 11'b0110101100;
        lut[651] = 11'b0111010011;
        lut[652] = 11'b01010001000;
        lut[653] = 11'b01101010011;
        lut[654] = 11'b0111010101;
        lut[655] = 11'b01011101100;
        lut[656] = 11'b01001001111;
        lut[657] = 11'b01010011110;
        lut[658] = 11'b01000110111;
        lut[659] = 11'b01000100110;
        lut[660] = 11'b01001111111;
        lut[661] = 11'b01101000110;
        lut[662] = 11'b01111100111;
        lut[663] = 11'b010000001111;
        lut[664] = 11'b01110011001;
        lut[665] = 11'b01000001010;
        lut[666] = 11'b01100110111;
        lut[667] = 11'b0101100010;
        lut[668] = 11'b01010101101;
        lut[669] = 11'b01010101000;
        lut[670] = 11'b0101000011;
        lut[671] = 11'b010010011011;
        lut[672] = 11'b01111111011;
        lut[673] = 11'b01111010011;
        lut[674] = 11'b010000010110;
        lut[675] = 11'b01111000111;
        lut[676] = 11'b01110000100;
        lut[677] = 11'b01111111110;
        lut[678] = 11'b01111111101;
        lut[679] = 11'b01110100000;
        lut[680] = 11'b01110101101;
        lut[681] = 11'b01110010001;
        lut[682] = 11'b01110000101;
        lut[683] = 11'b01101101001;
        lut[684] = 11'b01101011101;
        lut[685] = 11'b01100110100;
        lut[686] = 11'b01011111111;
        lut[687] = 11'b01011010111;
        lut[688] = 11'b01000010000;
        lut[689] = 11'b0111011001;
        lut[690] = 11'b0110010110;
        lut[691] = 11'b0111111101;
        lut[692] = 11'b0111100101;
        lut[693] = 11'b01011101101;
        lut[694] = 11'b01100011001;
        lut[695] = 11'b01100001000;
        lut[696] = 11'b01010010000;
        lut[697] = 11'b01011011010;
        lut[698] = 11'b0111001010;
        lut[699] = 11'b01010000001;
        lut[700] = 11'b01010000000;
        lut[701] = 11'b01100000001;
        lut[702] = 11'b01011100111;
        lut[703] = 11'b01011100100;
        lut[704] = 11'b01010111010;
        lut[705] = 11'b01010010010;
        lut[706] = 11'b0110110001;
        lut[707] = 11'b01001111001;
        lut[708] = 11'b01010001011;
        lut[709] = 11'b0110001101;
        lut[710] = 11'b01000000100;
        lut[711] = 11'b01000000101;
        lut[712] = 11'b01010001101;
        lut[713] = 11'b01000010010;
        lut[714] = 11'b01000100100;
        lut[715] = 11'b01011000010;
        lut[716] = 11'b010000011111;
        lut[717] = 11'b01011101011;
        lut[718] = 11'b010001111011;
        lut[719] = 11'b01000100010;
        lut[720] = 11'b01100010011;
        lut[721] = 11'b01000010101;
        lut[722] = 11'b0110010100;
        lut[723] = 11'b0101111100;
        lut[724] = 11'b0110111111;
        lut[725] = 11'b01100001111;
        lut[726] = 11'b0111111001;
        lut[727] = 11'b0111110101;
        lut[728] = 11'b01001000000;
        lut[729] = 11'b0111010010;
        lut[730] = 11'b01101011111;
        lut[731] = 11'b0111111011;
        lut[732] = 11'b01100111111;
        lut[733] = 11'b01010100111;
        lut[734] = 11'b01011000110;
        lut[735] = 11'b01011100001;
        lut[736] = 11'b01001100100;
        lut[737] = 11'b01000101000;
        lut[738] = 11'b01001001011;
        lut[739] = 11'b010000101001;
        lut[740] = 11'b01111010110;
        lut[741] = 11'b01110010000;
        lut[742] = 11'b01000011110;
        lut[743] = 11'b01010100100;
        lut[744] = 11'b01000001100;
        lut[745] = 11'b01011101010;
        lut[746] = 11'b0111101011;
        lut[747] = 11'b01000010001;
        lut[748] = 11'b01011011011;
        lut[749] = 11'b01111111001;
        lut[750] = 11'b01001101101;
        lut[751] = 11'b01010111011;
        lut[752] = 11'b01100001100;
        lut[753] = 11'b01100001101;
    end

    assign data = lut[addr];

endmodule