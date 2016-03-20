(
{
s.bootSync;
s.waitForBoot({

		"SERVER HAS BOOTED.".postln();

		SynthDef(\blauton, {
			var freqs = NamedControl.kr(\freqs, #[220, 440, 880]);
			var amps = NamedControl.kr(\amps, #[0.1, 0.1, 0.1]);
			var phases = NamedControl.kr(\phases, #[0.0, 0.0, 0.0]);
			var sig;
			sig = DynKlang.ar(`[freqs, amps, phases]);
			Out.ar([0,1], sig);
		}).add;


		~root = 50;
		~scale = Scale.major(\just);

		~freqs = 36.collect({arg d; ~scale.degreeToFreq(d, ~root.midicps, 0)});
		~freqs.postln;

		~amps = 0.0.dup(36);
		~phases = 0.0.dup(36);

		y = Synth(\blauton);
		y.set(\freqs, ~freqs);
		y.set(\amps, ~amps);
		y.set(\phases, ~phases);


		s.prepareForRecord("/home/stahl/job/hemauer_keller/recordings/out.aiff");
		s.record();


		f = CSVFileReader.read("/home/stahl/job/hemauer_keller/data.sc", true, true);

		t = Task {
			f.size.do { arg i;
				var e = f[i].asFloat;
				e = e.lincurve(0.0, 1.0, 0.0, 1.0, 4.0);
				e = e / 36;
				0.04.wait;  // 25 Hz
				y.set(\amps, e);
				//(i % 615 + " amps "+e).postln;
			}
		}.play;

	})
}.fork;
)

s.stopRecording;
Server.killAll


//////////// CHAOS AB HIER.. /////////////////////////////////////////


x = CSVFileReader.read("/home/stahl/job/hemauer_keller/data.sc", true, true);
x[0][0..137]
x[1]



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
