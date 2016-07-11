Title: Download
Date: 2016-05-31 10:20
sortorder: 2
Category: Pages

The latest release (both source code and binary installers) can always be found from: 

<https://github.com/tarmoj/eclick/releases/latest>

<br>
<br>

# Version 0.1.1


##Server

[Windows](https://github.com/tarmoj/eclick/releases/download/v0.1.1/eclick-server-setup-0.1.1.exe)

[OSX](https://github.com/tarmoj/eclick/releases/download/v0.1.1/eclick-server-0.1.1.dmg)

Linux - please build from [source code](https://github.com/tarmoj/eclick/archive/v0.1.1.tar.gz) 


##Client

[Android](https://github.com/tarmoj/eclick/releases/download/v0.1.1/eclick-client-0.1.1.apk) - with next versions available also in Google Play

[Windows](https://github.com/tarmoj/eclick/releases/download/v0.1.1/eclick-client-setup-0.1.1.exe)

[OSX](https://github.com/tarmoj/eclick/releases/download/v0.1.1/eclick-client-0.1.1.dmg)

**Linux** - please build from [source code](https://github.com/tarmoj/eclick/archive/v0.1.1.tar.gz)

**iOs** - the app is not in Apple Store yet but can be downloaded and used by registered testers from 
<http://tarmo.uuu.ee/varia/failid/eclick/ios/ios-download.html> 
To become one, please send me the UDID of your device (necessary for granting access to use the app's test version).
See <http://get.udid.io> or <http://whatsmyudid.com> to find out how to get one. 

<br>
<a name="issues011"></a>
##Known issues

* The **exact timing of the clients' clicks depends on the quality of network and the speed and power of the devices** - older and weaker smartphones may display the clicks later  i.e. the clicks may not be always exactly together.  Mostly the tolerance is acceptable but please try to use similar devices for you clients. In next release I plan to create settings where you can set different delays for clients to even it out, if necessary.

* On Windows 8 and Windows 10 **the server does not start playback if the program is started from the working directory** (ie when you double click on the _eclick-server.exe_ file)
    * workaround: - create a Desktop shortcut, right-click on it, open "Properties" and change the working directory from C:\Program files (x86)\eClick\server to something else. OR start the server by double clicking (or creating a link to) **eclick-server.bat** in the same directory where is the .exe.

* On Windows the Csound output console displays often **unreadable characters**. Please ignore it, it will be fixed in next version. The most important role of the console is to show that Csound is working.

* With the client program, you sometimes need to **click "Hello, server" twice**,   even if you have the address correct.



