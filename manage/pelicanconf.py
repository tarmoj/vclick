#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Tarmo Johannes'
SITENAME = u'eClick'
SITEURL = ''

TIMEZONE = 'Europe/Tallinn'

DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

# Blogroll
#LINKS =  (('Csound', 'http://csound.github.io/'),           )

# Social widget
#SOCIAL = (('You can add links in your config file', '#'),
#          ('Another social link', '#'),)

DEFAULT_PAGINATION = False

THEME = '../theme/gum'
# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True
PLUGIN_PATHS = [] # pelican_youtube shoud be installed systemwide with pip
PLUGINS = [
     'pelican_youtube',
 ]

STATIC_PATHS = ['images']

DISPLAY_PAGES_ON_MENU = False
DISPLAY_CATEGORIES_ON_MENU = False

MENUITEMS = (
    ('About', '/pages/about.html'),
    ('Download', '/pages/download.html'),
    ('Getting started', '/pages/getting-started.html'),
    ('How it works', '/pages/how-it-works.html'),
    ('Score files', '/pages/score-files.html'),
    ('Contribute', '/pages/contribute.html'),
    ('Contact', '/pages/contact.html')
)
