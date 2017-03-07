/*C
			calc_mod( a1, a2, t1, t2 )

	"calulator modular homomorphism".
	list calc_mod(a1,a2,t1,t2); obj a1, a2; single t1, t2;
	erg = calc_mod( a1, a2, t1, t2 );

	t1 bzw. t2 ist die Kennung des Objekts a1 bzw. a2.
	Berechnet wird a2 mod a1 im kleinsten positiven Restsystem.
	Ist a1 eine ganze Zahl, so muss sie positiv und a2 eine ra-
	tionale Zahl sein, deren Nenner teilerfremd zu a1 ist, oder
	ein rationales Polynom, dessen Hauptnenner teilerfremd zu a1
	ist. Das gilt fuer Matrix- und Vektorelemente.
	Rein rationale Module sind verboten, da sie keinen grossen
	Sinn ergeben. Ist a1 ein Polynom, so wird a2 % a1 berechnet
	gemaess der Polynomdivision.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_mod fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       11.05.1987      H.Stroeher/M.Mang
	Version 2       20.05.1988      C.Hollinger
	Version 3       07.09.1988      U.Schneiders
	Version 4       30.10.1989      C.Hollinger/U.Schneiders
	Version 4.1     20.01.1992      U.Schneiders
	Version 5       18.09.1992      U.Schneiders ( mod und nf )
	Version 6	26.07.1993	S.Schmitt ( gf )
	Version 7 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
H*/
 
#include <_calc.h>

list calc_mod( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj erg, b1, b2, P;
	single i, pos, r, r1, t;
	int N, R, Z, hn;
	list hilf, VL, V1, PP;
	pol p;
	bind( a1, a2 );
	init( erg, N, R, Z, hn, hilf, VL, p, P, b1, b2, V1, PP );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );

	/*** Abfangen rationaler oder nichtpositiver Module ***/
	/*** und fuer mod, nf und gf alles ausser Pol. darueber ***/

	if ( (t1 >= 4 && t1 != 16 && t1 != 18 && t1 != 25 && t1 != 32 ) || t1 == 1 )
	{       mistake( 245 );
		return( -BASIS );
	}
	if ( !t1 && isign( a1 ) < 1 )
	{       mistake( 245 );
		return( -BASIS );
	}

	/*** Abfangen rationaler Funktionen, Z/mZ, nfel und gfel ***/

	if ( t2 == 4 || t2 == 9 ||
           ( t2 > 13 && t2 != 18 && t2 != 20 && t2 != 22 && t2 != 25 && t2 != 27 && t2 != 29 && t2 != 32 && t2 != 34 && t2 != 36 ) )
	{       mistake( 246 );
		return( -BASIS );
	}
        if ( t2 > 13 && ( !t1 || t1 == 16 ) )
	{	mistake( 182 );
		return( ERROR );
	}
	if( t1 < 0 || t2 < 0 )
	{       mistake( 71 );
		return( ERROR );
	}

	/*** Modularrechnung ***/

	if( !t1 || t1 == 16 )

	{       switch( t2 )
		{       case 0: /*** Modularrrechnung fuer ganze Argumente ***/
				erg = mihom( a1, a2 );
				erg = list2( erg, 0 );
				break;
			case 1: /*** Modularrechnung fuer rationale Argumente ***/
				N = lsecond( a2 );
				if ( igcd( N, a1 ) != 1 )
				{       mistake2( 233, a2, a1 );
					erg = -BASIS;
				}
				else
				{       N = mihom(a1,N);
					N = miinv( a1, N );
					Z = lfirst( a2 );
					R = iprod( N, Z );
					erg = mihom( a1, R );
					erg = list2( erg, 0 );
				}
				break;
			case 2: /*** Modularrechnung fuer ganzzahlige Polynome als Argument ***/
				VL = lfirst( a2 );
				a2 = lsecond( a2 );
				r = llength( VL );
				erg = pitopmi( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg,2 );
				break;
			case 3: /*** Modularrechnung fuer rationale Polynome ***/
				VL = lfirst( a2 );
				a2 = lsecond( a2 );
				r = llength( VL );
				P = prnumden( r, a2, &hn );
				if( igcd( a1,hn ) != 1 )
				{       mistake1( 242, a1 );
					erg = -BASIS;
				}
				else
				{       hn = mihom(a1,hn);
					hn = miinv( a1,hn );
					p = piiprod( r, P, hn );
					erg = pitopmi( r, p, a1 );
					erg = list2( VL,erg );
					erg = list2( erg, 2 );
				}
				break;
			case 5: /*** Modularrrechnung fuer Matrix ueber Z ***/
				erg = maitomami( a1, a2 );
				erg = list2( erg, 5 );
				break;
			case 6: /*** Modularrrechnung fuer Matrix ueber Q ***/
				erg = martomami( a1, a2 );
				if( erg == ERROR )
				{       mistake1( 243, a1 );
					erg = -BASIS;
				}
				else   erg = list2( erg, 5 );
				break;
			case 7: /*** Modularrechnung fuer Matrizen ueber Pol. ueber Z ***/
				VL = lfirst( a2 );
				a2 = lsecond( a2 );
				r = llength( VL );
				erg = mapitomapmi( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg,7 );
				break;
			case 8: /*** Modularrechnung fuer Matrizen ueber Pol. ueber Q ***/
				VL = lfirst( a2 );
				a2 = lsecond( a2 );
				r = llength( VL );
				erg = maprtomapmi( r, a2, a1 );
				if( erg == ERROR )
				{       mistake1( 243, a1 );
					erg = -BASIS;
				}
				else
				{       erg = list2( VL, erg );
					erg = list2( erg, 7 );
				}
				break;
			case 10:/*** Modularrrechnung fuer Vektoren ueber Z ***/
				erg = vecitovecmi( a1, a2 );
				erg = list2( erg, 10 );
				break;
			case 11: /*** Modularrrechnung fuer Vektoren ueber Q ***/
				erg = vecrtovecmi( a1, a2 );
				if( erg == ERROR )
				{       mistake1( 244, a1 );
					erg = -BASIS;
				}
				else   erg = list2( erg, 10 );
				break;
			case 12: /*** Modularrechnung fuer Vektoren ueber Pol. ueber Z ***/
				VL = lfirst( a2 );
				a2 = lsecond( a2 );
				r = llength( VL );
				erg = vecpitovpmi( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg,12 );
				break;
			case 13: /*** Modularrechnung fuer Vektoren ueber Pol. ueber Q ***/
				VL = lfirst( a2 );
				a2 = lsecond( a2 );
				r = llength( VL );
				erg = vecprtovpmi( r, a2, a1 );
				if( erg == ERROR )
				{       mistake1( 244, a1 );
					erg = -BASIS;
				}
				else
				{       erg = list2( VL, erg );
					erg = list2( erg, 12 );
				}
				break;
		}
	}
	else
	{       V1 = lfirst( a1 );
		r1 = llength( V1 );

		if( t2 < 4 || t2 == 18 || t2 == 25 || t2 == 32 ) t = typer( a1, a2, t1, t2, &b1, &b2, 1 );
		else if( t2 < 9 || t2 == 20 || t2 == 27 || t2 == 34 ) t = smtyper( a1, a2, t1, t2, &b1, &b2, 1 );
		else          t = svtyper( a1, a2, t1, t2, &b1, &b2, 1 );

		if( t == -BASIS )       return( -BASIS );

		VL = lfirst( b1 );
		b1 = lsecond( b1 );
		b2 = lsecond( b2 );
		r = llength( VL );
		if( r1 != r )
		{       while( V1 != _0 )
			{       hilf = lfirst( V1 );
				V1 = lred( V1 );
				pos = lsrch( hilf, VL );
				PP = _0;
				for( i = r; i;  i-- )   PP = lcomp( i, PP );
				PP = lkill( PP, pos );
				PP = lsuffix( PP, pos );
				VL = lpermut( VL, PP );
				b1 = pvpermut( r, b1, PP );
				if( t2 < 4 || t2 == 18 || t2 == 25 || t2 == 32 ) b2 = pvpermut( r, b2, PP );
				else if( t2 < 9 || t2 == 20 || t2 == 27 || t2 == 34 )  b2 = mavpermut( r, b2, PP );
				else     b2 = vecvpermut( r, b2, PP );
			}
		}
		if( t > 16 && t < 23 ) 
		{	if( !pzsch )
			{	mistake( 46 );
				return( ERROR );
			}
			N = lfirst( varlist[modsch].varwert );
		}
		else if( t > 23 && t < 30 ) N = lfirst( varlist[nfsch].varwert );
		else if( t > 30 ) N = lfirst( varlist[gfsch].varwert );

		switch( t )
		{       case 2: N = plbc( r, b2 );
				Z = plbc( r, b1 );
				if( ( !icomp( N, 1 ) || !icomp( N, -1) )
                                 && ( !icomp( Z, 1 ) || !icomp( Z, -1)))
				          p = piqrem( r, b2, b1, &P );
				else
				{	b2 = pitopr( r, b2 );
					b1 = pitopr( r, b1 );
					p = prqrem( r, b2, b1, &P );
					t = 3;
				}
				break;
			case 3: p = prqrem( r, b2, b1, &P );
				break;
			case 7: P = mapitompmpi( r, b2, b1 );
				break;
			case 8: P = maprtompmpr( r, b2, b1 );
				break;
			case 12:P = vecpitvpmpi( r, b2, b1 );
				break;
			case 13:P = vecprtvpmpr( r, b2, b1 );
				break;
		        case 18:if( ssch ) P = pmsrem( r, N, b2, b1 );
		                else       P = pmirem( r, N, b2, b1 );
				break;
			case 25:P = pnfrem( r, N, b2, b1 );
				break;
			case 20:if( ssch ) P = mapmstomapmp( r, N, b1, b2 );
			        else       P = mapmitomapmp( r, N, b1, b2 );
				break;
			case 27:P = mapnftomapmp( r, N, b1, b2 );
				break;
			case 22:if( ssch ) P = vecpmstovpmp( r, N, b1, b2 );
			        else       P = vecpmitovpmp( r, N, b1, b2 );
				break;
			case 29:P = vecpnftovpmp( r, N, b1, b2 );
				break;
			case 32:if( gfchar == 2 ) erg = pgf2qrem( r, N, b2, b1, &P );
				else P = pgfsrem( r, gfchar, N, b2, b1 );
				break;
			case 34:if(gfchar==2) P=mpgf2tompmp(r,N,b1,b2);
				else P = mpgfstompmp( r, gfchar, N, b1, b2 );
				break;
			case 36:if(gfchar==2) P=vpgf2tovpmp(r,N,b1,b2);
				else P = vpgfstovpmp( r, gfchar, N, b1, b2 );
				break;
		}
		erg = list2( VL, P );
		erg = list2( erg, t );
	}
	return( erg );
}
