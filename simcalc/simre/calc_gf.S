/*C
			calc_gf( fkeller )

	"calculator Galois-field".
	list calc_gf(fkeller); list fkeller;
	L = calc_gf( fkeller );

	fkeller ist eine Liste bestehend aus einer ganzen oder rationa-
	len Zahl, einer Zahl aus Z/pZ (wobei p=gfchar), einem 
	Polynom ueber Z, Q oder Z/pZ, einer Matrix bzw. einem Vektor 
	ueber vorgenannte Strukturen oder einer elliptischen Kurve bzw. 
	einem Punkt auf ihr ueber Q oder Z/2Z (falls gfchar=2) in 
	langer WNF.
	Der endliche Koerper K ist bestimmt durch das in varlist[gfsch]
	stehende Polynom mit entsprechender Variablenliste oder 
	Arithmetikliste.
	Dabei ist zu beachten, dass Elemente aus K in der Variablen
	dargestellt werden, die auch fuer das den endlichen Koerper 
	erzeugende Polynom benutzt wurde.
	L = ( fkeller aufgefasst ueber K, ken ).
	fkeller aus Z, Q, Z/pZ             	 ken = 31 
	      P(Z), P(Q), P(Z/pZ)                      32 
	      Mat(Z), Mat(Q), Mat(Z/pZ)                33
	      Mat(P(Z)), Mat(P(Q)), Mat(P(Z/pZ))       34
	      Vek(Z), Vek(Q), Vek(Z/pZ)                35
	      Vek(P(Z)), Vek(P(Q)), Vek(P(Z/pZ))       36
	      EC(Q), EC(Z/2Z)                         -14
	      P(Q), P(Z/2Z)  aff                      -15
	      P(Q), P(Z/2Z)  proj                     -16
	Laeuft calc_gf fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1	27.05.1993	S.Schmitt/U.Schneiders
	Version 2 	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
	Version 2.1	29.02.1996	S.Schmitt (GF(2))
H*/
 
#include <_calc.h>

list calc_gf( fkeller )
list fkeller;
{
	single i, k, n, r;
	obj L, F, N, ko;
	list PP, VL;
	init( L, F, N, ko, PP, VL );
	bind( fkeller );

	k = lsecond( fkeller );
	if( k == 4 || k == 9 || ( k > 13 && k < 17 ) || k > 22 || k < (-8) || k == (-1) || k == (-5) )
	{       mistake( 262 );
		return( ERROR );
	}
	if( !gfsch )
	{       mistake( 260 );
		return( ERROR );
	} 
	if(((k>16 && k<23) || k<-5 ) && (!ssch || lfirst(varlist[modsch].varwert)!= gfchar))
	{	mistake(266);
		return(ERROR);
	}
	if(k<0 && gfchar != 2 )
	{	mistake(262);
		return(ERROR);
	}

	L = lfirst( fkeller );
	F = lfirst( varlist[gfsch].varwert );

	/*** Reduzieren mod F ***/

	switch( k )
	{       case 0: L = mshom( gfchar, L ); 
			if(L)
			{	L=list2(0,L);
				if(gfchar==2) L=udpm2tosb(L);
			}
			L = list2( L, 31 );
			break;
		case 1: VL = lsecond( L );
			if(igcd(VL,gfchar)!=1)
			{	mistake2(233,L,gfchar);
				return(ERROR);
			}
			VL=mshom(gfchar,VL);
			VL=msinv(gfchar,VL);
			L=lfirst(L);
			L=mshom(gfchar,L);
			L=msprod(gfchar,L,VL);
			if(L)
			{ 	L=list2(0,L);
				if(gfchar==2) L=udpm2tosb(L);
			}
			L = list2( L, 31 );
			break;
		case 2: VL=lfirst(L);
			L = lsecond( L );
			r = llength( VL );
			ko = lfirst( VGF );
			if( r == 1 && oequal( VL, VGF ) )
		        {	L = pitopms( 1, L, gfchar );
				if(gfchar!=2)
				{	F=lfirst(F);
					L=gfselred(gfchar,L,F);
				}
				else
				{	L=ptodp(1,L);
					L=udpm2togf2el(F,L);
				}
				L = list2( L, 31 );
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
				if(gfchar==2) L=pigf2evalfvs(r,F,L);
				else L = pigfsevalfvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 32 );
			}
			else
			{       L = pitopms( r, L, gfchar );
				if(gfchar!=2)  L=pmstopgfs(r,gfchar,L);
				else   L=pm2topgf2(r,L);
				L = list2( VL, L );
				L = list2( L, 32 );
			}
			break;
		case 3: VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
		        L=prnumden(r,L,&N);
			if(igcd(gfchar,N)!=1)
			{	mistake1(242,gfchar);
				return(ERROR);
			}
			N=mshom(gfchar,N);
			N = msinv( gfchar, N );
			L = pitopms( r, L, gfchar );
			L = pmsmsprod( r, gfchar, L, N );
			ko=lfirst(VGF);
			if( r == 1 && oequal( VL, VGF ) )
		        {	if(gfchar!=2)
				{	F=lfirst(F);
					L=gfselred(gfchar,L,F);
				}
				else
				{	L=ptodp(1,L);
					L=udpm2togf2el(F,L);
				}
				L = list2( L, 31 );
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
				if(gfchar==2) L=pigf2evalfvs(r,F,L);
				else L = pigfsevalfvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 32 );
			}
			else
			{ 	if(gfchar!=2)  L=pmstopgfs(r,gfchar,L);
				else   L=pm2topgf2(r,L);
				L = list2( VL, L );
				L = list2( L, 32 );
			}
			break;
		case 5: if(gfchar==2) L=maitomagf2(L);
			else L = maitomagfs( gfchar,L );
			L = list2( L, 33 );
			break;
		case 6: L =  martomami( gfchar,L );
			if(L==ERROR)
			{	mistake1(243,gfchar);
				return(ERROR);
			}
			if(gfchar==2) L=maitomagf2(L);
			else L=maitomagfs(gfchar,L);
			L = list2( L, 33 );
			break;
		case 7: VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			ko = lfirst( VGF );
			if( r == 1 && oequal( VL, VGF ) )
		        {       if(gfchar!=2)
				{	F=lfirst(F);
					L=magfsred(gfchar,L,F);
				}
				else L=magf2rem(L,F);
				L = list2( L, 33 );
			}
			else if( ( n = lsrch( ko, VL ) ) )
			{	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = mavpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				if(gfchar==2) L=mapigf2evfvs(r,F,L);
				else L = mapigfsevfvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 34 );
			}
			else
			{	L = mapitomapms( r, L, gfchar );
				if(gfchar==2) L=mpm2tompgf2(r,L);
				else L = mpmstompgfs(r,gfchar,L);
				L = list2( VL, L );
				L = list2( L, 34 );
			}
			break;
		case 8: VL = lfirst( L );
			L = lsecond( L );
			r = llength( VL );
			L =  maprtomapmi( r,L, gfchar );
			if(L==ERROR)
			{	mistake1(243,gfchar);
				return(ERROR);
			}
			ko = lfirst( VGF );
			if( r == 1 && oequal( VL, VGF ) )
		        {       if(gfchar!=2)
				{	F=lfirst(F);
					L=magfsred(gfchar,L,F);
				}
				else L=magf2rem(L,F);
				L = list2( L, 33 );
			}
			else if( ( n = lsrch( ko, VL ) ) )
			{	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = mavpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				if(gfchar==2) L=mapigf2evfvs(r,F,L);
				else L = mapigfsevfvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 34 );
			}
			else
			{	L = mapitomapms( r, L, gfchar );
				if(gfchar==2) L=mpm2tompgf2(r,L);
				else L = mpmstompgfs(r,gfchar,L);
				L = list2( VL, L );
				L = list2( L, 34 );
			}
			break;
		case 10: if(gfchar==2) L=vecitovecgf2(L);
			 else L = vecitovecgfs( gfchar,L );
			 L = list2( L, 35 );
			 break;
		case 11: L =  vecrtovecmi( gfchar,L );
			 if(L==ERROR)
			 {	mistake1(244,gfchar);
			 	return(ERROR);
			 }
			 if(gfchar==2) L=vecitovecgf2(L);
			 else L=vecitovecgfs(gfchar,L);
			 L = list2( L, 35 );
			 break;
		case 12: VL = lfirst( L );
			 L = lsecond( L );
			 r = llength( VL );
			 ko = lfirst( VGF );
			 if( r == 1 && oequal( VL, VGF ) )
		         {       if(gfchar!=2)
				 {	F=lfirst(F);
			   	 	L=vecgfsred(gfchar,L,F);
				 }
				 else L=vecgf2rem(L,F);
			 	 L = list2( L, 35 );
			 }
			 else if( ( n = lsrch( ko, VL ) ) )
			 {	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = vecvpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				if(gfchar==2) L=vecpigf2efvs(r,F,L);
				else L = vecpigfsefvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 36 );
			 }
			 else
			 {	L = vecpitovpms( r, L, gfchar );
				if(gfchar==2) L=vpm2tovpgf2(r,L);
				else L = vpmstovpgfs(r,gfchar,L);
				L = list2( VL, L );
				L = list2( L, 36 );
			 }
			 break;
		case 13: VL = lfirst( L );
			 L = lsecond( L );
			 r = llength( VL );
			 L =  vecprtovpmi( r,L,gfchar );
			 if(L==ERROR)
			 {	 mistake1(244,gfchar);
			 	 return(ERROR);
			 }
			 ko = lfirst( VGF );
			 if( r == 1 && oequal( VL, VGF ) )
		         {       if(gfchar!=2)
				 {	F=lfirst(F);
				 	L=vecgfsred(gfchar,L,F);
				 }
				 else L=vecgf2rem(L,F);
				 L = list2( L, 35 );
			 }
			 else if( ( n = lsrch( ko, VL ) ) )
			 {	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = vecvpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				if(gfchar==2) L=vecpigf2efvs(r,F,L);
				else L = vecpigfsefvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 36 );
			 }
			 else
			 {	L = vecpitovpms( r, L, gfchar );
				if(gfchar==2) L=vpm2tovpgf2(r,L);
				else L = vpmstovpgfs(r,gfchar,L);
				L = list2( VL, L );
				L = list2( L, 36 );
			 }
			 break;
	        case 17: if(L)
			 {	L=list2(0,L);
			 	if(gfchar==2) L=udpm2tosb(L);
			 }
			 L = list2( L, 31 );
			 break;
		case 18: VL=lfirst(L);
			 L = lsecond( L );
			 r = llength( VL );
			 ko = lfirst( VGF );
			 if( r == 1 && oequal( VL, VGF ) )
		         {	if(gfchar!=2)
				{	F=lfirst(F);
					L=gfselred(gfchar,L,F);
				}
				else
				{	L=ptodp(1,L);
					L=udpm2togf2el(F,L);
				}
				L = list2( L, 31 );
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
				if(gfchar==2) L=pigf2evalfvs(r,F,L);
				else L = pigfsevalfvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 32 );
			 }
			 else
			 {      if(gfchar!=2)  L=pmstopgfs(r,gfchar,L);
				else   L=pm2topgf2(r,L);
				L = list2( VL, L );
				L = list2( L, 32 );
			 }
			 break;
		case 19: if(gfchar==2) 
			 {	L=mam2tomams(L);
				L=maitomagf2(L);
			 }
			 else L = maitomagfs( gfchar,L );
			 L = list2( L, 33 );
			 break;
		case 20: VL = lfirst( L );
			 L = lsecond( L );
			 r = llength( VL );
			 ko = lfirst( VGF );
			 if( r == 1 && oequal( VL, VGF ) )
		         {       if(gfchar!=2) 
				 {	F=lfirst(F);
			 	 	L=magfsred(gfchar,L,F);
				 }
				 else L=magf2rem(L,F);
				 L = list2( L, 33 );
			 }
			 else if( ( n = lsrch( ko, VL ) ) )
			 {	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = mavpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				if(gfchar==2) L=mapigf2evfvs(r,F,L);
				else L = mapigfsevfvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 34 );
			 }
			 else
			 {	if(gfchar==2) L=mpm2tompgf2(r,L);
				else L = mpmstompgfs(r,gfchar,L);
				L = list2( VL, L );
				L = list2( L, 34 );
			 }
			 break;
		case 21: if(gfchar==2) L=vecitovecgf2(L);
			 else L = vecitovecgfs( gfchar,L );
			 L = list2( L, 35 );
			 break;
		case 22: VL = lfirst( L );
			 L = lsecond( L );
			 r = llength( VL );
			 ko = lfirst( VGF );
			 if( r == 1 && oequal( VL, VGF ) )
		         {       if(gfchar!=2)
				 {	F=lfirst(F);
			   	 	L=vecgfsred(gfchar,L,F);
				 }
				 else L=vecgf2rem(L,F);
			 	 L = list2( L, 35 );
			 }
			 else if( ( n = lsrch( ko, VL ) ) )
			 {	if( n != 1 )
				{	PP = _0;
					for( i = r; i; i-- )
						if( i != n ) PP = lcomp( i, PP );
					PP = lcomp( n, PP );
					L = vecvpermut( r, L, PP );
					VL = lpermut( VL, PP );
				}
				VL = lred( VL );
				if(gfchar==2) L=vecpigf2efvs(r,F,L);
				else L = vecpigfsefvs( r, gfchar, F, L );
				L = list2( VL, L );
				L = list2( L, 36 );
			 }
			 else
			 {	if(gfchar==2) L=vpm2tovpgf2(r,L);
				else L = vpmstovpgfs(r,gfchar,L);
				L = list2( VL, L );
				L = list2( L, 36 );
			 }
			 break;
		case (-2): /*** elliptische Kurve ueber Q ***/
			ko=ecracdisc(L);
			ko=lfirst(ko);
			if(!mshom(2,ko))
			{	mistake(106);
				return(ERROR);
			}
			L=lfirst(L);
			L=lfirst(L);
			VL=_0;
			while(L!=_0)
			{	ko=lfirst(L);
				L=lred(L);
				if(ko)  
				{	N = lsecond( ko );
			 		if(!mshom(2,N))
			 		{	mistake2(233,ko,gfchar);
			 			return(ERROR);
			 		}
			 		ko=lfirst(ko);
				}
			 	ko=mshom(2,ko);
				if(ko)
				{ 	ko=list2(0,ko);
			 		ko=udpm2tosb(ko);
				}
				VL=lcomp(ko,VL);
			}
			L=linv(VL);
			L=list2(L,-14);
			break;
		case (-3): /*** Punkte in aff. Darst. ***/
			ko=lthird(L);
			if(!ko)  L=list2(0,-15);
			else if(!mshom(2,ko)) L=list2(0,-15);
			else
			{	PP=lfirst(L);
				VL=lsecond(L);
				PP=mshom(2,PP);
				VL=mshom(2,VL);
				if(PP)
				{ 	PP=list2(0,PP);
					PP=udpm2tosb(PP);
				}
				if(VL)
				{	VL=list2(0,VL);
					VL=udpm2tosb(VL);
				}
				L=list2(PP,VL);
				L=list2(L,-15);
			}
			break;
		case (-4): /*** Punkte in proj. Darst. ***/
			ko=lthird(L);
			if(!ko || !mshom(2,ko))
			{	 PP=list2(0,1);
				 PP=udpm2tosb(PP);
				 L=list3(0,PP,0);
			}
			else
			{	PP=lfirst(L);
			 	VL=lsecond(L);
				PP=mshom(2,PP);
				VL=mshom(2,VL);
				if(PP)
				{ 	PP=list2(0,PP);
					PP=udpm2tosb(PP);
				}
				if(VL)
				{	VL=list2(0,VL);
					VL=udpm2tosb(VL);
				}
				ko = list2(0,1);
				ko = udpm2tosb(ko);
				L=list3(PP,VL,ko);
			}
			L=list2(L,-16);	
			break;
		case (-6): VL=_0;
			while(L!=_0)
			{	ko=lfirst(L);
				L=lred(L);
				if(ko)
				{ 	ko=list2(0,ko);
			 		ko=udpm2tosb(ko);
				}
				VL=lcomp(ko,VL);
			}
			L=linv(VL);
			L=list2(L,-14);
			break;
		case (-7): /*** Punkte in aff. Darst. ***/
			if(!L)  L=list2(0,-15);
			else
			{	PP=lfirst(L);
				VL=lsecond(L);
				if(PP)
				{ 	PP=list2(0,PP);
					PP=udpm2tosb(PP);
				}
				if(VL)
				{	VL=list2(0,VL);
					VL=udpm2tosb(VL);
				}
				L=list2(PP,VL);
				L=list2(L,-15);
			}
			break;
		case (-8): ko=lthird(L);
			if(!ko )
			{	 PP=list2(0,1);
				 PP=udpm2tosb(PP);
				 L=list3(0,PP,0);
			}
			else
			{	PP=lfirst(L);
			 	VL=lsecond(L);
				if(PP)
				{ 	PP=list2(0,PP);
					PP=udpm2tosb(PP);
				}
				if(VL)
				{	VL=list2(0,VL);
					VL=udpm2tosb(VL);
				}
				ko = list2(0,1);
				ko = udpm2tosb(ko);
				L=list3(PP,VL,ko);
			}
			L=list2(L,-16);	
		default: L = list2( L, k );
			 break;
	}
	return( L );
}
