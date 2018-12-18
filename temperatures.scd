(
~loadBuffers = {
    ~buffers = "../render/hits/*.wav".resolveRelative.pathMatch.collect { |x|
        Buffer.read(s, x);
    };
    ~onsetBuf = Buffer.read(s, "../render/filmceller/film-anslag.wav".resolveRelative);


    };
    ~loadBuffers.value;
)

"synthdefs".import;

~buffers[[2,3]]


(
Pdef(\temp_mel, Pbindf(Pn(Plazy {
    if (~melody = 0.1.coin) {
        Pbind(
            \instrument, \pi,
            \degree, Pseq([0,4,5]) + [0,7],
            \dur, Pseq([Rest(3), 1, 24]),
            \ffreq, Pexprand(1000, 2000),
            \legato, 1,
            \amp, 0.15,
            \timingOffset, 0.1
        )
    } {
        Pbind(
            \instrument, \pi,
            \timingOffset, 0.1,
            \amp, Pwhite(0.1, 0.15),
            \octave, 3,
            \note, 0,
            \dur, Pn(16, 1),
            \ffreq, Pexprand(100, 300),
            //This changes root of everything, see .collect further down


        )
    }
    }
), \root, Pstep([-2,1,-1,2,0], 60*60)).collect { |ev| ~root = ev.root; ev }
)
)

(
//Boogie
Pdef(\temp_rhy1, Pbind(
    \instrument, \hkHit,
    \tempo, 75/60,
    \bufnum, Pn(Plazy { Pshuf(~buffers[[2,3,4,5,6,7]]) }),
    \dur, PdurStutter(Pwrand([1,2,4,16], [0.99, 0.009, 0.001,0.0001].normalizeSum, inf), Prand([1,0.5], inf)),//Pseq([0.31,0.5].normalizeSum, inf),
    \db, Pxrand([9,6,3,0,-3], inf),
    \legato, 0,
    \atk, 0,
    \rel, Pseq([0.01, 0.1, 0.2, 0.1], inf) * Pwrand([1, 20], [0.99, 0.01], inf),
    \startPos, 0.1,
    \bufRate, Prand([1,2], inf),
    //\freqshift, Pseq([-1000, -1000, -2000, -1000], inf),
    \freqshift, Pseg(Pwhite(-2500, -5000), Pwhite(20, 40)),
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),));
//Pdef(\temp_rhy1).play
)).play;
)
(//Boogie
Pdef(\temp_pad, Pbind(
    \instrument, \hkPad2,
    \dur, 0.5,//Pseq([0.31,0.5].normalizeSum, inf),
    \bufnum, Pn(Plazy { ~buffers[4] }),
    \db, -32,
    \legato, 1,
    \rel, 1,
    \startPos, Pseg([0.01, 0.1, 0.01], 30, \lin, inf),
    \seekRate, Pwhite(0.01, 0.001),
    \bufRate, Prand([1,2], inf),
    \root, Pfunc { ~root },
    \octave, 4,    \degree, Pn(Pif(Pfunc { ~melody }, Pseq([0,4].dup(8) ++ [0,5].dup(40)), [0,4])),
    \ffreq, Pseg(Pwhite(500, 900), Pwhite(3.0,6)),
    \rq, Pwhite(0.01, 0.05),
    \freqshift, -1
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),
)).play;
//Pdef(\temp_pad).play
)

(
Pdef(\temperatures, Ptpar([
    0.0, Pdef(\temp_mel),
    0.1, Pdef(\temp_rhy1),
    0.1, Pdef(\temp_pad)
])).play;
)
(
{
    ~loadBuffers.value;
    Ptpar([
        0.0, Pdef(\temp_mel),
        0.1, Pdef(\temp_rhy1),
        0.1, Pdef(\temp_pad)
    ]).play
}.scoreClockRender("/Volumes/Mega/temperatures.w64", 60*60*5, 10, 44100,"w64")
)

(
//Rubato rhythm, satellite 1
Pdef(\temp_rhy_rub1, Pbind(
    \instrument, \hkHit,
    \tempo, 75/60,
    \bufnum, Pn(Plazy { Pshuf(~buffers) }),
    \dur, Pif(Pfunc{0.999.coin}, Pseg(Pwhite(0.1, 0.2), Pwhite(0.5, 3), \exp, inf), Pwhite(2.0, 3)),
    \amp, 1,
    \legato, 0,
    \atk, 0,
    \rel, Pif(Pfunc { |ev| ev.dur.postln > 1.99 }, 5, Plprand(0.01, 3)),
    \startPos, 0.1,
    \bufRate, Prand([1,3], inf),
    //\freqshift, Pseq([-1000, -1000, -2000, -1000], inf),
    \freqshift, Pstep(Pwhite(-2500, -5000), Pwhite(20, 40)),
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),
));
{
~loadBuffers.value;

Pn(Pdef(\temp_rhy_rub1)).play;
}.scoreClockRender("/Volumes/Mega/temperatures-satellite-rhyrub2.wav", 60*30, 10, 44100)
)


(
//Rubato rhythm, satellite 1
Pdef(\temp_rhy_rub2, Pbind(
    \instrument, \hkHit,
    \tempo, 75/60,
    \bufnum, Pn(Plazy { Pshuf(~buffers[[0,1,2,3,5]]) }),
    \dur, 0.1,
    \amp, 0.01,
    \legato,0.0,
    \atk, 0.002,
    \rel, 0.05,
    \startPos, 0,
    \bufRate, Prand([1,3], inf),
    //\freqshift, Pseq([-1000, -1000, -2000, -1000], inf),
    \freqshift, 0,
    //\rel, Pwrand([1, 2], [0.98, 0.02], inf),
));
Pn(Pdef(\temp_rhy_rub1)).play;
)
(
{
~loadBuffers.value;

Pn(Pdef(\temp_rhy_rub2)).play;
}.scoreClockRender("/Volumes/Mega/temperatures-satellite-rhyrub.wav", 60*30, 10, 44100)
)