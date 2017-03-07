/*C
			calc_m( fkeller )

	"calculator modular".
	list calc_m(fkeller); list fkeller;
	L = calc_m( fkeller );

	fkeller ist eine Liste bestehend aus einer ganzen oder rationa-
	len Zahl, einem Polynom ueber Z oder Q, einer Matrix bzw. einem
	Vektor ueber vorgenannte Strukturen oder einer elliptischen Kur-
	ve bzw. einem Punkt auf ihr ueber Q.
	Dieses Objekt a wird aufgefasst modulo dem in varlist[modsch]
	ablegten Modul m.
	Steht in fkeller eine elliptische Kurve oder ein Punkt, so
	muss m eine Primzahl sein.
	L = ( a mod m , ken ).
	a aus Z, Q              ken = 17
	      P(Z), P(Q)              18
	      Mat(Z), Mat(Q)          19
	      Mat(P(Z)), Mat(P(Q))    20
	      Vek(Z), Vek(Q)          21
	      Vek(P(Z)), Vek(P(Q))    22
	      EC(Q) snf               -5
	      EC(Q)                   -6
	      P(Q) aff                -7
	      P(Q) proj               -8
	Laeuft calc_m fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      17.03.1992      U.Schneiders
	Version  2      01.04.1993	S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

list calc_m( fkeller )
list fkeller;
{
	single i, j, k, r;
	obj L, M, P, ko[5];
	int N;
	list VL;
	init( L, M, P, N, VL );
	init( ko[0..4] );
	bind( fkeller );

	k = lsecond( fkeller );
	if( k == 4 || k == 9 || ( k > 13 && k < 17 ) || k > 22 || k < (-8) )
	{       mistake( 157 );
		return( ERROR );
	}
	if( !modsch )
	{       mistake( 158 );
		return( ERROR );
	}
	if( !pzsch && k < 0 )
	{	mistake( 46 );
		return( ERROR );
	}

	L = lfirst( fkeller );
	M = lfirst( varlist[modsch].varwert );

	/*** Reduzieren mod M ***/

	switch( k )
	{       case 0: /*** Modularrrechnung fuer ganze Argumente ***/
			if( ssch ) L = mshom( M, L );
			else       L = mihom( M, L );
			L = list2( L, 17 );
			break;
		case 1: /*** Modularrechnung fuer rationale Argumente ***/
			N = lsecond( L );
			if ( igcd( N, M ) != 1 )
			{       mistake2( 233, L, M );
				L = ERROR;
			}
			else
			{       N = mihom( M,N);
				N = miinv( M, N );
				L = lfirst( L );
				if( ssch )
				{       L = mshom( M, L );
					L = msprod( M, L, N );
                                }         
				else    
			        { 	L = mihom( M, L );
					L = miprod( M, L, N );
                                }
				L = list2( L, 17 );
			}
			break;
		case 2: /*** Modularrechnung fuer ganzzahlige Polynome ***/
			VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			if( ssch )  L = pitopms( r, L, M );
			else        L = pitopmi( r, L, M );
			L = list2( VL, L );
			L = list2( L, 18 );
			break;
		case 3: /*** Modularrechnung fuer rationale Polynome ***/
			VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			P = prnumden( r, L, &N );
			if( igcd( M, N ) != 1 )
			{       mistake1( 242, M );
				L = ERROR;
			}
			else
			{       N = mihom(M,N);
				N = miinv( M, N );
				if( ssch )
				{	P = pitopms( r, P, M );
					P = pmsmsprod( r, M, P, N );
                                }
				else      
				{	P = pitopmi( r, P, M );
					P = pmimiprod( r, M, P, N );
                                }
				L = list2( VL, P );
				L = list2( L, 18 );
			}
			break;
		case 5: /*** Modularrrechnung fuer Matrix ueber Z ***/
			if( ssch ) L = maitomams( M, L );
		        else       L = maitomami( M, L );
			if(M==2) L=mamstomam2(L);
			L = list2( L, 19 );
			break;
		case 6: /*** Modularrrechnung fuer Matrix ueber Q ***/
			L = martomami( M, L );
			if( L == ERROR ) mistake1( 243, M );
			else 
			{	if(M==2) L=mamstomam2(L);
			        L = list2( L, 19 );
			}
			break;
		case 7: /*** Modularrechnung fuer Matrizen ueber Pol. ueber Z ***/
			VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			if( ssch ) L = mapitomapms( r, L, M );  
			else       L = mapitomapmi( r, L, M );  
			L = list2( VL, L );
			L = list2( L, 20 );
			break;
		case 8: /*** Modularrechnung fuer Matrizen ueber Pol. ueber Q ***/
			VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			L = maprtomapmi( r, L, M );
			if( L == ERROR ) mistake1( 243, M );
			else
			{       L = list2( VL, L );
				L = list2( L, 20 );
			}
			break;
		case 10:/*** Modularrrechnung fuer Vektoren ueber Z ***/
			if( ssch )  L = vecitovecms( M, L );
			else        L = vecitovecmi( M, L );
			L = list2( L, 21 );
			break;
		case 11: /*** Modularrrechnung fuer Vektoren ueber Q ***/
			L = vecrtovecmi( M, L );
			if( L == ERROR ) mistake1( 244, M );
			else   L = list2( L, 21 );
			break;
		case 12: /*** Modularrechnung fuer Vektoren ueber Pol. ueber Z ***/
			VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			if( ssch )  L = vecpitovpms( r, L, M );
			else        L = vecpitovpmi( r, L, M );
			L = list2( VL, L );
			L = list2( L, 22 );
			break;
		case 13: /*** Modularrechnung fuer Vektoren ueber Pol. ueber Q ***/
			VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			L = vecprtovpmi( r, L, M );
			if( L == ERROR ) mistake1( 244, M);
			else
			{       L = list2( VL, L );
				L = list2( L, 22 );
			}
			break;
		case (-1): /*** Reduktion fuer elliptische Kurve ueber Q in kurzer WNF ***/
		case (-2): /*** Reduktion fuer elliptische Kurve ueber Q ***/
			N=ecracdisc(L);
			N=lfirst(N);
			if(iaval(M,N))
			{	mistake(106);
				return(ERROR);
			}	
			i = 0;
			P=lfirst(L);
			P=lfirst(P);
			while( P != _0 )
			{	ko[i] = lfirst( P );
			        if( ko[i] )
				{       N = lsecond( ko[i] );
					if( igcd( N, M ) != 1 )
					{       mistake2( 233, ko[i], M );
						L = ERROR;
						break;
					}
			 		else
			 		{       N = mihom(M,N);
						N = miinv( M, N );
						ko[i] = lfirst( ko[i] );
						if( ssch )
						{       ko[i] = mshom( M, ko[i] );
							ko[i] = msprod( M, ko[i], N );
                                		}         
						else    
						{       ko[i] = mihom( M, ko[i] );
							ko[i] = miprod( M, ko[i], N );
                                		}         
					}
				}

				P = lred( P );
				i++;
     			}
			if( L != ERROR )
			{       if( k == -1 )  L = list2( ko[3], ko[4] );
				else           L = list5( ko[0], ko[1], ko[2], ko[3], ko[4] );
				L = list2( L, k-4 );
			}
			break;
		case (-3): /*** Reduktion fuer Punkte in aff. Darst. ***/
			ko[2]=lthird(L);
			if(ssch)  ko[2]=mshom(M,ko[2]);
			else  ko[2]=mihom(M,ko[2]);
			if(!ko[2])
			    L=list2(0,-7);
			else
			{	ko[0]=lfirst(L);
				ko[1]=lsecond(L);
				if(ssch)
				{	ko[0]=mshom(M,ko[0]);
					ko[1]=mshom(M,ko[1]);
					ko[3]=msprod(M,ko[2],ko[2]);
					ko[0]=msquot(M,ko[0],ko[3]);
					ko[3]=msprod(M,ko[3],ko[2]);
					ko[1]=msquot(M,ko[1],ko[3]);
				}
				else
				{	ko[0]=mihom(M,ko[0]);
					ko[1]=mihom(M,ko[1]);
					ko[3]=miprod(M,ko[2],ko[2]);
					ko[0]=miquot(M,ko[0],ko[3]);
					ko[3]=miprod(M,ko[3],ko[2]);
					ko[1]=miquot(M,ko[1],ko[3]);
				}
				L=list2(ko[0],ko[1]);
				L=list2(L,-7);
			}
			break;

		case (-4): /*** Reduktion fuer Punkte in proj. Darst. ***/
			ko[2]=lthird(L);
			if(ssch)  ko[2]=mshom(M,ko[2]);
			else  ko[2]=mihom(M,ko[2]);	
			if(!ko[2])
				L=list3(0,1,0);
			else
			{	ko[0]=lfirst(L);
				ko[1]=lsecond(L);
				if(ssch)
				{	ko[0]=mshom(M,ko[0]);
					ko[1]=mshom(M,ko[1]);
					ko[3]=msprod(M,ko[2],ko[2]);
					ko[0]=msquot(M,ko[0],ko[2]);
					ko[1]=msquot(M,ko[1],ko[3]);
				}
				else
				{	ko[0]=mihom(M,ko[0]);
					ko[1]=mihom(M,ko[1]);
					ko[3]=miprod(M,ko[2],ko[2]);
					ko[0]=miquot(M,ko[0],ko[2]);
					ko[1]=miquot(M,ko[1],ko[3]);
				}
				L=list3(ko[0],ko[1],ko[2]);
			}
			L=list2(L,-8);
			break;
		default: L = list2( L, k );
			 break;
	}
	return( L );
}
