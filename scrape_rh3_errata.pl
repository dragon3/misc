#!/usr/bin/perl
#
# Scrape "Red Hat Enterprise Linux ES (v. 3) General Advisories"
#
use URI;
use Web::Scraper;

my $errata_line = scraper {
    process "//td[1]/img", type     => '@alt';
    process "//td[2]",     severity => 'TEXT';
    process "//td[3]",     advisory => 'TEXT';
    process "//td[4]",     synopsis => 'TEXT';
    process "a",           url      => '@href';
};

my $errata = scraper {
    process "table.list tr", "list[]" => $errata_line;
    result 'list';
};

my $res = $errata->scrape(
    URI->new("https://rhn.redhat.com/errata/rhel3es-errata.html") );

my @column = qw/type severity advisory synopsis url/;
printf STDOUT "|%s|%s|%s|%s|%s|\n", @column, "\n";

for my $line ( @{$res} ) {
    printf STDOUT "|%s|%s|%s|%s|%s|\n", map { $line->{$_} || '-' } @column;
}
