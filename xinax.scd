//Xinax
(
SynthDef("Xinax", {arg out = 0, freq = 50, pan = 0, rate = 2, amp = 0.1, gate = 0.1, width = 2, speed = 3;
	var sendIt, snd, sndAll, sndAgain;
	sendIt = Env.adsr(
		attackTime: 0.2,
		decayTime: 0.3,
		sustainLevel: 0.5,
		releaseTime: 0.7,
		peakLevel: 0.4,
		curve: 0.5,
		bias: 0).kr(gate, doneAction: 1);
	snd = SinOsc.ar(
		in: BPF.ar(freq: [freq, 10, 70]), mul: 0.1);
	sndAgain = LFSaw.ar(
		in: LPF.ar(freq: [freq, 60]), mul: 0.6);
	sndAll = snd * sendIt * sndAgain;
	sndAll = PanAz.ar(
		numChans: 2,
		width: width,
		in: sndAll,
		pos: Saw.kr(speed));
	Out.ar(out, sndAll);
}).add;
)

(
Synth (\Xinax)
)


(
SynthDef("Minax", {arg out = 0, freq = 600, pan = 0, rate = 5, amp = 0.8, gate = 0.1, width = 2, speed = 0.1;
	var bendIt, snd;
	bendIt = Env.adsr(
		attackTime: 0.2,
		decayTime: 1,
		sustainLevel: 0.2,
		releaseTime: 0.2,
		peakLevel: 0.2,
		curve: 3.0,
		bias: 0).kr(gate, doneAction: 2);
	snd = LFTri.ar(
		in: HPF.ar(freq: [freq, 100, 70]), mul: 0.1);
	snd = snd * bendIt;
	snd = PanAz.ar(
		numChans: 2,
		width: width,
		in: snd,
		pos: LFSaw.kr(speed));
	Out.ar(out, snd);
}).add;
)

(
Synth(\Minax)
)

(
Pbind(
	\instrument, \Xinax,
	\midinote, Pxrand([55, 55, 57, 55, 60, 59, 57, 55, 55, 57, 55, 62, 60, 59, 57, 55,
              55, 57, 57, 57, 57, 57, 59, 57, 59, 60, 55, 55, 55, 55, 60, 59,
              57, 55, 55, 57, 57, 57, 57, 57, 59, 57, 59, 60, 55, 62, 62, 62,
              62, 60, 59, 57, 55, 60, 59, 57, 55, 55, 57, 57, 57, 57, 57, 59,
              57, 59, 60, 55], inf),
	\dur, Pxrand([0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75,
                 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25,
                 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75,
                 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25,
                 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75,
                 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25, 0.75, 0.25], inf),
	\amp, 0.4,
	\pan, Pseq([0, 0.1], inf),
	\legato, 0.2,
	\gate, Pseq([1, 0], inf)

).trace.play;
)







































