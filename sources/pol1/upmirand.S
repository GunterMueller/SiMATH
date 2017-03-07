/*M
.SH NAME
upmirand - univariate polynomial over modular integers randomize

.SH SYNOPSIS
.nf
#include <_pol1.h>

pol upmirand (n, d)
int n;
single d;

P = upmirand (n, d);

.SH DESCRIPION
upmirand() generates a random polynomial P over Z/nZ.
.TP 4
.B n
.\" I really don't see why n should be a prime number.
is an integer greater than 0.
.TP 4
.B d
>= 0 is an upper bound for the degree of P.
.TP 4
.B P
!= 0 is a univariate polynomial over Z/nZ of degree <= d.
.PP
The output of upmirand() depends on the value of the global
variable SEMIRAND. For a description of SEMIRAND, see irand().

M*/

/*H
	Version 1       16.02.1993   	Joachim Stein
	Version 2	01.05.1996	Neue Doku.	Georg Lay
   DATE upmirand      : 930531.9612__
H*/

#include <_pol1.h>

pol upmirand( ip, m )
int ip; 
single m; 
{
	single i, n;
	int a;
	pol P;               

        bind( ip );
	init( a, P );

/** Polynom ueber Z/(ip)*Z zusammenbauen                             **/
        do
        {
          P = _0;
          for ( i = 0; i <= m; i++ )
          { 
            a = irand( ip );
            if ( a )  P = lcomp2( i, a, P ); 
          } 
        }
        while ( P == _0 ); 
        return( P );
}
