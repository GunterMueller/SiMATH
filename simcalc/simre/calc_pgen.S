/*C
			calc_pgen( fkeller )

	"calculator prime generator."
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_pgen( fkeller );  list fkeller;
	X = calc_pgen( fkeller );

	fkeller ist eine Liste, bestehend aus einer positeven ganzen
	Zahl o und einer positeven ganzen Zahl u mit u <= o.
	Berechnet wird die Liste aller Primzahlen p mit u <= p <= o.
	Laeuft calc_pgen fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      29.05.1991      U.Schneiders
H*/

#include<_calc.h>

list calc_pgen( fkeller )
list fkeller;
{
	single ken;
	obj o, u;
	list L;
	list AVL;
	init( o, u, L, AVL );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 2 )
	{       mistake1( 34,"pgen" );
		return( -BASIS );
	}

	/*** Ueberpruefung, ob korrekte Benutzung der Parameter. ***/

	o = lfirst( fkeller );
	ken = lsecond( o );
	if( ken )
	{       mistake( 63 );
		return( -BASIS );
	}
	u = lsecond( fkeller );
	ken = lsecond( u );
	if( ken )
	{       mistake( 63 );
		return( -BASIS );
	}
	u = lfirst( u );
	o = lfirst( o );
	if( isign( u ) <= 0 )
	{       mistake1( 34,"pgen" );
		return( -BASIS );
	}
	if( icomp( o, u ) < 0 )
	{       mistake1( 34,"pgen" );
		return( -BASIS );
	}

	/*** Berechnung der Liste der Primzahlen ***/

	L = ipgen( u, o );
	if( L == ERROR ) return( ERROR );
	if( L == _0 )
	{       u = list2( 0, 0 );
		return( u );
	}
	u = lfirst( L );
	if ( llength( L ) > 1 && !assch ) {
		printf( " smallest prime:\n %i\n", u );
		if( ps ) fprintf( datei, "out: smallest prime:\n %i\n", u );
	}
	u = list2( u, 0 );
	L = lred( L );
	if(avsch) AVL=_0;
	if( L != _0 )
	{       if(!assch)
		{	printf( " further primes:\n " );
			if( ps ) fprintf( datei, "out: further primes:\n " );
		}
		while( L != _0 )
		{       o = lfirst( L );
			L = lred( L );
			if(avsch) AVL=lcomp(list2(o,0),AVL);
			if(!assch)
			{   printf( "%i   ", o );
			    if( ps ) fprintf( datei, "%i   ", o );
			}
		}
		if(!assch)
		{   printf( "\n\n" );
		    if( ps ) fprintf( datei, "\n\n" );
		}
		if(avsch)
		{	AVL=linv(AVL);
			av_basad(AVL);
		}
	}
	return( u );
}
