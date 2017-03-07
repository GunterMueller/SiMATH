/*C
			calc_deriv(  fkeller )

	" calculator derivation ".
	list calc_deriv( fkeller );  list fkeller;
	X = calc_deriv( fkeller );

	fkeller enthaelt ein Polynom P und Variablen, nach denen ab-
	geleitet werden soll. Dabei duerfen diese Variablen nicht vor-
	besetzt sein. calc_deriv berechnet die Ableitung von P nach
	den angegebenen Variablen.
	Laeuft calc_deriv fehlerhaft ab, so ist  X  = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      07.07.1988      C.Hollinger/U.Schneiders
	Version  2      11.09.1992      U.Schneiders ( mod und nf )
	Version  3	15.07.1993	S.Schmitt ( gf )
	Version  3.1	25.01.1995	S.Schmitt ( R und C )
H*/

#include<_calc.h>
list calc_deriv( fkeller )
list fkeller;

{
	single ken, varken, sch, ksch, r, pos;
	list VL, varl, varl1;
	obj var, P, Z, N, Zd, Nd, S1, S2;
	init( VL, varl, varl1, var, P, Z, N, Zd, Nd, S1, S2 );
	bind( fkeller );

	sch = 1;
	ksch = 0;

	/*** Abfangen ungueltiger Eingaben. ***/

	if( llength( fkeller ) < 2 )
	{       mistake1( 34,"deriv" );
		return( -BASIS );
	}

	/*** Berechnung der Ableitung. ***/

	fkeller = linv( fkeller );
	P = lfirst( fkeller );
	fkeller = lred( fkeller );
	ken = lsecond( P );
	if( ( ken>4 && ken!=15 && ken!=17 && ken!=18 && ken!=24 && ken!=25 
		    && ken!=31 && ken!=32 && ken!=37 && ken!=38 && ken!=39 ) 
	   || ken < 0 )
	{       mistake( 83 );
		return( -BASIS );
	}
	if( ken<2 || ken==15 || ken==17 || ken==24 || ken==31 || ken==37 ) 
		sch = 0;
	if( sch )
	{       P = lfirst( P );
		VL = lfirst( P );
		r = llength( VL );
		P = lsecond( P );
	}
	if( ken == 18 ) N = lfirst( varlist[modsch].varwert );
	else if( ken == 25 ) N = lfirst( varlist[nfsch].varwert );
	else if( ken == 32 ) N = lfirst( varlist[gfsch].varwert );
	while( fkeller != _0 )
	{       var = lfirst( fkeller );
		fkeller = lred( fkeller );
		varken = lsecond( var );
		if( varken != 2 )
		{       mistake( 51 );
			return( -BASIS );
		}
		var = lfirst( var );
		varl = lfirst( var );
		var = lsecond( var );
		if( llength( var ) != 2 || lfirst( var ) != 1
		    || lsecond( var ) != 1 || llength( varl ) != 1 )
		{       mistake( 51 );
			return( -BASIS );
		}
		if( sch && !ksch )
		{       varl1 = lfirst( varl );
			pos = lsrch( varl1, VL );
			if( !pos ) ksch = 1;
		}
		if( !ksch )
		{       switch( ken )
			{       case 0:
				case 1:
				case 15:
				case 17:
				case 24:
				case 31:
				case 37:P = 0;
					break;
				case 2: P = piderivsv( r, P, pos );
					break;
				case 3: P = prderivsv( r, P, pos );
					break;
				case 4: Z = lfirst( P );
					N = lsecond( P );
					Zd = piderivsv( r, Z, pos );
					Nd = piderivsv( r, N, pos );
					S1 = piprod( r, Zd, N );
					S2 = piprod( r, Z, Nd );
					Z = pidif( r, S1, S2 );
					N = piprod( r, N, N );
					P = list2( Z, N );
					break;
				case 18:if( ssch ) P = pmsderivsv( r, N, P, pos );
					else P = pmiderivsv( r, N, P, pos ); 
					break;
				case 25:P = pnfderivsv( r, N, P, pos );
                                        break;
				case 32:if( gfchar == 2 ) P = pgf2derivsv( r, N, P, pos );
					else P=pgfsderivsv(r,gfchar,N,P,pos);
					break;
				case 38:P = pflderivsv( r, P, pos );
					break;
				case 39:P=pcderivsv(r,P,pos);
					break;
			}
		}
	}
	if( !sch || ksch )
	{	if( ken < 5 )  P = list2( 0, 0 );
		else if( ken==15 || ken > 36 ) P=list2(0,15);
		else if( ken < 19 )  P = list2( 0, 17 );
		else if( ken < 26 )  P = list2( 0, 24 );
		else  P = list2( 0, 31 );
	}
	else
	{       P = list2( VL, P );
		P = list2( P, ken );
	}
	return( P );
}
