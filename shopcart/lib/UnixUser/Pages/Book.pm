package UnixUser::Pages::Book;
use strict;
use base qw(UnixUser::Pages);

# �ƥ�ץ졼�ȥǥ��쥯�ȥ������
__PACKAGE__->tmpl_dirname('book');

use UnixUser::Book;
use UnixUser::Cart;

# BEFORE_DISPATCH �եå�����Ͽ (#1)
__PACKAGE__->register_hook(
    BEFORE_DISPATCH => \&init_cart,
);

sub init_cart {
    my $self = shift;
    # session ��� cart �����
    my $cart = $self->session->param('cart');
    unless (defined $cart) {
        $cart = UnixUser::Cart->new();
        $self->session->param(cart => $cart);
    }
}

# index:
#  ���Ұ�����ɽ��
sub dispatch_index {
    my $self = shift;
    my @books = UnixUser::Book->retrieve_all();
    $self->tmpl->param(books => \@books);
}

# view:
#  ���ҥ����ƥ�ξܺ�ɽ��
sub dispatch_view {
    my $self = shift;
    my $id = $self->r->param('id');
    my $book = UnixUser::Book->retrieve($id)
        or die "No such book: $id";
    $self->tmpl->param(book => $book);
}

# add_cart:
#  �����Ȥ��ɲ�
sub dispatch_add_cart {
    my $self = shift;
    my $id = $self->r->param('id');
    my $book = UnixUser::Book->retrieve($id)
        or die "No such book: $id";
    my $cart = $self->session->param('cart');
    $cart->add_item($book);
    $self->session->param(cart => $cart);
    $self->redirect('register.cgi'); # �쥸��
}

# register (GET):
#  �쥸ɽ��/�Ʒ׻�
sub dispatch_register {
    my $self = shift;
    if (my $id = $self->r->param('id')) {
        my $quant = $self->r->param('quantity');
        my $cart = $self->session->param('cart');
        $cart->update_item($id, $quant); # �Ʒ׻�
    }
}

# register(POST): (#2)
#  ����
sub post_dispatch_register {
    my $self = shift;
    # XXX: �ºݤη�ѽ����ϥ����˵���!
    my $cart = $self->session->param('cart');
       $cart->clear();  # �����Ȥ����
    $self->load_template('register_done');
    $self->finished(1); # GET�ˤ������˽�λ
}

1;
