package SledgeWiki::Pages::Index;
# $Id$
#
# Tatsuhiko Miyagawa <miyagawa@edge.jp>
# EDGE, Co.,Ltd.
#

use strict;
use base qw(SledgeWiki::Pages);

use SledgeWiki::WikiPage;
use URI::Escape;

sub dispatch_index {
    my $self = shift;
    my $name = $self->r->query_string || $SledgeWiki::WikiPage::DefaultName;
    my $wikipage = SledgeWiki::WikiPage->retrieve($name);
    $self->tmpl->param(wikipage => $wikipage);
}

sub post_dispatch_edit {
    my $self = shift;
    my $name = $self->r->param('page');
    my $wikipage = SledgeWiki::WikiPage->retrieve($name);
    $wikipage->set(body => $self->r->param('body'));
    $wikipage->save();
    $self->redirect("?" . uri_escape($name));
}

sub dispatch_edit {
    my $self = shift;
    my $name = $self->r->param('page');
    my $wikipage = SledgeWiki::WikiPage->retrieve($name);
    $self->tmpl->param(wikipage => $wikipage);
}

1;
