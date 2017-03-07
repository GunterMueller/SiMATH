/*M
.SH NAME
limerge - list of integers merge

.SH SYNOPSIS
.nf
#include<_arith1.h>

list limerge(L1,L2)
list L1,L2;

.SH DESCRIPTION
limerge() returns the ascendingly sorted concatenation
of the two ascendingly sorted lists L1 and L2.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE limerge       : 890501.9203__
H*/


#include <_arith1.h>

list limerge ( L1, L2 )          /* safe */
list L1,L2;
{
	int  a1,a2;
	list L, R;
	short sw;
	if ( L1 == _0 ) return( L2 );
	if ( L2 == _0 ) return( L1 );
    /***    init    ***/
	a1 = lfirst( L1 );
	a2 = lfirst( L2 );
	if ( sw = ( icomp(a1,a2)>0 ) )  {
		R = L = L2;
		L2 = lred( L2 );
	}
	else {
		R = L = L1;
		L1 = lred( L1 );
	}
    /***    naechstes Element von L1 bzw. L2    ***/
	for ( ; ; )  switch( sw )  {
		case 0:
			if ( L1==_0 )  {
				lsred( R,L2 );
				return( L );
			}
			a1 = lfirst( L1 );
			if ( sw = ( icomp(a1,a2)>0 ) )  {
				lsred( R,L2 );
				R = L2;
				L2 = lred( L2 );
			}
			else {
				R = L1;
				L1 = lred( L1 );
			}
			break;

		case 1:
			if ( L2==_0 )  {
				lsred( R,L1 );
				return( L );
			}
			a2 = lfirst( L2 );
			if ( sw = ( icomp(a1,a2)>0 ) )  {
				R = L2;
				L2 = lred( L2 );
			}
			else {
				lsred( R,L1 );
				R = L1;
				L1 = lred( L1 );
			}
	}
}
