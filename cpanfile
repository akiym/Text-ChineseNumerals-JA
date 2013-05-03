requires 'perl', '5.008005';
requires 'parent';
requires 'Exporter';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Base::Less';
};

on configure => sub {
    requires 'CPAN::Meta';
    requires 'CPAN::Meta::Prereqs';
    requires 'Module::Build';
};
