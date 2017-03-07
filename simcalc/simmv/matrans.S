/*C
			matrans( M )

	"matrix transpose"
	Quellbibliothek: srclib.calc
	Include-Datei:   _calc.h
	matrix matrans(M)  matrix M;
	T = matrans( M );
	T ist die transponierte Matrix zu M. M wird zerstoert.
C*/
/*H
	Version 1        7.04.88        R.Boeffgen
	Version 2       23.06.88        matrans -> matransp.   RB
	Version 3        1.07.88        M = 0 beruecksichtigt.  RB
	Version 4       14.11.88        Calculator- Version. HC/US
H*/
/*cS
	matrans ruft auf: isnullma, lcomp, linv
	Macros: lfirst, lred, lsfirst, lsred
Sc*/


# include <_calc.h>

matrix matrans( M )
matrix M;
{
	list   H, V, W;
	matrix Mr, T;
	bind( M );
	init( T, Mr, H, V, W );

   /***    M Nullmatrix               ***/
	if( isnullma( M ) ) return( M );
 
   /***    M abarbeiten, T aufbauen    ***/
	for (  T=_0;  lfirst(M) != _0;  T = lcomp( H,T )  )
	{       for  ( V=_0, Mr=M;  Mr!=_0;  V=W, Mr=lred(Mr)  )
		{       W = lfirst( Mr );
			lsfirst( Mr, lred(W) );
			lsred( W,V );
		}
		H = linv( V );
	 }

   /***    Ergebnis    ***/
	T = linv( T );
	return( T );

}
