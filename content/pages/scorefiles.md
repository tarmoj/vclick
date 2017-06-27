Title: Score files
Date: 2016-05-31 10:20
sortorder: 5
Category: Pages

*You ask:* How can I play a certain piece with vClick system? How does vClick know when to send the the beats? How is the "click-track" done?

vClick needs a special score where everything is defined. It is a plain text file, written in standard Csound score syntax. The  file has usually .sco ending.

You can study [Csound score syntax](https://csound.github.io/docs/manual/ScoreTop.html) and the demo scores:

<https://github.com/tarmoj/eclick/blob/master/server/simple-4-4.sco> (simple 4/4 for 50 bars)

<https://github.com/tarmoj/eclick/blob/master/server/test.sco> (the test score included also in server by default)

to see how it is done. You can write the score files yourself but with more complex pieces it can be quite tricky.

It can be easier to order the score file from me, escpecially since this is a good way to support the project and keep it in development. 

<br>

###Order the score

Please send the musical score in pdf to me at [trmjhnns ae gmail com](mailto:trmjhnns@gmail.com).

I will have a look and if the piece is possible to transcribe I will write a vClick score according to it and send it back. We must be in good contact meanwhile, of course, to get all details  - like durations of fermatas  etc etc - right.
<br>

####How much does it cost?

A simple score - 50 €

Medium or more complex score - 100 €

Very long or complex score or special rewrite for the server software (like having many clictracks going in different tempos) - let's agree.

I will let you know after seeing the score.


Feel free to share the vClick scores or find other people who can help with transcribing the scores.

<br>
<a name="multichannel"></a>
####Notes on multichannel scorel lines

Since version 0.3.0 you can send different information to different players

Say the flutist want its bar subdivided 3+3+2 but clarinet 2+3+3 or you want players to help with different polyrhythms or send different notifications to different players. You can do it.

To set to which player (which channel) the signal is sent, you must set the "channel" parameter in score lines. 0 means TUTTI - send to everybody, otherwise it should be bitwise sum of the voices you want to send the signal to: 1st voice - 1, 2nd voice - 2, 3rd voice - 4, 4st - 8 etc. Up to 32 different voices can be used.

For example:

```
i	2	0	4	4	4	2	1	21 ; send 4/4 subidivided in 2, bar number 1 to voices 1, 3 and 5 (1+4+16) 
```

```
i	"notification"	0	2	"You are 1!"	1 ; send notification to voice 1
```


