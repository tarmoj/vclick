
#eClick
**eClick** is a wire-free visual click-track (or metronome) system, useful for ensembles, bands or other formations. No need for cables, headphones, extra amplifiers or mixers - just use wifi network and the **eClick** software.

There are two parts in the software -  **server** (the main program that plays the click-track) and **client** (apps for players that show information about bar numbers, beats, tempo etc).

The  "click-track" (time, tempo, tempo changes, stops, fermatas etc etc) is written into a score in [Csound](http://csound.github.io/about.html) format and played back by the server. If necessary, also sound-clips or backtrack(s) can be started by the system in given moments. All necessary information is sent to clients (players) via wifi (OSC messages). Also extremely complex pieces can be encoded and played using the system. Every piece requires its own written out score.  If the eClick score is done well, the playback can be started from any bar in the piece.

The software is written on [Qt](http://www.qt.io/) platform and is cross-platform.

**eClick** is currently under development and not yet ready for wider use. But all help, testing and feedback is highly welcome!

See more: <http://tarmoj.github.io/eclick>

(c) Tarmo Johannes 2015 trmjhnns@gmail.com

