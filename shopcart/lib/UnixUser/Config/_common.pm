package UnixUser::Config::_common;
use strict;
use vars qw(%C);
*Config = \%C;

$C{TMPL_PATH}     = '/home/miyagawa/uu-sledge/view';
$C{DATASOURCE}    = [ 'dbi:mysql:uu','root', '' ];
$C{COOKIE_NAME}   = 'sledge_sid';
$C{COOKIE_PATH}   = '/';
$C{COOKIE_DOMAIN} = undef;

1;
