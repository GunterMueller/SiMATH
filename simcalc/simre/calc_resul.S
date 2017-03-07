/*C
			calc_resul( fkeller )

	"calculator resultant".
	list calc_resul( fkeller );       list fkeller;
	P =  calc_resul( fkeller );

	fkeller ist eine Liste, bestehend aus einer single- Variablen
	zur Kennzeichnung des Algorithmus', einem Variablennamen, bzgl.
	dessen die Resultante gebildet wird und zwei Polynomen mit ent-
	sprechender Kennung. Berechnet wird die Resultante der beiden
	Polynome bzgl. der im Variablennamen angegebenen Variablen mit
	folgenden Algorithmen :
		2 fuer Bezout- Algorithmus
		1 fuer Sylvester- Algorithmus
		3 fuer Collins- mit- Sylvester- Algorithmus
		4 fuer Collins- mit- Collins- Algorithmus.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       5.5.88          C.Hollinger/U.Schneiders
	Version 2       17.09.1992      U.Schneiders ( mod )
	Version 3	27.07.1993	S.Schmitt ( gf )
	Version 4 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
H*/
/*cS
	calc_resul ruft auf: lkill, lpermut, lsrch, mistake, pgfsres,
			     piresbez, pirescoll, piressylv, pmires, 
			     pmsres, pvinsert, pvpermut, typer
		     Macros: lcomp, lfirst, list2, llength, lred,
                	     lsecond, lsuffix
Sc*/

#include<_calc.h>

list calc_resul( fkeller )
list fkeller;
 
{       single ken1, ken2, r, i, pos;
	list pvar, VP, V, PP;
	pol P1, P2, Q1, Q2;
	obj arg;
	init( arg, pvar, VP, V, PP, P1, P2, Q1, Q2 );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller) != 4 )
	{       mistake1( 34, "resul");
		return( -BASIS );
	}

	/*** Ueberpruefung, ob korrekte Benutzung der Parameter. ***/

	arg = lfirst( fkeller );
	ken1 = lsecond( arg );
	arg = lfirst( arg );
	if( ken1 || arg < 1 || arg > 4 )
	{       mistake( 35 );
		return( -BASIS );
	}
	fkeller = lred( fkeller );
	pvar = lfirst( fkeller );

	/*** pvar muss wie folgt aussehen: ( ( name )( 1 1 ), 2 ) ***/

	ken1 = lsecond( pvar );
	if( ken1 != 2 )
	{       mistake( 36 );
		return( -BASIS );
	}
	pvar = lfirst( pvar );
	VP = lfirst( pvar );
	pvar = lsecond( pvar );
	if( llength(VP) != 1 || llength(pvar) != 2 || lfirst(pvar) != 1 || lsecond(pvar) != 1 )
	{       mistake( 36 );
		return( -BASIS );
	}
	fkeller = lred( fkeller );
	P2 = lfirst( fkeller );
	P1 = lsecond( fkeller );
	ken1 = lsecond( P1 );
	ken2 = lsecond( P2 );
	if( ( ken1 && ken1 != 2 && ken1 != 17 && ken1 != 18 && ken1 != 31 && ken1 != 32 )
	 || ( ken2 && ken2 != 2 && ken2 != 17 && ken2 != 18 && ken2 != 31 && ken2 != 32 )
	 || ( !ken1 && ( !ken2 || ken2 == 17 || ken2 == 31 ) )
	 || ( ken1 == 17 && ( !ken2 || ken2 == 17 || ken2 == 31 ) )
	 || ( ken1 == 31 && ( !ken2 || ken2 == 17 || ken2 == 31 ) )
	 || ( ( ken1 == 31 || ken1 == 32 || ken2 == 31 || ken2 == 32 ) && gfchar == 2 ) )
	{       mistake( 37 );
		return( -BASIS );
	}

	/*** Anpassung der Variablenlisten von P1 und P2 bzgl pvar. ***/

	P1 = lfirst( P1 );
	P2 = lfirst( P2 );
	ken1 = typer( P1, P2, ken1, ken2, &Q1, &Q2, 1 );
	if( ken1 == 18 && !pzsch )
	{	mistake( 37 );
		return( ERROR );
	}
	V = lfirst( Q1 );
	Q1 = lsecond( Q1 );
	Q2 = lsecond( Q2 );
	r = llength( V );
	PP = _0;
	for( i = r; i ; i-- )   PP = lcomp( i, PP );
	VP = lfirst( VP );
	pos = lsrch( VP, V );
	if( pos )
	{       PP = lkill( PP, pos );
		PP = lsuffix( PP, pos );
	}
	else
	{       Q1 = pvinsert( r, Q1, 1 );
		Q2 = pvinsert( r, Q2, 1 );
		V = lcomp( VP, V );
		PP = lsuffix( PP, r+1 );
		PP = lred( PP );
		PP = lsuffix( PP, 1 );
		r++;
	}
	Q1 = pvpermut( r, Q1, PP );
	Q2 = pvpermut( r, Q2, PP );
	V = lpermut( V, PP );

	/*** Berechnung der Resultante gemaess Eingabe. ***/

	if( ken1 == 2)
	{  switch( arg )
	   {    case 1: /*** Sylvester-Algorithmus ***/
			P1 = piressylv( r, Q1, Q2 );
			break;
		case 2: /*** Bezout-Algorithmus ***/
			P1 = piresbez( r,Q1, Q2 );
			break;
		case 3: /*** Collins-mit-Sylvester-Algorithmus ***/
			P1 = pirescoll( r, Q1, Q2, 1 );
			break;
		case 4: /*** Collins-mit-Collins-Algorithmus ***/
			P1 = pirescoll( r, Q1, Q2, 2 );
			break;
	   }
	   if( r == 1 )    P1 = list2( P1,0 );
	   else
	   {       V = lkill( V,r );
		   P1 = list2( V,P1 );
		   P1 = list2( P1,2 );
	   }
	}
	else if( ken1 == 18 )
	{	if( arg == 4 ) arg = 3;
		P2 = lfirst( varlist[modsch].varwert );
		if( ssch ) P1 = pmsres( r, P2, Q1, Q2, arg );
		else       P1 = pmires( r, P2, Q1, Q2, arg );
		if( P1 == ERROR || P1 == -BASIS-1 )
		{	mistake( 179 );
			return( ERROR );
		}
		if( r == 1 ) P1 = list2( P1, 17 );
		else
		{	V = lkill( V, r );
			P1 = list2( V, P1 );
			P1 = list2( P1, 18 );
		}
	}
	else      /* ken1 == 32 */
	{ 	P2 = lfirst( varlist[gfsch].varwert );
		P1 = pgfsres( r, gfchar, P2, Q1, Q2 );
		if( r == 1 ) P1 = list2( P1, 31 );
		else
		{	V = lkill( V, r );
			P1 = list2( V, P1 );
			P1 = list2( P1, 32 );
		}
	}		
	return( P1 );
}
