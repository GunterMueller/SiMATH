/*M
.SH NAME
isdpi - is dense polynomial over integers ? (recursive)
 
.SH SYNOPSIS
.nf
#include<_pol1.h>

single isdpi(r, P)  
obj r, P;

.SH DESCRIPTION
isdpi returns 
.TP 4
1,
if P can be interpreted as a dense polynomial in r variables ( 0 <= r < BASIS ) over the integer numbers,
.TP 4
0,
else.

M*/

/*H
	Version 1       19.08.1988      Christine Hollinger
   DATE isdpi         : 890501.9311__
H*/


#include <_pol1.h>

single isdpi(r,P)
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
		{       if( !r )       erg = isint( P );
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
							  erg = isdpi( r,Q );
							else
							  erg = isint( Q );
						}
					}
				}
			}
		}
	}
	return( erg );
}
