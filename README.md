# NAME

Text::ChineseNumerals::JA - Chinese numerals (Kansuji) to number converter

# SYNOPSIS

    use Text::ChineseNumerals::JA;

    print chinese2num('二四');       # => 24
    print chinese2num('二十四');     # => 24
    print chinese2num('北二十四条'); # => 北24条

# DESCRIPTION

Text::ChineseNumerals::JA provides a function covert Chinese numerals (Kansuji) to number.

# FUNCTIONS

- chinese2num($chinese\_numerals : Str)

    Convert Chinese numerals to number. $chinese\_numerals may also contain characters not in Chinese numerals.

- num2chinese($num : Num)

    Convert number to Chinese numerals.

# LICENSE

Copyright (C) Takumi Akiyama.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Takumi Akiyama <t.akiym@gmail.com>
