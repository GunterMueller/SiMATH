/*M
.SH NAME
ppfiprod - polynomial over p-adic field integer product 
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppfiprod(r, p, P, i)  
single p, r; 
pol P; 
int i;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the p-adic field Qp. Thereby, the coefficients of P are approximations of elements in Qp (s. itopfel).
.TP 4
.B i
is an integer number.
.PP
ppfiprod returns a polynomial over Qp, say P1, where
.IP
P1 = P * i.
  
.SH SEE ALSO
itopfel

M*/

/*H
	Version 1       17.08.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
	Version 3       01.08.1991      PFIPROD -> PFELIPROD.  PS
   DATE ppfiprod      : 901120.910915
H*/

#include <_pol3.h>

pol ppfiprod( r, p, P, i )
single p,r;
pol P;
int i;
{
	if( P && i )
	{       bind( P,i );

		if( r == 0 )    P = pfeliprod( p, P, i );
		else
		{       single e;
			pol h,P1;
			init( h,P1 );

			/*** koeffizientenweise multiplizieren ***/

			r--;
			P1 = _0;
			do
			{       e = lfirst( P );
				h = lsecond( P );
				P = lred2( P );
				if( r ) h = ppfiprod( r, p, h, i );
				else    h = pfeliprod( p, h, i );
				if( h ) P1 = lcomp2( h, e, P1 );
			}
			while( P != _0 );
			if( P1 == _0 )  P = 0;
			else    P = linv( P1 );
		}
	}
	else    P = 0;
	return( P );
}
