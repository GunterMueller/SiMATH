/*M
.SH NAME
udpitoudpr - univariate polynomial over integers to univariate polynomial over rationals

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpitoudpr( P )  
pol P;

.SH DESCRIPTION
.TP 4
.B P
is an univariate dense polynomial over the integer numbers.
.PP
udpitoudpr returns the polynomial P ( as a polynomial over the rational numbers ).

M*/

/*H
	Version 1       14.02.1989      Christine Hollinger
   DATE udpitoudpr    : 890601.9311__
H*/

#include <_pol1.h>

pol udpitoudpr( P )
pol P;
{
	bind( P );

	/*** P = 0, so P1 = 0. ***/

	/*** P ungleich Null. ***/
	if( P != 0 )
	{       obj pi;
		obj P1;
		init( P1,pi );

		pi = lfirst( P );       /* pi entspricht Grad von P.*/
		P = lred( P );
		P1 = list1( pi );
		while( P != _0 )
		{       pi = lfirst( P );
			P = lred( P );
			if( pi )
			{       pi = list2( pi,1 );
				P1 = lcomp( pi,P1 );
			}
			else    P1 = lcomp( 0,P1 );
		}
		P = linv( P1 );
	}
	return( P );
}
