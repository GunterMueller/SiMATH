/*C
			calc_sqrt( fkeller )

	"calculator square root".
	list calc_sqrt( fkeller ); list fkeller;
	erg = calc_sqrt( fkeller );

	fkeller ist eine Liste bestehend aus einem Objekt und zugehoe-
	riger Kennung. Die Quadratwurzel aus der Zahl in fkeller wird
	gezogen.
	Laeuft calc_sqrt fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      12.05.1987      H.Stroeher/M.Mang
	Version  2      27.01.1992      U.Schneiders ( reell )
	Version  3      10.09.1992      U.Schneiders ( mod )
	Version 3.1     28.09.1993	S.Schmitt/U.Schneiders (isqrt)
	Version 3.2     04.01.1995	U.Schneiders (neg. Zahlen)
H*/
 
#include <_calc.h>

list calc_sqrt(fkeller)
obj fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj a1, M, M1,M2,N;
	single t1, sch=0;
	init( a1,M, M1,M2,N );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( fkeller == -BASIS ) return( -BASIS );

	/*** Berechnung der Quadratwurzel mit calc_exp ***/

	a1 = lfirst( fkeller ); t1 = lsecond( fkeller );
	if( ( t1 > 1 && t1 < 15 ) || t1 < 0  || ( t1 > 15 && t1 != 17 && t1!=24 && t1 != 37 ))
	{       mistake( 25 );
		return( -BASIS );
	}
	if( t1 == 24 )
	{	M = lfirst( varlist[nfsch].varwert );
		M1 = list4( 2, 1, 0, 1 );
		if(!oequal(M,M1))
		{	mistake(25);
			return( ERROR );
		}
		t1=nftyper(a1,0,24,37,&M1,&M);
		a1 = M1;
	}

	if( !t1 )
	{       if( isign( a1 ) < 0 )
		{       a1 = itoc( a1 );
			sch = 1;
		}
		if( !sch )
		{       M=isqrt(a1);
			N=iprod(M,M);
			if(!icomp(N,a1)) 
			{	M=list2(M,0);
				return(M);
			}	
			a1 = itofl( a1 );
		}
	}
	else if( t1 == 1 )
	{       if( rsign( a1 ) < 0 )
		{       a1 = rtoc( a1 );
			sch = 1;
		}
		if( !sch )
		{       M1=lfirst(a1);
			M=isqrt(M1);
			N=iprod(M,M);
			if(!icomp(N,M1))
			{	M2 = lsecond(a1);
				M1 = isqrt(M2);
				N = iprod(M1,M1);
				if(!icomp(N,M2))
				{
					M = rcons(M,M1);
					M = list2(M,1);
					return(M);
				}
			}
			a1 = rtofl( a1 );
		}
	}
	else if( t1 == 15 && flsign( a1 ) < 0 )
	{       a1 = fltoc( a1 );
		sch = 1;
	}

	if( t1 < 16 && !sch )
	{	a1 = flsqrt( a1 );
		a1 = list2( a1, 15 );
	}
	else if(sch || t1 == 37)
	{	a1 = csqrt(a1);
		a1 = list2(a1,37);
	}
	else	/*** t1 == 17 ***/
	{	M = lfirst( varlist[modsch].varwert );
		if( pzsch && icomp(M,2) ) a1 = mipsqrt( M, a1 );
		else	    a1 = misqrt( M, a1 );
		if( a1 == (-1) )
		{	mistake( 175 );
			return( ERROR );
		}
		if( a1 == (-2) )
		{	mistake( 195 );
			return( ERROR );
		}
		a1 = list2( a1, 17 );
	}

	return( a1 );
}
