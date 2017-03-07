/*C
			calc_stfkt( fkeller )

	"calculator Stammfunktion".
	list calc_stfkt( fkeller );     list fkeller;
	X = calc_stfkt( fkeller );

	fkeller enthaelt ein Polynom P und Variablen, nach denen in-
	tegriert werden soll. Dabei duerfen diese Variablen nicht vor-
	besetzt sein. calc_stfkt berechnet die Stammfunktion mit der
	Integrationskonstanten Null.
	Laeuft calc_stfkt fehlerhaft ab, so ist  X  = -BASIS.
	Der include-file <_.calch> wird benoetigt.
C*/
/*H
	Version 1      07.07.1988       C.Hollinger/U.Schneiders
	Version 4 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
H*/
/*cS
	calc_stfkt ruft auf: lcomp, linv, lkill, llength, lpermut,
			     lsrch, lsuffix, mistake, pitopr, printegr,
			     pvinsert, pvpermut

		     Macros: lfirst, list2, lred, lsecond
Sc*/

#include<_calc.h>

list calc_stfkt( fkeller)
list fkeller;

{
	single i, ken, pos, r, sch, varken;
	list P, PP, var, varl, varl1, VL;
	init( P, PP, var, varl, varl1, VL );
	bind( fkeller );

	sch = 1;

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) < 2 )
	{       mistake1( 34,"prfunc" );
		return( -BASIS );
	}

	/*** Berechnung der Stammfunktion mit Integrationskonstante 0. ***/

	fkeller = linv( fkeller );
	P = lfirst( fkeller );
	fkeller = lred( fkeller );
	ken = lsecond( P );
	if( ken >= 4 || ken < 0 )
	{       mistake( 224 );
		return( -BASIS );
	}
	if( ken < 2 ) sch = 0;
	if( sch )
	{       P = lfirst( P );
		VL = lfirst( P );
		r = llength( VL );
		P = lsecond( P );
	}
	while( fkeller != _0 )
	{       var = lfirst( fkeller );
		fkeller = lred( fkeller );
		varken = lsecond( var );
		if( varken != 2 )
		{       mistake( 56 );
			return( -BASIS );
		}
		var = lfirst( var );
		varl = lfirst( var );
		var = lsecond( var );
		if( llength( var ) != 2 || lfirst( var ) != 1
		    || lsecond( var ) != 1 || llength( varl ) != 1 )
		{       mistake( 56 );
			return( -BASIS );
		}
		if( sch )
		{       varl1 = lfirst( varl );
			PP = _0;
			for( i = r; i ; i-- )   PP = lcomp( i, PP );
			pos = lsrch( varl1, VL );
			if( pos )
			{       PP = lkill( PP, pos );
				PP = lsuffix( PP, pos );
			}
			else
			{       P = pvinsert( r, P, 1 );
				VL = lcomp( varl1,VL );
				PP = lsuffix( PP, r+1 );
				PP = lred( PP );
				PP = lsuffix( PP, 1 );
				r++;
			}
			P = pvpermut( r, P, PP );
			VL = lpermut( VL, PP );
		}
		else
		{       P = lfirst( P );
			P = pvinsert( 0, P, 1 );
			VL = varl;
			r = 1;
			ken = ken + 2;
			sch = 1;
		}
		switch( ken )
		{               case 2: P = pitopr( r,P );
					P = printegr( r,P );
					ken = 3;
					break;
				case 3: P = printegr( r,P );
					break;
		}
	}
	P = list2( VL, P );
	P = list2( P, ken );
	return( P );
}
