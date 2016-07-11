Title: About
Date: 2016-05-31 10:20
sortorder: 1
Category: Pages

**eClick** is a cross-platform wire-free visual click-track (or metronome) system, useful for ensembles, bands or other formations. No need for cables, headphones, extra amplifiers or mixers - just use wifi network and the **eClick** software.

[![Demo in youtube](https://img.youtube.com/vi/80av5Aq36Gk/0.jpg)](https://www.youtube.com/watch?v=80av5Aq36Gk&feature=youtu.be)


There are two parts in the software -  **server** (the main program that plays the click-track) and **client** (app for players that show information about bar numbers, beats, tempo etc).

The  "click-track" (time, tempo, tempo changes, stops, fermatas etc etc) is written into a score in [Csound](http://csound.github.io/about.html) format and played by the server. If necessary, also sound-clips or backtrack(s) can be started by the system in given moments. All necessary information is sent to clients (players) via wifi. Also extremely complex pieces can be encoded and played using the system. Every piece requires its own written out [score](score-files.html).  If the e-click score is done well, the playback can be started from any bar in the piece.

See more: [Getting started](getting-started.html) and [How it works](how-it-works.html).

The software is written using [QT development framework](http://www.qt.io/) and [Csound](http://csound.github.io/) to be usable on different platforms (Linux, OSX, Windows, Android, iOS).

The software is open-source, available under the GNU GPL License. The source can be found [here](https://github.com/tarmoj/eclick)

**eClick** is currently under development and is not yet recommended for mission-critical performances. 

But all help, testing and feedback is highly welcome (see [Contributing](contribute.html) )!

Author: Tarmo Johannes
