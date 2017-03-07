/*C
			calc_egcd( fkeller )

	"calculator extended greatest common divisor".
	list calc_egcd(fkeller); list fkeller;
	X = calc_egcd( fkeller );

	fkeller ist eine Liste bestehend aus mindestens zwei Objekten
	mit zugehoerigen Kennungen.
	Berechnet wird der groesste gemeinsame Teiler der in fkeller
	stehenden Objekte, sowie die Kofaktoren, d.h. fuer
	fkeller=((a1,t1),...,(ak,tk)) mit ggT(a1,...,ak)=g die Objekte
	x1,...,xk mit   
		g = x1*a1 + ... + xk*ak. 
	Dabei muss jedes Objekt eine ganze Zahl oder ein Polynom ueber 
	Z, Z/pZ oder einem Zahlkoerper oder ein 
	Polynom in einer Variablen ueber einem endlichen Koerper oder
	einem Zahlkoerper sein. 
	Das Ergebnis wird mit zugehoeriger Kennung an das aufrufende 
	Programm uebergeben.
	Laeuft calc_egcd fehlerhaft ab, so ist X = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1	15.07.1994	S.Schmitt 
	Version  1.1	27.07.1995	U.Schneiders (upnfegcd) 
H*/


#include <_calc.h>

obj calc_egcd( fkeller )
list fkeller;

{       /*** Deklarationen und Vorbesetzungen ***/

	list L, L1, V, KO, K;
	obj A, M, Q1, Q2, T, X1, X2;
	single ken1, ken2, r, t1,t2;
	init( L, L1, V, KO, K, A, M, Q1, Q2, T, X1, X2 );
	bind( fkeller );

	/*** Sukzessives Abarbeiten des Kellerinhaltes ***/

	L = fkeller; r = 0; K=_0;
	while( L != _0 )
	{	A = lfirst( L );
		L = lred( L );
		ken1 = lsecond( A );
		if(ken1 && ken1!=1 && ken1!=2 && ken1!=3 && ken1!=17 && ken1!=18 
                && ken1!=24 && ken1!=25 && ken1!=31 && ken1!=32)
		{	mistake(335);
			return(ERROR);
		}
		if( ( (ken1==24 || ken1==25) && (r==17 || r==18 || r==31 || r==32) )
		|| ( (r==24 || r==25) && (ken1==17 || ken1==18 || ken1==31 || ken1==32) ) )
		{	mistake(71);
			return(ERROR);
		}
		if(ken1>r || (r==2 && ken1==1) || (r==31 && ken1==18) ||
                  (ken1==2 && ( r==17 || r==24 || r==31)) ||
		  (ken1==3 && ( r==17 || r==24 || r==31)) )	
		{	t1=0;
			if(r==31 && ken1==18) 
			{	r=32;
				t1=1;
			}
			else if(ken1==31 && r==18)
			{	r=32;
				t1=1;
			}
			else if(ken1==2 && (r==1 || r==17 || r==24 || r==31))
			{	r++;
				if(r==2) r++;
				t1=1;
			}
			else if(r==2 && (ken1==1 || ken1==17 || ken1==24|| ken1==31))
			{	r=ken1+1;
				if(r==2) r++;
				t1=1;
			}
			else if(ken1==3 && (r==17 || r==24 || r==31))
			{	r++;
				t1=1;
			}
			else if(r==3 && ( ken1==17 || ken1==24|| ken1==31))
			{	r=ken1+1;
				t1=1;
			}
			else r=ken1;
			if(K!=_0)
			{  L1=K;
			   K=_0;
			   A=lfirst(A);
			   while(L1!=_0)
			   {  Q1=lfirst(L1);
			      L1=lred(L1);
			      ken2=lsecond(Q1);
			      Q1=lfirst(Q1);
			      ken2=typer(A,Q1,ken1,ken2,&X1,&X2,1);
			      if( ken2==ERROR) return(ERROR);
			      X2=list2(X2,ken2);
			      K=lcomp(X2,K);
			   }
			   K=linv(K);
			   if(t1)
			   {	Q1=lfirst(K);
				ken2=lsecond(Q1);
				Q1=lfirst(Q1);
				ken2=typer(A,Q1,ken1,ken2,&X1,&X2,1);
		       	        if( ken2==ERROR) return(ERROR);
				A=list2(X1,ken2);
			   }
			   else A=list2(A,ken1);
			}
		}
		else if(ken1<r)
		{	A=lfirst(A);
			Q1=lfirst(lfirst(K));
			ken2=typer(A,Q1,ken1,r,&X1,&X2,1);
		        if( ken2==ERROR) return(ERROR);
			A=list2(X1,ken2);
		}
		K=lcomp(A,K);
	}
	if(r==1 || r==2 || r==3 || r==17 || r==31 || r==24)
	{	mistake(181);
		return(ERROR);
	}

	KO=_0;
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
		if( ken1 == 17 || ken1 == 18 || r == 18 ) 
		{	if( !pzsch ) 
			{	mistake( 180 );
				return( ERROR );
			}
			M = lfirst( varlist[modsch].varwert );
		}
		else if( ken1 == 24 || ken1 == 25 || r==25 ) M = lfirst( varlist[nfsch].varwert );
		else if( ken1 == 31 || ken1 == 32 || r==32 ) M = lfirst( varlist[gfsch].varwert );
		if(ken1>0 && ken1<4)
		{	if( ken1>1 ) 
			{	V = lfirst(Q1);
				if( r==18 )  T = pvinsert(0,1,1);
				else if( r==25 )
				{	T = itonf(1);
					T = pvinsert(0,T,1);
				}
				else if( r==32 )
				{	T = list2(0,1);
					T = pvinsert(0,T,1);
				}
				T = list2(V,T);
				t1 = typer(Q1,T,ken1,r,&Q1,&V,1);
				ken1 = typer(Q2,T,ken1,r,&Q2,&V,1);
			}
			else
			{	if(r==18) T = 1;
				else if(r==25) T = itonf(1);
				else if(r==32) T = list2(0,1);
				t1 = typer(Q1,T,ken1,r-1,&Q1,&V,1);
				ken1 = typer(Q2,T,ken1,r-1,&Q2,&V,1);
			}
		}

		switch( ken1 )
		{	case 0:	A = iegcd( Q1, Q2, &X1, &X2 );
				X1=list2(X1,0);
				X2=list2(X2,0);
				if(KO==_0) KO=list2(X1,X2);
				else 
				{   V=_0;
				    while(KO!=_0)
				    {	Q1=lfirst(KO);
					KO=lred(KO);
					t1=lsecond(Q1);
					Q1=lfirst(Q1);
					Q1=calc_prod(Q1,lfirst(X1),t1,0);
					Q1 = kenntest(Q1);
					V=lcomp(Q1,V);
				    }
				    V=lcomp(X2,V);
				    KO=linv(V);
				}
				if(fkeller==_0)
				{   KO=linv(KO);
				    A=list2(A,0);
				    eggtaus(A,KO,K);
				    if(avsch) av_basad(KO);
				    return(A);
				}
				A = list2( A, 0 );
				break;
			case 17:Q1 = pvinsert( 0, Q1, 1 );
				Q2 = pvinsert( 0, Q2, 1 );
				if( ssch ) A = upmsegcd( M, Q1, Q2, &X1, &X2 );
				else A = upmiegcd( M, Q1, Q2, &X1, &X2 );
				if( A == ERROR || A == -BASIS-1 )
				{	mistake( 178 );
					return( ERROR );
				}
				V=list1(list1('x'));
				if(X1==0) X1=list2(0,17);
				else
				{	X1=list2(V,X1);
					X1=kenntest(list2(X1,18));
				}
				if(X2==0) X2=list2(0,17);
				else
				{	X2=list2(V,X2);
					X2=kenntest(list2(X2,18));
				}
				if(KO==_0) KO=list2(X1,X2);
				else
				{   Q2=_0;
				    t1=lsecond(X1);
				    X1=lfirst(X1);
				    while(KO!=_0)
				    {	Q1=lfirst(KO);
					KO=lred(KO);
					t2=lsecond(Q1);
					Q1=lfirst(Q1);
					Q1=calc_prod(Q1,X1,t2,t1);
					Q1 = kenntest(Q1);
					Q2=lcomp(Q1,Q2);
				    }
				    Q2=lcomp(X2,Q2);
				    KO=linv(Q2);
				}	
				A = list2( V, A );
				A = list2( A, 18 );
				A = kenntest( A );
				if(fkeller==_0)
				{	KO=linv(KO);
					eggtaus(A,KO,K);
				        if(avsch) av_basad(KO);
					return(A);
				}
				break;
			case 18:V = lfirst( Q1 );
				Q1 = lsecond( Q1 );
				Q2 = lsecond( Q2 );
				t1 = llength( V );
				if(t1!=1)
				{	mistake(335);
					return(ERROR);
				}
				if( ssch ) A = upmsegcd( M, Q1, Q2, &X1, &X2 );
				else A = upmiegcd( M, Q1, Q2, &X1, &X2 );
				if( A == ERROR || A == -BASIS-1 )
				{	mistake( 178 );
					return( ERROR );
				}
				if(X1==0) X1=list2(0,17);
				else
				{   X1=list2(V,X1);
				    X1=kenntest(list2(X1,18));
				}
				if(X2==0) X2=list2(0,17);
				else
				{   X2=list2(V,X2);
				    X2=kenntest(list2(X2,18));
				}
				if(KO==_0) KO=list2(X1,X2);
				else
				{   Q2=_0;
				    t1=lsecond(X1);
				    X1=lfirst(X1);
				    while(KO!=_0)
				    {	Q1=lfirst(KO);
					KO=lred(KO);
					t2=lsecond(Q1);
					Q1=lfirst(Q1);
					Q1=calc_prod(Q1,X1,t2,t1);
					Q1 = kenntest(Q1);
					Q2=lcomp(Q1,Q2);
				    }
				    Q2=lcomp(X2,Q2);
				    KO=linv(Q2);
				}	
				A = list2( V, A );
				A = list2( A, 18 );
				A = kenntest( A );
				if(fkeller==_0)
				{	KO=linv(KO);
					eggtaus(A,KO,K);
				        if(avsch) av_basad(KO);
					return(A);
				}
				break;
			case 24:Q1 = pvinsert( 0, Q1, 1 );
				Q2 = pvinsert( 0, Q2, 1 );
				A=upnfegcd(M,Q1,Q2,&X1,&X2);
				if( A == ERROR )
				{	mistake( 178 );
					return( ERROR );
				}
				V = list1( list1( 'x' ) );
				if(X1==0) X1=list2(0,0);
				else
				{	X1=list2(V,X1);
					X1=kenntest(list2(X1,25));
				}
				if(X2==0) X2=list2(0,0);
				else
				{	X2=list2(V,X2);
					X2=kenntest(list2(X2,25));
				}
				if(KO==_0) KO=list2(X1,X2);
				else 
				{   Q2=_0;
				    t1=lsecond(X1);
				    X1=lfirst(X1);
				    while(KO!=_0)
				    {	Q1=lfirst(KO);
					KO=lred(KO);
					t2=lsecond(Q1);
					Q1=lfirst(Q1);
					Q1=calc_prod(Q1,X1,t2,t1);
					Q1 = kenntest(Q1);
					Q2=lcomp(Q1,Q2);
				    }
				    Q2=lcomp(X2,Q2);
				    KO=linv(Q2);
				}
				A = list2( V, A );
				A = list2( A, 25 );
				A = kenntest( A );
				if(fkeller==_0)
				{	KO=linv(KO);
					eggtaus(A,KO,K);
				        if(avsch) av_basad(KO);
					return(A);
				}
				break;
			case 25:V = lfirst( Q1 );
				t1 = llength( V );
				if( t1 > 1 )
				{	mistake( 335 );
					return( ERROR );
				}
				Q1 = lsecond( Q1 );
				Q2 = lsecond( Q2 );
				A=upnfegcd(M,Q1,Q2,&X1,&X2);
				if( A == ERROR )
				{	mistake( 178 );
					return ( ERROR );
				}
				if(X1==0) X1=list2(0,0);
				else
				{	X1=list2(V,X1);
					X1=kenntest(list2(X1,25));
				}
				if(X2==0) X2=list2(0,0);
				else
				{	X2=list2(V,X2);
					X2=kenntest(list2(X2,25));
				}
				if(KO==_0) KO=list2(X1,X2);
				else
				{   Q2=_0;
				    t1=lsecond(X1);
				    X1=lfirst(X1);
				    while(KO!=_0)
				    {	Q1=lfirst(KO);
					KO=lred(KO);
					t2=lsecond(Q1);
					Q1=lfirst(Q1);
					Q1=calc_prod(Q1,X1,t2,t1);
					Q1 = kenntest(Q1);
					Q2=lcomp(Q1,Q2);
				    }
				    Q2=lcomp(X2,Q2);
				    KO=linv(Q2);
				}
				A = list2( V, A );
				A = list2( A, 25 );
				A = kenntest( A );
				if(fkeller==_0)
				{	KO=linv(KO);
					eggtaus(A,KO,K);
				        if(avsch) av_basad(KO);
					return(A);
				}	
				break;
			case 31:Q1 = pvinsert( 0, Q1, 1 );
				Q2 = pvinsert( 0, Q2, 1 );
				if( gfchar == 2 ) A=upgf2egcd(M,Q1,Q2,&X1,&X2);
				else A=upgfsegcd(gfchar,M,Q1,Q2,&X1,&X2);
				if( A == ERROR )
				{	mistake( 178 );
					return( ERROR );
				}
				V = list1( list1( 'x' ) );
				if(X1==0) X1=list2(0,31);
				else
				{	X1=list2(V,X1);
					X1=kenntest(list2(X1,32));
				}
				if(X2==0) X2=list2(0,31);
				else
				{	X2=list2(V,X2);
					X2=kenntest(list2(X2,32));
				}
				if(KO==_0) KO=list2(X1,X2);
				else 
				{   Q2=_0;
				    t1=lsecond(X1);
				    X1=lfirst(X1);
				    while(KO!=_0)
				    {	Q1=lfirst(KO);
					KO=lred(KO);
					t2=lsecond(Q1);
					Q1=lfirst(Q1);
					Q1=calc_prod(Q1,X1,t2,t1);
					Q1 = kenntest(Q1);
					Q2=lcomp(Q1,Q2);
				    }
				    Q2=lcomp(X2,Q2);
				    KO=linv(Q2);
				}
				A = list2( V, A );
				A = list2( A, 32 );
				A = kenntest( A );
				if(fkeller==_0)
				{	KO=linv(KO);
					eggtaus(A,KO,K);
				        if(avsch) av_basad(KO);
					return(A);
				}
				break;
			case 32:V = lfirst( Q1 );
				t1 = llength( V );
				if( t1 > 1 )
				{	mistake( 335 );
					return( ERROR );
				}
				Q1 = lsecond( Q1 );
				Q2 = lsecond( Q2 );
				if( gfchar == 2 ) A=upgf2egcd(M,Q1,Q2,&X1,&X2);
				else  A=upgfsegcd(gfchar,M,Q1,Q2,&X1,&X2);
				if( A == ERROR )
				{	mistake( 178 );
					return ( ERROR );
				}
				if(X1==0) X1=list2(0,31);
				else
				{	X1=list2(V,X1);
					X1=kenntest(list2(X1,32));
				}
				if(X2==0) X2=list2(0,31);
				else
				{	X2=list2(V,X2);
					X2=kenntest(list2(X2,32));
				}
				if(KO==_0) KO=list2(X1,X2);
				else
				{   Q2=_0;
				    t1=lsecond(X1);
				    X1=lfirst(X1);
				    while(KO!=_0)
				    {	Q1=lfirst(KO);
					KO=lred(KO);
					t2=lsecond(Q1);
					Q1=lfirst(Q1);
					Q1=calc_prod(Q1,X1,t2,t1);
					Q1 = kenntest(Q1);
					Q2=lcomp(Q1,Q2);
				    }
				    Q2=lcomp(X2,Q2);
				    KO=linv(Q2);
				}
				A = list2( V, A );
				A = list2( A, 32 );
				A = kenntest( A );
				if(fkeller==_0)
				{	KO=linv(KO);
					eggtaus(A,KO,K);
				        if(avsch) av_basad(KO);
					return(A);
				}	
				break;
		}
		fkeller = lcomp( A, fkeller );
	}
}

