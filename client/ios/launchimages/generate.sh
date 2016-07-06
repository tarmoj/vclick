#!/bin/bash

LANDSCAPE="launch-screen-landscape.png"
PORTRAIT="launch-screen-portrait.png"

sips -z 480 320  --out LaunchImage.png $PORTRAIT
sips -z 960 640  --out LaunchImage@2x.png $PORTRAIT
sips -z 1136 640  --out LaunchImage568h@2x.png $PORTRAIT
sips -z 1004 768  --out LaunchImage-Portrait.png $PORTRAIT
sips -z 2008 1536  --out LaunchImage-Portrait@2x.png $PORTRAIT

sips -z 748 1024 --out LaunchImage-Landscape.png $LANDSCAPE
sips -z 1496 2048 --out LaunchImage-Landscape@2x.png $LANDSCAPE
