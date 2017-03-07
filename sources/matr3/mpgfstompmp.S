/*M
.SH NAME
mpgfstompmp - matrix of polynomials over Galois-field with single characteristic to matrix of polynomials modulo polynomial over Galois-field with single characteristic

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mpgfstompmp(r, p, AL, P, M)
single r,p;
list AL;
pol P;
matrix M;

.SH DESCRIPTION
mpgfstompmp() returns the matrix M with all entries converted
to polynomials reduced modulo P.


.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B P
is a polynomial in r variables over GF(p^n).
M*/







/*H
	Version 1       28.07.1993	S.Schmitt
   DATE mpgfstompmp   : 931130
H*/

#include <_matr3.h>

matrix mpgfstompmp( r, p, AL, P, M )
single r, p;
list AL;
pol P;
matrix M;
{
	pol el;
	matrix H;
	list Z, ZH;
	init(el,H,Z,ZH);
	bind(AL,P,M);

	H = _0;
	while( M != _0 )
	{	Z = lfirst( M );
		M = lred( M );
		ZH = _0;
		while ( Z != _0 ) 
	        {	el = lfirst(Z);
			Z  = lred(Z);
			el = pgfsrem(r,p,AL,el,P);
			ZH = lcomp(el,ZH);
		}
		if( ZH != _0 ) ZH = linv( ZH );
		H = lcomp( ZH, H );
	}
	if ( H != _0 ) M = linv(H);
	return(M);
}




