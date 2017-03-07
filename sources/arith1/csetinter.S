/*M
.SH NAME
csetinter - characteristic set intersection

.SH SYNOPSIS
.nf
#include<_arith1.h>

obj csetinter(S,T)
obj S,T;

.SH DESCRIPTION
csetinter() returns the intersection of the characteristic sets S and T.
M*/

/*H
	Version 1       13.04.88        R.Boeffgen
   DATE csetinter     : 890501
H*/


# include <_arith1.h>

obj csetinter( S, T )
obj S,T;
{
	obj U;

   /***    Sonderfaelle    ***/
	if ( isatom(S) && isatom(T) )  U = S & T;
	else if ( isatom(S) )  U = S & lfirst(T);
	else if ( isatom(T) )  U = lfirst(S) & T;

   /***    Allgemeinfall    ***/
	else {
		list V=_0;
		bind( S,T );
   /***    komponentenweise bit-Operationen    ***/
		do {
			V = lcomp( lfirst(S) & lfirst(T), V );
			S = lred( S ),  T = lred( T );
		}
		while ( S!=_0 && T!=_0 );

   /***    normalisieren    ***/
		while ( V!=_0 && lfirst(V)==0 )  V = lred( V );
		if ( V==_0 )  U = 0;
		else  U = linv( V );
	}
   /***    Ergebnis    ***/
	return( U );
}
