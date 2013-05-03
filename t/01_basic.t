use strict;
use warnings;
use utf8;
use Test::More;
use Text::ChineseNumerals::JA;

is chinese2num('第一話'), '第1話';
is chinese2num('第十二話'), '第12話';
is chinese2num('第二十四話'), '第24話';

is chinese2num('三億円事件'), '300000000円事件';
is chinese2num('百万ドルの夜景'), '1000000ドルの夜景';
is chinese2num('加藤一二三九段'), '加藤1239段';
is chinese2num('百均なのに五〇〇円'), '100均なのに500円';

done_testing;
