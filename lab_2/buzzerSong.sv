module buzzerSong (
	input clock,
	input reset,
	output logic buzzer
);

logic [19:0] frequency = 0;
logic timingClockOut;
logic [19:0] tempo = 15; // should be 32-nd beats per second

clockDivider toneGenerator (.clockIn(clock), .speed(frequency), .reset(reset), .clockOut(buzzer));
clockDivider timingClock (.clockIn(clock), .speed(tempo), .reset(reset), .clockOut(timingClockOut));

/* 
  Never Gonna Give you Up
  Connect a piezo buzzer
  More songs available at https://github.com/robsoncouto/arduino-songs                                            
                                              
                                              Robson Couto, 2019
*/

`define NOTE_B0  31
`define NOTE_C1  33
`define NOTE_CS1 35
`define NOTE_D1  37
`define NOTE_DS1 39
`define NOTE_E1  41
`define NOTE_F1  44
`define NOTE_FS1 46
`define NOTE_G1  49
`define NOTE_GS1 52
`define NOTE_A1  55
`define NOTE_AS1 58
`define NOTE_B1  62
`define NOTE_C2  65
`define NOTE_CS2 69
`define NOTE_D2  73
`define NOTE_DS2 78
`define NOTE_E2  82
`define NOTE_F2  87
`define NOTE_FS2 93
`define NOTE_G2  98
`define NOTE_GS2 104
`define NOTE_A2  110
`define NOTE_AS2 117
`define NOTE_B2  123
`define NOTE_C3  131
`define NOTE_CS3 139
`define NOTE_D3  147
`define NOTE_DS3 156
`define NOTE_E3  165
`define NOTE_F3  175
`define NOTE_FS3 185
`define NOTE_G3  196
`define NOTE_GS3 208
`define NOTE_A3  220
`define NOTE_AS3 233
`define NOTE_B3  247
`define NOTE_C4  262
`define NOTE_CS4 277
`define NOTE_D4  294
`define NOTE_DS4 311
`define NOTE_E4  330
`define NOTE_F4  349
`define NOTE_FS4 370
`define NOTE_G4  392
`define NOTE_GS4 415
`define NOTE_A4  440
`define NOTE_AS4 466
`define NOTE_B4  494
`define NOTE_C5  523
`define NOTE_CS5 554
`define NOTE_D5  587
`define NOTE_DS5 622
`define NOTE_E5  659
`define NOTE_F5  698
`define NOTE_FS5 740
`define NOTE_G5  784
`define NOTE_GS5 831
`define NOTE_A5  880
`define NOTE_AS5 932
`define NOTE_B5  988
`define NOTE_C6  1047
`define NOTE_CS6 1109
`define NOTE_D6  1175
`define NOTE_DS6 1245
`define NOTE_E6  1319
`define NOTE_F6  1397
`define NOTE_FS6 1480
`define NOTE_G6  1568
`define NOTE_GS6 1661
`define NOTE_A6  1760
`define NOTE_AS6 1865
`define NOTE_B6  1976
`define NOTE_C7  2093
`define NOTE_CS7 2217
`define NOTE_D7  2349
`define NOTE_DS7 2489
`define NOTE_E7  2637
`define NOTE_F7  2794
`define NOTE_FS7 2960
`define NOTE_G7  3136
`define NOTE_GS7 3322
`define NOTE_A7  3520
`define NOTE_AS7 3729
`define NOTE_B7  3951
`define NOTE_C8  4186
`define NOTE_CS8 4435
`define NOTE_D8  4699
`define NOTE_DS8 4978
`define REST      0

`define SONG_LENGTH 680

int i = 0;
int count = 0;
int duration = 0;

int melody[`SONG_LENGTH] = '{

  // Never Gonna Give You Up - Rick Astley
  // Score available at https://musescore.com/chlorondria_5/never-gonna-give-you-up_alto-sax
  // Arranged by Chlorondria
  
  // Encoding: 4 -> quarter note, 8 -> 8th note, 16 -> 16th note
  // -4 -> dotted quarter note, etc

	`NOTE_D5,-4, `NOTE_E5,-4, `NOTE_A4,4, //1
	`NOTE_E5,-4, `NOTE_FS5,-4, `NOTE_A5,16, `NOTE_G5,16, `NOTE_FS5,8,
	`NOTE_D5,-4, `NOTE_E5,-4, `NOTE_A4,2,
	`NOTE_A4,16, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,8, `NOTE_D5,16,
	`NOTE_D5,-4, `NOTE_E5,-4, `NOTE_A4,4, //repeat from 1
	`NOTE_E5,-4, `NOTE_FS5,-4, `NOTE_A5,16, `NOTE_G5,16, `NOTE_FS5,8,
	`NOTE_D5,-4, `NOTE_E5,-4, `NOTE_A4,2,
	`NOTE_A4,16, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,8, `NOTE_D5,16,
	`REST,4, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_D5,8, `NOTE_E5,8, `NOTE_CS5,-8,
	`NOTE_B4,16, `NOTE_A4,2, `REST,4, 

	`REST,8, `NOTE_B4,8, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_B4,4, `NOTE_A4,8, //7
	`NOTE_A5,8, `REST,8, `NOTE_A5,8, `NOTE_E5,-4, `REST,4, 
	`NOTE_B4,8, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_B4,8, `NOTE_D5,8, `NOTE_E5,8, `REST,8,
	`REST,8, `NOTE_CS5,8, `NOTE_B4,8, `NOTE_A4,-4, `REST,4,
	`REST,8, `NOTE_B4,8, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_B4,8, `NOTE_A4,4,
	`NOTE_E5,8, `NOTE_E5,8, `NOTE_E5,8, `NOTE_FS5,8, `NOTE_E5,4, `REST,4,
	 
	`NOTE_D5,2, `NOTE_E5,8, `NOTE_FS5,8, `NOTE_D5,8, //13
	`NOTE_E5,8, `NOTE_E5,8, `NOTE_E5,8, `NOTE_FS5,8, `NOTE_E5,4, `NOTE_A4,4,
	`REST,2, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_B4,8,
	`REST,8, `NOTE_E5,8, `NOTE_FS5,8, `NOTE_E5,-4, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_FS5,-8, `NOTE_FS5,-8, `NOTE_E5,-4, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,

	`NOTE_E5,-8, `NOTE_E5,-8, `NOTE_D5,-8, `NOTE_CS5,16, `NOTE_B4,-8, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16, //18
	`NOTE_D5,4, `NOTE_E5,8, `NOTE_CS5,-8, `NOTE_B4,16, `NOTE_A4,8, `NOTE_A4,8, `NOTE_A4,8, 
	`NOTE_E5,4, `NOTE_D5,2, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_FS5,-8, `NOTE_FS5,-8, `NOTE_E5,-4, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_A5,4, `NOTE_CS5,8, `NOTE_D5,-8, `NOTE_CS5,16, `NOTE_B4,8, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,

	`NOTE_D5,4, `NOTE_E5,8, `NOTE_CS5,-8, `NOTE_B4,16, `NOTE_A4,4, `NOTE_A4,8,  //23
	`NOTE_E5,4, `NOTE_D5,2, `REST,4,
	`REST,8, `NOTE_B4,8, `NOTE_D5,8, `NOTE_B4,8, `NOTE_D5,8, `NOTE_E5,4, `REST,8,
	`REST,8, `NOTE_CS5,8, `NOTE_B4,8, `NOTE_A4,-4, `REST,4,
	`REST,8, `NOTE_B4,8, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_B4,8, `NOTE_A4,4,
	`REST,8, `NOTE_A5,8, `NOTE_A5,8, `NOTE_E5,8, `NOTE_FS5,8, `NOTE_E5,8, `NOTE_D5,8,

	`REST,8, `NOTE_A4,8, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_B4,8, //29
	`REST,8, `NOTE_CS5,8, `NOTE_B4,8, `NOTE_A4,-4, `REST,4,
	`NOTE_B4,8, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_B4,8, `NOTE_A4,4, `REST,8,
	`REST,8, `NOTE_E5,8, `NOTE_E5,8, `NOTE_FS5,4, `NOTE_E5,-4, 
	`NOTE_D5,2, `NOTE_D5,8, `NOTE_E5,8, `NOTE_FS5,8, `NOTE_E5,4, 
	`NOTE_E5,8, `NOTE_E5,8, `NOTE_FS5,8, `NOTE_E5,8, `NOTE_A4,8, `NOTE_A4,4,

	`REST,-4, `NOTE_A4,8, `NOTE_B4,8, `NOTE_CS5,8, `NOTE_D5,8, `NOTE_B4,8, //35
	`REST,8, `NOTE_E5,8, `NOTE_FS5,8, `NOTE_E5,-4, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_FS5,-8, `NOTE_FS5,-8, `NOTE_E5,-4, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_E5,-8, `NOTE_E5,-8, `NOTE_D5,-8, `NOTE_CS5,16, `NOTE_B4,8, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_D5,4, `NOTE_E5,8, `NOTE_CS5,-8, `NOTE_B4,16, `NOTE_A4,4, `NOTE_A4,8, 

	 `NOTE_E5,4, `NOTE_D5,2, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16, //40
	`NOTE_FS5,-8, `NOTE_FS5,-8, `NOTE_E5,-4, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_A5,4, `NOTE_CS5,8, `NOTE_D5,-8, `NOTE_CS5,16, `NOTE_B4,8, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_D5,4, `NOTE_E5,8, `NOTE_CS5,-8, `NOTE_B4,16, `NOTE_A4,4, `NOTE_A4,8,  
	`NOTE_E5,4, `NOTE_D5,2, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	 
	`NOTE_FS5,-8, `NOTE_FS5,-8, `NOTE_E5,-4, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16, //45
	`NOTE_A5,4, `NOTE_CS5,8, `NOTE_D5,-8, `NOTE_CS5,16, `NOTE_B4,8, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_D5,4, `NOTE_E5,8, `NOTE_CS5,-8, `NOTE_B4,16, `NOTE_A4,4, `NOTE_A4,8,  
	`NOTE_E5,4, `NOTE_D5,2, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_FS5,-8, `NOTE_FS5,-8, `NOTE_E5,-4, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16, //45

	`NOTE_A5,4, `NOTE_CS5,8, `NOTE_D5,-8, `NOTE_CS5,16, `NOTE_B4,8, `NOTE_A4,16, `NOTE_B4,16, `NOTE_D5,16, `NOTE_B4,16,
	`NOTE_D5,4, `NOTE_E5,8, `NOTE_CS5,-8, `NOTE_B4,16, `NOTE_A4,4, `NOTE_A4,8, 

	`NOTE_E5,4, `NOTE_D5,2, `REST,4
};

	int durationNext;

	always_comb begin
		if (melody[2*i + 1] < 0) begin
			durationNext = 48 / (-melody[2*i + 1]);
		end else begin
			durationNext = 32 / melody[2*i + 1];
		end
	end

	always @(posedge timingClockOut) begin
		if (count < duration) begin
			count <= count + 1;
		end else begin
			frequency <= melody[2*i];
			count <= 0;
			duration <= durationNext;
			
			if (i < (`SONG_LENGTH/2) - 1) begin
				i <= i + 1;
			end else begin
				i <= 0;
			end
		end
	end
endmodule