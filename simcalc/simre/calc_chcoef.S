/*C
			calc_chcoef( fkeller )

	"calculator change coefficient".
	list calc_chcoef( fkeller );  list fkeller;
	X = calc_chcoef( fkeller );

	fkeller ist eine Liste, bestehend aus 4 Elementen: einem
	Koeffizienten k, einem Exponenten e, einer Variablen x und
	einem Polynom P.
	calc_chcoef veraendert den Koeffizienten von x^e im Polynom
	P zu k.
	Dabei muss die angegebene Variable eine Polynomvariable von
	P sein. k ist ein beliebiges Polynom.
	Laeuft calc_chcoef fehlerhaft ab, so ist  X = ERROR.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       14.02.1991      U.Schneiders
	Version 2       04.08.1992      U.Schneiders ( mod und nf )
	Version 3	26.07.1993	S.Schmitt ( gf )
	Version 4 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
	Version 4.1	25.01.1995	S.Schmitt ( R und C )
H*/
/*cS
	calc_chcoef ruft auf: calc_prod, calc_sum, issingle, lcomp,
			      lcopy, llength, lpermut, lsrch, mistake,
			      pgfsdif, pidif, pmidif, pmsdif, pnfdif, 
			      prdif, pvpermut
		      Macros: lfirst, lfourth, list1, list2, lred2,
			      lsecond, lthird, pgf2dif
Sc*/

#include<_calc.h>

list calc_chcoef( fkeller )
list fkeller;
{
	obj M, P, exp, koef, var;
	single ken, kken, i, pos, r;
	list VL, PP, varl;
	init( M, P, exp, koef, var, varl, VL, PP );
	bind( fkeller );

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) != 4 )
	{       mistake1( 34,"chcoef" );
		return( ERROR );
	}

	/*** Koeffizient ***/

	koef = lfirst( fkeller );
	kken = lsecond( koef );
	if( ( kken>3 && kken!=15 && kken!=17 && kken!=18 && kken!=24 
		     && kken!=25 && kken!=31 && kken!=32 && kken!=37
		     && kken!=38 && kken!=39 ) || kken < 0 )
	{       mistake1( 34,"chcoef" );
		return( ERROR );
	}
	koef = lfirst( koef );

	/*** Exponent ***/

	exp = lsecond( fkeller );
	ken = lsecond( exp );
	if( ken )
	{       mistake1( 34,"chcoef" );
		return( ERROR );
	}
	exp = lfirst( exp );
	if( !issingle( exp ) )
	{       mistake1( 34,"chcoef" );
		return( ERROR );
	}

	/*** Polynom ***/

	P = lfourth( fkeller );
	ken = lsecond( P );
	if( ken!=2 && ken!=3 && ken!=18 && ken!=25 && ken!=32 && ken!=38 && ken!=39 )
	{       mistake( 202 );
		return( ERROR );
	}

	/*** Polynom <-> Koeffizient ***/

	if( ( ( ken==18 || ken==32 ) 
	        && ( kken==15 || kken==24 || kken==25 || kken>32 ) )
	 || ( ( ken==25 || ken==38 || ken==39 ) 
		&& ( kken==17 || kken==18 || kken==31 || kken==32 ) ) )
	{	mistake( 173 );
		return( ERROR );
	}

	/*** MOD <-> GF ***/

	if( ( ken==18 && ( kken==31 || kken==32 ) )
	 || ( ken==32 && ( kken==17 || kken==18 ) ) )
	{	M=lfirst(varlist[modsch].varwert);
		if(M!=gfchar)
		{	mistake(173);
			return(ERROR);
		}
	}

	/*** R,C <-> Q(i) ***/
	
	if( ( ken==25 && ( kken==15 || kken>36 ) )
	 || ( ( ken==38 || ken==39 ) && ( kken==24 || kken==25 ) ) )
	{	VL = lfirst( varlist[nfsch].varwert );
		PP = list4( 2, 1, 0, 1 );
		if(!oequal(VL,PP))
		{	mistake(173);
			return( ERROR );
		}
	}
	
	/*** MOD,GF <-> Q ***/
	
	if( ( ken==18 || ken==32 ) && ( kken==1 || kken==3 ) )
	{	if( ken==18 ) M=lfirst(varlist[modsch].varwert);
		else M=gfchar;
		if(kken==1)  var=lsecond(koef);
		else  
		{	VL=lfirst(koef);
			r=llength(VL);
			PP=lsecond(koef);
			var=prlcd(r,PP);
		}
		if(igcd(var,M)!=1)
		{	mistake(123);
			return(ERROR);
		}
	}


	P = lfirst( P );
	VL = lfirst( P );
	r = llength( VL );
	P = lsecond( P );

	/*** Q <-> MOD,GF ***/
	
	if( ken==3 && ( kken==17 || kken==18 || kken==31 || kken==32 ) )
	{	if( kken==17 || kken==18 ) M=lfirst(varlist[modsch].varwert);
		else M=gfchar;
		var=prlcd(r,P);
		if(igcd(var,M)!=1)
		{	mistake(123);
			return(ERROR);
		}
	}

	/*** Variable ***/

	var = lthird( fkeller );
	pos = lsecond( var );
	if( pos != 2 )
	{       mistake1( 34,"chcoef" );
		return( ERROR );
	}
	var = lfirst( var );
	varl = lfirst( var );
	var = lsecond( var );
	if( llength( var ) != 2 || lfirst( var ) != 1
	    || lsecond( var ) != 1 || llength( varl ) != 1 )
	{       mistake1( 34,"chcoef" );
		return( ERROR );
	}
	varl = lfirst( varl );
	pos = lsrch( varl, VL );
	if( !pos )
	{       mistake1( 34,"chcoef" );
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

	/*** Vertauschen der Koeffizienten  ***/
	/*** durch Subtraktion und Addition ***/

	var = lcopy( P );
	pos = lfirst( var );
	while( pos > exp )
	{       var = lred2( var );
		if( var == _0 ) break;
		pos = lfirst( var );
	}

	/*** Gegenenfalls subtrahieren ***/

	if( pos == exp )
	{       var = lsecond( var );
		var = list2( exp, var );
		switch( ken )
		{	case 2: P = pidif( r, P, var );
				break;
			case 3: P = prdif( r, P, var );
				break;
			case 18:M = lfirst( varlist[modsch].varwert );
				if( ssch ) P = pmsdif( r, M, P, var );
				else	   P = pmidif( r, M, P, var );
				break;
			case 25:M = lfirst( varlist[nfsch].varwert );
				P = pnfdif( r, M, P, var );
				break;
			case 32:M = lfirst( varlist[gfsch].varwert );
				if( gfchar == 2 ) P = pgf2dif( r, M, P, var );
				else P = pgfsdif( r, gfchar, M, P, var );
				break;
			case 38:P = pfldif( r, P, var );
				break;
			case 39:P = pcdif( r, P, var );
				break;
		}
	}

	/*** koef * x^e ***/

	varl = list1( varl );
	var = list2( exp, 1 );
	var = list2( varl, var );
	koef = calc_prod( koef, var, kken, 2 );
	if( koef == ERROR )  return( ERROR );

	/*** koef + P ***/

	kken = lsecond( koef );
	koef = lfirst( koef );
	P = list2( VL, P );
	P = calc_sum( P, koef, ken, kken );
	if( P == ERROR )  return( ERROR );

	/*** Umsortieren ***/

	ken = lsecond( P );
	P = lfirst( P );
	VL = lfirst( P );
	r = llength( VL );
	varl = lfirst( varl );
	pos = lsrch( varl, VL );
	if( pos != r )
	{       P = lsecond( P );
		PP = list1( pos );
		i = r;
		while( i )
		{       if( i != pos )
				PP = lcomp( i, PP );
			i--;
		}
		VL = lpermut( VL, PP );
		P = pvpermut( r, P, PP );
		P = list2( VL, P );
	}
	P = list2( P, ken );

	return( P );
}
