(
a = {
	arg changeRun = 10;
var fre, ex, amp;
	fre = LFNoise0.kr(changeRun). exprange(200, 1000);
	amp = LFNoise1.kr(changeRun). exprange(0.5, 1);
	ex = SinOsc.ar{fre} * amp;
}.play;
)
a.set(\changeRun, 10.squared);
a.set(\changeRun, exprand(2, 70));
a.free;
//alternative
(
a = {
	arg changeRun = 10;
var fre, ex, amp;
	fre = LFNoise0.kr(changeRun). exprange(200, 1000);
	amp = LFNoise1.kr(changeRun). exprange(0.5, 1);
	ex = SinOsc.ar{fre} * amp;
}.play;
)
a.set(\changeRun, 100.cubed);
a.set(\changeRun, exprand(3, 70));
a.free;
//alternative
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

z = {SinOsc.ar}.play;
z.free;
s.boot;
s.quit;

//Experimentation 2:
s.boot;


(
SynthDef(\synthOne, {
	arg ampHertz = 4, crucial = 40, two = 20, width = 0.5, dampRev = 0.5, mixRev = 0.7, conductDecipher = 30, speedDecipher = 20;
    var amp1, amp2, freq1, freq2, ex1, ex2;


    freq1 = LFNoise0.kr(10).exprange(crucial, crucial * two).round(crucial);
    freq2 = LFNoise0.kr(8).exprange(crucial, crucial * two).round(crucial);


    freq1 = freq1 * LFPulse.kr(conductDecipher, add: 1);
    freq2 = freq2 * LFPulse.kr(speedDecipher, add: 1);


    amp1 = LFPulse.kr(ampHertz, 0, 0.12) * 0.75;
    amp2 = LFPulse.kr(ampHertz, 0.5, 0.12) * 0.75;


    ex1 = Pulse.ar(freq1, width, amp1);
    ex2 = Pulse.ar(freq2, width, amp2);


    ex1 = FreeVerb.ar(ex1, mixRev, 0.8, dampRev);
    ex2 = FreeVerb.ar(ex2, 0.7, 0.8, dampRev);


    Out.ar(0, ex1);
    Out.ar(1, ex2);
}).add;
)
a = {SinOsc.ar}.play;
a.free;
x = Synth.new(\synthOne, [\width, 0.09, \ampHertz, 8, \two, 50, \crucial, 80, \dampRev, 0.25, \mixRev, 1.2, \speedDecipher, 8, \conductDecipher, 5
]);
x.set(\width, 0.5);
x.set(\ampHertz, 4);
x.set(\two, 30);
x.set(\crucial, 60);
x.set(\dampRev, 0.75);
x.set(\mixRev, 0.5);
x.set(\conductDecipher, 100);
x.set(\speedDecipher, 100);
x.free;

s.quit;
