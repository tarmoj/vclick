# eyeClick 0.2.0 released
 

version 0.2.0 introduces lot's of improvements, bug fixes and new features. It seems to be fully functional and ready to use. Nevertheless it needs still more testing -  be careful in mission critical situations!
 
The source and binaries can be downloaded from: <https://github.com/tarmoj/eyeclick/releases/tag/0.2.0>.

**eyeClick Client for iOs** can now be used via TestFlight app for all testers who let know their email address.

### New in version 0.2.0:

* Configurable sound output, if score uses "playfile" commands. Most typical options for sound in "Csound Options" field is: 

``-odac -d``  

The folder for sound files (SFDIR) can be set in server. Use "Reset" button to go back into soundless mode (server).

* Lot's of improvements to iOs look and building system

* Android and iOs -  keep screen always open.

* Many improvements for better layout, automatic scaling of bar/beat numbers to fit.

* Possibility to set delay to sync with slower devices (client, Menu->Toggle delay row).

* "Update IP address"  in menu (if network has been changed) -  both client and server

* Added possibility to run a system command on start/stop (server) - commands are set in server's configuration file as rows startCommand="" and stopCommand=""

* NB! changed client's **OSC port to 87878** (to avoid possible port usage conflict on iOs) -  **this makes it incompatible with version 0.1.*!!!**

* Went over to QtQuick Controls 2.0 (requires Qt 5.7 or later) for better menu placement, cross platform font sizes and more (client, not used in Windows version yet).

### Fixes

* Fixed missing subdivision click (blue led)

* Put back colors for different beat numbers

* iOs -  fixed automatic restarting of OSC listener after standby, screen close or similar (works also after phone call :) )

* Fixed occasional crashes on starting/stopping repeatedly (server)

* Better conditions in .pro file to build on Windows

* Fixed setting volume before playback

* Fixed need to press "Connect" twice sometimes (client). Shows notification "Failed", if there no connection.




### Plans for further development

*  Rename the software (probably to eyeyeClick) to avoid possible trademark conflict

* Implement system where different clients can receive different signals.

* Dialog to select serveral scorefiles and set shortcuts to start them, if piece needs to be performed in multiple sections.

* Configurable OSC port number (both server and client)

* Release the version 1.0 to Google Play (android) and Apple Store

 