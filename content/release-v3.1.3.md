Title: vClick v3.1.3 release
Date: 2025-07-10
Slug: release_3.1.3
Author: Tarmo Johannes
Tags: release
Category: News


## vClick v3.1.3 Released

[vClick](pages/about.html) is a free wireless visual click-track system for musicians.

vClick 3.1.3 is the next public release after 3.0.0 (2023).

Although the version number has changed only slightly, a lot of work has gone into this release. See below for details.

Downloads: <https://github.com/tarmoj/vclick/releases/tag/v3.1.3>

The vClick Client for **Android** is also available on [Google Play](https://play.google.com/store/apps/details?id=org.vclick.client2).

The vClick Client for **iOS** is available on the [App Store](https://apps.apple.com/us/app/vclick-client/id1247820434).

**NB!** Due to Qt6 requirements, v3.x requires at least macOS 11. If you're using an older OS, you can download binaries from: https://github.com/tarmoj/vclick/releases/tag/v2.2.0

<br>

     
See demo about vClick:

<iframe width="853" height="480" src="https://www.youtube.com/embed/Hq4hpwjrqhM" title="Introduction of vClick 3.1.3" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>


### New in version 3.1.3:

* Basic integration with Reaper via OSC messages — seek to vClick’s start bar (or starting second in Time mode), start, and stop.
* **Search Server** button in the Client — automatically finds and connects to the server on the same network.
* The server sends the score list to the client, allowing selection of the piece from a drop-down menu by file name (Remote Control → Score).
* Cleaner and better-spaced layout on the server.
* Signed binaries on macOS.
* Removed Android support from the server.
* Moved QOsc to a separate repository; use a Git submodule to include it. The QOsc code was also polished for Qt6. https://github.com/tarmoj/qosc

<br>

### Fixes

* QOsc is now used as a separate library; many warnings were resolved (completing the Qt6 port).
* Fixed handling of complex bars in `test.sco`.
* Set status bar color for Android in the client.
* Closed temporary score file properly.

<br>

### Known problems

* WebAssembly version — no sound (due to WA restrictions). Entering bar numbers, starting seconds, and similar values via keyboard may not work.
* The server sends both OSC and WS messages if both are enabled and the client is connected. This is usually not a problem, but if sound is on, double events may be heard.
* Setting different instruments and delay times works only with OSC connections.

### Report issues

via github: <https://github.com/tarmoj/vclick/issues/new>



Tarmo Johannes <trmjhnns@gmail.com>

