(
~loadBuffers = {
    ~buffers = "samples/hits/*.wav".resolveRelative.pathMatch.collect { |x|
        Buffer.read(s, x);
    };
	~onsetBuf = Buffer.read(s, "samples/filmceller/film-anslag.wav".resolveRelative);


    };
    ~loadBuffers.value;
"synthdefs".import;

)


(
Pdef(\popup_mel1, Pbind(
    \instrument, \hkPad2,
    \dur, Pwhite(0.1,4.2),//Pseq([0.31,0.5].normalizeSum, inf),
    \bufnum, Pn(Plazy { ~buffers[4] }),
    \tempo, 1,
    \db, -16,
    \legato, 1,
    \atk, Pwhite(0, 0.2),
    \rel, 4,
    \startPos, Pseg([0.01, 0.1, 0.01], 30, \lin, inf),
    \seekRate, Pwhite(0.01, 0.001),
    \bufRate, Prand([1,2], inf),
    \root, 0,
    \octave, 4,
    \degree, Prand([0,4,5],inf),
    \ffreq, Pseg(Pwhite(500, 1400), Pwhite(3.0,6)),
    \rq, Pwhite(0.001, 0.05),
    \freqshift, -1
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),
)).play;
//Pdef(\temp_pad).play
)
(
5.do { |x|
    {
        ~loadBuffers.value;
        Pfindur(200, Pdef(\popup_mel1)).play;
    }.scoreClockRender("/Volumes/Mega/popup-drone%.wav".format(x), 200, 10, 44100)
}
)

(
Pdef(\popup_mel2, Pbind(
    \instrument, \hkPad2,
    \dur, 0.4,//Pseq([0.31,0.5].normalizeSum, inf),
    \bufnum, Pn(Plazy { ~buffers[4] }),
    \tempo, 1,
    \db, -16,
    \legato, 1,
    \atk, 0,
    \rel, 4,
    \startPos, Pseg([0.01, 0.1, 0.01], 30, \lin, inf),
    \seekRate, Pwhite(0.01, 0.001),
    \bufRate, Prand([1,2], inf),
    \root, -2,
    \octave, 4,
    \degree, Prand([0,4,5],inf).clump(2),
    \ffreq, Pseg(Pwhite(500, 1400), Pwhite(3.0,6)),
    \rq, Pwhite(0.001, 0.05),
    \freqshift, -1
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),
)).play;
//Pdef(\temp_pad).play
)

(
{
    ~loadBuffers.value;
    Pfindur(200, Pdef(\popup_mel2)).play;
}.scoreClockRender("/Volumes/Mega/popup-mel2.wav".format(x), 200, 10, 44100)

)


(
Pdef(\popup_mel3, Pbind(
    \instrument, \hkPad2,
    \dur, Pwhite(0.05, 0.1),//Pseq([0.31,0.5].normalizeSum, inf),
    \bufnum, Pn(Plazy { ~buffers[4] }),
    \tempo, 1,
    \db, -16,
    \legato, 0.2,
    \atk, 0,
    \rel, 2,
    \startPos, Pseg([0.01, 0.1, 0.01], 30, \lin, inf),
    \seekRate, Pwhite(0.01, 0.001),
    \bufRate, Prand([1,2], inf),
    \root, -5,
    \octave, 4,
    \degree, 0,
    \ffreq, Pseg(Pwhite(1000, 1400), Pwhite(3.0,6)),
    \rq, Pwhite(0.04, 0.1),
    \freqshift,0
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),
)).play;
//Pdef(\temp_pad).play
)

(
{
    ~loadBuffers.value;
    Pfindur(200, Pdef(\popup_mel3)).play;
}.scoreClockRender("/Volumes/Mega/popup-mel3.wav".format(x), 200, 10, 44100)

)



(
Pdef(\popup_solodrone, Pbind(
    \instrument, \hkPad2,
    \dur, Pwhite(0.05, 0.1),//Pseq([0.31,0.5].normalizeSum, inf),
    \bufnum, Pn(Plazy { ~buffers[4] }),
    \tempo, 130/60,
    \db, -16,
    \legato, 0.2,
    \atk, 0,
    \rel, 2,
    \startPos, Pseg([0.01, 0.1, 0.01], 30, \lin, inf),
    \seekRate, Pwhite(0.01, 0.001),
    \bufRate, Prand([1,2], inf),
    \root, 2,
    \octave, 4,
    \degree, 0,
    \ffreq, Pseg(Pwhite(600, 1000), Pwhite(3.0,6)),
    \rq, Pwhite(0.04, 0.1),
    \freqshift,0
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),
)).play;
//Pdef(\temp_pad).play
)

(
{
    ~loadBuffers.value;
    Pfindur(200*130/60, Pdef(\popup_solodrone)).play;
}.scoreClockRender("samples/popups/popup_solodrone_%.wav".format(Date.localtime.stamp).resolveRelative, 200, 10, 44100)

)


(
Pdef(\popup_solodrone2, Pbind(
    \instrument, \hkPad2,
    \dur, Pwhite(0.05, 0.5),//Pseq([0.31,0.5].normalizeSum, inf),
    \bufnum, Pn(Plazy { ~buffers[8] }),
    \tempo, 130/60,
    \db, -16,
    \legato, 0.2,
    \atk, 0,
    \rel, 2,
    \startPos, Pseg([0.01, 0.1, 0.01], 30, \lin, inf),
    \seekRate, Pwhite(0.01, 0.001),
    \bufRate, Prand([1,2], inf),
    \root, 0,
    \octave, 4,
    \degree, 0,
    \ffreq, Pseg(Pwhite(200, 400), Pwhite(3.0,6)),
    \rq, 0.1,
    \freqshift,0
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),
)).play;
//Pdef(\temp_pad).play
)

(
{
    ~loadBuffers.value;
    Pfindur(200*130/60, Pdef(\popup_solodrone2)).play;
}.scoreClockRender("samples/popups/popup_solodrone2_%.wav".format(Date.localtime.stamp).resolveRelative, 200, 10, 44100)

)
