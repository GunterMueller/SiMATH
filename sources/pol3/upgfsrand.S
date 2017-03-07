/*M
.SH NAME
upgfsrand - univariate polynomial over Galois-field with single characteristic randomize

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol upgfsrand( p, AL, m )  
single p, m; 
list AL;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4 
.B m
is an integer number, 0 <= m < BASIS.
.PP
upgfsrand randomly generates an univariate polynomial over GF(p^n), say P, where
0 <= deg(P) <= m, P != 0, and returns it.
 
.SH SEE ALSO
gfsalgen

M*/
                             
/*H
	Version 1	20.10.1992	Joachim Stein
   DATE upgfsrand     : 921130
H*/


#include <_pol3.h>

pol upgfsrand( p, AL, m )
single p, m; 
list AL;
{
	single i, n;
	pol P;               
        gfel a;

        bind( AL );
	init( P, a );

/** Polynom ueber GF(p^n) zusammenbauen                              **/
        do
        {
          P = _0;
          for ( i = 0; i <= m; i++ )
          { 
            a = gfselrand( p, AL );
            if ( a )  P = lcomp2( i, a, P ); 
          } 
        }
        while ( P == _0 ); 
        return( P );
}
