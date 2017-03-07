/*C
			calc_nf( fkeller )

	"calculator number field".
	list calc_nf(fkeller); list fkeller;
	L = calc_nf( fkeller );

	fkeller ist eine Liste bestehend aus einer ganzen oder rationa-
	len Zahl, einer Zahl aus einem Zahlkoerper K, einem Polynom
        ueber Z, Q oder K, einer Matrix bzw. einem Vektor ueber vorge-
        nannte Strukturen oder einer elliptischen Kurve bzw. einem
        Punkt auf ihr ueber Q oder K.
	Der Zahlkoerper K ist bestimmt durch das in varlist[nfsch]
	stehende Polynom mit entsprechender Variablenliste.
	Dabei ist zu beachten, dass Elemente aus K in der Variablen
	dargestellt werden, die auch fuer das Zahlkoerper erzeugende
        Polynom benutzt wurde.
	L = ( fkeller aufgefasst ueber K, ken ).
	fkeller aus Z, Q, K             	 ken = 24 
	      P(Z), P(Q), P(K)                         25 
	      Mat(Z), Mat(Q), Mat(K)                   26
	      Mat(P(Z)), Mat(P(Q)), Mat(P(K))          27
	      Vek(Z), Vek(Q), Vek( K )                 28
	      Vek(P(Z)), Vek(P(Q)), Vek(P(K))          29
	      EC(Q), EC(K)  snf                       - 9
	      EC(Q), EC(K)                            -10
	      P(Q), P(K)  aff                         -11
	      P(Q), P(K)  proj                        -12
	Laeuft calc_nf fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1       21.04.1992      U.Schneiders
	Version 2	01.04.1993	S.Schmitt/U.Schneiders
	Version 3	03.02.1994	S.Schmitt/U.Schneiders
	Version 4 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
	Version 4.1	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/
 
#include <_calc.h>

list calc_nf( fkeller )
list fkeller;
{
	single i, k, n, r;
	obj L, F, ko, koe[5];
	list PP, VL;
	init( L, F, ko, PP, VL );
	init( koe[0..4]);
	bind( fkeller );

	k = lsecond( fkeller );
	if( k == 4 || k == 9 || ( k > 13 && k < 24 ) || k > 29 || ( k >  (-9) && k < (-4) ) || k < (-12) )
	{       mistake( 162 );
		return( ERROR );
	}
	if( !nfsch )
	{       mistake( 163 );
		return( ERROR );
	}

	L = lfirst( fkeller );
	F = lfirst( varlist[nfsch].varwert );

	/*** Reduzieren mod F ***/

	switch( k )
	{       case 0: L = itonf( L ); 
			L = list2( L, 24 );
			break;
		case 1: L = rtonf( L );
			L = list2( L, 24 );
			break;
		case 2: VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			ko = lfirst( VNF );
			if( r == 1 && oequal( VL, VNF ) )
		        {	L = pitopr( 1, L );
				L = uprtonfel( F, L );
				L = list2( L, 24 );
			}
			else if( ( n = lsrch( ko, VL ) ) )
		        {	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = pvpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				L = pinfevalfvs( r, F, L );
				L = list2( VL, L );
				L = list2( L, 25 );
			}
			else
			{       L = pitopnf( r, L );
				L = list2( VL, L );
				L = list2( L, 25 );
			}
			break;
		case 3: VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			ko = lfirst( VNF );
			if( r == 1 && oequal( VL, VNF ) )
		        {	L = uprtonfel( F, L );
				L = list2( L, 24 );
			}
			else if( ( n = lsrch( ko, VL ) ) )
			{       if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = pvpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				L = prnfevalfvs( r, F, L );
				L = list2( VL, L );
				L = list2( L, 25 );
			}
			else
			{       L = prtopnf( r, L );
				L = list2( VL, L );
				L = list2( L, 25 );
			}
			break;
/**		case 5: L = maitomanf( L );
			L = list2( L, 26 );
			break;
		case 6: L =  martomanf( L );
			L = list2( L, 26 );
			break;**/
		case 7: VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			ko = lfirst( VNF );
			if( ( n = lsrch( ko, VL ) ) )
			{	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = mavpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				L = mapinfevlfvs( r, F, L );
				if( r != 1 )
				{	L = list2( VL, L );
					L = list2( L, 27 );
				}
				else	L = list2( L, 26 );
			}
			else
			{/*	L = mapitomapnf( r, L );*/
				L = list2( VL, L );
				L = list2( L, 7 );
			}
			break;
		case 8: VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			ko = lfirst( VNF );
			if( ( n = lsrch( ko, VL ) ) )
			{	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = mavpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				L = maprnfevlfvs( r, F, L );
				if( r != 1 )
				{	L = list2( VL, L );
					L = list2( L, 27 );
				}
				else	L = list2( L, 26 );
			}
			else
			{/*	L = maprtomapnf( r, L );*/
				L = list2( VL, L );
				L = list2( L, 8 );
			}
			break;
		/**case 10:L = vecitovecnf( L );
			L = list2( L, 28 );
			break;
		case 11:L = vecrtovecnf( L );
			L = list2( L, 28 );
			break;**/
		case 12:VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			ko = lfirst( VNF );
			if( ( n = lsrch( ko, VL ) ) )
			{	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = vecvpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				L = vpinfevalfvs( r, F, L );
				if( r != 1 )
				{	L = list2( VL, L );
					L = list2( L, 29 );
				}
				else	L = list2( L, 28 );
			}
			else
			{/*	L = vecpitovpnf( r, L );*/
				L = list2( VL, L );
				L = list2( L, 12 );
			}
			break;
		case 13:VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			ko = lfirst( VNF );
			if( ( n = lsrch( ko, VL ) ) )
			{	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = vecvpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				L = vprnfevalfvs( r, F, L );
				if( r != 1 )
				{	L = list2( VL, L );
					L = list2( L, 29 );
				}
				else	L = list2( L, 28 );
			}
			else
			{/*	L = vecprtovpnf( r, L );*/
				L = list2( VL, L );
				L = list2( L, 13 );
			}
			break;
/***		case (-1): *** elliptische Kurve ueber Q in kurzer WNF ***
		case (-2): *** elliptische Kurve ueber Q ***
			L=lfirst(L);
			L=lfirst(L);
			VL=_0;
			if(k==(-1))  L=lred3(L);
			i=0;
			while(L!=_0)
			{	ko=lfirst(L);
				L=lred(L);
				ko=rtonf(ko);
				if(ecqnfsch!=_0) koe[i] = ko;
				else VL=lcomp(ko,VL);
				i++;
			}
			if(ecqnfsch!=_0) 
			{	F=lfirst(ecqnfsch);
				if(k==(-1)) L=ecqnfinit(F,0,0,0,koe[0],koe[1]);
				else L=ecqnfinit(F,koe[0],koe[1],koe[2],koe[3],koe[4]);
			}
			else
			{ 	L=linv(VL);
				if(k==(-2))
				{	ko=lsecond(L);
					PP=lthird(L);
					leset(L,2,PP);
					leset(L,3,ko);
				}
			}
			L=list2(L,k-8);
			break;
		case (-3): *** Punkte in aff. Darst. ***
			ko=lthird(L);
			if(!ko)  L=list2(0,-11);
			else
			{	PP=lfirst(L);
				VL=lsecond(L);
				L=iprod(ko,ko);
				PP=rcons(PP,L);
				L=iprod(L,ko);
				VL=rcons(VL,L);
				PP=rtonf(PP);
				VL=rtonf(VL);
				L=list2(PP,VL);
				L=list2(L,-11);
			}
			break;
		case (-4): *** Punkte in proj. Darst. ***
			ko=lthird(L);
			if(!ko)
			{	PP=itonf(1);
				 L=list3(0,PP,0);
			}
			else
			{	PP=lfirst(L);
			 	VL=lsecond(L);
				PP=rcons(PP,ko);
				L=iprod(ko,ko);
				VL=rcons(VL,L);
				PP=rtonf(PP);
				VL=rtonf(VL);
				ko=itonf(ko);
				L=list3(PP,VL,ko);
			}
			L=list2(L,-12);	
			break; ***/
		default: L = list2( L, k );
			 break;
	}
	return( L );
}
