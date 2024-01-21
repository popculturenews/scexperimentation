//To begin: mandatory booting.
s.boot;
Stethoscope.new;
s.quit;
//Establishes synthDef, variables and arguments.
(
SynthDef(\synthOne, {
	arg ampHertz = 4, crucial = 40, two = 20, width = 0.5, dampRev = 0.5, mixRev = 0.7, conductDecipher = 30, speedDecipher = 20;
    var amp1, amp2, freq1, freq2, ex1, ex2;

//Introduces variable characteristics, assign control rate, exponential range, refer to arguments atop.
	freq1 = LFNoise0.kr(10).exprange(crucial, crucial * two).round(crucial);
    freq2 = LFNoise0.kr(8).exprange(crucial, crucial * two).round(crucial);

//Assign pulse, adding 1 to prior.
    freq1 = freq1 * LFPulse.kr(conductDecipher, add: 1);
    freq2 = freq2 * LFPulse.kr(speedDecipher, add: 1);

//Amplitude; volume manipulation.
    amp1 = LFPulse.kr(ampHertz, 0, 0.12) * 0.75;
    amp2 = LFPulse.kr(ampHertz, 0.5, 0.12) * 0.75;

//Combines elements to conduct tune.
    ex1 = Pulse.ar(freq1, width, amp1);
    ex2 = Pulse.ar(freq2, width, amp2);
	//Apply reverb.
	ex1 = FreeVerb.ar(ex1, 0.7, 0.8, 0.25);
	ex2 = FreeVerb.ar(ex2, 0.7, 0.8, 0.25);
	//Conduct output.
	Out.ar(0, ex1);
    Out.ar(1, ex2);
}).add;
)
b = Synth.new(\synthOne);
b.free;
s.killAll;
(
//Regular sinOsc w/significantly increased amplitude (Will be frightening loud & claustrophobic.
a = {
	var amp, ex;
	amp = LFNoise1.kr(100, 1, 0.0);
	ex = SinOsc.ar * amp;
}.play;
)
Server.killAll;
a.free;
//Accessible changes of variables.

x = Synth.new(\synthOne, [\width, 0.09, \ampHertz, 8, \two, 50, \crucial, 80, \dampRev, 0.25, \mixRev, 1.2, \speedDecipher, 16.cubed, \conductDecipher, 10.squared]);
x.set(\crucial, 100);
x.set(\width, 0.5);
x.set(\ampHertz, 16);
x.set(\two, 30);
x.set(\crucial, 60);
x.set(\dampRev, 0.75);
//Prepare for craziness.
x.set(\speedDecipher, 16.cubed);
x.set(\conductDecipher, 10.squared);
//Introduces second variable. Define exponential range, control rate, precisely same kr for both values.
(
a = {
	arg changeRun = 10;
var fre, ex, amp;
	fre = LFNoise0.kr(changeRun). exprange(200, 1000);
	amp = LFNoise1.kr(changeRun). exprange(0.5, 1);
	ex = SinOsc.ar{fre} * amp;
}.play;
)
a.set(\changeRun, 10);
a.set(\changeRun, exprand(3, 70));
a.free;
//Create function w/EnvGen control rate being multiplied by 200 and added to 0.1. Refer to in execution.
(
q = {
    arg gate = 1;
    var ex, env, freq;
	freq = EnvGen.kr(Env.adsr(1), gate, 200, 0.1);
    env = EnvGen.kr(Env.adsr, gate);
	ex = VarSaw.ar(SinOsc.kr(freq).range(200, 800)) * env;
}.play;
)
q.set(\gate, 0);
q.free;
//Executing envelope w/duration of 2.5 seconds. Amplitude will progressively deteriorate, will ensure execution will stop with doneAction.
(
y = {
	var env, ex;
	env = Line.kr(2, 0, 2.5, doneAction:2);
	ex = Pulse.ar(exprand(200, 800)) * env;
}.play;
)
y.free;
//Create SynthDef conducting multichannel happenings. Splay will fluctuate and deteriorate both in a duration of ten seconds.
(
SynthDef.new (\niceSound, {
	var ex, amp, env;
	env = EnvGen.kr(
		Env.new([1, 0, 1], [10, 10], [1, -1]),
		doneAction: 2
	);
	//Generate unique arrays eight consecutive times for control rate and ar.
	amp = SinOsc.kr({ExpRand(7, 16)}!8).range(0, 1);
	ex = SinOsc.ar({ExpRand(200, 700)}!8);
	ex = ex * amp * env;
	//Create Splay with decreased amplitude, and conduct required output command.
	ex = Splay.ar(ex) * 0.625;
	Out.ar(0, ex);
}).add;
)
f = Synth.new(\niceSound);
f.free;
//Create PinkNoise with multichannel happenings.
g = {PinkNoise.ar(0.5)!2}.play;
g.free;
//Create SynthDef with tremendous iterations: envelope generator possesses distinguishable traits, refer to in execution. Conduct 'do' and duplication of UGens: Random frequuency & iphase, exponentially random duty cycle.
(
SynthDef.new(\iteration, {
		arg freq = 40;
	var whole, ex, env;
	ex = 0;
	env = EnvGen.kr(
		Env.perc(0.01, 4.0, 2.0, -2),
		doneAction:2
	);
	10.do{
	whole = VarSaw.ar(
			freq * {Rand(1.1, 1.625)}!2,
			{Rand(0.0, 1.0)}!2,
			{ExpRand(0.005, 0.06)}!2,
		);
		ex = ex + whole;
	};
	ex = ex * 0.05 * env;
	Out.ar(0, ex);
}).add;
)
//Manipulate frequency argument.
Synth.new(\iteration, [\freq, 400]);
Synth.new(\iteration, [\freq, 700]);
Synth.new(\iteration, [\freq, 350]);
Synth.new(\iteration, [\freq, 250]);
Synth.new(\iteration, [\freq, 100]);
//Conducting simultaneous frequencies using midicps & arrays.
(
[53, 46, 72, 61].do{
	arg midinote;
	Synth.new(\iteration, [\freq, midinote.midicps]);
}
)
//Create second SynthDef with tremendous differences. (LFNoise1 will specify frequency). Evoke peculiar sounds using multichannel happenings, duplications. Range will result in spontaneous fluctuations.
(
SynthDef.new(\iteration2, {
		arg freq = 225;
	var whole, ex;
	ex = 0;
	10.do{
		arg specify;
	whole = SinOsc.ar(
		freq *
			(specify + 1) *
			LFNoise1.kr({Rand(0.05, 0.2)}!2).range(0.9, 1.1)
		);
		whole = whole * LFNoise1.kr({Rand(0.7, 7)}!2).exprange(0.02, 1.1);
		ex = ex + whole;
	};
	ex = ex * 0.05;
	Out.ar(0, ex);
}).add;
)
x = Synth.new(\iteration2);
x.set(\freq, 75);
x.free;
//Input and output bus experimentation: simple frequency with low control rate, execution with decreased amplitude, little impulse, Envelope with moderate range. Contains unit generator modulation.
(
SynthDef.new(\begin1, {
	arg out, crucial = 350, density = 3, decay = 0.7;
	var freq, two, ex;
	freq = LFNoise0.kr(6).exprange(crucial, crucial*2).round(crucial);
	ex = SinOsc.ar(freq) * 0.375;
	two = Dust.kr(density);
	ex = ex * EnvGen.kr(Env.perc(0.01, decay), two);
	ex = Pan2.ar(ex, LFNoise0.kr(12));
	Out.ar(out, ex);
}).add;
//Apply reverb.
SynthDef.new(\revSynth, {
	arg in, out = 0;
	var ex;
	ex = In.ar(in, 2);
	ex = FreeVerb.ar(ex, 0.45, 0.7, 0.4);
	Out.ar(out, ex);
}).add;
)
//Create global variable being referred to by synth, representing multichannel UGens, index of 4. Iteration of 8 replications, assign crucial frequency.
8.do {
Synth.new(\begin1,
		[\out, ~reverbBus,
			\crucial, exprand(40, 310).round(25)
	],
		~sourceGroup
	);
}
//Multiple-node manipulations.
~sourceGroup.set(\decay, 0.5);
~sourceGroup.set(\density, 6);
~sourceGroup.freeAll;
u = Synth.new(\revSynth, [\in, ~reverbBus], ~afterGroup);
u.free;
//afterGroup will be conducted after source group.
~reverbBus = Bus.audio(s, 1);
~sourceGroup = Group.new;
~afterGroup = Group.after(~sourceGroup);
