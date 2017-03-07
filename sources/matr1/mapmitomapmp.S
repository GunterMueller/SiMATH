/*M
.SH NAME
mapmitomapmp - matrix of polynomials over modular integers to matrix of polynomials modulo polynomial over modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmitomapmp(r, m, P, M)
single r;
int m;
pol P;
matrix M;

.SH DESCRIPTION
mapmitomapmp() returns the matrix M with all entries
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
   DATE mapmitomapmp  : 921130.9305__
H*/

#include <_matr1.h>

matrix mapmitomapmp( r, m, P, M )
single r;
int m;
pol P;
matrix M;
{
	pol el;
	matrix H;
	list Z, ZH;
	init(el,H,Z,ZH);
	bind(m,P,M);

	H = _0;
	while( M != _0 )
	{	Z = lfirst( M );
		M = lred( M );
		ZH = _0;
		while ( Z != _0 ) 
	        {	el = lfirst(Z);
			Z  = lred(Z);
			el = pmirem(r,m,el,P);
			ZH = lcomp(el,ZH);
		}
		if( ZH != _0 ) ZH = linv( ZH );
		H = lcomp( ZH, H );
	}
	if ( H != _0 ) M = linv(H);
	return(M);
}

