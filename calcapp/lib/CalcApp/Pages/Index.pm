package CalcApp::Pages::Index;
use base qw(CalcApp::Pages);

sub dispatch_index { }

sub post_dispatch_index {
    my $self = shift;
    my $arg1 = $self->r->param('arg1');
    my $arg2 = $self->r->param('arg2');

    if ($arg1 ne  '' && $arg2 ne '') {
	# �û��¹�
	my $result = $arg1 + $arg2;
	$self->tmpl->param(result => $result);

	# �׻�����ι���
	my $history = $self->session->param('history') || [];
	unshift @$history, {
	    arg1 => $arg1, arg2 => $arg2,
	    result => $result,
	};
	my @new_history =  splice(@$history, 0, 10);

	# ���å�������Ȥ򹹿�����
	$self->session->param(history => \@new_history);
    }
}

1;
