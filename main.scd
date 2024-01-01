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
a.set(\changeRun, 10.cubed);
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
