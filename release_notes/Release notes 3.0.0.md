# vClick v3.0.0 released
 
 
Version 2 saw a lot of rolling development and no more full releases after v2.0.0.

v3.0.0 bring vClick to a new level, with lots of fixes, better look (especially in Client) and new possibilities. v3.0.0 is meant to be built with Qt6 (binaries built with Qt 6.5.2). The last version (very close in functionality) that builds still with Qt5 is v2.2.0. <https://github.com/tarmoj/vclick/releases/tag/v3.0.0>


The source and binaries can be downloaded from: <https://github.com/tarmoj/vclick/releases/tag/v3.0.0>.


### New in version 3.0.0:

* Support for Qt6

* Server can listen to different websocket ports. This way it is possible to run several servers in parallel. Server can be started with several new command line options:

```
vClick Server, version  3.0.0
Usage: ./vclick-server [options]

Options:
  -h, --help                      Displays help on commandline options.
  --help-all                      Displays help including Qt specific options.
  -v, --version                   Displays version information.
  -p, --port <port>               Websocket port that the server will be
                                  listening to
  -s, --score-files <scoreFiles>  Scorefiles (if not read from settings) ,
                                  separated by semicolon
  --no-osc, -n                    Do not send OSC messages, do not register
                                  oscClients


```

* Server can be built in console app mode (no gui, command line interface), that can be run in servers, Raspberry PI or any computer. The no-gui version is bot provided in the installers, it has to be built from sources with `CONFIG += no-gui` option 


* Client can set the websocket port in Menu.

* Material style in Client, better layout, updated support (including Android 13)

* WebAssembly version of the client to be run on the web.



<br>


### Fixes

* Too many to count, especially in Server that is now way more stable.

<br>

### Known problems

* Sound (clicks) in Client on Linux sometimes too late and clipping.
* Playing sound files lightly tested and suspicious on Windows
* WebAssembly version - no sound (due WA restrictions), entering bar number, starting second and similar from keyboard may not work.
* Server send both OSC and WS messages, if both are enabled.


Tarmo Johannes <trmjhnns@gmail.com>

