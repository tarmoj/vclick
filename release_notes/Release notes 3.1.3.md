## vClick v3.1.3 released
 
 
 DRAFT
 
vClick 3.1.3 is next public release after 3.0.0 in 2023. 

Although the version code has changes a little, much work has been done. See below.



*NB! Due the Qt6 requirements, v3.x requires at least MacOS 11 on Mac. If you have an older OS, you can use the binaries from  <https://github.com/tarmoj/vclick/releases/tag/v2.2.0>*


Downloads: <https://github.com/tarmoj/vclick/releases/tag/v3.1.3>.

vClick CLient for **Android** can be installed also from [Google Play](https://play.google.com/store/apps/details?id=org.vclick.client2).

vClick CLient for **iOS**-  LINK


<br>

### New in version 3.0.0:

* Basic integrationo with Reaper via OSC messages - ....

* Search Server button on Client

 *  Server sends score list to Client, so the piece can be chosen from drop-down menu with file names on the Client (Remote Control -> Score).

* Cleaner and better spaced layout on Server



<br>


### Fixes

* Use QOsc as separate library, ironed out many warnings (finished porting to Qt6)
* ....

<br>

### Known problems

* WebAssembly version - no sound (due WA restrictions), entering bar number, starting second and similar from keyboard may not work.
* Server sends both OSC and WS messages, if both are enabled and Client is connected. This is usually not a problem, maybe only when the sound is on, the double event can be heard.
* Setting different instruments  and delay time works only for OSC connections.


Tarmo Johannes <trmjhnns@gmail.com>

