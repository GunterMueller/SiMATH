/*M
.SH NAME
udppffit - univariate dense polynomial over p-adic field fitting

.SH SYNOPSIS
.nf
#include<_pol3.h>

single udppffit(p, P, Pd)  
single p; 
pol P, *Pd;
  
.SH DESCRIPTION
.TP 4
.B p 
is a prime number, p < BASIS.
.TP 4
.B P
is an univariate polynomial in dense representation over the p- adic field Qp. P must not be zero (for the representation of elements in the p-adic field, see itopfel). 
.TP 4
.B Pd 
points on the polynomial *Pd.
.PP
udppfit returns the maximal common precision, say d, of the coefficients, say a_i, of P. Further, udppffit makes the coefficients a_i fit in the precision d and writes the new arising polynomial to *Pd.   

.SH SEE ALSO
itopfel

M*/

/*H
	Version 1       13.07.1990      Christine Hollinger
   DATE udppffit      : 901120.9109__
H*/

#include <_pol3.h>

single udppffit( p, P, Pd )
single p;
pol P,*Pd;
{
	single h,d;
	pfel ai;
	list L;
	bind( P );
	init( ai );

	if( lfirst( P ) == 0 )                  /*** P = Konstante ***/
	{       *Pd = P;
		ai = lsecond( P );
		return( lfirst( ai ) );
	}
	/*** Bestimme minimal gemeinsame Genauigkeit d aller Koeffi-
	     zienten von P ! ***/

	P = lred( P );
	ai = lfirst( P );
	d = lfirst( ai );
	P = lred( P );
	L = list1( ai );
	for( ; P != _0; P = lred( P ) )
	{       ai = lfirst( P );
		if( ai )        d = smin( d,lfirst( ai ) );
		L = lcomp( ai,L );
	}
	/*** Anpassen an Genauigkeit an d ***/

	while( L != _0 )
	{       ai = lfirst( L );
		L = lred( L );
		if( ai == 0 )   P = lcomp( 0,P );
		else
		{       if( lsecond( ai ) > d )         P = lcomp( 0,P );
			else
			{       h = lfirst( ai ) - d;
				d = lsfirst( ai,d );
				ai = linv( ai );
				ai = lreduct( ai,h );
				ai = linv( ai );
				P = lcomp( ai,P );
			}
		}
	}
	/*** Grad von Pd bestimmen: Fuehrende Nullen beseitigen ***/

	for( ; P != _0 && lfirst( P ) == 0; P = lred( P ) );
	if( P == _0 )   *Pd = 0;
	else
	{       h = llength( P ) - 1;           /*** = Grad( Pd ) ***/
		P = lcomp( h,P );
		*Pd = P;
	}
	return( d );
}
