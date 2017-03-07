/*M
.SH NAME
marfrchpol - matrix of rational functions over the rational numbers, characteristic polynomial

.SH SYNOPSIS
.nf
#include<_matr3.h>

rfunc marfrchpol(r, M)
single r;
matrix M;

.SH DESCRIPTION
marfrchpol() returns the characteristic polynomial of M, i.e.
chp(X) = det( M - X * I ), where I is the unity matrix.
chp is a rational function in r+1 variables over GF(p^n).

.PP
.TP 4
.B M
is a square matrix of rational functions in r variables over GF(p^n).
M*/








/*H
	Version 1       05.06.1989      U. Schneiders, Th. Weis
   DATE marfrchpol    : 890801.9109__
H*/

# include <_matr3.h>

rfunc marfrchpol( r, M )
single r;
matrix M;

{
        list ZL, ZM;
        matrix L;
	rfunc a, b, mEins;
	pol na, za;
	single i,j;

	bind( M ); 
	init( ZL, ZM, L, a, b, mEins, na, za );
	
	ZL = pvinsert( 0, 1, r+1 );
	mEins = pvinsert( 0, -1, r );
	mEins = list2( 1, mEins );
	mEins = list2( mEins, ZL );

	L = _0;                         
	i = 0;
	while ( M != _0 )
        {
		ZL = _0;
		j = 0;
		ZM = lfirst( M );
	        M = lred( M );
        	while ( ZM != _0 )
		{
			a = lfirst( ZM );
			ZM = lred( ZM ); 
			if ( a )
			{
				na = lfirst( a );
				za = lsecond( a );
				na = list2( 0, na );
				za = list2( 0, za );
				b = list2( na, za ); 
			}
			else	b = 0; 
			if ( i == j )  b = rfrsum( r+1, b, mEins );
			ZL = lcomp( b, ZL );
			j++;
		}
		ZL = linv( ZL );
		L = lcomp( ZL, L );
		i++;
	}
	L = linv( L );
	a = marfrdet( r+1, L );
	return( a );
} 


