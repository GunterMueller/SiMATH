/*C
			calc_integr( fkeller )

	"calculator integration".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_integr( fkeller );     list fkeller;
	X = calc_integr( fkeller );

	fkeller enthaelt ein Polynom P, die Variablen, nach denen in-
	tegriert werden soll, und die Integrationsgrenzen, die direkt
	auf den Variablennamen folgen muessen. Dabei duerfen diese Va-
	riablen nicht vorbesetzt sein. calc_integr berechnet das ent-
	sprechende Integral.
	Laeuft calc_integr fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
        Version 1       01.09.1988      U.Schneiders
	Version 1.1     11.12.1992      U.Schneiders ( Test, ob rat.
					Fkt. erst beim Ergeb. )
	Version 2 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
H*/
/*cS
	calc_integr ruft auf: calc_dif, kenntest, lcomp, linv, lkill, 
			      llength, lpermut, lsrch, lsuffix, mistake,
			      peval, pitopr, printegr, pvinsert, 
			      pvpermut
		      Macros: lfirst, list2, lred, lsecond
Sc*/

#include<_calc.h>
list calc_integr( fkeller)
list fkeller;

{
	single i, ken, ken1, ken2, keno, kenu, pos, posv[2], r, sch, varken;
	list PP, Varl, Varl1, VL;
	obj Gro, Gru, P, N1, N2, Var;
	init( P, PP, Var, Varl, Varl1, VL, Gro, Gru, N1, N2 );
	bind( fkeller );

	sch = 1;

	/*** Abfangen ungueltiger Eingaben. ***/

	r = llength( fkeller );
	if( r < 4 || ( ( r-1 ) % 3 ) )
	{       mistake1( 34,"integr" );
		return( -BASIS );
	}

	/*** Berechnung des Integrals. ***/

	fkeller = linv( fkeller );
	P = lfirst( fkeller );
	fkeller = lred( fkeller );
	ken = lsecond( P );
	if( ken > 4 || ken < 0 )
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
	{       Var = lfirst( fkeller );
		fkeller = lred( fkeller );
		varken = lsecond( Var );
		if( varken != 2 )
		{       mistake( 214 );
			return( -BASIS );
		}
		Var = lfirst( Var );
		Varl = lfirst( Var );
		Var = lsecond( Var );
		if( llength( Var ) != 2 || lfirst( Var ) != 1
		    || lsecond( Var ) != 1 || llength( Varl ) != 1 )
		{       mistake( 214 );
			return( -BASIS );
		}
		if( sch )
		{       Varl1 = lfirst( Varl );
			PP = _0;
			for( i = r; i ; i-- )   PP = lcomp( i, PP );
			pos = lsrch( Varl1, VL );
			if( pos )
			{       PP = lkill( PP, pos );
				PP = lsuffix( PP, pos );
			}
			else
			{       P = pvinsert( r, P, 1 );
				VL = lcomp( Varl1,VL );
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
			VL = Varl;
			r = 1;
			ken = ken + 2;
			sch = 1;
		}
		switch( ken )
		{       case 2: P = pitopr( r,P );
				P = printegr( r,P );
				ken = 3;
				break;
			case 3: P = printegr( r,P );
				break;
		}
		Gru = lfirst( fkeller );
		kenu = lsecond( Gru );
		fkeller = lred( fkeller );
		Gro = lfirst( fkeller );
		keno = lsecond( Gro );
		fkeller = lred( fkeller );
		if( kenu > 4 || keno > 4 || kenu < 0 || keno < 0 )
		{       mistake( 226 );
			return( -BASIS );
		}  
		posv[ 0 ] = r;
		posv[ 1 ] = -1;
		N1 = peval( VL, P, ken, Gru, posv );
		N2 = peval( VL, P, ken, Gro, posv );
		ken1 = lsecond( N1 );
		N1 = lfirst( N1 );
		ken2 = lsecond( N2 );
		N2 = lfirst( N2 );
		P = calc_dif( N1, N2, ken1, ken2 );
		P = kenntest( P );
		ken = lsecond( P );
		if( fkeller != _0 &&  ken == 4 )
		{       mistake( 66 );
			return( -BASIS );
		}
		if( ken < 2 ) sch = 0;
		if( sch && fkeller != _0 )
		{       P = lfirst( P );
			VL = lfirst( P );
			r = llength( VL );
			P = lsecond( P );
		}
	}
	return( P );
}
