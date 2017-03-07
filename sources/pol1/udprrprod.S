/*M
.SH NAME
udprrprod - univariate dense polynomial over rationals, rational number product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udprrprod( P, A )  
pol P; 
rat A;

.SH DESCRIPTION
.TP 4
.B P
is an univariate dense polynomial over the rational numbers.
.PP
udprrprod returns the polynomial P1, where                                      
.IP                                                                             
P1 = A * P.              
 
M*/

/*H
	Version 1       14.02.1989      Christine Hollinger
   DATE udprrprod     : 890601.9109__
H*/


# include <_pol1.h>

pol udprrprod( P,A )
pol P;
rat A;
{
	bind(P,A);

	/*** P = 0, so P1 = 0. ***/
	if( P )
	{        /***  A = 0. ***/
		if( A == 0 )    P = 0;

		/*** P koeffizientenweise mit A multiplizieren. ***/
		else
		{       single r;
			rat pi;
			pol P1;
			init( pi,P1 );

			r = lfirst( P );
			P = lred( P );
			P1 = list1( r );
			while ( P != _0 )
			{       pi = lfirst( P );
				P = lred( P );
				pi = rprod( pi,A );
				P1 = lcomp( pi,P1 );
			}
			P = linv( P1 );
		}
	}
	return( P );
}
