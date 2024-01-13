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
(
//Regular sinOsc w/significantly increased amplitude.
a = {
	var amp, ex;
	amp = LFNoise1.kr(100, 1, 0.0);
	ex = SinOsc.ar * amp;
}.play;
)
a.free;
//Accessible changes of variables.

x = Synth.new(\synthOne, [\width, 0.09, \ampHertz, 8, \two, 50, \crucial, 80, \dampRev, 0.25, \mixRev, 1.2, \speedDecipher, 16.cubed, \conductDecipher, 10.squared]);
x.free;
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
