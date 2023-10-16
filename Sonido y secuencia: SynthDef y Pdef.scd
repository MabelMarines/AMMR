
s.boot;// Definición del SynthDef con envolvente ADSR
(
SynthDef(\miSintetizador, {
    |freq = 440, dur = 1, amp = 0.5|
    var env, osc;

    // Envolvente ADSR
    env = EnvGen.kr(Env.asr(0.01, 1, 0.5), doneAction: 2);

    // Oscilador
    osc = SinOsc.ar(freq);

    // Aplicar la envolvente al oscilador
    osc = osc * env * amp;

    // Salida del sonido
    Out.ar(0, osc);
}).add;
)

// Ejecutar el sintetizador
x = Synth(\miSintetizador, [
    \freq, 440, // Frecuencia
    \dur, 1,   // Duración0
    \amp, 0.5  // Amplitud
]);


// Define el Pdef
(
Pdef(\miPatron, Pbind(
    \instrument, \miSintetizador,
    \degree, Pseq([0, 2, 4, 5], 2),
    \dur, 1,  // Duración de cada nota en segundos
    \amp, Pseq([0.5, 0.3, 0.4, 0.6], 2),  // Una secuencia de amplitudes
    \legato, 0.1  // Controla la suavidad de las transiciones entre notas
)).add;
)

// Ejecutar el Pdef
Pdef(\miPatron).play;
