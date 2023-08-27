#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Tarmo Johannes'
SITENAME = u'vClick'
SITEURL = 'https://tarmoj.github.io/vclick'
SITE_URL = SITEURL

TIMEZONE = 'Europe/Tallinn'

DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
#FEED_ALL_ATOM = None
#CATEGORY_FEED_ATOM = None
#TRANSLATION_FEED_ATOM = None

# Blogroll
#LINKS =  (('Csound', 'http://csound.github.io/'),           )

# Social widget
#SOCIAL = (('You can add links in your config file', '#'),
#          ('Another social link', '#'),)

DEFAULT_PAGINATION = False

#THEME = '../theme/Responsive-Pelican' #'../theme/gum'
THEME = "../theme/Flex"
# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
PLUGIN_PATHS = [] # pelican_youtube shoud be installed systemwide with pip
#PLUGINS = [
     #'pelican_youtube',
 #]

STATIC_PATHS = ['images', 'scores']

DISPLAY_PAGES_ON_MENU = False
DISPLAY_CATEGORIES_ON_MENU = False

PAGE_ORDER_BY = 'sortorder'



# suffic /eclick/ since in github the page is in gh-branch by eclick repository, main site is tarmoj.github.io that is considered to be root
MENUITEMS = (
    ('Home', SITEURL+'/index.html'),
    ('About', SITEURL+'/pages/about.html'),
    ('Download', SITEURL+'/pages/download.html'),
    ('Getting started', SITEURL+'/pages/getting-started.html'),
    ('How it works', SITEURL+'/pages/how-it-works.html'),
    ('Score files', SITEURL+'/pages/score-files.html'),
    ('Library of scores', SITEURL+'/pages/score-library.html'),
    ('Contribute', SITEURL+'/pages/contribute.html'),
    ('Contact', SITEURL+'/pages/contact.html')
)
