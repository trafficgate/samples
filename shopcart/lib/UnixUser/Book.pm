package UnixUser::Book;
use strict;

# id => data (hashref)
my %Books = (
    1 => {
        title     => 'UNIX USER',
        publisher => 'SOFTBANK',
        price     => 1380,
    },
    2 => {
        title     => '2ちゃんねる AA大辞典',
        publisher => 'SOFTBANK',
        price     => 1200,
    },
    3 => {
        title     => '猫でもわかるWindowsプログラミング',
        publisher => 'SOFTBANK',
        price     => 2800,
    },
);

sub retrieve_all {
    my $class = shift;
    my @books;
    for my $id (keys %Books) {
        push @books, $class->retrieve($id);
    }
    return @books;
}

sub retrieve {
    my($class, $id) = @_;
    my $data = $Books{$id} or return;
    bless { id => $id, %$data }, $class;
}

# accessors
sub id        { shift->{id} }
sub title     { shift->{title} }
sub publisher { shift->{publisher} }
sub price     { shift->{price} }

1;
