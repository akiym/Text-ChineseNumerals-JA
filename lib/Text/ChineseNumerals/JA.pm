package Text::ChineseNumerals::JA;
use 5.008005;
use strict;
use warnings;
use parent qw/Exporter/;

our $VERSION = "0.01";

our @EXPORT = qw/num2chinese chinese2num/;

our $RE_CHINESE = qr/[\x{96f6}\x{3007}\x{4e00}\x{4e8c}\x{4e09}\x{56db}\x{4e94}\x{516d}\x{4e03}\x{516b}\x{4e5d}\x{5341}\x{767e}\x{5343}]/;
our $RE_CHINESE_ALL = qr/(?:[\x{96f6}\x{3007}\x{4e00}\x{4e8c}\x{4e09}\x{56db}\x{4e94}\x{516d}\x{4e03}\x{516b}\x{4e5d}\x{5341}\x{767e}\x{5343}\x{4e07}\x{5104}\x{5146}\x{4eac}\x{5793}\x{25771}\x{7a63}\x{6e9d}\x{6f97}\x{6b63}\x{8f09}\x{6975}]|\x{6052}\x{6cb3}\x{6c99}|\x{963f}\x{50e7}\x{7947}|\x{90a3}\x{7531}\x{4ed6}|\x{4e0d}\x{53ef}\x{601d}\x{8b70}|\x{7121}\x{91cf}\x{5927}\x{6570})/;

our $RE_CHINESE_ORDINARY = qr/\x{96f6}\x{3007}\x{4e00}\x{4e8c}\x{4e09}\x{56db}\x{4e94}\x{516d}\x{4e03}\x{516b}\x{4e5d}/;
our $RE_CHINESE_PART = qr/[\x{5341}\x{767e}\x{5343}]/;
our $RE_CHINESE_SPECIAL = qr/(?:[\x{4e07}\x{5104}\x{5146}\x{4eac}\x{5793}\x{25771}\x{7a63}\x{6e9d}\x{6f97}\x{6b63}\x{8f09}\x{6975}]|\x{6052}\x{6cb3}\x{6c99}|\x{963f}\x{50e7}\x{7947}|\x{90a3}\x{7531}\x{4ed6}|\x{4e0d}\x{53ef}\x{601d}\x{8b70}|\x{7121}\x{91cf}\x{5927}\x{6570})/;

sub chinese2num {
    my $chinese = shift;
    $chinese =~ s{($RE_CHINESE_ALL+)}{
        my $c = $1;
        if ($c =~ /$RE_CHINESE_SPECIAL/) {
            _chinese2num_special($c);
        } elsif ($c =~ /$RE_CHINESE_PART/) {
            _chinese2num_part($c);
        } else {
            _chinese2num_ordinary($c);
        }
    }eg;
    return $chinese;
}

sub _chinese2num_ordinary {
    local $_ = shift;
    tr/\x{96f6}\x{3007}\x{4e00}\x{4e8c}\x{4e09}\x{56db}\x{4e94}\x{516d}\x{4e03}\x{516b}\x{4e5d}/00123456789/;
    return $_;
}

sub _chinese2num_part {
    my $chinese = shift;
    my (@part) = $chinese =~ /
        (?:(.?)\x{5343})? # 1000
        (?:(.?)\x{767e})? # 100
        (?:(.?)\x{5341})? # 10
        (.)?              # 1
    /x;
    my $num = my $i = 0;
    for my $n (reverse @part) {
        if (defined $n) {
            my $position = 10 ** $i;
            if ($n eq '') {
                $num += 1 * $position;
            } else {
                $num += _chinese2num_ordinary($n) * $position;
            }
        }
        $i++;
    }
    return $num;
}

sub _chinese2num_special {
    my $chinese = shift;
    my (@special) = $chinese =~ /
        (?:(.*)\x{7121}\x{91cf}\x{5927}\x{6570})? # 10 ** 68
        (?:(.*)\x{4e0d}\x{53ef}\x{601d}\x{8b70})? # 10 ** 64
        (?:(.*)\x{90a3}\x{7531}\x{4ed6})?         # 10 ** 60
        (?:(.*)\x{963f}\x{50e7}\x{7947})?         # 10 ** 56
        (?:(.*)\x{6052}\x{6cb3}\x{6c99})?         # 10 ** 52
        (?:(.*)\x{6975})?                         # 10 ** 48
        (?:(.*)\x{8f09})?                         # 10 ** 44
        (?:(.*)\x{6b63})?                         # 10 ** 40
        (?:(.*)\x{6f97})?                         # 10 ** 36
        (?:(.*)\x{6e9d})?                         # 10 ** 32
        (?:(.*)\x{7a63})?                         # 10 ** 28
        (?:(.*)\x{25771})?                        # 10 ** 24
        (?:(.*)\x{5793})?                         # 10 ** 20
        (?:(.*)\x{4eac})?                         # 10 ** 16
        (?:(.*)\x{5146})?                         # 10 ** 12
        (?:(.*)\x{5104})?                         # 10 ** 8
        (?:(.*)\x{4e07})?                         # 10 ** 4
        (.+)?
    /x;
    my $num = my $i = 0;
    for my $n (reverse @special) {
        if (defined $n) {
            my $position = 10 ** (4 * $i);
            if ($n eq '') {
                $num += 1 * $position;
            } else {
                if ($n =~ /$RE_CHINESE_PART/) {
                    $num += _chinese2num_part($n) * $position;
                } else {
                    $num += _chinese2num_ordinary($n) * $position;
                }
            }
        }
        $i++;
    }
    return $num;
}

sub num2chinese {
    my $num = shift;
    if ($num == 0) {
        return "\x{96f6}";
    } else {
        $num =~ tr/0123456789/\x{3007}\x{4e00}\x{4e8c}\x{4e09}\x{56db}\x{4e94}\x{516d}\x{4e03}\x{516b}\x{4e5d}/;
        return $num;
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Text::ChineseNumerals::JA - Chinese numerals (Kansuji) to number converter

=head1 SYNOPSIS

  use Text::ChineseNumerals::JA;

  print chinese2num('二四');       # => 24
  print chinese2num('二十四');     # => 24
  print chinese2num('北二十四条'); # => 北24条

=head1 DESCRIPTION

Text::ChineseNumerals::JA provides a function covert Chinese numerals (Kansuji) to number.

=head1 FUNCTIONS

=over 4

=item chinese2num($chinese_numerals : Str)

Convert Chinese numerals to number. $chinese_numerals may also contain characters not in Chinese numerals.

=item num2chinese($num : Num)

Convert number to Chinese numerals.

=back

=head1 LICENSE

Copyright (C) Takumi Akiyama.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Takumi Akiyama E<lt>t.akiym@gmail.comE<gt>

=cut

