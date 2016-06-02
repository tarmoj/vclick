#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Tarmo Johannes'
SITENAME = u'eClick'
SITEURL = 'http://tarmoj.github.io/eclick'
SITE_URL = SITEURL

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

THEME = '../theme/Responsive-Pelican' #'../theme/gum'
# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True
PLUGIN_PATHS = [] # pelican_youtube shoud be installed systemwide with pip
PLUGINS = [
     'pelican_youtube',
 ]

STATIC_PATHS = ['images']

DISPLAY_PAGES_ON_MENU = False
DISPLAY_CATEGORIES_ON_MENU = False

PAGE_ORDER_BY = 'sortorder'



# suffic /eclick/ since in github the page is in gh-branch by eclick repository, main site is tarmoj.github.io that is considered to be root
MENUITEMS = (
    ('About', '/eclick/pages/about.html'),
    ('Download', '/eclick/pages/download.html'),
    ('Getting started', '/eclick/pages/getting-started.html'),
    ('How it works', '/eclick/pages/how-it-works.html'),
    ('Score files', '/eclick/pages/score-files.html'),
    ('Contribute', '/eclick/pages/contribute.html'),
    ('Contact', '/eclick/pages/contact.html')
)
