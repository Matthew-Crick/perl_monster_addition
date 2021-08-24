#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Monster addition 
# Matthew Crick 
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Carp;
use Data::Dump qw(dump);
use Data::Table::Text qw(:all);
use Test::More qw(no_plan);
use feature qw(say state current_sub);

sub count_encounters($@)
 {my ($target_difficulty, @monster_list) = @_;
  my @p;
  push @p, "my \$c = 0;";
  for my $i(keys @monster_list)
    { push @p, "for my \$n$i(0..$target_difficulty){ ";
    }
  
  push @p, "my \$p = 0;";
  for my $i(keys @monster_list)
    { push @p, "\$p += \$n$i * $monster_list[$i][1];";
    }
  push @p, "if (\$p == $target_difficulty){ ++ \$c}";
  
  for my $i(keys @monster_list)
    { push @p, "}";
    }
  
  push @p, q($c;);
  my $v = join " \n", @p;
  eval $v;
 }

if (1)                                                                          #
 {my @monster_list = ([qw(tiger 4)],[qw(panda 7)], [qw(lizards 6)], [qw(lion 9)], [qw(elephant 13)]);
  my $target_difficulty = 25;
  my $c = count_encounters $target_difficulty, @monster_list;
  is_deeply $c, 8;
 }

if (1)                                                                          #
 {my @monster_list = ([qw(tiger 4)],[qw(panda 7)], [qw(lizards 6)], [qw(lion 9)], [qw(elephant 13)]);
  my $target_difficulty = 15;
  my $c = count_encounters $target_difficulty, @monster_list;
  is_deeply $c, 2;
 }

if (1)                                                                          #
 {my @monster_list_1 = ([qw(bear 5)],[qw(imp 2)], [qw(kobold 3)], [qw(dragon 10)]);
  my $target_difficulty = 15;
  my $c = count_encounters $target_difficulty, @monster_list_1;
  is_deeply $c, 9;
 }
