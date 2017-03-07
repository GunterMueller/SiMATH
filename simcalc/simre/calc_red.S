/*C
			calc_red( fkeller )

	"calculator reduction".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_red( fkeller )   list fkeller;
	L = calc_red( fkeller );

	fkeller ist eine Liste, bestehend aus einer elliptischen Kurve E
	mit Koeffizienten aus Z und einer einfachgenauen Primzahl p.
	E muss in p minimal sein. Falls E in p gute Reduktion, ist L
	die mod p reduzierte elliptische Kurve. Sonst wird eine Meldung,
	dass E multiplikative bzw. additive Reduktion hat, ausgegeben.
	Laeuft calc_red fehlerhaft ab, so ist  L = ERROR.
C*/
/*H
	Version  1      28.08.1991      U.Schneiders
	Version  2	08.04.1993	S.Schmitt/U.Schneiders
H*/

#include <_calc.h>

list calc_red( fkeller )
list fkeller;
{
	single k, ks, i;
	obj p, L;
	rat c4, d, ko[5], a[5];
	init( c4, d, L, p ); init( ko[0..4] ); init( a[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"red" );
		return( ERROR );
	}

	/*** Primzahl ***/

	p = lsecond( fkeller );
	ks = lsecond( p );
	if( ks )
	{       mistake( 46 );
		return( ERROR );
	}
	p = lfirst( p );
	if( isatom( p ) )
	{	ks = issprime( p, &L );
		if( !ks || ks == (-1) )
		{       mistake( 46 );
			return( ERROR );
		}
	}
	else
	{
		L = ispd(p,&c4);
		if(L!=_0)
		{
			mistake(46);
			return(ERROR);
		}
	}

	/*** elliptische Kurve ***/

	fkeller = lfirst( fkeller );
	k = lsecond( fkeller );
	if( k != (-1) && k != (-2) )
	{       mistake1( 34,"red" );
		return( ERROR );
	}

	fkeller = lfirst( fkeller );
        L=lfirst(fkeller);
	L=lfirst(L);
	for(i=0;i<5;i++)
	{	ko[i] = lfirst( L );
		if( ko[i] )
		{       if( iavalint(p,lsecond( ko[i] )))
			{       mistake( 204 );
				return( ERROR );
			}
		}
		L=lred(L);
	}
	d=ecracdisc(fkeller);	


	/*** hoechste p- Potenz, die die Diskr. teilt ***/

	ks = ravalint( p, d );
	if( ks >= 12 )
	{       if(icomp(p,3)>0) 
		{       mistake( 143 );
			return(ERROR);
		}
		else
		{	a[0]=ecimina1(fkeller);
			L=lsecond(fkeller);
			L=lfirst(L);
			for(i=0;i<5;i++)	
			{	a[i]=lfirst(L);
				L=lred(L);
				a[i]=itor(a[i]);
				if(rcomp(a[i],ko[i]))
				{     mistake(143);
				      return( ERROR );
				}
			}
		}
	}
	if( ks )
	{ 	c4 = ecracc4( fkeller );
		if( c4 )        c4 = lfirst( c4 );
		if( mihom( p, c4 ) )
		{       mistake( 144 );
			return( ERROR );
		}
		mistake( 145 );
		return( ERROR );
	}

	/*** gute Reduktion ***/

	ko[3]= rtomi( ko[3], p );
	if( ko[3] ) ko[3] = list2( ko[3], 1 );
	ko[4] = rtomi( ko[4], p );
	if( ko[4] ) ko[4] = list2( ko[4], 1 );
        ko[0] = rtomi(ko[0], p );
	if( ko[0] ) ko[0] = list2( ko[0], 1 );
	ko[1] = rtomi(ko[1], p );
	if( ko[1] ) ko[1] = list2( ko[1], 1 );
	ko[2] = rtomi( ko[2], p );
	if( ko[2] ) ko[2] = list2( ko[2], 1 );
	L = ecrinit( ko[0], ko[1], ko[2], ko[3], ko[4] );
	L = list2( L, k );
	return( L );
}
