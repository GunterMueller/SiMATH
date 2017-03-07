/*C
			calc_bitrans( fkeller )

	"calculator birational transformation".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list calc_bitrans( fkeller );  list fkeller;
	L = calc_bitrans( fkeller );

	fkeller ist eine Liste, bestehend aus 5 Objekten r, s, t, u,
	die Zahlen aus Z, Q, Z/pZ oder aus einem Zahlkoerper sein
        muessen und aus einer elliptischen Kurve bzw. einem Punkt auf einer
	elliptischen Kurve. Berechnet wird die elliptische Kurve L, die aus 
	der elliptischen Kurve in fkeller durch Variablentransformation mit 
	r, s, t, u im ueblichen Sinne entsteht, bzw. der entsprechende Punkt.
	Laeuft calc_bitrans fehlerhaft ab, so ist  X  = ERROR.
C*/
/*H
	Version  1      03.12.1990      U.Schneiders
	Version  2      04.08.1992      U.Schneiders ( mod und nf )
	Version  3      06.04.1993	S.Schmitt/U.Schneiders
	Version  4      22.07.1993      U.Schneiders ( gf )
	Version  5      20.12.1994	S.Schmitt
	Version  5.1    10.07.1996	S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

list calc_bitrans( fkeller )
list fkeller;
{
	single k, l;
	int n;
	rat ko[5];
	obj r, s, t, u, M;
	list L;
	init( L, r, s, t, u, M, n ); init( ko[0..4] );
	bind( fkeller );

	/*** Abfangen falscher Eingaben ***/

	if( llength( fkeller ) != 5 )
	{       mistake1( 34,"bitrans" );
		return( ERROR );
	}

	/*** elliptische Kurve ***/

	L = lfifth( fkeller );
	k = lsecond( L );
	L = lfirst( L );
	/****if( k != (-1) && k != (-2) && k != (-5) && k != (-6) && k != (-9) && k != (-10) && k != (-14) )****/
	if(k>=0)
	{       mistake( 70 );
		return( ERROR );
	}

	if( k <= (-5) && k >= (-8) )  M = lfirst( varlist[modsch].varwert );
	else if( k <= (-9) && k >= (-12) ) M = lfirst( varlist[nfsch].varwert );
	else if( k <= (-14) ) M = lfirst( varlist[gfsch].varwert );

	/*** Transformationsparameter ***/

	u = lfirst( fkeller );
	l = lsecond( u );
	if( ( l && l != 1 && l != 17 && l != 24 && l != 31 ) || 
	    ( l == 17 && ( k>(-5) || ( k < (-8) && k > (-14) ) ) ) ||
	    ( l == 24 && ( ( k < (-4) && k > (-9) ) || k < (-12) ) ) || 
	    ( l == 31 && ( k > (-5) || ( k < (-8) && k > (-14) ) ) ) )
	{       mistake( 124 );
		return( ERROR );
	}
	if( l == 24 && k > (-5) )
	{	L = tonftyper( L, k );
		k = k - 8;
		M = lfirst( varlist[nfsch].varwert );
	}
	else if(l==31 && k > (-14) )
	{	L=togftyper(L,k,1);
		if(L==ERROR) return(ERROR);
		k=k-8;
		M=lfirst(varlist[gfsch].varwert);
	}
	
	u = lfirst( u );
	if( !u )
	{       mistake( 124 );
		return( ERROR );
	}
	switch( k )
	{	case (-1):
		case (-2): 
		case (-3):
		case (-4): if( !l ) u = itor( u );
			   break;
		case (-5):
		case (-6): 
		case (-7):
		case (-8): switch( l )
			   {	case 0: if( ssch ) u = mshom( M, u );
					else       u = mihom( M, u );
					if( !u )
					{	mistake( 124 );
						return( ERROR );
					}
				        break;
				case 1: n = lsecond( u );
	                		if ( igcd( n, M ) != 1 )
					{   mistake2( 233, u, M ); 
		        		    return( ERROR );
					}
					u = lfirst( u );
					if( ssch )
					{	n = msinv( M, n );
					        u = mshom( M, u );
						u = msprod( M, u, n );
                        		}         
					else    
					{	n = miinv( M, n );
					        u = mihom( M, u );
						u = miprod( M, u, n );
					}
					if( !u )
					{	mistake( 124 );
						return( ERROR );
					}
					break;
			   }
			   break;
		case (-9):
		case (-10):
		case (-11):
		case (-12):switch( l )
			   {	case 0: u = itonf( u );
				        break;
				case 1: u = rtonf( u );
					break;
			   }
			   break;
		case (-14):
		case (-15):
		case (-16):if( l != 31 )
			   { 	u = list2( u, l );
			   	u = calc_gf( u );
			   	if( u == ERROR ) return( ERROR );
			   	u = lfirst( u );
			   }
			   if( !u )
			   {	mistake( 124 );
				return( ERROR );
			   }
			   break;
	}
				
	fkeller = lred( fkeller );
	t = lfirst( fkeller );
	l = lsecond( t );
	if( ( l && l != 1 && l != 17 && l != 24 && l != 31 ) || 
	    ( l == 17 && ( k>(-5) || ( k < (-8) && k > (-14) ) ) ) ||
	    ( l == 24 && ( ( k < (-4) && k > (-9) ) || k < (-12) ) ) || 
	    ( l == 31 && ( k > (-5) || ( k < (-8) && k > (-14) ) ) ) )
	{       mistake( 124 );
		return( ERROR );
	}
	if( l == 24 && k > (-5) )
	{	L = tonftyper( L, k );
		k = k - 8;
		M = lfirst( varlist[nfsch].varwert );
		u = rtonf( u );
	}
	else if(l==31 && k > (-14) )
	{	L=togftyper(L,k,1);
		if(L==ERROR) return(ERROR);
		k=k-8;
		M=lfirst(varlist[gfsch].varwert);
		u=list2(0,u);
		u=udpm2tosb(u);
	}
	t = lfirst( t );
	switch( k )
	{	case (-1):
		case (-2): 
		case (-3): 
		case (-4): if( !l ) t = itor( t );
			   break;
		case (-5):
		case (-6): 
		case (-7):
		case (-8): switch( l )
			   {	case 0: if( ssch ) t = mshom( M, t );
					else       t = mihom( M, t );
				        break;
				case 1: n = lsecond( t );
	                		if ( igcd( n, M ) != 1 )
					{   mistake2( 233, t, M );
		        		    return( ERROR );
					}
					t = lfirst( t );
					if( ssch )
					{	n = msinv( M, n );
					        t = mshom( M, t );
						t = msprod( M, t, n );
                        		}         
					else    
					{	n = miinv( M, n );
					        t = mihom( M, t );
						t = miprod( M, t, n );
					}
					break;
			   }
			   break;
		case (-9):
		case (-10):
		case (-11):
		case (-12):switch( l )
			   {	case 0: t = itonf( t );
				        break;
				case 1: t = rtonf( t );
					break;
			   }
			   break;
		case (-14):
		case (-15):
		case (-16):if( l != 31 )
			   {	t = list2( t, l );
			   	t = calc_gf( t );
			   	if( t == ERROR ) return( ERROR );
			   	t = lfirst( t );
			   }
			   break;
	}

	fkeller = lred( fkeller );
	s = lfirst( fkeller );
	l = lsecond( s );
	if( ( l && l != 1 && l != 17 && l != 24 && l != 31 ) || 
	    ( l == 17 && ( k>(-5) || ( k < (-8) && k > (-14) ) ) ) ||
	    ( l == 24 && ( ( k < (-4) && k > (-9) ) || k < (-12) ) ) || 
	    ( l == 31 && ( k > (-5) || ( k < (-8) && k > (-14) ) ) ) )
	{       mistake( 124 );
		return( ERROR );
	}
	if( l == 24 && k > (-5) )
	{	L = tonftyper( L, k );
		k = k - 8;
		M = lfirst( varlist[nfsch].varwert );
		u = rtonf( u );
		t = rtonf( t );
	}
	else if(l==31 && k > (-14) )
	{	L=togftyper(L,k,1);
		if(L==ERROR) return(ERROR);
		k=k-8;
		M=lfirst(varlist[gfsch].varwert);
		u=list2(0,u);
		u=udpm2tosb(u);
		if(t)
		{	t=list2(0,t);
			t=udpm2tosb(t);
		}
	}
	s = lfirst( s );
	switch( k )
	{	case (-1):
		case (-2): 
		case (-3):
		case (-4): if( !l ) s = itor( s );
			   break;
		case (-5):
		case (-6): 
		case (-7):
		case (-8): switch( l )
			   {	case 0: if( ssch ) s = mshom( M, s );
					else       s = mihom( M, s );
				        break;
				case 1: n = lsecond( s );
	                		if ( igcd( n, M ) != 1 )
					{   mistake2( 233, s, M );
		        		    return( ERROR );
					}
					s = lfirst( s );
					if( ssch )
					{	n = msinv( M, n );
					        s = mshom( M, s );
						s = msprod( M, s, n );
                        		}         
					else    
					{	n = miinv( M, n );
					        s = mihom( M, s );
						s = miprod( M, s, n );
					}
					break;
			   }
			   break;
		case (-9):
		case (-10):
		case (-11):
		case (-12):switch( l )
			   {	case 0: s = itonf( s );
				        break;
				case 1: s = rtonf( s );
					break;
			   }
			   break;
		case (-14):
		case (-15):
		case (-16):if( l != 31 )
			   {	s = list2( s, l );
			   	s = calc_gf( s );
			   	if( s == ERROR ) return( ERROR );
			   	s = lfirst( s );
			   }
			   break;
	}

	fkeller = lred( fkeller );
	r = lfirst( fkeller );
	l = lsecond( r );
	if( ( l && l != 1 && l != 17 && l != 24 && l != 31 ) || 
	    ( l == 17 && ( k>(-5) || ( k < (-8) && k > (-14) ) ) ) ||
	    ( l == 24 && ( ( k < (-4) && k > (-9) ) || k < (-12) ) ) || 
	    ( l == 31 && ( k > (-5) || ( k < (-8) && k > (-14) ) ) ) )
	{       mistake( 124 );
		return( ERROR );
	}
	if( l == 24 && k > (-5) )
	{	L = tonftyper( L, k );
		k = k - 8;
		M = lfirst( varlist[nfsch].varwert );
		u = rtonf( u );
		t = rtonf( t );
		s = rtonf( s );
	}
	else if(l==31 && k > (-14) )
	{	L=togftyper(L,k,1);
		if(L==ERROR) return(ERROR);
		k=k-8;
		M=lfirst(varlist[gfsch].varwert);
		u=list2(0,u);
		u=udpm2tosb(u);
		if(t)
		{	t=list2(0,t);
			t=udpm2tosb(t);
		}
		if(s)
		{	s=list2(0,s);
			s=udpm2tosb(s);
		}
	}
	r = lfirst( r );
	switch( k )
	{	case (-1):
		case (-2): 
		case (-3):
		case (-4): if( !l ) r = itor( r );
			   break;
		case (-5):
		case (-6): 
		case (-7): 
		case (-8): switch( l )
			   {	case 0: if( ssch ) r = mshom( M, r );
					else       r = mihom( M, r );
				        break;
				case 1: n = lsecond( r );
	                		if ( igcd( n, M ) != 1 )
					{   mistake2( 233, r, M );
		        		    return( ERROR );
					}
					r = lfirst( r );
					if( ssch )
					{	n = msinv( M, n );
					        r = mshom( M, r );
						r = msprod( M, r, n );
                        		}         
					else    
					{	n = miinv( M, n );
					        r = mihom( M, r );
						r = miprod( M, r, n );
					}
					break;
			   }
			   break;
		case (-9):
		case (-10):
		case (-11):
		case (-12):switch( l )
			   {	case 0: r = itonf( r );
				        break;
				case 1: r = rtonf( r );
					break;
			   }
			   break;
		case (-14):
		case (-15):
		case (-16):if( l != 31 )
			   {	r = list2( r, l );
			   	r = calc_gf( r );
			   	if( r == ERROR ) return( ERROR );
			   	r = lfirst( r );
			   }
			   break;
	}

	if((k==(-9) || k==(-10)) && ecqnfsch!=_0)
	{	if(llength(ecqnfsch)==3) L=qnftonf(L,k);
		else
		{	L = lfirst(L);
			L=lfirst(L);	
			if(k==(-9)) L = lred3(L);
		}
	}

	if( k == (-5) || k == (-9) )
	{       ko[0] = 0;
		ko[1] = 0;
		ko[2] = 0;
		ko[3] = lfirst( L );
		ko[4] = lsecond( L );
	}
	else if(k==(-6) || k==(-10) || k==(-14))
	{       ko[0] = lfirst( L );
		ko[1] = lsecond( L );
		ko[2] = lthird( L );
		ko[3] = lfourth( L );
		ko[4] = lfifth( L );
	}

	switch( k )
	{	case (-1):
		case (-2): M=list4(r,s,t,u);
			   L = ecracbtco(L , M );
			   break;
		case (-3):
		case (-4): if(lthird(L))
			   {	M=list4(r,s,t,u);
				L=ecrbtp(L,M);
			   }	
			   break;
		case (-5):
		case (-6): L = ecmpbtco( M, ko[0], ko[1], ko[2], ko[3], ko[4], r, s, t, u );
			   break;
		case (-7): 
		case (-8): if((k==(-7) && L) || (k==(-8) && lthird(L)))
			   {	ko[0]=lfirst(L);
				ko[1]=lsecond(L);
				if(ssch)
				{   ko[4]=msinv(M,u);
				    ko[3]=msprod(M,ko[4],ko[4]);

				    ko[0]=msdif(M,ko[0],r);
				    ko[0]=msprod(M,ko[0],ko[3]);

				    ko[3]=msprod(M,ko[3],ko[4]);
				    ko[2]=msprod(M,u,u);
				    ko[2]=msprod(M,ko[2],s);
				    ko[2]=msprod(M,ko[2],ko[0]);

				    ko[1]=msdif(M,ko[1],t);
				    ko[1]=msdif(M,ko[1],ko[2]);
				    ko[1]=msprod(M,ko[1],ko[3]);
				}
				else
				{   ko[4]=miinv(M,u);
				    ko[3]=miprod(M,ko[4],ko[4]);

				    ko[0]=midif(M,ko[0],r);
				    ko[0]=miprod(M,ko[0],ko[3]);

				    ko[3]=miprod(M,ko[3],ko[4]);
				    ko[2]=miprod(M,u,u);
				    ko[2]=miprod(M,ko[2],s);
				    ko[2]=miprod(M,ko[2],ko[0]);

				    ko[1]=midif(M,ko[1],t);
				    ko[1]=midif(M,ko[1],ko[2]);
				    ko[1]=miprod(M,ko[1],ko[3]);
				}
				if(k==(-7)) L=list2(ko[0],ko[1]);
				else L=list3(ko[0],ko[1],1);
			   }
			   break;
		case (-9):
		case (-10):L = ecnfbtco( M, ko[0], ko[1], ko[2], ko[3], ko[4], r, s, t, u );
			   break;
		case (-11):
		case (-12):if((k==(-11) && L) || (k==(-12) && lthird(L)))
			   {	ko[0]=lfirst(L);
				ko[1]=lsecond(L);

				ko[3]=nfprod(M,u,u);

				ko[0]=nfdif(M,ko[0],r);
				ko[0]=nfquot(M,ko[0],ko[3]);

				ko[2]=nfprod(M,ko[3],s);
				ko[2]=nfprod(M,ko[2],ko[0]);
				ko[3]=nfprod(M,ko[3],u);

				ko[1]=nfdif(M,ko[1],t);
				ko[1]=nfdif(M,ko[1],ko[2]);
				ko[1]=nfquot(M,ko[1],ko[3]);
				
				if(k==(-11)) L=list2(ko[0],ko[1]);
				else L=list3(ko[0],ko[1],itonf(1));
			   }
			   break;
		case (-14):L = ecgf2btco( M, ko[0], ko[1], ko[2], ko[3], ko[4], r, s, t, u );
			   break;
		case (-15):
		case (-16):if((k==(-15) && L) || (k==(-16) && lthird(L)))
			   {	ko[0]=lfirst(L);
				ko[1]=lsecond(L);

				ko[3]=gf2prod(M,u,u);

				ko[0]=gf2dif(M,ko[0],r);
				ko[0]=gf2quot(M,ko[0],ko[3]);

				ko[2]=gf2prod(M,ko[3],s);
				ko[2]=gf2prod(M,ko[2],ko[0]);
				ko[3]=gf2prod(M,ko[3],u);

				ko[1]=gf2dif(M,ko[1],t);
				ko[1]=gf2dif(M,ko[1],ko[2]);
				ko[1]=gf2quot(M,ko[1],ko[3]);

				if(k==(-15)) L=list2(ko[0],ko[1]);
				else 
				{	ko[3]=list2(0,1);
					ko[3]=udpm2tosb(ko[3]);
					L=list3(ko[0],ko[1],ko[3]);
				}
			   }
			   break;
	}
	if((k==(-9) || k==(-10)) && ecqnfsch!=_0)
	{	M=lfirst(ecqnfsch);
		ko[0] = lfirst(L);
		ko[1] = lsecond(L);
		ko[2] = lthird(L);
		ko[3] = lfourth(L);
		ko[4] = lfifth(L);
		if(llength(ecqnfsch)==3)
		{	ko[0]=nftoqnf(ko[0],24);
			ko[1]=nftoqnf(ko[1],24);
			ko[2]=nftoqnf(ko[2],24);
			ko[3]=nftoqnf(ko[3],24);
			ko[4]=nftoqnf(ko[4],24);
		}
		L=ecqnfinit(M,ko[0],ko[1],ko[2],ko[3],ko[4]);
	}
	switch( k )
	{	case (-1):
		case (-2): L = list2( L, (-2) );
			   break;
		case (-5):
		case (-6): L = list2( L, (-6) );
			   break;
		case (-9):
		case (-10):L = list2( L, (-10) );
			   break;
		case (-14):L = list2( L, (-14) );
			   break;
		default : L=list2(L,k);
	}
	return( L );
}
