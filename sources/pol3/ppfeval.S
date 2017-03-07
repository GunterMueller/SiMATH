/*M
.SH NAME
ppfeval - polynomial over p-adic field evaluation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfeval(r, p, P, A)  
single r, p; 
pol P; 
pfel A;
     
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp (s. itopfel).
.TP 4
.B A
is an element in Qp (for the representation of p-adic field elements s. itopfel).
.PP
ppfeval returns the evaluation of P at A with regard to the main variable.

.SH CAUTION
If P is an univariate polynomial, P(A) is both of type pol and of type pfel.

.SH SEE ALSO
itopfel

M*/
                                  
/*H
	Version 1       27.08.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
   DATE ppfeval       : 901120.910915
H*/

#include <_pol3.h>

pol ppfeval( r, p, P, A )
single r,p;
pol P;
pfel A;
{
	if( P )
	{       single e,e1;
		pol h,P1;
		init( h,P1 );
		bind( P,A );

		/*** Auswertung mit Horner-Schema ***/

		r--;
		e = lfirst( P );
		P1 = lsecond( P );
		P = lred2( P );
		while( P != _0 )
		{       e1 = lfirst( P );
			h = lsecond( P );
			P = lred2( P );
			for( e -= e1; e; e-- )
			{       if( r ) P1 = ppfpfprod( r, p, P1, A );
				else    P1 = pfprod( p, P1, A );
			}
			if( r ) P1 = ppfsum( r, p, P1, h );
			else    P1 = pfsum( p, P1, h );
			e = e1;
		}
		for( ; e; e-- )
		{       if( r ) P1 = ppfpfprod( r, p, P1, A );
			else    P1 = pfprod( p, P1, A );
		}
		P = P1;
	}
	return( P );
}
