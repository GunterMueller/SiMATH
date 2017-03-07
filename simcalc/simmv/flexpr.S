/*C
			flexpr( a1, a2 )

	"floating point exponentiation with rational exponents".
	list flexpr(a1,a2); floating a1; rat a2;
	A = flexpr( a1, a2 );
	a2 > 0.
	Berechnet wird a1 hoch a2,
	Laeuft flexpr fehlerhaft ab, so ist A = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      21.01.1992      U.Schneiders
	Version  2      28.12.1992      U.Schneiders ( flpow )
	Version  2.1    21.02.1995      S.Schmitt/U.Schneiders ( C )
H*/
 
#include <_calc.h>

list flexpr( a1, a2 )
floating a1;
rat a2;

{       /*** Deklarationen und Vorbesetzungen ***/

	floating A;
	single e, n1, n2, p2=0, un2, nsch=0, unger=0;
	bind( a1, a2 );
	init( A );
	n1 = lfirst( a2 );
	n2 = lsecond( a2 );

	/*** Fehlermeldung, falls Basiszahl negativ und Nenner des
	     Exponenten gerade ist ***/

	/*if ( flsign( a1 ) == -1  && !( n2%2 ) ) {
		mistake( 251 );
		return( -BASIS );
	}*/

	/*** Berechnung von a1 hoch a2 ***/

	A = flsexp( a1, n1 );
	if( flsign( A ) < 0 )
	{	A = flneg(A);
		nsch = 1;
	}
	if( sodd(n2) ) 
	{	unger = 1;
		un2 = n2;
	}
	else
	{	p2 = iaval( 2, n2 );
		un2 = ip2quot(n2, p2 );
	}
	if( un2!=1 )
	{	a1 = rcons( 1, un2);
		a1 = rtofl(a1);
		A = flpow( A, a1 );
	}
	if(nsch) A = flneg(A);
	if( p2 )
	{	if(nsch) 
		{	A = fltoc(A);
			for( e = 0; e < p2; e++ ) A = csqrt(A);
			A = list2(A,37);
		}
		else
		{	for( e = 0; e < p2; e++ ) A = flsqrt(A);
			A = list2(A,15);	
		}
	}
	else    A = list2(A,15);

	return( A );
}
