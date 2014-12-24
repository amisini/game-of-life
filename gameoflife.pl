use strict;
use warnings;


#Usage: perl gameoflife.pl 10 10 5 1

=Inputs
$rows: Number of rows 
$columns: Number of columns 
$iterations: Number of iterations 
$delay: Delay in seconds
=cut
my ($rows, $columns, $iterations, $delay) = @ARGV;

=generate_board
If the number=1: generates a random board of 0 and 1
If the number=0: generates only a board with 0
=cut
sub generate_board {
    my ($row, $column, $number, @board) = @_;
    push @board, [map {int(rand($number + 1))} (1 .. $column)] for (1 .. $row);
    return @board;
}

=neighbor_numbers
Returns the number of neighbors
=cut
sub neighbor_numbers {
    my ($row, $rows, $column, $columns, $board) = @_;
    return grep
        { 
            $$board[($row + $$_[0]) % $rows][($column + $$_[1]) % $columns]
        }
        ([-1,-1],[-1, 0],[-1, 1],[ 0,-1],
         [ 0, 1],[ 1,-1],[ 1, 0],[ 1, 1])
}

=print_board
Print the board.
system("cls") is for windows.
If you use OS X or Linux use: system("clear");
=cut
sub print_board {
    system("cls");
    print +(join '', @$_).$/ foreach @_;
    sleep $delay;
}


sub main {
    my ($rows, $columns, $iterations) = @_;
    my @board = generate_board($rows, $columns, 1); #generates a radom board of 0 and 1
    foreach (1..$iterations) {
        my @next = generate_board($rows, $columns, 0); #generates a board with all 0
        print_board(@board);
        foreach my $row (0 .. $rows - 1) {
            foreach my $column (0 .. $columns - 1) {
                my $neighbors = neighbor_numbers($row, $rows, $column, $columns, \@board);
                #udate the next board if for 2 or 3 neighbors
                $next[$row][$column] = $board[$row][$column] & ($neighbors == 2) | ($neighbors == 3);
            }
        }        
        @board = @next;
    }
}

main($rows, $columns, $iterations);