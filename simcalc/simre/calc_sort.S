/*C
			calc_sort( fkeller )

	"calculator sort".
	list clac_sort( fkeller );  list fkeller;
	X = calc_sort( fkeller );

	calc_sort sortiert das in fkeller angegebene rationale Poly-
	nom P in r Variablen um. Dabei muss die angegebene Variablen-
	liste gerade eine Permutation derjenigen von P sein.
	Die Umsortieung fuer echt gebrochenrationale Polynome kann vor-
	laeufig noch nicht vorgenommen werden, da diese in kenntest
	wegen pvmix wieder zunichte gemacht wird.
	Laeuft calc_sort fehlerhaft ab, so ist  X  = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       30.06.1988      C.Hollinger/U.Schneiders
	Version 1.1     28.07.1988      C.Hollinger
	Version 1.2     20.01.1992      U.Schneiders
	Version 1.3     11.09.1992      U.Schneiders ( mod und nf )
	Version 1.4	26.07.1993	S.Schmitt ( gf )
	Version 2 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
	Version 2.1	15.02.1995	S.Schmitt ( R und C )
H*/

#include<_calc.h>

list calc_sort( fkeller )
list fkeller;

{
	obj P, p, var;
	single ken, f, i, pos, r, varken;
	list VL, PP, Z, N, varl;
	init( P,p, VL, PP, Z, N, var, varl );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	P = llast( fkeller );
	P = lfirst( P );
	ken = lsecond( P );

	/*** Ueberpruefung, ob P keine Konstante ist. ***/

	if(ken<2 || (ken>4 && ken!=18 && ken!=25 && ken!=32 && ken!=38 && ken!=39))
	{       mistake( 57 );
		return( -BASIS );
	}

	/*** Ueberpruefung, ob P echt gebrochenrational. ***/

	if( ken == 4 )
	{       mistake( 57 );
		return( -BASIS );
	}
	P = lfirst( P );
	VL = lfirst( P );
	r = llength( VL );
	P = lsecond( P );
	f = llength( fkeller );

	/*** Korrekte Angabe der Variablen? ***/

	if( f-r != 1 )
	{       mistake1( 34,"sort" );
		return( -BASIS );
	}

	/*** Permutieren der Variablen. ***/

	PP = _0;
	i = r;
	while( i )
	{       p = lfirst( fkeller );
		varken = lsecond( p );
		if( varken != 2 )
		{       mistake( 148 );
			return( ERROR );
		}
		p = lfirst( p );
		varl = lfirst( p );
		var = lsecond( p );
		if( llength( var ) != 2 || lfirst( var ) != 1
		    || lsecond( var ) != 1 || llength( varl ) != 1 )
		{       mistake( 148 );
			return( ERROR );
		}
		p = lfirst( varl );

		pos = lsrch( p, VL );
		if( !pos )
		{       mistake1( 34,"sort" );
			return( -BASIS );
		}
		PP = lcomp( pos, PP );
		fkeller = lred( fkeller );
		i--;
	}
	PP = linv( PP );
	if( ken != 4  )    P = pvpermut( r, P, PP );
	/*      else
		{       Z = lfirst( P );
			N = lsecond( P );
			Z = pvpermut( r, Z, PP );
			N = pvpermut( r, N, PP );
			P = list2( Z, N );
		}                                       */
	VL = lpermut( VL, PP );
	P = list2( VL, P );
	P = list2( P, ken );
	return( P );
}
