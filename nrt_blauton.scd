(
var data = thisProcess.argv[0];
var root = thisProcess.argv[1].asInteger;
var scale = Scale.major(thisProcess.argv[2].asSymbol);
var curve = thisProcess.argv[3].asInteger;
var out = thisProcess.argv[4];

var score = thisProcess.nowExecutingPath.dirname +/+ "temp.osc";

// create frequencies
var freqs = 36.collect({arg d; scale.degreeToFreq(d, root.midicps, 0)});

SynthDef("blauton",{ arg freq = 440, amp = 0.00;
    Out.ar(0, SinOsc.ar(freq, 0.0, amp))
}).writeDefFile;


Routine.run({
	// read comma separated data
	f = CSVFileReader.read(data, true, true);
	// create score array
	x = Array.new(36 + f.size*36 + 1);  // 36 synth defs + lines in file * synths + 1 end instruction.

	// create 36 synths
	36.do({ arg i;
		x = x.insert(i, [0.0, [\s_new, \blauton, 1000+i, 0, 0, \freq, freqs[i] ]]);
	});

	f.size.do({ arg i; // for each line in the file
		36.do({ arg j; // for each synth
			x = x.insert(36+(i*36)+j, [i*0.04, [\n_set, 1000+j, \amp, ((f[i][j].asFloat).lincurve(0.0,1.0,0.0,1.0,curve))/36 ]]);
		});
	});

	// mark end of score
	x.insert(36 + f.size*36, [(f.size+1)*0.04, [\c_set, 0, 0]]);

	// write score to file
	Score.write(x, score);

	// run scsynth with file and output
	("scsynth -N" + score + "_" + out + "44100 wav int16 -o 1").unixCmd;

	// shutdown interpreter and exit
	thisProcess.shutdown;
	0.exit;

});
)