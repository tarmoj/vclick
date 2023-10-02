#!/bin/bash

SOURCE="client-square-1024.png"


sips -Z 29 --out AppIcon29x29.png $SOURCE
sips -Z  58 --out AppIcon29x29@2x.png $SOURCE
sips -Z  58 --out AppIcon29x29@2x~ipad.png $SOURCE
sips -Z 29 --out AppIcon29x29~ipad.png $SOURCE
sips -Z 80 --out AppIcon40x40@2x.png $SOURCE
sips -Z  80 --out AppIcon40x40@2x~ipad.png $SOURCE
sips -Z 40 --out AppIcon40x40~ipad.png $SOURCE
sips -Z 100 --out AppIcon50x50@2x~ipad.png $SOURCE
sips -Z 50 --out AppIcon50x50~ipad.png $SOURCE
sips -Z 57 --out AppIcon57x57.png $SOURCE
sips -Z 114 --out AppIcon57x57@2x.png $SOURCE
sips -Z 120 --out AppIcon60x60@2x.png $SOURCE$
sips -Z 144 --out AppIcon72x72@2x~ipad.png $SOURCE
sips -Z  72 --out AppIcon72x72~ipad.png $SOURCE
sips -Z 76 --out AppIcon76x76~ipad.png $SOURCE

sips -Z 512 --out iTunesArtwork512x512.png $SOURCE
sips -Z 1024 --out iTunesArtwork@2x.png $SOURCE

#cp generated/*.png path/to/Images.xcassets/AppIcon.appiconset