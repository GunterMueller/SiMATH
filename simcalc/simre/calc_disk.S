/*C
			calc_disk( fkeller )

	"calculator discriminant".
	list calc_disk( fkeller ); list fkeller;
	P =  calc_disk( fkeller );

	fkeller ist eine Liste, bestehend aus einer single- Variablen
	zur Kennzeichnung des Algorithmus', einem Variablennamen, bzgl.
	dessen die Resultante gebildet wird und einem Polynom mit ent-
	sprechender Kennung. Berechnet wird die Diskriminante des Poly-
	noms bzgl. der im Variablennamen angegebenen Variablen mit fol-
	genden Algorithmen :
		1 fuer Hankel-Algorithmus
		2 fuer Sylvester- Algorithmus
		3 fuer Collins- mit- Sylvester- Algorithmus
		4 fuer Collins- Algorithmus.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       13.5.88         C.Hollinger/U.Schneiders
	Version 2       17.9.92         U.Schneiders ( mod )
	Version 3       10.05.1993	S.Schmitt/U.Schneiders	
	Version 4 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
H*/

#include<_calc.h>

list calc_disk( fkeller )
list fkeller;

{       obj arg;
	single i, ken, pos, r;
	list pvar, PP, VL, VP;
	pol P;
	bind( fkeller );
	init( arg, pvar, PP, VL, VP, P );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller) != 3 )
	{       mistake1( 34, "disc" );
		return( -BASIS );
	}

	/*** Ueberpruefung, ob korrekte Benutzung der Parameter. ***/

	arg = lfirst( fkeller );
	ken = lsecond( arg );
	arg = lfirst( arg );
	if( ken || arg < 1 || arg > 4 )
	{       mistake( 39 );
		return( -BASIS );
	}
	fkeller = lred( fkeller );
	pvar = lfirst( fkeller );

	/*** pvar muss wie folgt aussehen: ( ( name )( 1 1 ), 2 ) ***/

	ken = lsecond( pvar );
	if( ken != 2 )
	{       mistake( 40 );
		return( -BASIS );
	}
	pvar = lfirst( pvar );
	VP = lfirst( pvar );
	pvar = lsecond( pvar );
	if( llength(VP) != 1 || llength(pvar) != 2 || lfirst(pvar) != 1 || lsecond(pvar) != 1 )
	{       mistake( 40 );
		return( -BASIS );
	}
	fkeller = lred( fkeller );
	P = lfirst( fkeller );
	ken = lsecond( P );
	if( ( ken != 2 && ken != 18 ) || ( ken == 18 && !pzsch ) )
	{       mistake( 41 );
		return( -BASIS );
	}
	P = lfirst( P );
	VL = lfirst( P );
	P = lsecond( P );
	VP = lfirst( VP );
	r = llength( VL );
	PP = _0;
	for( i = r; i ; i-- )   PP = lcomp( i, PP );
	pos = lsrch( VP, VL );
	if( pos )
	{       PP = lkill( PP, pos );
		PP = lsuffix( PP, pos );
	}
	else
	{       P = pvinsert( r, P, 1 );
		VL = lcomp( VP, VL );
		PP = lsuffix( PP, r+1 );
		PP = lred( PP );
		PP = lsuffix( PP, 1 );
		r++;
	}
	P = pvpermut( r, P, PP );
	VL = lpermut( VL, PP );

	/*** Berechnung der Diskriminante gemaess Eingabe. ***/

	if( ken == 2 )
	{	if(arg==1)
		{	PP=plc(r,P);
			if(PP==1)
				P=pidiscrhank(r,P);
			else
				P=pidiscr(r,P,1);
		}
		else
			P = pidiscr( r, P, (arg-1) );
		if(P==ERROR)
		{	mistake(179);
			return(ERROR);
		}
		if( r == 1 )    P = list2( P,0 );
		else
		{       VL = lkill( VL,r );
			P = list2( VL,P );
			P = list2( P,2 );
		}
	}
	else	
	{	PP = lfirst( varlist[modsch].varwert );	
		VP=pdegree(r,P);
		if(!mihom(PP,VP))
			P=pmidiscrhank(r,PP,P);
		else if(arg==1)
		{	VP=plc(r,P);
			if(VP==1)	P=pmidiscrhank(r,PP,P);
			else if(ssch)	P=pmsdiscr(r,PP,P,1);
			else	P=pmidiscr(r,PP,P,1);
		}
		else
		{ 	if( arg == 4 ) arg = 3;
			if( ssch ) P = pmsdiscr( r, PP, P, (arg-1) );
			else       P = pmidiscr( r, PP, P, (arg-1) );
		}
		if( P == ERROR || P==(ERROR-1) )
		{	mistake( 179 );
			return( ERROR );
		}
		if( r == 1 )	P = list2( P, 17 );
		else
		{       VL = lkill( VL,r );
			P = list2( VL,P );
			P = list2( P, 18 );
		}
	}
	return( P );
}
