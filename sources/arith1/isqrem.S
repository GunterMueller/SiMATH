/*M
.SH NAME
isqrem - integer single-precision quotient and remainder

.SH SYNOPSIS
.nf
#include<_arith1.h>

int isqrem(A,b,pQ,pr)
int A,*pQ;
single b,*pr;

.SH DESCRIPTION
isqrem() calculates the integer *pQ = A / b and 
the single *pr = A - (*pQ) * b
for b!=0 and returns 0. 
M*/

/*H
	Version  1      08.08.1986      R.Boeffgen
	Version  2      08.05.1989      C.H/U.S wegen mods divs: fuer Apollo
					in erstem if die 3.Zeile weg.
	Version  3      07.12.1989      einheitl. Version fuer MX2(+), SUN
					und Apollo. PS
	Version  4      14.02.1990      "ifndef ___apollo --> "ifdef ___mx". PS
	Version  5	03.11.1994	MX-Version entfernt.
   DATE isqrem        : 890501.890601.891001.900101.900315.9112__.941201
H*/

# include <_arith1.h>

int isqrem ( A, b, pQ, pr )         /* unsafe A */
int  A, *pQ;
single  b, *pr;
{
    /***    A einfach-genau    ***/
	if  ( isatom(A) ) {
		*pQ = A/b;
		*pr = A%b;
	}
	else
	{
    /***    A mehrfach-genau    ***/
		single  a, q, r=0;
		list  Q;
		init( Q );
		Q=_0;
		A = lcinv( A );
		bind( A );
		do {    a = lfirst( A ),  A = lred( A );
			sqrem ( r,a,b, &q,&r );
			if ( q || Q!=_0 )  Q = lcomp( q,Q );
		}
		while ( A!=_0 );
		if ( lred(Q) == _0 )  *pQ = lfirst( Q );
		else *pQ = Q;
		*pr = r;
	}
	return(0);
}
