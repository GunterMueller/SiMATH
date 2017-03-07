/*M
.SH NAME
nfexp - number field element exponentiation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfexp( F, a, n )   
pol F;
nfel a; 
single n;
 
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree > 1. F generates a number field, say K.
.TP 4
.B a 
is an element of K (for representation of number field elements s. nfneg).
.TP 4
.B n
is an integer number. For a = 0, n must not be < 0.
.PP
nfexp returns an element of K, say b, where
.IP
b = a^n.
  
.SH SEE ALSO
nfneg

M*/
            
/*H
	Version 1       06.03.1989      Christine Hollinger
	Version 2       26.06.1989      C.H. ( binaere right-to-left
					       Methode )
   DATE nfexp         : 890601.890801
H*/

#include<_arith2.h>

nfel nfexp( F, a, n )
pol F;
nfel a;
single n;
{
	nfel erg, p;
	init( erg, p );
	bind( F,a );

	if( n < 0 )
	{       a = nfinv( F,a );
		n = ineg( n );
	}

	/*** Berechnung gemaess binaerer right-to-left-Methode. ***/

	erg = itonf( 1 );
	p = a;
	while( n )
	{       if( n % 2 )     erg = nfprod( F, erg, p );
		p = nfprod( F, p, p );
		n = n / 2 ;
	}
	return( erg );
}
