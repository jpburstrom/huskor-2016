(
~loadBuffers = {
    ~buffers = "../render/hits/*.wav".resolveRelative.pathMatch.collect { |x|
        Buffer.read(s, x);
    };
};
~loadBuffers.value;
)

//SYNTHDEFS
(
"synthdefs".import;

//PATTERNS

//Walking
Pdef(\hits1, Pbind(
    \instrument, \hkHit,
    \tempo, 40/60,
    \bufnum, Plazy { Pxrand(~buffers, inf) } ,
    \dur, Pwrand([0.25,0.5,1],[0.5, 0.5, 0.01].normalizeSum, inf),
    \db, Pwhite(-9, 0),
    \legato, 1,
    \startPos, Pwhite(0.0, 0.1),
    //\strum, 0.04,
    \bufRate, 1,
    \freqshift, Pstutter(Phprand(1,10), Plazy { Pxrand(5.collect { 20.rrand(45) }, inf) },).floor.midicps,
    \rel, Pseg(Pwhite(2, 3), 3),
));

//Fast, high
Pdef(\hits2, Ppar([
    Pbind(
    \instrument, \hkHit,
    \tempo, 120/60,
        \bufnum, Plazy { Pxrand(~buffers, inf) },
    \dur, Prand([0.25,0.5], inf),
    \db, Pwhite(-9, 0) * 4,
    \sustain, 0,
    \startPos, Pwhite(0.0, 0.1),
    \bufRate, 1,
    \atk, Pwrand([0,1], [0.99, 0.01], inf),
    \freqshift, Pstutter(48, Pwhite(4000, 5000)),
    \rel, Pseg(Pwhite(0.1, 0.2), 3),
), Pbind(
    \instrument, \hkHit,
    \tempo, 120/60,
        \bufnum, Plazy { Pxrand(~buffers, inf) },
    \dur, Prand([0.25,0.5], inf),
    \db, Pwhite(-9, 0) * 4,
    \sustain, 0,
    \startPos, Pwhite(0.0, 0.1),
    \bufRate, 1,
    \freqshift, Pstutter(32, Pwhite(800, 1000)),
    \rel, Pseg(Pwhite(0.01, 0.2), 3),
)]));

//Phasing
Pdef(\hits3, Ppar([
    Pbind(
    \instrument, \hkHit,
    \tempo, 60/60,
        \bufnum, Plazy { Pxrand(~buffers, inf) },
    \dur, 1,
    \db, Pwhite(-9, 0) ,
    \legato, 1,
    \startPos, Pwhite(0.0, 1),
    \bufRate, 2,
    \freqshift, 2000,
    \rel, Pseg(Pwhite(2, 3), 3),
), Pbind(
    \instrument, \hkHit,
        \bufnum, Plazy { Pxrand(~buffers, inf) },
    \dur, 1.25,
    \db, Pwhite(-9, 0) ,
    \legato, 1,
    \startPos, Pwhite(0.0, 1),
    \bufRate, 2,
    \freqshift, -1000,
    \rel, Pseg(Pwhite(2, 3), 3),
)]));

//Doomy
Pdef(\hits4, Pbind(
    \instrument, \hkHit2,
    \tempo, 60/60,
    \bufnum, Plazy { Pxrand(~buffers, inf) },
    \dur, Pbrown(0.25, 5, 0.5),
    \db, -9,
    \legato, 1,
    \startPos, 0,
    \bufRateStart, Pwhite(0.25, 0.26),
    \bufRateEnd, 0.23,
    \bufRateEnvDur, 5,
    \freqshift, [0,1000],
    \rel, Pseg(Pwhite(2, 3), 3),
));

//Light ostinato
Pdef(\hits5, Pbind(
    \instrument, \hkHit,
    \tempo, 100/60,
    \bufnum, Plazy { Pseq(~buffers, inf) },
    \dur, 0.5,
    \timingOffset, Pwhite(-0.02, 0.02),
    \db, 12,
    \legato, 0,
    \atk, 0.002,
    //Get closer and closer to 0 startPos
    \startPos, Pwhite(Pseg([0.1, 0.01], 180), 0.2) * 0.5,
    \bufRate, 1,
    \freqshift, Pn(Pseries(0, Pseg(Pwhite(70,100), 10), 10)),
    \rel, Pwrand([1, 5], [0.96, 0.04], inf),
));

//Cloud
Pdef(\hits6, Pbind(
    \instrument, \hkHit,
    \tempo, 100/60,
    \bufnum, Plazy { Pseq(~buffers, inf) },
    \dur, Pwhite(0.01, 0.012),
    // \timingOffset, Pwhite(-0.02, 0.02),
    \db, 12,
    \legato, 2,
    //Get closer and closer to 0 startPos
    \startPos, Pwhite(0, 0.1) + Pseg(Pwhite(0.01, 0.2), 10),
    \bufRate, 1,
    \freqshift, Pwhite(-100, 100) * Pseg([0.001,1], 180, \exp),
    \atk, 0.02,
    \rel, 0.02,
));

//Boogie
Pdef(\hits7, Pbind(
    \instrument, \hkHit,
    \tempo, 135/60,
    \bufnum, Plazy { Pseq(~buffers, inf) },
    \dur, Pseq([0.31,0.5].normalizeSum, inf),
    \db, 0,
    \legato, 1,
    \startPos, 0,
    \bufRate, Prand([1,2], inf),
    \freqshift, Prand([Pseq([10, -3000]), Pseq([0, -3000, -5000])], inf) * Pwhite(0.99, 1.01),
    \rel, Pwrand([1, 2], [0.98, 0.02], inf),
));

//Boogie2
Pdef(\hits8, Pbind(
    \instrument, \hkHit,
    \tempo, 100/60,
    \bufnum, Plazy { Pstep(Pseq(~buffers, inf),Pwhite(1, 5.0), inf) },
    \dur, Pwrand([0.25, 0.5, Pseq([0.28, 0.22])], [0.8, 0.1, 0.1], inf),
    \db, 32,
    \sustain, 0.1,
    \startPos, Pn(Pseries(0.4, 0.003, 6)),
    \bufRate, Prand([1,2], inf),
    \freqshift, Prand([-100, -380], inf),
    \atk, Pwhite(0.0, 0.01),
    \rel, Pwrand([1, 0.1], [0.98, 0.02], inf),
));

//Very slow
//
Pdef(\hits9, Penvir((), Ppar([
    Pbind(
        \instrument, \hkHit2,
        \tempo, 60/60,
        \bufnum, Pfunc {
            ~buf = topEnvironment[\buffers].choose;
        },
        \rel, Pwrand([1, 0.1], [0.98, 0.02], inf),
        \dur, Pwhite(10.0, 20),
        \db, 0,
        \sustain, 1,
        \startPos, 0,
        \bufRateStart, 1,
        \bufRateEnd, 1.1,
        \bufRateEnvDur, 0.1,
        \freqshift, Prand([-100, -380], inf),
        \atk, Pwhite(0.0, 0.01),

    ).collect { |ev| ~dur = ev.dur; ev },
    Pbind(
        \instrument, \hkHit,
        \tempo, 60/60,
        \bufnum, Pfunc { ~buf },
        \rel, 0.002,
        \dur, Pseg(Pwhite(0.1, 0.01), Pwhite(0.1, 1)),
        \amp, Pseg([1, 4], Pfunc { ~dur }, \exp, inf),
        \sustain, 1,
        \startPos, Pseg([0.01, Pwhite(0.05, 0.4, 1)], Pfunc { ~dur }, \lin, inf),
        \freqshift, -2000,
        \atk, 0.002,
)])
));

Pdef(\hits10, Pbind(
    \instrument, \hkHit,
    \tempo, 60/60,
    \bufnum, Pfunc { ~buffers[1] },
    \rel, 0.002,
    \dur, Pseg(Pwhite(0.1, 0.01), Pwhite(1, 5.0)),
    \sustain, 1,
    \startPos, Pseg(Pwhite(0.01, 0.4, inf), Pwhite(10, 20.0), \lin, inf),
    \amp, Pkey(\startPos).linlin(0, 1, 1, 10),
    // \freqshift, -2000,
    \atk, 0.002,
));
)

PdefAllGui()
//RENDER EVERYTHING

(
var date = Date.localtime.stamp;
var duration = 180;
var cond = Condition();
~cond =  cond;
fork {
    (1..10).do { |n|
        fork {
            {
                topEnvironment[\loadBuffers].value;
                Pfindur(999, Pdef("hits%".format(n).asSymbol)).play;
            }.scoreClockRender("../render/popups/popup%_%.wav".format(n, date).resolveRelative, duration, 10, 48000, action: {
                cond.unhang;

            });
        };
        cond.hang;
    }
}
)

(
var date = Date.localtime.stamp;
var duration = 180;
var cond = Condition();
~cond =  cond;
fork {
    [8].do { |n|
        fork {
            {
                topEnvironment[\loadBuffers].value;
                Pfindur(999, Pdef("hits%".format(n).asSymbol)).play;
            }.scoreClockRender("../render/popups/popup%_%.wav".format(n, date).resolveRelative, duration, 10, 48000, action: {
                cond.unhang;

            });
        };
        cond.hang;
    }
}
)
(
//Light ostinato
//Version 2
Pdef(\hits5_2, Pbind(
    \instrument, \hkHit,
    \tempo, 130/60,
    \bufnum, Plazy { Pseq(~buffers, inf) },
    \dur, PdurStutter(Pwrand([1,2,4], [0.9, 0.1, 0.1].normalizeSum, inf), 0.5),
    \timingOffset, Pwhite(-0.02, 0.02),
    \db, 3,
    \legato, 0,
    \atk, 0.00,
    //Get closer and closer to 0 startPos
    \startPos, Pkey(\dur).linlin(0.125,0.5, 0.05, 0.01) + Pwhite(-0.004, 0.004),
    \bufRate, 1,
    \rel, Pwrand([0.5, 5], [0.96, 0.04], inf),
    \freqshift, Pseq([
        Pfin(120, Pn(Pseries(0, Pseg(Pwhite(70,100), 10), 10), 10, inf)),
        Pfin(120, 0),
    ], inf)
)
).play;
)

(
{
    ~loadBuffers.value;
    Pfindur(180*130/60, Pdef(\hits5_2)).play;
}.scoreClockRender("../render/popups/popup5_2_%.wav".format(Date.localtime.stamp).resolveRelative, 200, 10, 44100)

)