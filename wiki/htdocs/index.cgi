#!/usr/local/bin/perl -w
# $Id$
#
# Tatsuhiko Miyagawa <miyagawa@edge.jp>
# EDGE, Co.,Ltd.
#

use strict;
use SledgeWiki::Pages::Index;
SledgeWiki::Pages::Index->dispatch_query(".cmd");
