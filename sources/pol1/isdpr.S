/*M
.SH NAME
isdpr - is dense polynomial over rationals ? (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single isdpr(r, P)  
obj r, P;

.SH DESCRIPTION
isdpr returns
.TP 4
1,
if P can be interpreted as a dense polynomial in r variables over the rational numbers,
 ( r integer number, 0 <= r < BASIS )
.TP 4
0, else.


M*/

/*H
	Version 1       26.08.1988      Christine Hollinger
   DATE isdpr         : 890501.9311__
H*/


#include <_pol1.h>

single isdpr(r,P)
obj r, P;
{
	single erg, e, Q;
	bind( r,P );
	erg =  0;

	/*** Ist r single und >= 0 ? ***/

	if( isatom( r )  &&  r >= 0 )

	/*** Ist P Polynom in dense-Darstellung? ***/

	{       if(P == 0)     erg = 1;
		else
		{       if( !r )       erg = israt( P );
			else
			{       if( islist(P) )
				{       e = lfirst(P);
					if( isatom(e) && e >= 0 && llength(P) == e+2)
					{       r--;
						P = lred(P);
						erg = 1;
						while( P != _0  &&  erg )
						{       Q = lfirst(P);
							P = lred( P );
							if( r )
							  erg = isdpr( r,Q );
							else
							  erg = israt( Q );
						}
					}
				}
			}
		}
	}
	return( erg );
}
