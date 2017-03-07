/*M
.SH NAME
lsbmsort - list of single precisions bubble merge sort

.SH SYNOPSIS
.nf
#include<_list.h>

list lsbmsort(L)  
list L;
 
.SH DESCRIPTION
.TP 4
.B L
is a list of single precision numbers.
.PP
lsbmsort returns a list containing the same elements as L, sorted in ascending order. lsbmsort should be used whit large lists.
L will be changed.

M*/
    
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lsbmsort      : 890501
H*/


# include <_list.h>

list lsbmsort ( L )                     /* safe B1,C,L1,L2 */
list L;
{
    short  t=10;
    single n=llength(L);
    if ( n<t )  lsbsort( L );
    else
    {
	single i,j,k, m,q,r;
	list   B,B1,C,L1,L2, L3;
	init( L3 );
   /***    Aufbereitung fuer merge    ***/
	for ( k=1, m=2, q=n ; (q/=2) >= t ; m*=2, k++ );
	r = n - m * q;
	B = _0, L1 = L, i = 0;
	while ( ++i<=m )  {
		j = q - (i>r);
		for ( L2=L1 ; j-- ; L2=lred(L2) );
		L3 = lred( L2 );
		lsred( L2,_0 );
		lsbsort( L1 );
		B = lcomp( L1,B );
		L1 = L3;
	}
   /***    merge    ***/
	bind( B );
	for ( ; k-- ; B=C )
	    for ( C=_0, B1=B ; B1!=_0 ; C=lcomp(L1,C) )  {
		L1 = lfirst( B1 );
		L2 = lsecond( B1 );
		B1 = lred2( B1 );
		L1 = lsmerge( L1,L2 );
	    }
	L = lfirst(B);
    }
    return( L );
}
