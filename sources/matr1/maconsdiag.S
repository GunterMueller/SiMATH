/*M
.SH NAME
maconsdiag - matrix construction diagonal-matrix

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maconsdiag(n, el)
single n;
obj el;

.SH DESCRIPTION
maconsdiag() returns the nxn matrix M with
with M[i,j]=el for i=j and  M[i,j]=0 otherwise.
M*/
/*H
	Version 1       23.08.1988      Klaus Petry
   DATE maconsdiag    : 890501
H*/

# include <_matr1.h>

matrix maconsdiag( n, el )
single n;
obj el;

{
	matrix M = _0;
	list Z;
	single i, j;

	bind( M, el );
	init( Z );

	for( i=0; i<n; i++ ){
		Z = _0;
		for ( j=0; j<n; j++ ) {
			if ( i==j ) Z = lcomp( el, Z );
			else Z = lcomp( 0, Z);
			}
		M = lcomp( Z, M );
		}
	return( M );
}
