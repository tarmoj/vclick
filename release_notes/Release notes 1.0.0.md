# vClick 1.0.0 released
 

The first "production ready" version is out! It is based closely on version 0.3.0, the changes are described more in detail here.
 
The source and binaries can be downloaded from: <https://github.com/tarmoj/vclick/releases/tag/v1.0.0>.

**vClick Client for iOs** can now be installed from [App Store](https://itunes.apple.com/us/app/vclick-client/id1247820434?mt=8).

**vClick Client for Android** is available from [Google Play](https://play.google.com/store/apps/details?id=org.vclick.client).


**NB!** This software was called **eClick** before version 0.3.0, now it is **vClick** for "visual click-track system"


### New in version 1.0.0:

* Implemented multichannel support -  OSC messages are (ususally) sent from Csound, not WsServer classs. The latter can be enabled, if used together with reading Jack or driven by external Websocket messages.

Different players (or instruments/voices) can receive different signals (times, subdivisions, notifications etc). In Client there is option "Set instrument number" in menu, in Server the voice can be added as <number>: before the client's IP address like

``2:192.168.1.109``  

In the score the channels' (voices') prarameter must be set as bitwise sum of the voices:  1-  voice 1, 2- voice 2, 4 -  voice 3, 8 -  voice 4 etc. 

NB! Use 0 for TUTTI (sent to everyone).

Up to 32 voices can be used.


* Server -  sending Websocket and server's OSC is disabled by default, can be enabled from menu. 



### Fixes

* Better connection routins, also from "Update" instrument number in Client.

* Store voice numbers of clients in Server's settings

* Avoide extra permissions (Camera, Record_Voice) in Android build.
