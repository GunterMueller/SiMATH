/*C
			calc_quot( a1, a2, t1, t2 )

	"calculator quotient".
	list calc_quot(a1,a2,t1,t2); obj a1, a2; single t1, t2;
	erg = calc_quot( a1, a2, t1, t2 );

	t1 bzw. t2 ist die Kennung des Objekts a1 bzw. a2.
	Falls a1 und a2 ganze Zahlen, Polynome ueber Z, Q, Z/mZ, ueber 
	Zahlkoerpern oder endlichen Koerpern sind, so wird der 
	ganzzahlige Anteil von a2 durch a1 berechnet.
	Der Dividend a1 muss ungleich 0 sein.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_quot fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       11.05.1987      H.Stroeher/M.Mang
	Version 2       11.09.1992      U.Schneiders ( mod und nf )
	Version 2.1     11.12.1992      U.Schneiders ( Umsort. der Var.
					liste, Pol. ueber Z und Q )
	Version 3	15.07.1993	S.Schmitt ( gf )
	Version 4 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
H*/
/*cS
	calc_quot ruft auf: lcomp, lkill, llength, lpermut, lsrch, 
			    lsuffix, mistake, pgf2qrem, pvpermut, typer
		    Macros: iquot, lfirst, list2, lred, lsecond, pgfsquot,
			    piquot, pmiquot, pmsquot, pnfquot, prquot
Sc*/
 
#include <_calc.h>

list calc_quot( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj erg, b1, b2, M, hilf;
	list VL, V1, PP;
	single r, r1, i, pos, t3;
	init( erg , b1, b2, M, hilf, VL, V1, PP );
	bind( a1, a2 );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );
	if ( a1 == 0 )
	{       mistake( 10 );
		return( -BASIS );
	}
	if( t1 == 17 || t1 == 18 || t2 == 17 || t2 == 18 )
		M = lfirst(varlist[modsch].varwert );
	if( ( t1 == 0 && ( ( t2 == 18 && igcd( a1, M ) != 1 ) || ( t2 == 32 && igcd( a1, gfchar ) != 1 ) ) ) 
	  || ( t1 == 1 && ( ( t2 == 18 && igcd( lfirst(a1), M ) != 1 ) || ( t2 == 32 && igcd( lfirst(a1), gfchar ) != 1 ) ) ) )
	{	mistake(10);
		return(ERROR);
	}

	if( ( ( t1 > 3 && t1 < 17 ) || ( t1 > 18 && t1 < 24 ) || ( t1 > 25 && t1 < 31 ) || t1 > 32 )
         || ( ( t2 > 3 && t2 < 17 ) || ( t2 > 18 && t2 < 24 ) || ( t2 > 25 && t2 < 31 ) || t2 > 32 ) )
	{       mistake( 23 );
		return( -BASIS );
	}
	if( t1 < 0 || t2 < 0 )
	{       mistake( 71 );
		return( ERROR );
	}

	if( t1 == 2 || t1 == 3 || t1 == 18 || t1 == 25 || t1 == 32 ) 
	{	V1 = lfirst( a1 );
		r1 = llength( V1 );
	}
	else
	{	V1 = _0;
		r1 = 0;
	}
	
	t3 = typer( a1, a2, t1, t2, &b1, &b2, 1 );
	if( t3 == -BASIS )      return( -BASIS );
	if( t3 > 0 && t3 != 2 && t3 != 3 && t3 != 18 && t3 != 25 && t3 != 32 )
	{	mistake( 23 );
		return( ERROR );
	}

	if( t3 > 0 )
	{	VL = lfirst( b1 );
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
				b2 = pvpermut( r, b2, PP );
			}
		}
	}

	switch( t3 )
	{       case 0: erg = iquot( b2, b1 );
			break;
		case 2: M = plbc( r, b2 );
			hilf = plbc( r, b1 );
			if( ( !icomp( M, 1 ) || !icomp( M, -1) )
                        && ( !icomp( hilf, 1 ) || !icomp( hilf, -1)))
				erg = piquot( r, b2, b1 );
			else
			{	b2 = pitopr( r, b2 );
				b1 = pitopr( r, b1 );
				erg = prquot( r, b2, b1 );
				t3 = 3;
			}
			erg = list2( VL, erg );
			break;
		case 3: erg = prquot( r, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 18:if( t1!=0  && t1!=1 && t1!=17 && !pzsch )
			{	mistake( 46 );
				return( ERROR );
			}
			else if(!pzsch)
			{	if(t1==1)
				{	b1=lsecond(a1);
					if(igcd(b1,M)!=1)
					{	mistake(168);
						return(ERROR);
					}
					a1=rtomi(a1,M);
				}
				if(igcd(a1,M)!=1)
				{	mistake(168);
					return(ERROR);
				}
				if(ssch) 
				{	b1=mshom(M,a1);
					erg=pmsmsquot(r,M,b2,b1);
				}
				else
				{	b1=mihom(M,a1);
					erg=pmimiquot(r,M,b2,b1);
				}
				erg=list2(VL,erg);
				break;
			}
			if( ssch ) erg = pmsquot( r, M, b2, b1 );
			else       erg = pmiquot( r, M, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 25:M = lfirst( varlist[nfsch].varwert );
			erg = pnfquot( r, M, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 32:M=lfirst( varlist[gfsch].varwert );
			if(gfchar == 2) erg = pgf2qrem(r,M,b2,b1,&hilf);
			else erg = pgfsquot(r,gfchar,M,b2,b1);
			erg=list2(VL,erg);
			break;
		default:break;
	}
	erg = list2( erg, t3 );
	return( erg );
}
