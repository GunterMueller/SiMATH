/*C
			rexpr( a1, a2 )

	"rational exponentiation with rational exponents".
	list rexpr(a1,a2); rat a1, a2;
	A = rexpr( a1, a2 );
	a2 > 0.
	Berechnet wird a1 hoch a2.
	Laeuft rexpr fehlerhaft ab, so ist A = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      21.01.1992      U.Schneiders
	Version  2      28.12.1992      U.Schneiders ( flpow )
	Version  2.1    21.06.1993      U.Schneiders ( iroot )
	Version  2.2    21.02.1995      S.Schmitt/U.Schneiders ( C )
H*/
 
#include <_calc.h>

list rexpr( a1, a2 )
rat a1, a2;

{       /*** Deklarationen und Vorbesetzungen ***/

	rat A;
	int Az, An, pi;
	single e, n1, n2, p2=0, un2, nsch=0, unger=0;
	bind( a1, a2 );
	init( A, Az, An, pi );
	n1 = lfirst( a2 );
	n2 = lsecond( a2 );

	/*** Fehlermeldung, falls Basiszahl negativ und Nenner des
	     Exponenten gerade ist ***/

	/*if ( rsign( a1 ) == -1  && !( n2%2 ) ) {
		mistake( 251 );
		return( -BASIS );
	} */

	/*** Berechnung von a1 hoch a2 ***/

	/*** Spezialfall a1 beliebig, a2 = n1/2^e ***/

	A = rexp( a1, n1 );
	if( rsign( A ) < 0 )
	{	A = rneg(A);
		nsch = 1;
	}
	if( sodd(n2) )
	{       unger = 1;
		un2 = n2;
	}
	else
	{	p2 = iaval( 2, n2 );
		un2 = ip2quot(n2, p2 );
	}

	if( !nsch || (nsch && unger) )
	{       Az = lfirst(A);
	        Az = iroot( Az, n2, &e );
		if( !e ) 
		{       An = lsecond(A);
			An = iroot( An, n2, &e );
			if( !e )
			{	pi = rcons( Az, An );	
				if(nsch) pi = rneg(pi);	
				A = list2( pi, 1 );
				return(A);
			}
		}
	}

	A = rtofl(A);
	if( un2!=1 )
	{	a1 = rcons( 1, un2);
		a1 = rtofl(a1);
		A = flpow( A, a1 );
	}
	if(nsch) A = flneg(A);
	if( p2 )
	{	if(nsch) 
		{	A = fltoc(A);
			for( pi = 0; pi < p2; pi++ ) A = csqrt(A);
			A = list2(A,37);
		}
		else
		{	for( pi = 0; pi < p2; pi++ ) A = flsqrt(A);
			A = list2(A,15);	
		}
	}
	else    A = list2(A,15);

	return( A );
}
