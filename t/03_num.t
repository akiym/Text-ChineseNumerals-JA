use strict;
use warnings;
use utf8;
use Test::More;
use Test::Base::Less;
use Text::ChineseNumerals::JA;

for my $block (blocks) {
    is num2chinese($block->input), $block->expected;
}

done_testing;

__DATA__

===
--- input: 0
--- expected: 零

===
--- input: 1
--- expected: 一

===
--- input: 2
--- expected: 二

===
--- input: 3
--- expected: 三

===
--- input: 4
--- expected: 四

===
--- input: 5
--- expected: 五

===
--- input: 6
--- expected: 六

===
--- input: 7
--- expected: 七

===
--- input: 8
--- expected: 八

===
--- input: 9
--- expected: 九

===
--- input: 10
--- expected: 一〇
