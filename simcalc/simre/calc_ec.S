/*C
			calc_ec( fkeller )

	"calculator elliptic curve".
	list calc_ec(fkeller); list fkeller;
	L = calc_ec( fkeller );

	fkeller ist eine Liste bestehend aus zwei oder fuenf Objekten
	mit zugehoerigen Kennungen. Sie entsprechen den Koeffizienten
	der elliptischen Kurve in kurze oder normaler Weierstrass-
	Normalform. Ihre Kennung muss 0, 1, 17 oder 24 sein. 
	Ist ein Koeffizient aus Z, so wird er in ein Element aus Q 
	umgewandelt.
	Elliptische Kurven in langer Weierstrass-Normalform ueber Q
	erhalten die Kennung -2. Solche in kurzer Weierstrass-
	Normalform die Kennung -1. 
	Ueber Z/pZ erhalten elliptische Kurven in kurzer Weierstrass-
	Normalform die Kennung -5, solche in langer die Kennung -6.
	Ueber Zahlkoerpern erhalten die elliptischen Kurven in kurzer
	Weierstrass-Normalform die Kennung -9, solche in langer die
	Kennung -10.
	Berechnet wird die Diskriminante der zugehoerigen ellipti-
	schen Kurve. Ist sie 0, so ist die Kurve singulaer, und es er-
	folgt eine Fehlermeldung.
	Laeuft calc_ec fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.11.1990      U.Schneiders
	Version  2      31.03.1992      U.Schneiders ( Z/mZ )
	Version  2.1    21.05.1992      U.Schneiders ( NF )
	Version  3      26.03.1993      S.Schmitt/U.Schneiders
					(neues Konzept)
	Version  3.1	12.07.1993	U.Schneiders (GF in Char 2 )
	Version  3.2	28.01.1994	S.Schmitt/U.Schneiders
	Version  3.3	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/
 
#include <_calc.h>

list calc_ec( fkeller )
list fkeller;
{
	single ak, akmax, i, ken, o;
	rat koef[5];
	list L,L1,L2,L3,T;
	obj a;
	init( koef[0..4] );
	init( a, L, L1, L2, L3, T );
	bind( fkeller );

	/*** kurze oder normale Weierstrass- Normalform ***/

	ken = llength( fkeller );
	if( ken != 2 && ken != 5 )
	{       mistake( 105 );
		return( ERROR );
	}
	if( ken == 2 )  {   ken = (-1); i = 1;   }
	else            {   ken = (-2); i = 4;   }

	/*** Koeffizienten aus Z oder Q ***/

	L = _0; akmax = 0;
	while( fkeller != _0 )
	{       a = lfirst( fkeller );
		ak = lsecond( a );
		if( ak && ak != 1 && ak != 17 && ak != 24 && ak != 31 )
		{       mistake( 107 );
			return( ERROR );
		}
		if( ak == 17 && !pzsch )
		{	mistake( 46 );
			return( ERROR );
		}
		if( ak == 31 && gfchar != 2 )
		{	mistake( 107 );
			return( ERROR );
		}
		if( ak == 31 && ken == (-1) )
		{	mistake( 267 );
			return( ERROR );
		}
		if( ( (ak == 17 || ak == 31) && akmax == 24 ) 
		|| ( ak == 24 && (akmax == 17 || akmax ==31)) )
		{	mistake( 165 );
			return( ERROR );
		}
		if( ((ak==17 && akmax==31) || (ak==31 && akmax==17)) &&
		gfchar != lfirst( varlist[modsch].varwert) )
		{	mistake( 266 );
			return( ERROR );
		}
		if( ak > akmax )  akmax = ak;
		koef[i] = a;
		i--;
		fkeller = lred( fkeller );
	}
	if( ken == (-1) ) o = 2;
	else  o = 5;
	for( i = 0; i < o; i++ )
	{	a = lfirst( koef[i] );
		ak = lsecond( koef[i] );
		switch( akmax )
		{	case 0: a = itor( a );
				break;
			case 1: if( !ak ) a = itor( a );
				break;
			case 17:if( ak < 2 )
				{	a = calc_m( koef[i] );
					if( a == ERROR ) return( ERROR );
					a = lfirst( a );
				}
				break;
			case 24:if( ak < 2 )
				{	a = calc_nf( koef[i] );
					if( a == ERROR ) return( ERROR );
					a = lfirst( a );
				}
				break;
			case 31:if( ak < 30 )
				{	a = calc_gf( koef[i] );
					if( a == ERROR ) return( ERROR );
					a = lfirst( a );
				}
				break;
   		}
		if(akmax>1 && ( akmax != 24 || ecqnfsch==_0 ))
		       L = lcomp( a, L );
		koef[i] = a;
	}
	if(akmax>1 && (akmax!=24 || ecqnfsch==_0))
	         L = linv( L );
	else if(akmax < 2)
	{       if(o==5)	
			L=ecrinit(koef[0],koef[1],koef[2],koef[3],koef[4]);
		else    L=ecrinit(0,0,0,koef[0],koef[1]);
	}
	else 
	{	a=lfirst(ecqnfsch);
		if(llength(ecqnfsch)==3) 
		{	for(i=0;i<o;i++) koef[i]=nftoqnf(koef[i],24);
			
		}
		if(o==5) 
			L=ecqnfinit(a,koef[0],koef[1],koef[2],koef[3],koef[4]);
		else 	L=ecqnfinit(a,0,0,0,koef[0],koef[1]);
		ken = ken - 8;
	}
		
	if( akmax == 17 )
        {	 ken = ken - 4;
		 a = lfirst( varlist[modsch].varwert );
	}
	else if( akmax == 24 && ecqnfsch==_0 )
        {	 ken = ken - 8;
		 a = lfirst( varlist[nfsch].varwert );
	}
	else if( akmax == 31 )
        {	 ken = ken - 12;
		 a = lfirst( varlist[gfsch].varwert );
	}

	/*** singulaere ell. Kurven abfangen ***/

	switch( ken )
	{	case (-1): 
		case (-2): a = ecracdisc(L);
			   break;
		case (-5): a = ecmpsnfdisc( a, koef[0], koef[1] );
			   break;
		case (-6): a = ecmpdisc( a, koef[0], koef[1], koef[2], koef[3], koef[4] );
			   break;
		case (-9): if(ecqnfsch!=_0) a = ecqnfacdisc(L);
			   else  a = ecnfsnfdisc( a, koef[0], koef[1] );
			   break;
		case (-10):if(ecqnfsch!=_0) a = ecqnfacdisc(L);
			   else  a = ecnfdisc( a, koef[0], koef[1], koef[2], koef[3], koef[4] );
			   break;
		case (-14):a = ecgf2disc( a, koef[0], koef[1], koef[2], koef[3], koef[4] );
			   break;
	}
	if( !a )
	{       mistake( 106 );
		return( ERROR );
	}

	L = list2( L, ken );
	return( L );
}
