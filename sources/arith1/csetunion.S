/*M
.SH NAME
csetunion - characteristic set union

.SH SYNOPSIS
.nf
#include<_arith1.h>

obj csetunion(S,T)
obj S,T;

.SH DESCRIPTION
csetunion() returns the union of the characteristic sets S and T.
M*/

/*H
	Version 1       14.04.88        R.Boeffgen
   DATE csetunion     : 890501
H*/


# include <_arith1.h>

obj csetunion( S,T )
obj S,T;
{
	obj U;

   /***    Sonderfaelle    ***/
	if ( isatom(S) && isatom(T) )  U = S | T;
	else if ( isatom(S) )  U = lcomp( S|lfirst(T), lred(T) );
	else if ( isatom(T) )  U = lcomp( T|lfirst(S), lred(S) );

   /***    Allgemeinfall    ***/
	else {
		list V=_0;
		bind( S,T );
   /***    komponentenweise bit-Operationen    ***/
		do {
			V = lcomp( lfirst(S) | lfirst(T), V );
			S = lred( S ),  T = lred( T );
		}
		while ( S != _0 && T != _0 );

   /***    normalisieren    ***/
		U = linv( V );
		if ( S==_0 )  lsred( V,T );
		else  lsred( V,S );
	}
   /***    Ergebnis    ***/
	return( U );
}
