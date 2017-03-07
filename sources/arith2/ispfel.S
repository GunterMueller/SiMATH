/*M
.SH NAME
ispfel - is p-adic field element?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single ispfel(p,a)     
single p; 
obj a;

.SH DESCRIPTION
.TP 4
.B p
is a single prime, defining the p-adic number field Qp.
.PP
ispfel returns 
.TP 4
1,  
if a can be seen as the approximation of an element of Qp (s. itopfel), and
.TP 4
0, 
else.

.SH SEE ALSO
itopfel

M*/
                                 
/*H
	Version 1       09.03.1990      Christine Hollinger
   DATE ispfel        : 901120
H*/

#include <_arith2.h>

single ispfel( p,a )
single p;
obj a;
{
	single s = 1;
	obj ai,vp;
	init( ai,vp );
	bind( a );

	/*** a = 0 -> a Nullatom. ***/

	if( a == 0 )    return( 1 );

	/*** a != 0, so a Liste wie oben angegeben? ***/

	if( !islist( a ) )      return( 0 );
	if( llength( a ) < 3 )  return( 0 );

	/*** d >= vp( A ) ? ***/

	ai = lfirst( a );
	if( !isint( ai ) )      return( 0 );
	vp = lsecond( a );
	if( !isint( vp ) )      return( 0 );
	if( icomp( ai,vp ) < 0 )        return( 0 );

	/*** Anzahl der Koeffizienten = d + 1 - vp( A ) ? ***/

	a = lred2( a );
	ai = idif( ai,vp );
	ai++;
	if( ai != llength( a ) )        return( 0 );

	/*** Gilt fuer alle ai 0 <= ai <= p-1 und a_vp( A ) != 0 ? ***/

	if( !islists( a ) )     return( 0 );
	p--;
	ai = lfirst( a );
	if( ai <= 0 || p < ai )         s = 0;
	else    a = lred( a );
	while( s && a != _0 )
	{       ai = lfirst( a );
		if( ai < 0 || p < ai )  s = 0;
		else    a = lred( a );
	}
	return( s );
}
