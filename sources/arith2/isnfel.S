/*M
.SH NAME
isnfel - is number field element?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isnfel(F, a)     
pol F;
nfel a;
   
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Z. F generates a number field, say K.
.PP
isnfel returns 
.TP 4
1, 
if a is the representation of an element of K, as described in the documentation of nfneg.
.TP 4
0, 
else.
  
.SH SEE ALSO
nfneg

M*/
                       
/*H
	Version 1       15.02.1989      Christine Hollinger
   DATE isnfel        : 890601
H*/

#include <_arith2.h>

single isnfel( F,a )
pol F;
obj a;
{
	single s;
	int wert, HNa, g, ai;
	init( wert, HNa, g, ai );
	bind( F,a );

	/*** a = 0 -> a Nullatom. ***/
	if( a == 0 )    return( 1 );

	/*** a ungleich Null, so beginnt Untersuchung. ***/
	s = islist( a );
	if( s )
	{       if( llength( a ) <= 2 )      s = 0;
		else
		{       HNa = lfirst( a );
			if( !isint( HNa ) || HNa < 0 )    s = 0;
			else
			{       a = lred( a );
				s = isdpi( 1,a );
				if( s )
				{       /* Grad a < Grad F. */
					if( lfirst( a ) >= lfirst( F ) )
						s = 0;
					else
					{   /* ggt( HNa,ar,...,a0 )=1? */
						ai = lsecond( a );
						a = lred2( a );
						g = igcd( HNa,ai );
						wert = ai;
						while( a != _0 && g != 1 )
						{       ai = lfirst( a );
							a = lred( a );
							g = igcd( g,ai );
							if( !wert )  wert = ai;
						}
					    /* wert = 0 -> Nullpolynom nicht
					       als 0 dargestellt. */
						if( g != 1 || wert == 0 )
							s = 0;
						else    s = 1;
					}
				}
			}
		}
	}
	return( s );
}
