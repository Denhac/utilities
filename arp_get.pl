#!/usr/bin/env perl

use strict;
use Net::SSH::Perl;

# Configure connection info.
my $arp_host = 'skynet.denhac.local';
my $arp_host_user = 'rdhender';
my $arp_host_pass = '';

# Configure output file.
my $out_file = './data';

# SSH to host and get arp output.
my $ssh = Net::SSH::Perl->new($arp_host);
$ssh->login($arp_host_user, $arp_host_pass);

my ($stdout, $stderr, $exit) = $ssh->cmd('arp -a');
my @list = split /\n/, $stdout;

# Parse arp output and add to csv file.
foreach my $line (@list){
    $line =~ s/expires in //g;
    $line =~ /(\S+) \((\d+.\d+.\d+.\d+)\) at (\S+) on (\S+) (.+) (\[\S+\])/;
    print "$1,$2,$3,$5\n";
}

