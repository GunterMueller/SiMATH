/*C
			calc_elsubst( fkeller )

	"calculator element substitution".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_elsubst( fkeller );  list fkeller;
	X = calc_elsubst( fkeller );

	fkeller ist eine Liste aus einer Matrix bzw. einem Vektor, dem zu
	ersetzenden Element und den Positionsangaben. Auf der angegebenen
	Position in der Matrix bzw. dem Vektor wird das entsprechende Ele-
	ment ersetzt. Die neue Matrix bzw. der neue Vektor wird in X zu-
	rueckgegeben.
	Laeuft calc_elsubst fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      17.01.1990      C.Hollinger/U.Schneiders
	Version  1.1    20.01.1992      U.Schneiders
	Version  2      11.09.1992      U.Schneiders ( mod und nf )
	Version  3	26.07.1993	S.Schmitt ( gf )
H*/

#include<_calc.h>

list calc_elsubst( fkeller )
list fkeller;

{
	single spbit=0, kenel, kenm, kenpos, kenpos1, l;
	list pos, pos1, VM;
	obj el, eln, M, Mn;

	init( pos, pos1, VM, el, eln, M, Mn );
	bind( fkeller );

	VM = _0;
	l = llength( fkeller );
	if( l < 3 || l > 4 )
	{       mistake1( 34,"elsubst" );
		return( -BASIS );
	}
	if( l == 3 )
	{       M = lthird( fkeller );
		kenm = lsecond( M );
		if( kenm < 10 || ( kenm > 14 && kenm != 21 && kenm != 22 && kenm != 28 && kenm != 29 && kenm != 35 && kenm != 36 ) )
		{       mistake1( 34,"elsubst" );
			return( -BASIS );
		}
		el = lsecond( fkeller );
		kenel = lsecond( el );
		if( ( kenel > 4 && kenel != 17 && kenel != 18 && kenel != 24 && kenel != 25 && kenel != 31 && kenel != 32 ) || kenel < 0 )
		{       mistake( 77 );
			return( -BASIS );
		}
		pos = lfirst( fkeller );
		kenpos = lsecond( pos );
		if( kenpos )
		{       mistake1( 34,"elsubst" );
			return( -BASIS );
		}
		pos = lfirst( pos );
		M = lfirst( M );
		if( ( kenm > 11 && kenm < 15 ) || kenm == 22 || kenm == 29 || kenm == 36 )
		{       VM = lfirst( M );
			Mn = lsecond( M );
		}
		else    Mn = M;
		if( pos < 1 || llength( Mn ) < pos )
		{       mistake( 98 );
			return( -BASIS );
		}
	}
	else
	{       M = lfourth( fkeller );
		kenm = lsecond( M );
		if( kenm < 5 || ( kenm > 9 && kenm != 19 && kenm != 20 && kenm != 26 && kenm != 27 && kenm != 33 && kenm != 34 ) )
		{       mistake1( 34,"elsubst" );
			return( -BASIS );
		}
		el = lthird( fkeller );
		kenel = lsecond( el );
		if( ( kenel > 4 && kenel != 17 && kenel != 18 && kenel != 24 && kenel != 25 && kenel != 31 && kenel != 32 ) || kenel < 0 )
		{       mistake( 77 );
			return( -BASIS );
		}
		pos = lfirst( fkeller );
		kenpos = lsecond( pos );
		if( kenpos )
		{       mistake1( 34,"elsubst" );
			return( -BASIS );
		}
		pos = lfirst( pos );
		M = lfirst( M );
		if( ( kenm > 6 && kenm < 10 ) || kenm == 20 || kenm == 27 || kenm == 34 )
		{       VM = lfirst( M );
			Mn = lsecond( M );
		}
		else    Mn = M;
		if(kenm==19 && lfirst(varlist[modsch].varwert)==2) spbit=1;
		if( pos < 1 || (spbit && lfirst(Mn)<pos ) || (!spbit && manrcol( Mn ) < pos ))
		{       mistake( 98 );
			return( -BASIS );
		}
		pos1 = lsecond( fkeller );
		kenpos1 = lsecond( pos1 );
		if( kenpos1 )
		{       mistake1( 34,"elsubst" );
			return( -BASIS );
		}
		pos1 = lfirst( pos1 );
		if( pos1 < 1 || (spbit && (llength(Mn)-1)<pos1) || (!spbit && manrrow( Mn ) < pos1)) 
		{       mistake( 98 );
			return( -BASIS );
		}
	}
	el = lfirst( el );

	if( l == 3 )
	{       kenm = svtyper( el, M, kenel, kenm, &eln, &Mn, 1 );
		if( kenm == ERROR ) return( ERROR );
		if( ( kenm > 11 && kenm < 15 ) || kenm == 22 || kenm == 29 || kenm == 36 )
		{       VM = lfirst( Mn );
			Mn = lsecond( Mn );
			eln = lsecond( eln );
		}
		M = lcopy( Mn );
		leset( M, pos, eln );
		if( ( kenm > 11 && kenm < 15 ) || kenm == 22 || kenm == 29 || kenm == 36 )
			M = list2( VM, M );
	}
	else
	{       kenm = smtyper( el, M, kenel, kenm, &eln, &Mn, 1 );
		if( kenm == ERROR ) return( ERROR );
		if( ( kenm > 6 && kenm < 10 ) || kenm == 20 || kenm == 27 || kenm == 34 )
		{       VM = lfirst( Mn );
			Mn = lsecond( Mn );
			eln = lsecond( eln );
		}
		M = lcopy( Mn );
		if(spbit) mam2setel(M,pos1,pos,eln);
		else masetel( M, pos1, pos, eln );
		if( ( kenm > 6 && kenm < 10 ) || kenm == 20 || kenm == 27 || kenm == 34 )
			M = list2( VM, M );
	}
	M = list2( M, kenm );
	return( M );
}
