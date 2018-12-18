(
~loadBuffers = {
    ~buffers = "../render/hits/*.wav".resolveRelative.pathMatch.collect { |x|
        Buffer.read(s, x);
    };
    ~onsetBuf = Buffer.read(s, "../render/filmceller/film-anslag.wav".resolveRelative);


    };
    ~loadBuffers.value;
)

(
//Cloud
Pdef(\filmGrains, Pbind(
    \instrument, \hkHit,
    \tempo, 100/60,
    \bufnum, Plazy { Pseq(~buffers, inf) },
    \dur, Pwhite(0.01, 0.012),
    // \timingOffset, Pwhite(-0.02, 0.02),
    \db, 0,
    \legato, 4,
    //Get closer and closer to 0 startPos
    \startPos, Pwhite(0, 0.1) + Pseg([0.2, 0.01], 13.6 * 100/60),
    \bufRate, 1,
    \freqshift, 100,
    \atk, 0.02,
    \rel, 0.02,
)).play;
)
(
//Walking
Pdef(\filmBeat, Pbind(
    \instrument, \hkHit,
    \tempo, 155/60,
    \bufnum, Plazy { Pxrand(~buffers, inf) } ,
    \dur, PdurStutter(Pwrand([1,2], [0.9,0.1], inf), Pwrand([0.5,1],[0.5, 0.01].normalizeSum, inf)),
    \db, 6,
    \legato, 1,
    \startPos, Pwhite(0.05, 0.1),
    //\strum, 0.04,
    \bufRate, 1,
    \freqshift, -2000,
    \rel, 0.1,
)).play;
)

(
Pdef(\filmOnset, Pbind(
    \instrument, \hkHit,
    \tempo, 1,
    \bufnum, Pfunc { ~onsetBuf } ,
    \dur, PdurStutter(Pwrand([1,2], [0.9,0.1], inf), Pwrand([0.5,1],[0.5, 0.01].normalizeSum, inf)),
    \db, 0,
    \legato, 1,
    \dur, Pseg([0.05, 0.1], 5) * Pwhite(0.99, 1.01),
    \startPos, Pseg([0.05, 0.6], 5, \lin),
    //\strum, 0.04,
    \bufRate, 1,
    \atk, 0.002,
    \rel, 0.002,
)).play;
)

(
var date = Date.localtime.stamp;
var duration = 60;
var cond = Condition();
~cond =  cond;
fork {
    [\filmGrains].do { |def|
        fork {
            {
                topEnvironment[\loadBuffers].value;
                Pfindur(999, Pdef(def)).play;
            }.scoreClockRender("../render/film/%_%.wav".format(def, date).resolveRelative, duration, 10, 48000, action: {
                cond.unhang;

            });
        };
        cond.hang;
    }
}
)