package UnixUser::Cart;
use strict;
use UnixUser::Book;

sub new {
    my $class = shift;
    bless { _items => {} }, $class;
}

sub add_item {
    my($self, $item) = @_;
    $self->{_items}->{$item->id}++;
}

sub update_item {
    my($self, $id, $quantity) = @_;
    if ($quantity == 0) {
        delete $self->{_items}->{$id};
    } else {
        $self->{_items}->{$id} = $quantity;
    }
}

sub clear {
    my $self = shift;
    $self->{_items} = {};
}

sub items {
    my $self = shift;
    return map UnixUser::Book->retrieve($_),
        keys %{$self->{_items}};
}

sub quantity_for {
    my($self, $item) = @_;
    return $self->{_items}->{$item->id};
}

sub total_quantity {
    my $self = shift;
    my $total = 0;
    my @books = $self->items;
    $total += $self->quantity_for($_) for @books;
    return $total;
}

sub total_price {
    my $self = shift;
    my $price = 0;
    my @books = $self->items;
    $price += $_->price * $self->quantity_for($_) for @books;
    return $price;
}

1;
