package SledgeWiki::Pages;
use strict;
use Sledge::Pages::Compat;

use Sledge::Authorizer::Null;
use Sledge::Charset::UTF8;
use Sledge::SessionManager::Cookie;
use Sledge::Session::MySQL;
use Sledge::Template::TT;

use SledgeWiki::Config;

sub create_authorizer {
    my $self = shift;
    return Sledge::Authorizer::Null->new($self);
}

sub create_charset {
    my $self = shift;
    return Sledge::Charset::UTF8->new($self);
}

sub create_config {
    my $self = shift;
    return SledgeWiki::Config->instance;
}

sub create_manager {
    my $self = shift;
    return Sledge::SessionManager::Cookie->new($self);
}

sub create_session {
    my($self, $sid) = @_;
    return Sledge::Session::MySQL->new($self, $sid);
}

use Sledge::DispatchQuery;

1;
