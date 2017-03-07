/*M
.SH NAME
udpitoudpmi - univariate dense polynomial over integers to univariate dense polynomial over modular integers

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpitoudpmi( P, M )  
pol P; 
int M;

.SH DESCRIPTION
.TP 4
.B P
is an univariate dense polynomial over the integer numbers.       
.TP 4
.B M
is an integer number, M > 0.
.PP
udpitoudpmi returns the polynomial P ( as a polynomial over Z/(M*Z) ).

M*/

/*H
	Version 1       29.03.1989      Christine Hollinger
   DATE udpitoudpmi   : 890601.9311__
H*/

#include<_pol1.h>

pol udpitoudpmi( P,M )
pol P;
int M;
{
	bind( P,M );

	/*** P = 0 -> P1 = 0. ***/

	if( P )
	{       pol P1;
		int ai;
		single i,r;
		init( P1,ai );

		/*** Koeffizientenweise berechnen. ***/
		r = lfirst( P );
		P = lred( P );
		P1 = _0;
		i = r;
		while( P!= _0 )
		{       ai = lfirst( P );
			P = lred( P );
			ai = mihom( M,ai );

			/*** Fuehrende Nullen rausstreichen. ***/
			if( !ai && i == r )     r--;
			else    P1 = lcomp( ai,P1 );
			i--;
		}
		if( r >=  0 )
		{       P1 = linv( P1 );
			P = lcomp( r,P1 );
		}
		else    P = 0;
	}
	return( P );
}
