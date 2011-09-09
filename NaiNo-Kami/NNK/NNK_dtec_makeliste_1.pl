#!/usr/bin/perl 
#             -w  affiche warning
# 0 : date lim | 1 : extention fichier | 2 : path des data | 3 : format dossier 
##########################################################################################################################
##########################################################################################################################

my $out = '' ;
my $item = '' ; 
my $irec = 0 ;
my $ista = 0 ;
my $icomp = 0 ;
my %lesrec ; 
my %lesstat ; 
my %lescomp ; 


 
open (OUT,">tmp.txt");
open (OUT1,">tmp1.txt");
open (OUT2,">tmp2.txt");
open (OUT3,">tmp3.txt");
open (OUT4,">tmp4.txt"); 
open (OUT5,">tmp5.txt"); 
open (OUT6,">tmp6.txt");

my @list = `ls -dl $ARGV[2]/*/$ARGV[3] $ARGV[2]/$ARGV[3] $ARGV[2]/*/*/$ARGV[3] | grep drwxr` ;
my $numb =  $#list + 1; 

foreach $item (@list) {
    chomp($item) ;
    my @elt = split('/',$item) ;  
    my $direct = substr($elt[-1],0,14) ; 
    my @elt = split(' ',$item) ; 
    my $paf = $elt[-1] ;


    if($direct > $ARGV[0]) {

        print "ls $paf/$ARGV[1]\m\n";
        my @sublist = `ls $paf/$ARGV[1]` ;

        foreach $file (@sublist) {
            chomp($file);
            @elt=split("/",$file);
            
            my $stat = substr($elt[-1],0,3) ; 
            my $compo = substr($elt[-1],4,1) ;
            
            if(-e $file) { 
                print OUT "$file\n" ;

                if(exists $lesrec{$direct}) {} else {$lesrec{$direct} = ++$irec ; print OUT4 "$paf\n" ; }
                if(exists $lesstat{$stat}) {} else {$lesstat{$stat} = ++$ista ; print OUT5 "$stat\n" ;}
                if(exists $lescomp{$compo}) {} else {$lescomp{$compo} = ++$icomp ; print OUT6 "$compo\n" ; }

                print OUT1 "$lesrec{$direct}\n" ; 
                print OUT2 "$lesstat{$stat}\n" ;
                print OUT3 "$lescomp{$compo}\n" ;

            }
        }
    }
}
close(OUT) ; 
close(OUT1) ; 
close(OUT2) ; 
close(OUT3) ;
close(OUT4) ;
close(OUT5) ;
close(OUT6) ;

#open (OUT4,">tmp4.txt"); foreach my $k (keys(%lesrec)) { print OUT4 "$k\n" ;} close(OUT4) ;
#open (OUT5,">tmp5.txt"); foreach my $k (keys(%lesstat)) { print OUT5 "$k\n" ;} close(OUT5) ;
#open (OUT6,">tmp6.txt"); foreach my $k (keys(%lescomp)) { print OUT6 "$k\n" ;} close(OUT6) ;

