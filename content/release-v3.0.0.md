Title: vClick v3.0.0 release
Date: 2023-08-11
Slug: release_3.0.0
Author: Tarmo Johannes
Tags: release
Category: News


**vClick  v3.0.0 is out!** 

    
[vClick](pages/about.html) is a free wireless visual click-track system for musicians.   


v3.0.0 brings vClick to a new level, with lots of fixes, better look (especially in Client) and new possibilities. v3.0.0 is meant to be built with Qt6. The last version (very close in functionality) that builds still with Qt5 is v2.2.0 - if you have an older system, you might need to stick to that.

See demo about vClick:

<iframe width="898" height="505" src="https://www.youtube.com/embed/5Xw0KSh3TMQ" title="vClick v3.0.0 Presentation" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


The source and binaries can be downloaded from: <https://github.com/tarmoj/vclick/releases/tag/v3.0.0>.


vClick CLient for **Android** can be installed also from [Google Play](https://play.google.com/store/apps/details?id=org.vclick.client2).

vClick CLient for **iOS**- preparing an iOS version is possible but is waiting for kind [donations](https://www.paypal.com/paypalme/tarmojohannes) to pay for Apple Developer license, renting a recent virtual Mac and getting the app to App Store.



### New in version 3.0.0:

* Support for Qt6

* Server can listen to different websocket ports. This way it is possible to run several servers in parallel. 

* Server can be started with several new command line options:

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

* Server can be built in console app mode (no gui, command line interface), that can be run on servers, Raspberry PI, any healess system or actually any computer. The no-gui version is not provided by the installers, it has to be built from sources with `CONFIG += no-gui` option 


* Client can set the websocket port in Menu.

* Material style in Client, better layout, updated support (including Android 13)

* WebAssembly build of the client to be run on the web. WebAssembly version works only over Websocket connection, there is no OSC support.



<br>


### Fixes

* Too many to count, especially in Server that is now way more stable.

<br>

### Known problems

* Sound (clicks) in Client on Linux sometimes too late or clipping.
* Playing sound files lightly tested and suspicious on Windows
* WebAssembly version - no sound (due WA restrictions), entering bar number, starting second and similar from keyboard may not work.
* Server sends both OSC and WS messages, if both are enabled and Client is connected. This is usually not a problem, maybe only when the sound is on, the double event can be heard.
* Setting different instruments  and delay time works only for OSC connections.



### Report issues

via github: <https://github.com/tarmoj/vclick/issues/new>



Tarmo Johannes <trmjhnns@gmail.com>

