/*C
			iexpr( a1, a2 )

	"integer exponentiation with rational exponents".
	list iexpr(a1,a2); int a1; rat a2;
	A = iexpr( a1, a2 );
	a2 > 0.
	Berechnet wird a1 hoch a2,
	Laeuft iexpr fehlerhaft ab, so ist A = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
	Version  2      21.01.1992      U.Schneiders
	Version  3      28.12.1992      U.Schneiders ( flpow )
	Version  3.1    21.06.1993      U.Schneiders ( iroot )
	Version  3.2    21.02.1995      S.Schmitt/U.Schneiders ( C )
H*/
 
#include <_calc.h>

list iexpr( a1, a2 )
int a1;
rat a2;

{       /*** Deklarationen und Vorbesetzungen ***/

	int A, pi;
	single e, n1, n2, nsch=0, p2=0, un2, unger=0;
	bind( a1, a2 );
	init( A, pi );
	n1 = lfirst( a2 );
	n2 = lsecond( a2 );

	/*** Fehlermeldung, falls Basiszahl negativ und Nenner des
	     Exponenten gerade ist ***/

/*	if ( isign( a1 ) == -1  && !( n2%2 ) ) {
		mistake( 251 );
		return( -BASIS );
	} */

	/*** Berechnung von a1 hoch a2 ***/

	A = iexp( a1, n1 );
	if( isign( A ) < 0 )
	{	A = ineg(A);
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

	if( !nsch || (nsch && unger) )
	{       pi = iroot( A, n2, &e );
		if( !e ) 
		{       if(nsch) pi = ineg(pi);	
			A = list2( pi, 0 );
			return(A);
		}
	}

	A = itofl(A);
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
