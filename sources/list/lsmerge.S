/*M
.SH NAME
lsmerge - list of single precisions merge

.SH SYNOPSIS
.nf
#include<_list.h>

list lsmerge(L1, L2)  
list L1, L2;
           
.SH DESCRIPTION
.TP 4
.B L1, L2
are two lists of singles. The elements in L1 and L2 are sorted in ascending order.
lsmerge returns a list, say L. L is the concatenation of L1 and L2. The elements in L are sorted in ascending order.
L1 and l2 will be changed.

M*/
      
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lsmerge       : 890501.9203__
H*/


# include <_list.h>

list lsmerge ( L1, L2 )
list L1,L2;
{
	single a1,a2;
	list L,R;
	short sw;
	if ( L1 == _0 ) return( L2 );
	if ( L2 == _0 ) return( L1 );
   /***    init    ***/
	a1 = lfirst( L1 );
	a2 = lfirst( L2 );
	if ( sw = a1>a2 )  {
		R = L = L2;
		L2 = lred( L2 );
	}
	else  {
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
			if ( sw = a1>a2 )  {
				lsred( R,L2 );
				R = L2;
				L2 = lred( L2 );
			}
			else  {
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
			if ( sw = a1>a2 )  {
				R = L2;
				L2 = lred( L2 );
			}
			else  {
				lsred( R,L1 );
				R = L1;
				L1 = lred( L1 );
			}
	}
}
