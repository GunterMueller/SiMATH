/*M
.SH NAME
mpgf2tompmp - matrix of polynomials over Galois-field with characteristic 2 to matrix of polynomials modulo polynomial over Galois-field with characteristic 2  

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mpgf2tompmp(r, G, P, M) 
single r;
pol G,P;
matrix M;

.SH DESCRIPTION
mpgf2tompmp() returns the matrix M where the polynomials are
reduced modulo P.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
.TP 4
.B P
is a polynomial in r variables over GF(2^n).
M*/

/*H
	Version 1       06.03.1996	S.Schmitt
   DATE mpgf2tompmp   : 960501
H*/

#include <_matr3.h>

matrix mpgf2tompmp( r, G, P, M )
single r;
pol G, P;
matrix M;
{
	pol el;
	matrix H;
	list Z, ZH;
	init(el,H,Z,ZH);
	bind(G,P,M);

	H = _0;
	while( M != _0 )
	{	Z = lfirst( M );
		M = lred( M );
		ZH = _0;
		while ( Z != _0 ) 
	        {	el = lfirst(Z);
			Z  = lred(Z);
			el = pgf2rem(r,G,el,P);
			ZH = lcomp(el,ZH);
		}
		if( ZH != _0 ) ZH = linv( ZH );
		H = lcomp( ZH, H );
	}
	if ( H != _0 ) M = linv(H);
	return(M);
}




