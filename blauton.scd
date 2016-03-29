(
{
s.bootSync;
s.waitForBoot({

		"SERVER HAS BOOTED.".postln();

		SynthDef(\blauton, {
			var freqs = NamedControl.kr(\freqs, #[220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880, 220, 440, 880]);
			var amps = NamedControl.kr(\amps, #[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]);
			var phases = NamedControl.kr(\phases, #[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]);
			var sig;
			sig = DynKlang.ar(`[freqs, amps, phases]);
			Out.ar([0,1], sig);
		}).add;


		~root = 38;
		~scale = Scale.major(\just);
		~freqs = 36.collect({arg d; ~scale.degreeToFreq(d, ~root.midicps, 0)});
		~freqs.postln;

		y = Synth(\blauton);
		y.set(\freqs, ~freqs);

		s.prepareForRecord(thisProcess.nowExecutingPath.dirname +/+ ("recordings/" "test_1x12px_tiff" ".aiff"));
		//s.record();

		~data = thisProcess.nowExecutingPath.dirname +/+ "../test_tiffs/" "test_1x12px_tiff/" "data.sc";
		~data.postln;
		f = CSVFileReader.read(~data, true, true);
		f[0].postln;

		t = Task {
			f.size.do { arg i;
				var e = f[i].asFloat;
				e = e.lincurve(0.0, 1.0, 0.0, 1.0, 2.0);
				e = e / 36;
				y.set(\amps, e);
				0.04.wait;  // 25 Hz
				//(i % 615 + " amps "+e).postln;
			};
			"DONE.".postln();
			s.stopRecording;
		}.play;
	})
}.fork;
)

Server.killAll

//////////// CHAOS AB HIER.. /////////////////////////////////////////

s.reboot;

(
SynthDef(\blauton, {
	var freqs = NamedControl.kr(\freqs, #[73.416191979352, 82.593215976732, 91.770239974108, 97.888255972357, 110.12428796885, 122.36031996534, 137.65535996094, 146.8323839587, 165.18643195346, 183.54047994822, 195.77651194471, 220.2485759377, 244.72063993067, 275.31071992188, 293.66476791741, 330.37286390693, 367.08095989643, 391.55302388943, 440.4971518754, 489.44127986135, 550.62143984375, 587.32953583482, 660.74572781386, 734.16191979286, 783.10604777885, 880.99430375079, 978.88255972269, 1101.2428796875, 1174.6590716696, 1321.4914556277]);
	var amps = NamedControl.kr(\amps, #[0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027,0.027]);
	var phases = NamedControl.kr(\phases, #[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]);
	var sig;

	freqs.size.postln;
	amps.size.postln;
	phases.size.postln;

	sig = DynKlang.ar(`[freqs, amps, phases]);
	Out.ar([0,1], sig);
}).add;

y = Synth(\blauton);

)


36.collect({arg d; Scale.major(\just).degreeToFreq(d, 38.midicps, 0)})

y.set(\freqs, );

y.set(\freqs, [220, 440, 880, 1200, 434]);
// Platte: 35 Hz - 15kHz

(
~root = 38;
//~scale = Scale.major(\pythagorean);
~scale = Scale.major(\just);
//~scale = Scale.major();


//~freqs = Array.fill(~num, { arg i; (~root+i).midicps });
~freqs = 36.collect({arg d; ~scale.degreeToFreq(d, ~root.midicps, 0)});

//~amps = Array.fill(~num, { 1 / ~num });
//~amps.postln;
//~phases = 0.0.dup(~num);
//~phases = {1.0.rand}.dup(~num);
//~phases.postln;

y.set(\freqs, ~freqs);
//y.set(\amps, ~amps);
//y.set(\phases, ~phases);

)

~amps = Array.fill(~num, { 1 / (~num+155) });
y.set(\amps, ~amps);

(
s.prepareForRecord(thisProcess.nowExecutingPath.dirname +/+ "test.aiff");
s.record();
)
s.stopRecording;

Tuning.directory


(0..100).collect(_.lincurve(0.0, 100.0, 0.0, 1.0, 8.0)).plot;
(1..100).collect(_.log).plot;

(0..1000).normalize(-10, 10).collect { |num| num.lcurve }.plot;
(0..1000).normalize(-10, 10).plot;
(0..10).expexp(0.1, 10.0, 0.1, 1.0).plot;

d = thisProcess.nowExecutingPath.dirname +/+ "data.sc";
x = CSVFileReader.read(d, true, true);
// x[line][offset]
x[0][0..137]
x[0][0..3]



(
var size = 36;
var amps = { rrand(0.01, 0.05).round(0.01) }.dup(size);
y.setn(\amps, amps);
//amps.plot;
)


// generate scale
(
var root = 50;
var numberOfOctaves = 10;
//var sc = Scale.newFromKey(\major);
var sc = Scale.major(\just);
var f = numberOfOctaves.collect({arg octave; ((octave * sc.pitchesPerOctave) + root + sc.semitones)}).flat;

root.midinote.postln;
f.midicps.round(0.111)[0..35].postln;
f.size;

)


// d dur
[50, 52, 54, 55, 57, 59, 61, 62, 64, 66, 67, 69, 71, 73, 74, 76, 78, 79, 81, 83, 85, 86, 88, 90, 91, 93, 95, 97, 98, 100, 102, 103, 105, 107, 109, 110].size


[0,1,2,3,4,5,6][3..5]
Scale.directory


Tuning.directory

60.midicps
50.midicps

Scale.major.postln;
scale.tuning_(\just); // Just intonation

(
var sc = Scale.major(\just);
var root = 50;
36.collect({arg d; sc.degreeToFreq(d, root.midicps, 0)});

)


(
e = [0.0,0.1,0.2,0.3,0.5,1.0];
e = e.linexp(0.0, 1.0, 1.0, 200.0)/100;
)

(0..1000).normalize(-10, 10).collect { |num| num.lcurve }.plot;


(0..100).collect(_.lincurve(0, 100, 0, 1, -8)).plot

// different curves:
(
(-4..4).do { |val|
    (0..100).collect(_.lincurve(0, 100, 0, 1, val)).plot
}
)




