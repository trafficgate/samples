package SledgeWiki::WikiPage;
# $Id$
#
# Tatsuhiko Miyagawa <miyagawa@edge.jp>
# EDGE, Co.,Ltd.
#

use strict;
use SledgeWiki::Formatter;

use File::Spec;
use FileHandle;
use URI::Escape;

use vars qw($WikiDir $DefaultName);

$DefaultName = "WelcomePage";

sub default_name { $DefaultName }

sub retrieve {
    my($class, $name) = @_;
    $name ||= $DefaultName;
    my $file = $class->wikiname2file($name);
    my $fh = FileHandle->new($file);
    if ($fh) {
	my $data = do { local $/; <$fh> };
	return bless { name => $name, body => $data }, $class;
    } else {
	return bless { name => $name, body => undef, new => 1 }, $class;
    }
}

sub wikiname2file {
    my($class, $name) = @_;
    return File::Spec->catfile($WikiDir, uri_escape($name));
}

sub name { shift->{name} }
sub body { shift->{body} }

sub is_new {
    my $self = shift;
    $self->{new};
}

sub set {
    my($self, $key, $value) = @_;
    $self->{$key} = $value;
}

sub save {
    my $self = shift;
    my $file = $self->wikiname2file($self->name);
    my $fh = FileHandle->new(">$file") or die "$file: $!";
    $fh->print($self->body);
    $fh->close;
}

sub wikipage_exists {
    my($self, $name) = @_;
    my $f = $self->wikiname2file($name);
    return -e $f;
}

sub as_html {
    my $self = shift;
    my $formatter = SledgeWiki::Formatter->new($self);
    (my $body = $self->body) =~ tr/\r//d;
    $formatter->process($body);
}

1;
