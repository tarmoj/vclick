Title: About
Date: 2016-05-31 10:20
sortorder: 1
Category: Pages

**vClick is a wireless visual click-track or metronome system for ensembles** where central computer plays  the "click-track" of the piece and sends signals about beats, bar numbers, tempo changes and other information to the palyers' screens over wifi. Players can use their smartphones, tablets or laptops to display the info - no special hardware needed. Also no need for cables, headphones, extra amplifiers or mixers.

**vClick is free and open-source** see [Downloads](downloads.html).


**vClick is cross-platform** - the software exists for Linux, OSX and Windows, players' apps also for Android and iOs. 


vClick works best in situations where you cannot hear clear beat or can get easily lost, have difficulties playing together but you don't have or cannot use a conductor.  It can be useful also in very diffents situations or for different formations. 

See a demo:

[![Demo in youtube](https://img.youtube.com/vi/-w_sGl_7SuQ/0.jpg)](https://www.youtube.com/watch?v=-w_sGl_7SuQ&t=36s)


There are two parts in the software -  **server** (the main program that plays the click-track) and **client** (app for players that show information about bar numbers, beats, tempo etc).

The  "click-track" (time, tempo, tempo changes, stops, fermatas etc etc) is written into a score in [Csound](http://csound.github.io/about.html) format and played by the server. If necessary, also sound-clips or backtrack(s) can be started by the system in given moments. All necessary information is sent to clients (players) via wifi. Also extremely complex pieces can be encoded and played using the system. Every piece requires its own written out [score](score-files.html).  If the vClick score is done well, the playback can be started from any bar in the piece.

See more: [Getting started](getting-started.html) and [How it works](how-it-works.html).

The software is written using [QT development framework](http://www.qt.io/) and [Csound](http://csound.github.io/) to be usable on different platforms (Linux, OSX, Windows, Android, iOS).

The software is open-source, available under the GNU GPL License. The source can be found [here](https://github.com/tarmoj/eclick)

Any help, testing and feedback is highly welcome (see [Contributing](contribute.html) )!

Author: Tarmo Johannes
