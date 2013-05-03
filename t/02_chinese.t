use strict;
use warnings;
use utf8;
use Test::More;
use Test::Base::Less;
use Text::ChineseNumerals::JA;

for my $block (blocks) {
    is chinese2num($block->input), $block->expected;
}

done_testing;

__DATA__

===
--- input: 零
--- expected: 0

===
--- input: 〇
--- expected: 0

===
--- input: 一
--- expected: 1

===
--- input: 二
--- expected: 2

===
--- input: 三
--- expected: 3

===
--- input: 四
--- expected: 4

===
--- input: 五
--- expected: 5

===
--- input: 六
--- expected: 6

===
--- input: 七
--- expected: 7

===
--- input: 八
--- expected: 8

===
--- input: 九
--- expected: 9

===
--- input: 十
--- expected: 10

===
--- input: 百
--- expected: 100

===
--- input: 千
--- expected: 1000

===
--- input: 一万
--- expected: 10000

===
--- input: 一億
--- expected: 100000000

===
--- input: 一兆
--- expected: 1000000000000

===
--- input: 一京
--- expected: 10000000000000000

===
--- input: 一垓
--- expected: 1e+20

===
--- input: 一𥝱
--- expected: 1e+24

===
--- input: 一穣
--- expected: 1e+28

===
--- input: 一溝
--- expected: 1e+32

===
--- input: 一澗
--- expected: 1e+36

===
--- input: 一正
--- expected: 1e+40

===
--- input: 一載
--- expected: 1e+44

===
--- input: 一極
--- expected: 1e+48

===
--- input: 一恒河沙
--- expected: 1e+52

===
--- input: 一阿僧祇
--- expected: 1e+56

===
--- input: 一那由他
--- expected: 1e+60

===
--- input: 一不可思議
--- expected: 1e+64

===
--- input: 一無量大数
--- expected: 1e+68

===
--- input: 一〇
--- expected: 10

===
--- input: 十一
--- expected: 11

===
--- input: 一万九千八百
--- expected: 19800

===
--- input: 十二万二〇〇〇
--- expected: 122000

===
--- input: 七千九百億
--- expected: 790000000000
