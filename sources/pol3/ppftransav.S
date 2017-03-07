/*M
.SH NAME
ppftransav - polynomial over p-adic field translation, all variables
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppftransav(r, p, P, Lpf)  
single r, p; 
pol P; 
list Lpf;
 
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
.B Tpf
is a list, containing r elements in Qp, say B_1,...,B_r.
.PP
ppftransav returns a polynomial over Qp, say P1, where
.PP
P1(X_1, ..., X_r) = P(X_1+B1, .., X_r+Br).  

.SH SEE ALSO
.nf
itopfel
ppftrans

M*/
          
/*H
	Version 1       07.09.1990      Christine Hollinger
	Version 2       19.06.1991      C.H.    r, p vertauscht
   DATE ppftransav    : 901120.910915
H*/

#include <_pol3.h>

pol ppftransav( r, p, P, Lpf )
single r,p;
pol P;
list Lpf;
{
	if( P )
	{       single e;
		pfel B;
		pol h, P1, Ph;
		init( B, h, P1, Ph );
		bind( P,Lpf );

		/*** Translation bzgl. der Hauptvariablen ***/

		B = lfirst( Lpf );
		Lpf = lred( Lpf );
		P1 = ppftrans( r, p, P, B );

		/*** Translation bzgl. der Nebenvariablen ***/

		r--;
		if( r && P1 )
		{       Ph = _0;
			while( P1 != _0 )
			{       e = lfirst( P1 );
				h = lsecond( P1 );
				P1 = lred2( P1 );
				h = ppftransav( r, p, h, Lpf );
				Ph = lcomp2( h, e, Ph );
			}
			P1 = linv( Ph );
		}
		P = P1;
	}
	return( P );
}
