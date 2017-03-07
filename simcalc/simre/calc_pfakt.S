/*C
			calc_pfakt( fkeller )

	"calculator factorization modular primes ".
	list calc_pfakt( fkeller ); list fkeller;
	X =  calc_pfakt( fkeller );

	fkeller ist eine Liste, bestehend aus einem Objekt mit zugehoe-
	riger Kennung und einer Primzahl mit Kennung.
	Berechnet wird die Liste der Primteiler des Objekts, dabei muss
	der Hauptnenner des zu faktorisierenden Objekts teilerfremd zur
	Primzahl sein.
	Da die berechnete Liste der Primteiler von den uebergeordneten
	Programmen des Calculators nicht verarbeitet werden kann, wird
	der Ersatzwert -BASIS zurueckgeliefert.
	Laeuft calc_pfakt fehlerhaft ab, so wird -BASIS zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      09.06.1988       C.Hollinger/U.Schneiders
	Version  2      04.12.1989       U.Schneiders
	Version  3      03.04.1991       U.Schneiders
H*/

#include<_calc.h>

list calc_pfakt(fkeller)
list fkeller;

{
	list erg, hilf, L, P, p, VL;
	single ken, kenp, r, s;
	obj c;
	pol PH;
	int hn;
	bind( fkeller );
	init( erg, hilf, L, P, p, VL, c, PH, hn );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller )!= 2 )
	{       mistake1( 34, "pfact" );
		return( -BASIS );
	}

	/*** Ueberpruefung, ob korrekte Benutzung der Parameter. ***/

	P = lfirst( fkeller );
	ken = lsecond( P );
	if( ken >= 4 || ken < 0 )
	{       mistake( 43 );
		return( -BASIS );
	}
	if( ken > 1 )
	{       P = lfirst( P );
		VL = lfirst( P );
		P = lsecond( P );
		r = llength( VL );
		if( r != 1 )
		{       mistake( 100 );
			return( ERROR );
		}
	}
	else    P = lfirst( P );
	p=lsecond( fkeller );
	kenp = lsecond( p );
	if( kenp )
	{       mistake( 46 );
		return( -BASIS );
	}
	p = lfirst( p );
	if( isatom( p ) )
	{	s = issprime( p, &c );
		if( s != 1 )
		{       mistake( 46 );
			return( -BASIS );
		}
	}
	else
	{
		L = ispd(p,&c);
		if(L!=_0)
		{
			mistake(46);
			return(ERROR);
		}
	}

	/*** Berechnung der Faktorisierung modulo p ***/

	switch( ken )
	{       case 0: /*** Faktorisierung modulo p fuer ganze Argumente ***/
			erg = calc_mod( p, P, kenp, ken );
			break;
		case 1: /*** Faktorisierung modulo p fuer rat. Argumente ***/
			erg = calc_mod( p, P, kenp, ken );
			break;
		case 2: /*** Faktorisierung modulo p fuer ganzahlige Polynome als
			     Polynome als Argumente ***/
			PH = pitopmi( r, P, p );
			if( !PH )  L = list1(0);
			else if( !lfirst( PH ) )
			{       c = lsecond( PH );
				L = list1( c );
			}
			else
			{       c = lsecond( PH );
				if( c != 1 )
					PH = pmimiquot( r, p, PH, c );
				L = upmicfact( p, PH );
				L = lcomp( c, L );
			}
			erg=polaus( VL, L, P, 2, p );
			if(lsecond(erg))
			{	erg = list2(VL,erg);
				erg=list2(erg,2);
			}
			break;
		case 3: /*** Faktorisierung modulo p fuer rat. Polynome als Argumente ***/
			PH = prnumden( r, P, &hn );
			if( igcd( p, hn ) != 1 )
			{       mistake1( 242, p );
				erg = -BASIS;
			}
			else
			{       hn = miinv( p, hn );
				PH = piiprod( r, PH, hn );
				PH = pitopmi( r, PH, p );
				if( !PH )  L = list1(0);
				else if( !lfirst( PH ) )
				{       c = lsecond( PH );
					L = list1( c );
				}
				else
				{       c = lsecond( PH );
					if( c != 1 )
						PH = pmimiquot( r, p, PH, c );
					L = upmicfact( p, PH );
					L = lcomp( c, L );
				}
				erg=polaus( VL, L, P, 3, p );
				if(lsecond(erg))
				{	erg = list2(VL,erg);
					erg=list2(erg,2);
				}
			}
			break;
	}
	return( erg );
}
