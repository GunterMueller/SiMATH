/*M
.SH NAME
isdppf - is dense polynomial over p-adic field ?
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

single isdppf(r, p, P)  
single p; 
obj r, P;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.PP
isdppf returns 1, if P can be deemed to be a dense-polynomial in r (< BASIS) variables over the p-adic field Qp, and 0 else.
 
M*/
            
/*H
	Version 1       23.07.1990      Christine Hollinger
	Version 2       12.06.1991      C.H.    r, p vertauscht
   DATE isdppf        : 901120.910915
H*/

#include <_pol3.h>

single isdppf( r, p, P )
single p;
obj r,P;
{
	single erg, e, Q;
	bind( r,P );
	erg =  0;

	/*** Ist r single und >= 0 ? ***/

	if( isatom( r )  &&  r >= 0 )

	/*** Ist P Polynom in dense-Darstellung? ***/

	{       if( P == 0 )    erg = 1;
		else
		{       if( !r )       erg = ispfel( p,P );
			else
			{       if( islist( P ) )
				{       e = lfirst( P );
					if(isatom(e) && e >= 0 && llength(P) == e+2)
					{       r--;
						P = lred( P );
						erg = 1;
						while( P != _0 && erg )
						{       Q = lfirst( P );
							P = lred( P );
							if( r )
							  erg = isdppf( r,p,Q );
							else
							  erg = ispfel( p,Q );
						}
					}
				}
			}
		}
	}
	return( erg );
}
