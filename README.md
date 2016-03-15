
#eClick
**eClick** is a wire-free visual click-track (or metronome) system, useful for ensembles, bands or other formations. No need for cables, headphones, extra amplifiers or mixers - just use wifi network and the **eClick** software.

[![Demo in vimeo](https://i.vimeocdn.com/video/553114335_200x150.jpg)](https://vimeo.com/152966128)


There are two parts in the software -  **server** (the main program that plays the click-track) and **client** (apps for players that show information about bar numbers, beats, tempo etc).

The  "click-track" (time, tempo, tempo changes, stops, fermatas etc etc) is written into a score in [Csound](http://csound.github.io/about.html) format and played back by the server. If necessary, also sound-clips or backtrack(s) can be started by the system in given moments. All necessary information is sent to clients (players) via wifi (OSC messages). Also extremely complex pieces can be encoded and played using the system. Every piece requires its own written out score.  If the e-click score is done well, the playback can be started from any bar in the piece.

The **client app** keeps the players together and shows a lot of useful information:

* countdown before start		
* bar and beat numbers		
* current tempo		
* coloured "leds" blink to show first beat (red), other beats (green) or off-beats (blue)		
* the "leds" are animated according to the tempo - the speed of shrinking gives idea when the next beat comes (like conductor's hand approaching to the next beat)		


The software is written using [QT development framework](http://www.qt.io/) and [Csound](http://csound.github.io/) and is portable to almost any wide-spread platform (Linux, OSX, Windows, Android, iOS).

The software is open-source, available under the GNU GPL License. The source can be found here: LINK

**eClick** is currently under development and not yet ready for wider use. But all help, testing and feedback is highly welcome!

Author: Tarmo Johannes trmjhnns ae gmail d com
=======
#eClick cient

A program/app that receives OSC messages about click-track of piece, sent by eClick server.

Displays bar and beat numbers, messages, blinks according to beats.

See more: <http://tarmoj.github.io/eclick.html>

(c) Tarmo Johannes 2015 trmjhnns@gmail.com

