/*C
			calc_coef( fkeller )

	"calculator coefficient".
	list calc_coef( fkeller );  list fkeller;
	X = calc_coef( fkeller );

	fkeller ist eine Liste, bestehend aus 3 Elementen: einem
	Exponenten e, einer Variablen x und einem Polynom P.
	calc_coef gibt den Koeffizienten von x^e im Polynom P an.
	Dabei muss die angegebene Variable eine Polynomvariable von
	P sein.
	Laeuft calc_coef fehlerhaft ab, so ist  X = ERROR.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       14.02.1991      U.Schneiders
	Version 2       04.08.1992      U.Schneiders ( mod und nf )
	Version 3       26.07.1993	S.Schmitt ( gf )
	Version 4 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
	Version 4.1	25.01.1995	S.Schmitt ( R und C )
H*/
/*cS
	calc_coef ruft auf: issingle, lcomp, lkill, llength, lpermut,
			    lsrch, mistake, pvpermut
		    Macros: lfirst, list1, list2, lred2, lsecond, lthird
Sc*/

#include<_calc.h>

list calc_coef( fkeller )
list fkeller;
{
	obj P, exp, var;
	single ken, i, pos, r;
	list VL, PP, varl;
	init( P, exp, var, varl, VL, PP );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 3 )
	{       mistake1( 34,"coef" );
		return( ERROR );
	}

	exp = lfirst( fkeller );
	ken = lsecond( exp );
	if( ken )
	{       mistake1( 34,"coef" );
		return( ERROR );
	}
	exp = lfirst( exp );
	if( !issingle( exp ) )
	{       mistake1( 34,"coef" );
		return( ERROR );
	}

	P = lthird( fkeller );
	ken = lsecond( P );
	if( ken!=2 && ken!=3 && ken!=18 && ken!=25 && ken!=32 && ken!=38 && ken!=39)
	{       mistake( 53 );
		return( ERROR );
	}
	P = lfirst( P );
	VL = lfirst( P );
	r = llength( VL );
	P = lsecond( P );

	var = lsecond( fkeller );
	pos = lsecond( var );
	if( pos != 2 )
	{       mistake1( 34,"coef" );
		return( ERROR );
	}
	var = lfirst( var );
	varl = lfirst( var );
	var = lsecond( var );
	if( llength( var ) != 2 || lfirst( var ) != 1
	    || lsecond( var ) != 1 || llength( varl ) != 1 )
	{       mistake1( 34,"coef" );
		return( ERROR );
	}
	varl = lfirst( varl );
	pos = lsrch( varl, VL );
	if( !pos )
	{       mistake1( 34,"coef" );
		return( ERROR );
	}

	/*** Permutieren der Variablen. ***/

	PP = list1( pos );
	i = r;
	while( i )
	{       if( i != pos )
			PP = lcomp( i, PP );
		i--;
	}
	VL = lpermut( VL, PP );
	P = pvpermut( r, P, PP );

	/*** Bestimmen des Koeffizientes ***/

	pos = lfirst( P );
	while( pos > exp )
	{       P = lred2( P );
 		if( P == _0 ) break;
		pos = lfirst( P );
	}

	if( pos == exp )
	{       P = lsecond( P );
		VL = lkill( VL, r );
		P = list2( VL, P );
		P = list2( P, ken );
	}
	else if( ken < 4 )  P = list2( 0, 0 );
	else if( ken < 38 ) P = list2( 0, (ken-1) );
  	else  		    P=list2( 0, 15 );

	return( P );
}
