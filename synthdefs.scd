SynthDef(\hkHit, { arg bufnum;
    var snd = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * \bufRate.kr(1), 1, \startPos.kr(0) * BufFrames.kr(bufnum), 1, 2);

    snd = FreqShiftAA.ar(snd, \freqshift.kr(0));

    snd = snd * EnvGen.ar(Env.linen(\atk.kr(0), \sustain.kr(1), \rel.kr(1)), doneAction:2);
    snd = HPF.ar(snd, 200);

    Out.ar(\outbus.kr(0), snd * \amp.kr)

}).add;
SynthDef(\hkHit2, { arg bufnum;
    var rate = XLine.ar(\bufRateStart.kr(1), \bufRateEnd.kr(1), \bufRateEnvDur.kr(0));
    var snd = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * rate, 1, \startPos.kr(0) * BufFrames.kr(bufnum), 1, 2);

    snd = FreqShiftAA.ar(snd, \freqshift.kr(0));

    snd = snd * EnvGen.ar(Env.linen(\atk.kr(0), \sustain.kr(1), \rel.kr(1)), doneAction:2);
    snd = HPF.ar(snd, 200);

    Out.ar(\outbus.kr(0), snd * \amp.kr)

}).add;
SynthDef(\hkPad2, { arg bufnum;
    var trig = Impulse.ar(\freq.kr(440));
    var snd = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * \bufRate.kr(1),
        trig, Phasor.ar(0, \seekRate.kr(0.001), \startPos.kr(0) * BufFrames.kr(bufnum), BufFrames.kr(bufnum)), 1, 2);

    snd = FreqShiftAA.ar(snd, \freqshift.kr(0));

    snd = snd * EnvGen.ar(Env.adsr(\atk.kr(0), \decay.kr(0.3), \susLevel.kr(0.667), \rel.kr(1)), \gate.kr(1), doneAction:2);

    snd = RLPF.ar(snd, \ffreq.kr(2000), \rq.kr(0.1));

    Out.ar(\outbus.kr(0), snd * \amp.kr(0.1))

}).add;

SynthDef(\pi, {
    var snd = MdaPiano.ar(\freq.kr(440), 1, \amp.kr(0.1) * 127);
    DetectSilence.ar(snd, 0.0001, doneAction:2);
    snd = LPF.ar(snd, \ffreq.kr(800));
    snd = FreqShiftAA.ar(snd, LFNoise2.ar(LFNoise0.ar(0.2,1)).range(-4,4));
    Out.ar(\outbus.kr(0), snd);


}).add