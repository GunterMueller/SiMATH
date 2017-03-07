/*M
.SH NAME
ppffit - polynomial over p-adic field fitting 
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol ppffit(r, p, P, d)  
single r, p, d; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the p-adic field Qp. Thereby, the coefficients of P (say a_i) are approximations of elements in Qp (s. itopfel). P != 0.
.TP 4
.B d
is the maximal common precision of the coefficients a_i of P not equal to zero
(so d := ppford(r,p,P)).
.PP
ppffit makes the coefficients a_i fit in the precision d and returns the new arising polynomial.
 
.SH SEE ALSO
.nf
itopfel
ppford
M*/
   
/*H
	Version 1       06.08.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p, d vertauscht
	Version 3       01.08.1991      Parameterreihenfolge korrigiert.  PS
   DATE ppffit        : 901120.910915
H*/

#include <_pol3.h>

pol ppffit( r, p, P, d )
single r, p, d;
pol P;
{
	bind( P );

	if( r ) /*** Passe die Koeffizienten von P bzgl. der maximal
		     gemeinsamen Genauigkeit an.                    ***/

	{       single e,l;
		pol h,Pd;
		init( h,Pd );

		r--;
		Pd = _0;
		do
		{       e = lfirst( P );
			h = lsecond( P );
			P = lred2( P );
			if( r ) h = ppffit( r, p, h, d );
			else    /*** Anpassung ***/
			{       if( lsecond( h ) <= d )
				{       l = lfirst( h ) - d;
					d = lsfirst( h,d );
					h = linv( h );
					h = lreduct( h,l );
					h = linv( h );
				}
				else    h = _0;
			}
			if( h != _0 )   Pd = lcomp2( h, e, Pd );
		}
		while( P != _0 );
		P = linv( Pd );
	}
	return( P );
}
