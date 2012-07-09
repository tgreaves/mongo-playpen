#!/usr/bin/perl

use strict;

use MongoDB;

my $conn = MongoDB::Connection->new;

my $db = $conn->shard_test;

my $users = $db->users;

my $i = 0;

while ($i < 10000)
{
    $i++;

    $users->insert(     
                    {   "user_id" => $i,
                            "name" => "Wang" . $i
                });

}

exit;
