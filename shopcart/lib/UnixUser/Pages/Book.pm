package UnixUser::Pages::Book;
use strict;
use base qw(UnixUser::Pages);

# テンプレートディレクトリの設定
__PACKAGE__->tmpl_dirname('book');

use UnixUser::Book;
use UnixUser::Cart;

# BEFORE_DISPATCH フックに登録 (#1)
__PACKAGE__->register_hook(
    BEFORE_DISPATCH => \&init_cart,
);

sub init_cart {
    my $self = shift;
    # session 内の cart 初期化
    my $cart = $self->session->param('cart');
    unless (defined $cart) {
        $cart = UnixUser::Cart->new();
        $self->session->param(cart => $cart);
    }
}

# index:
#  書籍一覧の表示
sub dispatch_index {
    my $self = shift;
    my @books = UnixUser::Book->retrieve_all();
    $self->tmpl->param(books => \@books);
}

# view:
#  書籍アイテムの詳細表示
sub dispatch_view {
    my $self = shift;
    my $id = $self->r->param('id');
    my $book = UnixUser::Book->retrieve($id)
        or die "No such book: $id";
    $self->tmpl->param(book => $book);
}

# add_cart:
#  カートに追加
sub dispatch_add_cart {
    my $self = shift;
    my $id = $self->r->param('id');
    my $book = UnixUser::Book->retrieve($id)
        or die "No such book: $id";
    my $cart = $self->session->param('cart');
    $cart->add_item($book);
    $self->session->param(cart => $cart);
    $self->redirect('register.cgi'); # レジへ
}

# register (GET):
#  レジ表示/再計算
sub dispatch_register {
    my $self = shift;
    if (my $id = $self->r->param('id')) {
        my $quant = $self->r->param('quantity');
        my $cart = $self->session->param('cart');
        $cart->update_item($id, $quant); # 再計算
    }
}

# register(POST): (#2)
#  購入
sub post_dispatch_register {
    my $self = shift;
    # XXX: 実際の決済処理はココに記述!
    my $cart = $self->session->param('cart');
       $cart->clear();  # カートを空に
    $self->load_template('register_done');
    $self->finished(1); # GETにいかずに終了
}

1;
