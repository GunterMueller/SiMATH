/*M
.SH NAME
ppford - polynomial over p-adic field order
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single ppford(r, p, P)  
single p, r; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the p-adic field Qp. Thereby, the coefficients of P (say a_i) are approximations of elements in Qp (s. itopfel).
.PP
Let d_i be the precision of the coefficient a_i (s. itopfel). ppford returns the maximal common precision (say d) of the coefficients a_i not equal to zero.
.IP
d = min{ d_i | of the a_ i != 0}
  
.SH SEE ALSO
itopfel

M*/
   
/*H
	Version 1       06.08.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
   DATE ppford        : 901120.910915
H*/

#include <_pol3.h>

single ppford( r, p, P )
single p,r;
pol P;
{
	single d;
	bind( P );

	if( r == 0 )    d = lfirst( P );

	else    /*** Bestimme minimal gemeinsame Kennung aller
		     Koeffizienten von P!                      ***/
	{       pol h;
		init( h );

		r--;
		d = BASIS;
		do
		{       h = lsecond( P );
			P = lred2( P );
			if( r ) h = ppford( r, p, h );
			else    h = lfirst( h );
			d = smin( h,d );
		}
		while( P != _0 );
	}
	return( d );
}
