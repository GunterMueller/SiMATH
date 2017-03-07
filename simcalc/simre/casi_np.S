/*C
			casi_np( fkeller )

	"calculator number of points".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	int casi_np( fkeller )   list fkeller;
	N = casi_np( fkeller );

	fkeller ist eine Liste, bestehend aus einer elliptischen Kurve E
	mit Koeffizienten aus Z und einer einfachgenauen Primzahl p.
	E muss in p minimal sein. Falls E in p gute Reduktion, ist N =
	#E(Z/pZ). Sonst wird eine Meldung, dass E multiplikative bzw.
	additive Reduktion hat, ausgegeben.
	Oder fkeller ist eine Liste, bestehend aus einer elliptischen
	Kurve E ueber Z/pZ.
	Fuehrt der Shanks-Algorithmus zu keinem Ergebnis, wird eine
	Warnung ausgegeben.
	Laeuft casi_np fehlerhaft ab, so ist  L = ERROR.
C*/
/*H
	Version  1      29.08.1991      U.Schneiders
	Version  2      04.08.1992      U.Schneiders ( mod )
	Version  2.1    28.12.1992      U.Schneiders ( minim. Modell )
	Version  3	08.04.1993	S.Schmitt/U.Schneiders
	Version  4      27.07.1993      U.Schneiders ( gf )
H*/

#include <_calc.h>

int casi_np( fkeller )
list fkeller;
{
	single k, ks, sch, i;
	obj  p, N, L1;
	rat c4, d, ko[5];
	init( c4, d, N, L1, p ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/
# ifdef ___CASI

	sch = llength( fkeller );
	if( sch > 2 )
	{       mistake1( 34,"np" );
		return( ERROR );
	}

	if( sch == 2 )
	{
		/*** Primzahl ***/

		p = lsecond( fkeller );
		ks = lsecond( p );
		if( ks )
		{       mistake( 46 );
			return( ERROR );
		}
		p = lfirst( p );
		if( isatom( p ) )
		{	ks = issprime( p, &N );
			if( !ks || ks == (-1) )
			{       mistake( 46 );
				return( ERROR );
			}
		}
		else
		{
			L1 = ispd(p,&N);
			if(L1!=_0)
			{
				mistake(46);
				return(ERROR);
			}
		}

		/*** elliptische Kurve ***/
	
		fkeller = lfirst( fkeller );
		k = lsecond( fkeller );
		if( k != (-1) && k != (-2) )
		{       mistake1( 34,"np" );
			return( ERROR );
		}
	}
	
	else
	{
		/*** elliptische Kurve ***/
		
		fkeller = lfirst( fkeller );
		k = lsecond( fkeller );
		if( k != (-5) && k != (-6) && k != (-14) )
		{       mistake1( 34,"np" );
			return( ERROR );
		}

		if( k == (-5) || k ==(-6) ) 
			p = lfirst( varlist[modsch].varwert );
		else
			p = lfirst( varlist[gfsch].varwert );
	}


	fkeller = lfirst( fkeller );
	if( k == (-1) || k==(-2))
	{       L1=lfirst(fkeller);
		L1=lfirst(L1);
		if(k==(-1)) 
		{     N=3;
		      L1=lred3(L1);
		}		 
		else	N=0;
		for(i=N;i<5;i++)
		{ 	ko[i] = lfirst( L1 );
			if( ko[i] )
			{       if(iavalint(p, lsecond( ko[i] )))
				{       mistake( 207 );
					return( ERROR );
				}
			}
			L1=lred(L1);
		}
		d = ecracdisc( fkeller );
	}
	else if( k == (-5) )
	{	ko[3] = lfirst( fkeller );
		ko[4] = lsecond( fkeller );
	}
	else 
	{	ko[0] = lfirst( fkeller );
		ko[1] = lsecond( fkeller );
		ko[2] = lthird( fkeller );
		ko[3] = lfourth( fkeller );
		ko[4] = lfifth( fkeller );
	}

	if( sch == 2 )
	{
		/*** hoechste p- Potenz, die die Diskr. teilt ***/

/*		if(k==(-1) || k==(-2))    ks = ravalint( p, d );
		else	ks=iavalint(p,d); */

		ks = ravalint( p, d );
		if( ks >= 12 )
		{	N=ecimina1(fkeller);
			N = lsecond( fkeller );
			N = lfirst( N );
			k = (-2);
			ko[0] = lfirst( N );
			ko[1] = lsecond( N );
			ko[2] = lthird( N);
			ko[3] = lfourth( N );
			ko[4] = lfifth( N );
			ko[0] = itor( ko[0] );
			ko[1] = itor( ko[1] );
			ko[2] = itor( ko[2] );
			ko[3] = itor( ko[3] );
			ko[4] = itor( ko[4] );
			N=ecrinit(ko[0],ko[1],ko[2],ko[3],ko[4]);
			d = ecracdisc( N );
			ks = ravalint( p, d );
			
		}
		else  N=fkeller;
		if( ks )
		{ 	c4 = ecracc4( N );
			if( c4 )        c4 = lfirst( c4 );
			if( mihom( p, c4 ) )
			{       mistake( 144 );
				return( ERROR );
			}
			mistake( 145 );
			return( ERROR );
		}

		/*** gute Reduktion ***/

	 	ko[3] = rtomi( ko[3], p );
		ko[4] = rtomi( ko[4], p );
		if( k == (-2) )
		{       ko[0] = rtomi( ko[0],p );
			ko[1] = rtomi( ko[1],p );
			ko[2] = rtomi( ko[2],p );
		}
	}	
	if( k == (-2) || k == (-6) )
	{	if( icomp( p, 3 ) > 0 )
		{       N = ecmptosnf( p, ko[0], ko[1], ko[2], ko[3], ko[4] );
			N = lfirst( N );
			ko[3] = lfirst( N );
			ko[4] = lsecond( N );
			/*** ecmptosnf liefert Koeff. nicht im pos. Restsystem ***/
			ko[3] = mihom( p, ko[3] );
			ko[4] = mihom( p, ko[4] );
		}
	}

	if( ( ( k == (-1) || k == (-5) ) && icomp( p, 2 ) ) || ( k!=(-14) && icomp( p, 3 ) > 0 ) )
	{       if( icomp( p, 46337 ) > 0 )
		{       
			if( icomp( iexp(10,25), p ) > 0 || !icomp(ko[3],0) || !icomp(ko[4],0))
			{    
			     for( ks = 0; ks < 2; ks++ )
			     {  N = ecmspsnfsha( p, ko[3], ko[4] );
				if( N != NULL && N >= 0 )  break;
			     }
			     if( N == NULL || N < 0 )
			     {  mistake( 247 );
				return( ERROR );
			     }
			}
			else  /* p > 10^25 */
			{	
			     /* L1 = p^(1/2) / (4 * 10^10) */
							
			     ks = iexp(10,10);
			     ks = iprod(4,ks);
			     L1 = isqrt(p);
			     L1 = iquot(L1,ks);
			     N = ecmpsnfcsesa(p, ko[3], ko[4], L1, 0, 0);
			     if( N == NULL )
			     {  mistake( 247 );
				return( ERROR );
			     }
			}
		}
		else
		{       N = ecmspsnfnp( p, ko[3], ko[4] );
			if(N==ERROR)
			{	mistake(87);
				return(ERROR);
			}
		}
	}
	else if( k != (-14) )
		  N = ecmspnp( p, ko[0], ko[1], ko[2], ko[3], ko[4] );

	else /*** k == (-14) ***/
	{       if( lfirst( p ) > 18 )
		{ 	N = ecgf2fp(p, ko[0], ko[1], ko[2], ko[3], ko[4]);
    			L1 = ecgf2msha1(p,ko[0],ko[1],ko[2],ko[3],ko[4],N,0,1,0,0);
			if( L1 == NULL )
			{	mistake(269);
				return( ERROR );
			}
			if( lfirst( L1 ) < 0 )
			{	mistake(270);
				return( ERROR );
			}
			N = lthird( L1 );
			L1 = lsecond( L1 );
	
			/*** Hasse Intervall ***/
			d = lfirst( p );
			d = iexp( gfchar, d );
			c4 = isqrt( d );
			p = isum( c4, c4 );
			c4 = idif( d, p );
			d = isum( d, p );
	
			/*** Testen, ob res = N eindeutig in Hasse Interv. ***/
			p = isum( N, L1 );
			if( icomp( c4, p ) <= 0 && icomp( p, d ) <= 0 )
			{	mistake1( 271, L1 );
				return( ERROR );
			}	
			p = idif( N, L1 );
			if( icomp( c4, p ) <= 0 && icomp( p, d ) <= 0 )
			{	mistake1( 271, L1 );
				return( ERROR );
			}	
		}
		else
		{	N = ecgf2npcasv( p, ko[0], ko[1], ko[2], ko[3], ko[4] );
			if( !N )
			{	mistake(270);
				return( ERROR );
			}
		}
	}
			
	N = list2( N, 0 );
	return( N );
# endif 
}
