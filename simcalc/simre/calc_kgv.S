/*C
			calc_kgv( fkeller )

	"calculator kleinstes gemeinsames Vielfaches".
	list calc_kgv(fkeller); list fkeller;
	X = calc_kgv( fkeller );
	fkeller ist eine Liste bestehend aus mindestens zwei Objekten
	mit zugehoerigen Kennungen.
	Berechnet wird das kleinste gemeinsame Vielfache der in fkeller
	stehenden Objekte. Dabei muss jedes Objekt eine ganze Zahl oder
	ein Polynom ueber Z, Z/pZ oder einem Zahlkoerper oder ein Polynom 
	in einer Variablen ueber einem endlichen Koerper  sein. Das 
	Ergebnis wird mit zugehoeriger Kennung an das aufrufende 
	Programm uebergeben.
	Laeuft calc_kgv fehlerhaft ab, so ist X = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.06.1987      H.Stroeher/M.Mang
	Version  2      29.03.1988      U.Schneiders
	Version  3	06.05.1993	S.Schmitt/U.Schneiders
	Version  4	26.07.1993	S.Schmitt ( gf )
	Version  5	28.07.1995	U.Schneiders ( multivar. gf+nf )
H*/
 
#include <_calc.h>

obj calc_kgv( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	list A, L, L1, V;
	obj  D, M, Q1, Q2;
	single gken, d, ken1, ken2, r;
	init( A, L, L1, V, D, M, Q1, Q2 );
	bind( fkeller );

	/*** Sukzessives Abarbeiten des Kellerinhaltes ***/
	
	L = fkeller; gken = 0;
	while( L != _0 )
	{	A = lfirst( L );
		L = lred( L );
		ken1 = lsecond( A );
		if(ken1 && ken1!=1 && ken1!=2 && ken1!=3 && ken1!=17 && ken1!=18 
                && ken1!=24 && ken1!=25 && ken1!=31 && ken1!=32)
		{	mistake(15);
			return(ERROR);
		}
		if( ( (ken1==24 || ken1==25) && (gken==17 || gken==18 || gken==31 || gken==32) )
		|| ( gken==24 || gken==25) && (ken1==17 || ken1==18 || ken1==31 || ken1==32) )
		{	mistake(71);
			return(ERROR);
		}
		if( (gken==1 && ken1==2) || (gken==2 && ken1==1) ) gken=3;
		else if( (gken==2 || gken==3) && (ken1==17 || ken1==24 || ken1==31) ) gken = ken1+1;
		else if( (ken1==2 || ken1==3) && (gken==17 || gken==24 || gken==31) ) gken = gken+1;
		else if( (gken==18 && ken1==31) || (gken==31 || ken1==18) ) gken=32;
		else gken = smax( gken, ken1 );
	}
	if(gken==1 || gken==3 || gken==17 || gken==31 || gken==24)
	{	mistake( 181 );
		return( ERROR );
	}		
	
	while ( fkeller != _0 ) {
		L = lfirst( fkeller );
		fkeller = lred( fkeller );
		L1 = lfirst( fkeller );
		fkeller = lred( fkeller );
		if ( L == -BASIS || L1 == -BASIS ) return( -BASIS );
		ken1 = lsecond( L );
		ken2 = lsecond( L1 );
		L = lfirst( L );
		L1 = lfirst( L1 );
		ken1 = typer( L, L1, ken1, ken2, &Q1, &Q2, 1 );
		if( ken1 == ERROR ) return( ERROR );
		if( ken1 == 17 || ken1 == 18 || gken==18 ) 
		{	if( !pzsch ) 
			{	mistake( 180 );
				return( ERROR );
			}
			M = lfirst( varlist[modsch].varwert );
		}
		else if( ken1 == 24 || ken1 == 25 || gken==25 ) M = lfirst( varlist[nfsch].varwert );
		else if( ken1 == 31 || ken1 == 32 || gken==32 ) M = lfirst( varlist[gfsch].varwert );
		if( ken1==3 ) 
		{	V = lfirst(Q1);
			if( gken==18 )  D = pvinsert(0,1,1);
			else if( gken==25 )
			{	D = itonf(1);
				D = pvinsert(0,D,1);
			}
			else if( gken==32 )
			{	D = list2(0,1);
				D = pvinsert(0,D,1);
			}
			D = list2(V,D);
			ken2 = typer(Q1,D,ken1,gken,&Q1,&V,1);
			if(ken2==ERROR) return(ERROR);
			ken1 = typer(Q2,D,ken1,gken,&Q2,&V,1);
			if(ken1==ERROR) return(ERROR);
		}
		else if( ken1==1 )
		{	if(gken==18) D = 1;
			else if(gken==25) D = itonf(1);
			else if(gken==32) D = list2(0,1);
			ken2 = typer(Q1,D,ken1,gken-1,&Q1,&V,1);
			if(ken2==ERROR) return(ERROR);
			ken1 = typer(Q2,D,ken1,gken-1,&Q2,&V,1);
			if(ken1==ERROR) return(ERROR);
		}

		switch( ken1 )
		{	case 0:	A = ilcm( Q1, Q2 );
				A = list2( A, 0 );
				break;
			case 2: V = lfirst( Q1 );
				Q1 = lsecond( Q1 );
				Q2 = lsecond( Q2 );
				r = llength( V );
				A = pigcdcf( r, Q1, Q2, &L, &L1 );
				A=piprod(r,L,Q2);
				A=list2(V,A);
				A=list2(A,2);
				A=kenntest(A);
				break;
			case 17:Q1 = pvinsert( 0, Q1, 1 );
				Q2 = pvinsert( 0, Q2, 1 );
				if( ssch ) A = pmsgcdcf( 1, M, Q1, Q2, &L, &L1 );
				else A = pmigcdcf( 1, M, Q1, Q2, &L, &L1 );
				if( A == ERROR || A == -BASIS-1 )
				{	mistake( 178 );
					return( ERROR );
				}
				if(ssch)   A=pmsprod(1,M,Q2,L);
				else    A=pmiprod(1,M,Q2,L);
				V = list1(list1('x'));
				A = list2( V, A );
				A = list2( A, 18 );
				A = kenntest( A );
				break;
			case 18:V = lfirst( Q1 );
				Q1 = lsecond( Q1 );
				Q2 = lsecond( Q2 );
				r = llength( V );
				if( ssch ) A = pmsgcdcf( r, M, Q1, Q2, &L, &L1 );
				else A = pmigcdcf( r, M, Q1, Q2, &L, &L1 );
				if( A == ERROR || A == -BASIS-1 )
				{	mistake( 178 );
					return( ERROR );
				}
				if(ssch)    A=pmsprod(r,M,Q2,L);
				else     A=pmiprod(r,M,Q2,L);
				A = list2( V, A );
				A = list2( A, 18 );
				A = kenntest( A );
				break;
			case 24:Q1 = pvinsert( 0, Q1, 1 );
				Q2 = pvinsert( 0, Q2, 1 );
				A = upnfgcdcf( M, Q1, Q2, &L, &L1 );
				A = pnfprod(1, M, L, Q2);
				A = list2( VNF, A );
				A = list2( A, 25 );
				A = kenntest( A );
				break;
			case 25:V = lfirst( Q1 );
				r = llength( V );
				Q1 = lsecond( Q1 );
				Q2 = lsecond( Q2 );
				if( r==1 ) A = upnfgcdcf( M, Q1, Q2, &L, &L1 );
				else
				{     D = ouspidenic(dptop(1,M));
				      A = pnfgcdcf(r,M,D,Q1,Q2,&L,&L1);
				}
				A = pnfprod(r, M, Q2, L );
				A = list2( V, A );
				A = list2( A, 25 );
				A = kenntest( A );
				break;
			case 31:Q1 = pvinsert( 0, Q1, 1 );
				Q2 = pvinsert( 0, Q2, 1 );
				if( gfchar == 2 )
				{	A = upgf2gcd( M, Q1, Q2 );
					if( A == ERROR || A == -BASIS-1 )
					{	mistake( 178 );
						return( ERROR );
					}
					A = pgf2qrem( 1, M, Q1, A, &L );
					if( L )
					{	mistake( 178 );
						return( ERROR );
					}
					A = pgf2prod( 1, M, Q2, A );
				}
				else
				{	A = upgfsgcd( gfchar, M, Q1, Q2 );
					if( A == ERROR || A == -BASIS-1 )
					{	mistake( 178 );
						return( ERROR );
					}
					A = pgfsquot( 1, gfchar, M, Q1, A );
					A = pgfsprod( 1, gfchar, M, Q2, A );
				}
				V = list1( list1( 'x' ) );
				A = list2( V, A );
				A = list2( A, 32 );
				A = kenntest( A );
				break;
			case 32:V = lfirst( Q1 );
				r = llength( V );
				Q1 = lsecond( Q1 );
				Q2 = lsecond( Q2 );
				if( r==1 )
				{ if( gfchar == 2 )
				  {	A = upgf2gcd( M, Q1, Q2 );
					if( A == ERROR || A == -BASIS-1 )
					{	mistake( 178 );
						return( ERROR );
					}
					A = pgf2qrem( 1, M, Q1, A, &L );
					if( L )
					{	mistake( 178 );
						return( ERROR );
					}
					A = pgf2prod( 1, M, Q2, A );
				  }
				  else
				  {	A = upgfsgcd( gfchar, M, Q1, Q2 );
					if( A == ERROR || A == -BASIS-1 )
					{	mistake( 178 );
						return( ERROR );
					}
					A = pgfsquot( 1, gfchar, M, Q1, A );
					A = pgfsprod( 1, gfchar, M, Q2, A );
				  }
				}
				else
				{ if( gfchar!=2 ) 
				  {	A = pgfsgcdcf(r,gfchar,M,Q1,Q2,&L,&L1);
				        if( A == ERROR || A == -BASIS-1 )
				        {	mistake( 178 );
					        return( ERROR );
				        }
					A = pgfsprod(r,gfchar,M,Q2,L);
				  }	
				  else
				  {	Q1 = pgf2topgfs(r,M,Q1);
				  	Q2 = pgf2topgfs(r,M,Q2);
					D = sbtoudpm2(M);
					d = lfirst(D);
					D = dptop(1,D);
					D = gfsalgen(2,d,D);
				        A = pgfsgcdcf(r,gfchar,D,Q1,Q2,&L,&L1);
				        if( A == ERROR || A == -BASIS-1 )
				        {	mistake( 178 );
					        return( ERROR );
				        }
					Q2 = pgfstopgf2(r,M,Q2);
					L = pgfstopgf2(r,M,L);
					A = pgf2prod( r, M, Q2, L );
				  }
				}
				A = list2( V, A );
				A = list2( A, 32 );
				A = kenntest( A );
				break;
		}
		if( fkeller == _0 ) return( A );
		fkeller = lcomp( A, fkeller );
	}
}
