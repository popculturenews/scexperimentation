//SynthDef utilizing multichannel expansion with Splay & Pan2 (using mathematical operations for a range of the square root of scaling factor). Uses percussive envelope generator.
//Uses the dust unit generator to create 20 impulses. Uses doneAction:2 to ensure envelope generator will stop following execution. Uses Sine oscillator and VarSaw UGens. Outputting zero busses.

(
SynthDef.new(\synth, {
var freq, fx, multi, ex, env;
freq = 450;
fx = Dust.kr(20);
env = EnvGen.kr(Env.perc(0.7, 0.5, 0.9, 0.6), doneAction:2);
var sigone = SinOsc.ar(freq) * env * fx * 0.5;
var sigtwo = VarSaw.ar(freq) * env * fx * 0.5;
var sigspatialone = Pan2.ar(sigone, 0.1, 1.2);
var sigspatialtwo = Pan2.ar(sigtwo, -0.1, 1.2);
ex = {sigspatialone, sigspatialtwo};
multi = Splay.ar(ex, 0.7, 0.8, 1.3);
Out.ar(0, multi);
}).add;
)
//Uses Pbind to assign constant duration, attack, and relapse. Assigns exponential range for frequency.
(
Pbind (
\instrument, \sine, 
\freq, Pexprand(100, 500, inf),
\dur, (0.33, inf),
\atk, 0.4,
\rel, 0.5,
).play;
)
//Similar to prior but simpler without multichannel expansion, includes reverb.
(
SynthDef.new(\simplesynth, {
var ex, env, freq, rev;
env = EnvGen.kr(Env.perc(0.7, 0.8, 1.3, 0.4));
freq = 300;
ex = SinOsc.ar(freq) * env * 0.5;
rev = FreeVerb.ar(ex, 0.7, 0.8, 0.9):
Out.ar(0, rev);
}).add;
)
//Similar to prior but different instrument, constant duration (rhythmic value of one quintuplet). 60 is fundamental frequency.
(
Pbind (
\instrument, \simplesynth,
\freq, Pexprand(60, 700, inf);
\dur, (0.2, inf);
).play;
)
