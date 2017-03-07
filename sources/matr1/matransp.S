/*M
.SH NAME
matransp - matrix transpose

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix matransp(M)
matrix M;

.SH DESCRIPTION
matransp() returns the transpose of the matrix M.

.SH CAUTION
M will be destroyed.
M*/

/*H
	Version 1        7.04.88        R.Boeffgen
	Version 2       23.06.88        matrans -> matransp.   RB
	Version 3        1.07.88        M = 0 beruecksichtigt.  RB
	Version 4       22.11.88        M = 0 gestrichen. KP
   DATE matransp      : 890501
H*/


# include <_matr1.h>

matrix matransp( M )
matrix M;
{
	list   V, W;
	matrix Mr, T;
	bind( M );
	init( T );
 
   /***    M abarbeiten, T aufbauen    ***/
	for (  T=_0;  lfirst(M) != _0;  T = lcomp( linv(V),T )  )
		for  ( V=_0, Mr=M;  Mr!=_0;  V=W, Mr=lred(Mr)  )
		{
			W = lfirst( Mr );
			lsfirst( Mr, lred(W) );
			lsred( W,V );
		}

   /***    Ergebnis    ***/
	return( linv(T) );
}
