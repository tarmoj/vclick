Title: How it works
Date: 2016-05-31 10:20
sortorder: 4
Category: Pages


This is a bit more techical stuff but probably interesting to many people, who undertand the terms like OSC messages, websockets etc - it may help you to use the system in your own setup, write custom clients (like using Processing, Max MSP or any other OSC aware software). Feel free to be creative and use eClick as you need!


###The Client

The client is listening by default to **incoming OSC messages on port 57878**. (It was 87878 for version 1.* but the port can be set from the Client's menu.


The messages' format is:
 
Path | Types | Data 
 --- | --- | --- 
/metronome/beatbar | ii  | < bar> < beat> 
/metronome/led | if | < led\*> < duration>  
/metronome/tempo | f | < tempo>
/metronome/notification | s | < message>\**
/metronome/notification | sf | < message> < duration>

The types stand for: i - integer, f- floating point number, s - string.

\* Led numbers: 0 - red, 1 -  green, 2 - blue<br>
\*\* If no duration given, 4 seconds is taken as default.

For example (using oscsend on Linux), send following messages to client with IP address 192.168.1.151:

	oscsend 192.168.1.151 57878 /metronome/led if 0 0.5

		- blink red led for 0.5 seconds

	oscsend 192.168.1.151 57878 /metronome/beatbar ii 12 4

		- set bar number to 12 and beat to 4

	oscsend 192.168.1.151 57878 /metronome/notification s "Are you there?"

		- Send message, will be displayed for 4 seconds.


	

###The Server	

The **vclick Server** is running a websocket server on port 6006. It is used mostly for registering clients (clients send a "hello" websocket message when "Hello, Server" button is pressed), but it can be used also in two other ways:

It can send out websocket messages about beats, leds etc, when "Send ws" is ticked on the Server window. This way the client can be aslo be web based. In fact I developed the system at first this way - the users don't need a special app but just open one page in their browser. It works but is less stable. These files are not part of the git-project, if you are interested to have a look or try it out, please send me an e-mail.

Also vClick server can be driven via websockest messages - you can start/stop the playback, send in messages about beats, led blinks, tempo changes etc and the server will send according OSC messages to all registered clients.  This way you can develop your own programs, scripts or web applications that can work together with vClick system according to your better needs.

The messages expected are strings in following format:

	"start" -  as if "Start" had been pressed on Server. Starting from given bar not implemented yet.
	"stop" -  as if "Stop" had been pressed on Server
	"bar <number>" - set bar number to "number"
	"beat <number>" - set beat number to "number"
	"duration <duration>" -  set duration of either led blink or notification
	"led < number> <duration>" - blink led number 0-red|1-green|2-blue for < duration> seconds
	"tempo <tempo>" -  set tempo
	"notification <text>" -  send notification, shown for <durtaion>  seconds.


The info can be combined also into one string:

	"bar 10 beat 4 led 1 druation 0.25"
		-set bar to 10, beat 4, blink green led for 0.25 seconds 

<br>

The source code is available at <https://github.com/tarmoj/vclick>. Feel free to study it, improve or develop further or use in any other context! (obeying to GNU GPL license included in the sources).