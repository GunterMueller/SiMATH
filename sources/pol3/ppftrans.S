/*M
.SH NAME
ppftrans - polynomial over p-adic field translation, main variable

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppftrans(r, p, P, A)  
single r, p; 
pol P; 
pfel A; 
     
.SH DESCRIPTION
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
ppftrans returns a polynomial over Qp, say P1, where
.PP
P1( X_1, ..., X_r ) = P( X_1, ..., X_( r-1 ), X_r+A ).  

.SH SEE ALSO
.nf
itopfel
ppftransav

M*/
                    
/*H
	Version 1       03.09.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
   DATE ppftrans      : 901120.910915
H*/

#include <_pol3.h>

pol ppftrans( r, p, P, A )
single r,p;
pol P;
pfel A;
{
	if( P && A )
	{       single e;
		list tr1,tr2;
		pol h,P1;
		init( tr1, tr2, h, P1 );
		bind( P,A );

		/*** ( Xr + A )^ei statt Xr^ei gemaess dem Horner-Schema
		     ersetzen ***/

		P1 = 0;
		while( P != _0 )
		{       e = lfirst( P );
			h = lsecond( P );
			P = lred2( P );
			tr1 = list2( 0,h );
			P1 = ppfsum( r, p, P1, tr1 );
			if( P != _0 )   e -= lfirst( P );
			for( ; e; e-- )
			{       tr1 = ppmvprod( r, P1, 1 );
				tr2 = ppfpfprod( r, p, P1, A );
				P1 = ppfsum( r, p, tr1, tr2 );
			}
		}
		P = P1;
	}
	return( P );
}
