package CalcApp::Config::_common;
use strict;
use vars qw(%C);
*Config = \%C;

$C{TMPL_PATH}     = '/home/sledge-user/calcapp/template';
$C{DATASOURCE}    = [ 'dbi:mysql:test','root', '' ];
$C{COOKIE_NAME}   = 'sledge_sid';
$C{COOKIE_PATH}   = '/';
$C{COOKIE_DOMAIN} = undef;

1;
