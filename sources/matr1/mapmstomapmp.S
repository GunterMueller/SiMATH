/*M
.SH NAME
mapmstomapmp - matrix of polynomials over modular singles to matrix of polynomials modulo polynomial over modular singles

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmstomapmp(r, m, P, M)
single r, m;
pol P;
matrix M;

.SH DESCRIPTION
mapmstomapmp() returns the matrix M with all entries
reduced modulo P.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over Z/mZ.
.TP 4
.B P
is a polynomial in r variables over Z/mZ.
M*/
/*H
	Version 1       18.09.1992	U.Schneiders
   DATE mapmstomapmp  : 921130.9305__
H*/

#include <_matr1.h>

matrix mapmstomapmp( r, m, P, M )
single r, m;
pol P;
matrix M;
{
	pol el;
	matrix H;
	list Z, ZH;
	init(el,H,Z,ZH);
	bind(P,M);

	H = _0;
	while( M != _0 )
	{	Z = lfirst( M );
		M = lred( M );
		ZH = _0;
		while ( Z != _0 ) 
	        {	el = lfirst(Z);
			Z  = lred(Z);
			el = pmsrem(r,m,el,P);
			ZH = lcomp(el,ZH);
		}
		if( ZH != _0 ) ZH = linv( ZH );
		H = lcomp( ZH, H );
	}
	if ( H != _0 ) M = linv(H);
	return(M);
}

