Title: Getting started
Date: 2016-05-31 10:20
sortorder: 3
Category: Pages

You need to get two programs to work together - the server and client(s).

<img src=../images/eclick-server.png width=64 >
**The server** has red application icon. It plays the clicktrack and sends signals about beats, bar numbers etc to all players over wifi.



<img src=../images/eclick-client.png width=64 > **The client** is the app marked with green icon. It receives the messages from server and displays the beats and other info to player(s). You can have numerous clients connected to the server, ie the server sends the same signals to all players. It is most convenient to have clients running in smartphones or tablests but laptops or computers are also great (in fact they work better :) ).

###First steps: 

1) Donwload server to your computer (see [Downloads](download.html) )

2) Download a client to your device(s) - for testing it is useful to install a client also to the same computer where you have the server.

3) First test - start the server and client in one computer. In server press button **+ this computer**. You should see address 127.0.0.1 added to the Clients. 

Press **Start** If you see numbers moving on server's screen, the client should display the same numbers and blink the leds. If it does so, you are good to go.

<img src=../images/client%2Bserver_on_desktop.png width=600 >

<br><br>

##Connect client(s) and server

The server (the central computer) and the clients (player's phones/laptops) **must be IN ONE NETWORK** (the same wifi network or network cables connected to the same router). 

* *You ask*: How can I be sure the devices are in one network?

* *Answer*: Look at the IP address on client's and server's screen. If they look similar, just the ending is different - like 192.168.1.20 and 192.168.1.21 - everything is fine.

<br>

_NB! Use a good quality network! Try to keep the wifi router close to all players! Avoid public or overcrowded networks -  the performance will most certainly suffer. (Also in many public networks the clients are not allowed to connect to each other)._

<br>

To connect clients to server there are two possibilities: 

1. Enter the IP address of server to client's **Server address** field and press **Hello, Server**. You should receive a notification "Got you!" on client's screen. _NB! Don't overwrite the beginning nor the ending of the address, it should look like: ws://< IP address >:6006/ws . Sometimes it is necessary to press "Hello" twice._

2. Add the clients' addresses to server's field **Clients**, separated by commas. Then press **Update** and the clients on these addresses should be receiving the messages. The server remembers the addresses from last session, you don't need to enter them every time, if the addresses don't change.

<br>
### Playing a piece

The rest is easy - load a score file on the server with definitions of time signatures, tempos etc and press **Start**. You can also enter from which bar you want to start (useful from rehearsing).

To try out, download or copy a simple demo score file (50 bars in 4/4, tempo 60) from
<https://raw.githubusercontent.com/tarmoj/eclick/v0.1.1/server/simple-4-4.sco> to your computer and see if you can load and play it.

How to write or get score files for your specific pieces, see [Score files](score-files.html).





