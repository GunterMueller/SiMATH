/*C
			calc_sum( a1, a2, t1, t2 )

	"calculator sum".
	list calc_sum(a1,a2,t1,t2);    obj a1, a2; single t1, t2;
	erg = calc_sum( a1, a2, t1, t2 );
	t1 bzw. t2 ist die Kennung des Objekts a1 bzw.a2.
	Berechnet wird die Summe von a1 und a2.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_sum fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  2      23.06.1988      C.Hollinger/U.Schneiders
	Version  3      29.05.1989      C.Hollinger
	Version  4      12.07.1989      C.Hollinger/U.Schneiders
	Version  5      28.11.1990      U.Schneiders
	Version  6      20.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  7      20.07.1992      U.Schneiders ( mod und nf )
	Version  8	08.04.1993	S.Schmitt/U.Schneiders
	Version  9      24.06.1993      S.Schmitt/U.Schneiders
	Version  9.1    12.07.1993      U.Schneiders
	Version  9.2    07.12.1993      U.Schneiders (tonf)
	Version  10	13.01.1994	S.Schmitt/U.Schneiders
	Version  10.1   28.12.1994      U.Schneiders (togf)
	Version  11     24.01.1995      S.Schmitt/U.Schneiders 
					(Polynome ueber R und C)
	Version  11.1   05.03.1996      S.Schmitt ( GF(2) )
	Version  11.2   10.07.1996      S.Schmitt (ecqnfsch neu)
H*/
 
#include <_calc.h>


#define vecpgf2sum(r, G, U, V)          vecsumspec(U, V, pgf2sum, 2, r, G, 0, 0, 0)

list calc_sum( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj erg, b1, b2, B1, B2, M;
	list VL;
	single r, t3, m1, m2, n1, n2;
	bind( a1, a2 );
	init( erg, b1, b2, B1, B2, M, VL );

	/*** Abfangen ungueltiger Eingaben. ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );
	if( ( t1 < 10 || (t1 > 16 && t1 < 21) || (t1 > 23 && t1 < 28 )|| ( t1 > 30 && t1 < 35 ) )
           && ( t2 < 10 || (t2 > 16 && t2 < 21) || (t2 > 23 && t2 < 28 ) || ( t2 > 30 && t2 < 35 ) ) || t1 == 15 || t2 == 15 || t1 == 37 || t2 == 37 
           || t1==38 || t2==38 || t1==39 || t2==39 )
		t3 = typer( a1, a2, t1, t2, &b1, &b2, 1 );
	else if( ( ( t1 > 9 && t1 < 15 ) || t1 == 21 || t1 == 22 || t1 == 28 || t1 == 29 || t1 == 35 || t1 == 36 )
                && ( ( t2 > 9 && t2 < 15 ) || t2 == 21 || t2 == 22 || t2 == 28 || t2 == 29 || t2 == 35 || t2 == 36 ) ) 
		t3 = vtyper( a1, a2, t1, t2, &b1, &b2,1 );
	else
	{       mistake( 71 );
		return( -BASIS );
	}

	if( t3 == -BASIS )      return( -BASIS );
	if( (t3 >1 && t3 < 5) || (t3 > 6 && t3 < 10) 
         || (t3 > 11 && t3 < 15) || t3 == 18 || t3 == 20 || t3 == 22
         || t3 == 25 || t3 == 27 || t3 == 29 || t3 == 32 || t3 == 34 
	 || t3 == 36 || t3==38 || t3 ==39 )
	{       VL = lfirst( b1 );
		r = llength( VL );
		b1 = lsecond( b1 );
		b2 = lsecond( b2 );
	}

	/*** Ueberpruefung der Dimensionen fuer Matrizen u. Vektoren ***/
	/*** Man braucht schon hier M, da es fuer Matrizen ueber Z/2Z die
	     besondere Bit-Darstellung gibt			     ***/

	if( ( t3 > 16 && t3 < 23 ) || ( t3 > (-9) && t3 < (-4) ) )
		M = lfirst( varlist[modsch].varwert );
	
	if( (t3 > 4 && t3 < 10) || t3 == 19 || t3 == 20 || t3 == 26 || t3 == 27 || t3 == 33 || t3 == 34 )         /*** Matrix. ***/
	{       if(t3==19 && M==2)
		{	m1=llength(b1)-1;
			m2=llength(b2)-1;
		}
		else 
		{	m1 = manrrow( b1 );
			m2 = manrrow( b2 );
		}
		if( m1 != m2 )
		{       mistake( 72 );
			return( -BASIS );
		}
		if(t3==19 && M==2)
		{	n1=lfirst(b1);
			n2=lfirst(b2);
		}
		else
		{	n1 = manrcol( b1 );
			n2 = manrcol( b2 );
		}
		if( n1 != n2 )
		{       mistake( 72 );
			return( -BASIS );
		}
	}
	else    if( (t3 > 9 && t3 < 15) || t3 == 21 || t3 == 22 || t3 == 28 || t3 == 29 || t3 == 35 || t3 == 36 )         /*** Vektor. ***/
		{       n1 = llength( b1 );
			n2 = llength( b2 );
			if( n1 != n2 )
			{       mistake( 72 );
				return( -BASIS );
			}
		}

	if( ( t3 > 23 && t3 < 30 ) || ( t3 > (-13) && t3 < (-8) ) )
		M = lfirst( varlist[nfsch].varwert );
	else if( ( t3 > 30 && t3 < 37 ) || ( t3 > (-17) && t3 < (-12)) )
		M = lfirst(varlist[gfsch].varwert);
		
	switch( t3 )
	{
		case 0: erg = isum( b1, b2 );
			break;
		case 1: erg = rsum( b1, b2 );
			break;
		case 2: erg = pisum( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 3: erg = prsum( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 4: if(b1) B1 = lsecond( b1 );
			if(b2) B2 = lsecond( b2 );
			if( !expover( r, B1, B2 ) )   return( -BASIS );
			if(b1) B1 = lfirst( b1 );
			if(b2) B2 = lsecond( b2 );
			if( !expover( r, B1, B2 ) )   return( -BASIS );
			if(b1) B1 = lsecond( b1 );
			if(b2) B2 = lfirst( b2 );
			if( !expover( r, B1, B2 ) )   return( -BASIS );
			erg = rfrsum( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 5: erg = maisum( b1, b2 );
			break;
		case 6: erg = marsum( b1, b2 );
			break;
		case 7: erg = mapisum( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 8: erg = maprsum( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 9: erg = marfrsum( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 10:erg = vecisum( b1,b2 );
			break;
		case 11:erg = vecrsum( b1,b2 );
			break;
		case 12:erg = vecpisum( r, b1, b2 );
			erg = list2( VL,erg );
			break;
		case 13:erg = vecprsum( r, b1, b2 );
			erg = list2( VL,erg );
			break;
		case 14:erg = vecrfrsum( r, b1, b2 );
			erg = list2( VL,erg );
			break;
		case 15:erg = flsum( b1, b2 );
			break;
		case 17:if( ssch ) erg = mssum( M, b1, b2 );
			else       erg = misum( M, b1, b2 );
			break;
		case 18:if( ssch ) erg = pmssum( r, M, b1, b2 );
			else       erg = pmisum( r, M, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 19:if(M==2) 	erg = mam2sum( b1, b2 );
			else if( ssch ) erg = mamssum( M, b1, b2 );
			else       	erg = mamisum( M, b1, b2 );
			break;
		case 20:if( ssch ) erg = mapmssum( r, M, b1, b2 );
			else       erg = mapmisum( r, M, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 21:if( ssch ) erg = vecmssum( M, b1, b2 );
			else       erg = vecmisum( M, b1, b2 );
			break;
		case 22:if( ssch ) erg = vecpmssum( r, M, b1, b2 );
			else       erg = vecpmisum( r, M, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 24:erg = nfsum( M, b1, b2 );
			break;
		case 25:erg = pnfsum( r, M, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 26:erg = manfsum( M, b1, b2 );
			break;
		case 27:erg = mapnfsum( r, M, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 28:erg = vecnfsum( M, b1, b2 );
			break;
		case 29:erg = vecpnfsum( r, M, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 31:if(gfchar==2)  	erg=gf2sum(M,b1,b2);
			else  		erg=gfssum(gfchar,M,b1,b2);
			break;
		case 32:if(gfchar==2) 	erg=pgf2sum(r,M,b1,b2);
			else 		erg=pgfssum(r,gfchar,M,b1,b2);
			erg=list2(VL,erg);
			break;
		case 33:if(gfchar!=2) 	erg=magfssum(gfchar,M,b1,b2);
			else 		erg=magf2sum(M,b1,b2);
			break;
		case 34:if(gfchar!=2) 	erg=mapgfssum(r,gfchar,M,b1,b2);
			else 		erg=mapgf2sum(r,M,b1,b2);
			erg=list2(VL,erg);
			break;
		case 35:if(gfchar!=2) 	erg=vecgfssum(gfchar,M,b1,b2);
			else 		erg=vecgf2sum(M,b1,b2);
			break;
		case 36:if(gfchar!=2) 	erg=vecpgfssum(r,gfchar,M,b1,b2);
			else 		erg=vecpgf2sum(r,M,b1,b2);
			erg=list2(VL,erg);
			break;
		case 37:erg = csum( b1, b2 );
			break;
		case 38:erg = pflsum(r,b1,b2);
			erg = list2( VL, erg );
			break;
		case 39:erg = pcsum(r,b1,b2);
			erg = list2( VL, erg );
			break;
		case (-3): 
		case (-4): if( !ecsch )
			   {    mistake( 111 );
				return( ERROR );
			   }
			   erg = varlist[ecsch].varwert;
			   r = lsecond( erg );
			   if( r != (-1) && r != (-2) && r != (-9) && r != (-10) ) 
			   {	mistake( 45 );
				return( ERROR );
			   }
			   erg = lfirst( erg );
			   if( r > (-3) )
			   {	if(!isponecrac(erg,a1) || !isponecrac(erg,a2))
			   	{	mistake(112);
					return(ERROR);
			   	}
			   	erg = ecracsum( erg, a1, a2 );
			   }
			   else
			   {	if( t1 > (-5) ) a1 = tonftyper( a1, t1 );
				if( t2 > (-5) ) a2 = tonftyper( a2, t2 );
				M = lfirst( varlist[nfsch].varwert );
				if( t1 == (-3) || t2 == (-3) )
				{ t3 = (-11);
  				  b2 = itonf( 1 );
			   	  if( !a1 )    a1 = list3( 0, b2, 0 );
			   	  else
			   	  {    b1 = lcopy( a1 );
				       a1 = lsuffix( b1, b2 );
			   	  }
			   	  if( !a2 )    a2 = list3( 0, b2, 0 );
			   	  else
			   	  {    b1 = lcopy( a2 );
				       a2 = lsuffix( b1, b2 );
			   	  }
				  if(ecqnfsch!=_0)
				  {	erg = lfirst(erg);
					erg = lfirst(erg);
					if(r==(-9)) erg = lred3(erg); 
				  }	
			   	  switch( r )
			   	  {  case (-9): b1 = lfirst( erg );
					   	b2 = lsecond( erg );
						if(llength(ecqnfsch)==3)
						{	b1=qnftonf(b1,24);
							b2=qnftonf(b2,24);
						}
					   	if( !iselecnfsnf( M, b1, b2, a1 ) || !iselecnfsnf( M, b1, b2, a2 ) )
					   	{    mistake( 112 );
						     return( ERROR );
					   	}
					   	erg = ecnfsnfsum( M, b1, b2, a1, a2 );
					   	break;
				     case (-10):b1 = lfirst( erg );
					   	B1 = lsecond( erg );
					   	b2 = lthird( erg );
					   	B2 = lfourth( erg );
					   	erg = lfifth( erg );
						if(llength(ecqnfsch)==3)
						{	b1=qnftonf(b1,24);
							b2=qnftonf(b2,24);
							B1=qnftonf(B1,24);
							B2=qnftonf(B2,24);
							erg=qnftonf(erg,24);
						}
					   	if( !iselecnf( M, b1, B1, b2, B2, erg, a1 ) || !iselecnf( M, b1, B1, b2, B2, erg, a2 ) )
					   	{    mistake( 112 );
						     return( ERROR );
					   	}
					   	erg = ecnfsum( M, b1, B1, b2, B2, erg, a1, a2 );
					   	break;
			   	  }
			   	  b1 = ecnfsrpp( M, erg );
			   	  if( !lthird( b1 ) )  erg = 0;
			   	  else
			   	  {    B1 = lfirst( b1 );
				       B2 = lsecond( b1 );
				       erg = list2( B1, B2 );
			   	  }
				}
				else
				{ t3 = (-12);
				  if(ecqnfsch!=_0)
				  {	erg = lfirst(erg);
					erg = lfirst(erg);
					if(r==(-9)) erg = lred3(erg);
				  }
				  switch( r )
			   	  {    case (-9): b1 = lfirst( erg );
					          b2 = lsecond( erg );
						  if(llength(ecqnfsch)==3)
						  {	b1=qnftonf(b1,24);
							b2=qnftonf(b2,24);
						  }
					          if( !iselecnfsnf( M, b1, b2, a1 ) || !iselecnfsnf( M, b1, b2, a2 ) )
					          {    mistake( 112 );
						       return( ERROR );
					          }
					          erg = ecnfsnfsum( M, b1, b2, a1, a2 );
					          break;
				       case (-10):b1 = lfirst( erg );
					          B1 = lsecond( erg );
					          b2 = lthird( erg );
					          B2 = lfourth( erg );
					          erg = lfifth( erg );
						  if(llength(ecqnfsch)==3)
						  {	b1=qnftonf(b1,24);
							b2=qnftonf(b2,24);
							B1=qnftonf(B1,24);
							B2=qnftonf(B2,24);
							erg=qnftonf(erg,24);
						  }
					          if( !iselecnf( M, b1, B1, b2, B2, erg, a1 ) || !iselecnf( M, b1, B1, b2, B2, erg, a2 ) )
					          {    mistake( 112 );
						       return( ERROR );
					          }
					          erg = ecnfsum( M, b1, B1, b2, B2, erg, a1, a2 );
					          break;
			          }
			          erg = ecnfsrpp( M, erg );
				}
			   }
			   break;
		case (-7): if( !ecsch )
			   {    mistake( 111 );
				return( ERROR );
			   }
			   erg = varlist[ecsch].varwert;
			   r = lsecond( erg );
			   if( r != (-5) && r != (-6) && r != (-14) )
			   {	mistake( 45 );
				return( ERROR );
			   }
			   erg = lfirst( erg );
			   if( !a1 )    a1 = list3( 0, 1, 0 );
			   else
			   {    b1 = lcopy( a1 );
				a1 = lsuffix( b1, 1 );
			   }
			   if( !a2 )    a2 = list3( 0, 1, 0 );
			   else
			   {    b1 = lcopy( a2 );
				a2 = lsuffix( b1, 1 );
			   }
			   if( r==(-14) )
			   {	if( t1 > (-9) ) 
				{	a1 = togftyper( a1, t1, 1 );
					if(a1==ERROR) return(ERROR);
				}
				if( t2 > (-9) ) 
				{	a2 = togftyper( a2, t2, 1 );
					if(a2==ERROR) return(ERROR);
				}
				M = lfirst( varlist[gfsch].varwert );
			        t3=t3-8;
			   }
			   switch( r )
			   {    case (-5): b1 = lfirst( erg );
					   b2 = lsecond( erg );
					   if( !iselecmpsnf( M, b1, b2, a1 ) || !iselecmpsnf( M, b1, b2, a2 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecmpsnfsum( M, b1, b2, a1, a2 );
			   		   b1 = ecmpsrpp( M, erg );
					   break;
				case (-6): b1 = lfirst( erg );
					   B1 = lsecond( erg );
					   b2 = lthird( erg );
					   B2 = lfourth( erg );
					   erg = lfifth( erg );
					   if( !iselecmp( M, b1, B1, b2, B2, erg, a1 ) || !iselecmp( M, b1, B1, b2, B2, erg, a2 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecmpsum( M, b1, B1, b2, B2, erg, a1, a2 );
			   		   b1 = ecmpsrpp( M, erg );
					   break;
				case (-14):b1 = lfirst( erg );
			   		   B1 = lsecond( erg );
			   		   b2 = lthird( erg );
			   		   B2 = lfourth( erg );
			   		   erg = lfifth( erg );
			   		   if( !iselecgf2( M, b1, B1, b2, B2, erg, a1 ) || !iselecgf2( M, b1, B1, b2, B2, erg, a2 ) )
			   		   {    mistake( 112 );
						   return( ERROR );
			   		   }
			   		   erg = ecgf2sum( M, b1, B1, b2, B2, erg, a1, a2 );
			   		   b1 = ecgf2srpp( M, erg );
			   		   break;
			   }
			   if( !lthird( b1 ) )  erg = 0;
			   else
			   {    B1 = lfirst( b1 );
				B2 = lsecond( b1 );
				erg = list2( B1, B2 );
			   }
			   break;
		case (-8): if( !ecsch )
			   {    mistake( 111 );
				return( ERROR );
			   }
			   erg = varlist[ecsch].varwert;
			   r = lsecond( erg );
			   if( r != (-5) && r != (-6) && r != (-14) )
			   {	mistake( 45 );
				return( ERROR );
			   }
			   erg = lfirst( erg );
			   if( r==(-14) )
			   {	if( t1 > (-9) ) 
				{	a1 = togftyper( a1, t1, 1 );
					if(a1==ERROR) return(ERROR);
				}
				if( t2 > (-9) ) 
				{	a2 = togftyper( a2, t2, 1 );
					if(a2==ERROR) return(ERROR);
				}
				M = lfirst( varlist[gfsch].varwert );
			        t3=t3-8;
			   }
			   switch( r )
			   {    case (-5): b1 = lfirst( erg );
					   b2 = lsecond( erg );
					   if( !iselecmpsnf( M, b1, b2, a1 ) || !iselecmpsnf( M, b1, b2, a2 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecmpsnfsum( M, b1, b2, a1, a2 );
			   		   erg = ecmpsrpp( M, erg );
					   break;
				case (-6): b1 = lfirst( erg );
					   B1 = lsecond( erg );
					   b2 = lthird( erg );
					   B2 = lfourth( erg );
					   erg = lfifth( erg );
					   if( !iselecmp( M, b1, B1, b2, B2, erg, a1 ) || !iselecmp( M, b1, B1, b2, B2, erg, a2 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecmpsum( M, b1, B1, b2, B2, erg, a1, a2 );
			   		   erg = ecmpsrpp( M, erg );
					   break;
				case (-14):b1 = lfirst( erg );
			   		   B1 = lsecond( erg );
			   		   b2 = lthird( erg );
			   		   B2 = lfourth( erg );
			   		   erg = lfifth( erg );
			   		   if( !iselecgf2( M, b1, B1, b2, B2, erg, a1 ) || !iselecgf2( M, b1, B1, b2, B2, erg, a2 ) )
			   		   {    mistake( 112 );
						   return( ERROR );
			   		   }
			   		   erg = ecgf2sum( M, b1, B1, b2, B2, erg, a1, a2 );
			   		   erg = ecgf2srpp( M, erg );
			   		   break;
			   }
			   break;
		case (-11): if( !ecsch )
			   {    mistake( 111 );
				return( ERROR );
			   }
			   erg = varlist[ecsch].varwert;
			   r = lsecond( erg );
			   if( r != (-9) && r != (-10) && r != (-1) && r != (-2) )
			   {	mistake( 45 );
				return( ERROR );
			   }
			   erg = lfirst( erg );
			   if( r > (-3) )
			   {	erg = tonftyper( erg, r );
				r = r - 8;
			   }
			   if( t1 > (-5) ) a1 = tonftyper( a1, t1 );
			   if( t2 > (-5) ) a2 = tonftyper( a2, t2 );
			   b2 = itonf( 1 );
			   if( !a1 )    a1 = list3( 0, b2, 0 );
			   else
			   {    b1 = lcopy( a1 );
				a1 = lsuffix( b1, b2 );
			   }
			   if( !a2 )    a2 = list3( 0, b2, 0 );
			   else
			   {    b1 = lcopy( a2 );
				a2 = lsuffix( b1, b2 );
			   }
			   if(ecqnfsch!=_0)
			   {	erg = lfirst(erg);
				erg = lfirst(erg);
				if(r==(-9)) erg = lred3(erg);
			   }
			   switch( r )
			   {    case (-9): b1 = lfirst( erg );
					   b2 = lsecond( erg );
					   if(llength(ecqnfsch)==3)
					   {	b1=qnftonf(b1,24);
						b2=qnftonf(b2,24);
					   }
					   if( !iselecnfsnf( M, b1, b2, a1 ) || !iselecnfsnf( M, b1, b2, a2 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecnfsnfsum( M, b1, b2, a1, a2 );
					   break;
				case (-10):b1 = lfirst( erg );
					   B1 = lsecond( erg );
					   b2 = lthird( erg );
					   B2 = lfourth( erg );
					   erg = lfifth( erg );
					   if(llength(ecqnfsch)==3)
					   {	b1=qnftonf(b1,24);
						b2=qnftonf(b2,24);
						B1=qnftonf(B1,24);
						B2=qnftonf(B2,24);
						erg=qnftonf(erg,24);
					   }
					   if( !iselecnf( M, b1, B1, b2, B2, erg, a1 ) || !iselecnf( M, b1, B1, b2, B2, erg, a2 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecnfsum( M, b1, B1, b2, B2, erg, a1, a2 );
					   break;
			   }
			   b1 = ecnfsrpp( M, erg );
			   if( !lthird( b1 ) )  erg = 0;
			   else
			   {    B1 = lfirst( b1 );
				B2 = lsecond( b1 );
				erg = list2( B1, B2 );
			   }
			   break;
		case (-12):if( !ecsch )
			   {    mistake( 111 );
				return( ERROR );
			   }
			   erg = varlist[ecsch].varwert;
			   r = lsecond( erg );
			   if( r != (-9) && r != (-10) && r != (-1) && r != (-2) )
			   {	mistake( 45 );
				return( ERROR );
			   }
			   erg = lfirst( erg );
			   if( r > (-3) )
			   {	erg = tonftyper( erg, r );
				r = r - 8;
			   }
			   if( t1 > (-5) ) a1 = tonftyper( a1, t1 );
			   if( t2 > (-5) ) a2 = tonftyper( a2, t2 );
			   if(ecqnfsch!=_0)
			   {	erg = lfirst(erg);
				erg = lfirst(erg);
				if(r==(-9)) erg = lred3(erg);
			   }
			   switch( r )
			   {    case (-9): b1 = lfirst( erg );
					   b2 = lsecond( erg );
					   if(llength(ecqnfsch)==3)
					   {	b1=qnftonf(b1,24);
						b2=qnftonf(b2,24);
					   }
					   if( !iselecnfsnf( M, b1, b2, a1 ) || !iselecnfsnf( M, b1, b2, a2 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecnfsnfsum( M, b1, b2, a1, a2 );
					   break;
				case (-10):b1 = lfirst( erg );
					   B1 = lsecond( erg );
					   b2 = lthird( erg );
					   B2 = lfourth( erg );
					   erg = lfifth( erg );
					   if(llength(ecqnfsch)==3)
					   {	b1=qnftonf(b1,24);
						b2=qnftonf(b2,24);
						B1=qnftonf(B1,24);
						B2=qnftonf(B2,24);
						erg=qnftonf(erg,24);
					   }
					   if( !iselecnf( M, b1, B1, b2, B2, erg, a1 ) || !iselecnf( M, b1, B1, b2, B2, erg, a2 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecnfsum( M, b1, B1, b2, B2, erg, a1, a2 );
					   break;
			   }
			   erg = ecnfsrpp( M, erg );
			   break;
		case (-15):if( !ecsch )
			   {    mistake( 111 );
				return( ERROR );
			   }
			   erg = varlist[ecsch].varwert;
			   r = lsecond( erg );
			   if( r != (-14) && r != (-6) )
			   {	mistake( 45 );
				return( ERROR );
			   }
			   erg = lfirst( erg );
			   if( r==(-6) )
			   {	erg = togftyper(erg,r,1);
				if(erg==ERROR) return(ERROR);
				r=r-8;
			   }
			   b2 = list2( 0, 1 );
			   b2 = udpm2tosb( b2 );
			   if( t1>(-9) )   
			   {	a1 = togftyper(a1,t1,1);
				if(a1==ERROR) return(ERROR);
			   }
			   if( !a1 )    a1 = list3( 0, b2, 0 );
			   else
			   {    b1 = lcopy( a1 );
				a1 = lsuffix( b1, b2 );
			   }
			   if( t2>(-9) )   
			   {	a2 = togftyper(a2,t2,1);
				if(a2==ERROR) return(ERROR);
			   }
			   if( !a2 )    a2 = list3( 0, b2, 0 );
			   else
			   {    b1 = lcopy( a2 );
				a2 = lsuffix( b1, b2 );
			   }
			   b1 = lfirst( erg );
			   B1 = lsecond( erg );
			   b2 = lthird( erg );
			   B2 = lfourth( erg );
			   erg = lfifth( erg );
			   if( !iselecgf2( M, b1, B1, b2, B2, erg, a1 ) || !iselecgf2( M, b1, B1, b2, B2, erg, a2 ) )
			   {    mistake( 112 );
				return( ERROR );
			   }
			   erg = ecgf2sum( M, b1, B1, b2, B2, erg, a1, a2 );
			   b1 = ecgf2srpp( M, erg );
			   if( !lthird( b1 ) )  erg = 0;
			   else
			   {    B1 = lfirst( b1 );
				B2 = lsecond( b1 );
				erg = list2( B1, B2 );
			   }
			   break;
		case (-16):if( !ecsch )
			   {    mistake( 111 );
				return( ERROR );
			   }
			   erg = varlist[ecsch].varwert;
			   r = lsecond( erg );
			   if( r != (-14) && r != (-6) )
			   {	mistake( 45 );
				return( ERROR );
			   }
			   erg = lfirst( erg );
			   if( r==(-6) )
			   {	erg = togftyper(erg,r,1);
				if(erg==ERROR) return(ERROR);
				r=r-8;
			   }
			   if( t1>(-9) )   
			   {	a1 = togftyper(a1,t1,1);
				if(a1==ERROR) return(ERROR);
			   }
			   if( t2>(-9) )   
			   {	a2 = togftyper(a2,t2,1);
				if(a2==ERROR) return(ERROR);
			   }
			   b1 = lfirst( erg );
			   B1 = lsecond( erg );
			   b2 = lthird( erg );
			   B2 = lfourth( erg );
			   erg = lfifth( erg );
			   if( !iselecgf2( M, b1, B1, b2, B2, erg, a1 ) || !iselecgf2( M, b1, B1, b2, B2, erg, a2 ) )
			   {    mistake( 112 );
				return( ERROR );
			   }
			   erg = ecgf2sum( M, b1, B1, b2, B2, erg, a1, a2 );
			   erg = ecgf2srpp( M, erg );
			   break;
	}
	erg = list2( erg, t3 );
	return( erg );
}
