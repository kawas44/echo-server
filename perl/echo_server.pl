#!/usr/bin/perl -w

use Socket;


sub main {
    my $port = shift(@ARGV) || 7003;
    my $host = shift(@ARGV) || "127.0.0.1";
    
    print("Start server on $host:$port\n");
    $host_ip = inet_aton($host);
    $sockaddr = sockaddr_in($port, $host_ip);
    
    socket(SERVER, PF_INET, SOCK_STREAM, getprotobyname('tcp'));
    setsockopt(SERVER, SOL_SOCKET, SO_REUSEADDR, 1);
    
    bind(SERVER, $sockaddr) || die "Couldn't bind: $!\n";
    listen(SERVER, SOMAXCONN) || die "Couldn't listen: $!\n";
    
    while (accept(CLIENT, SERVER)) {
        print "  accept connection\n";
        $message = <CLIENT>;
        print CLIENT "echo: $message";
        close(CLIENT) || die "Couldn't close connection: $!\n";
    }
    
    close(SERVER);
}


main();
