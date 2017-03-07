/*C
			calc_neg( a1, t1 )

	"calculator negation".
	list calc_neg(a1,t1);       obj a1; single t1;
	erg = calc_neg( a1, t1 );

	t1 ist die Kennung des Objekts a1. Berechnet wird das additiv
	Inverse des Objekts a1. Das Ergebnis wird mit der Kennung t1
	der Variablen 'erg' zugeordnet.
	Laeuft calc_neg fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  2      26.10.1988      C.Hollinger/U.Schneiders
	Version  3      24.05.1989      C.Hollinger
	Version  4      12.07.1989      C.Hollinger/U.Schneiders
	Version  5      28.11.1990      U.Schneiders
	Version  6      20.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  7      20.07.1992      U.Schneiders ( mod und nf )
	Version  8	13.04.1993	S.Schmitt
	Version  9      12.07.1993	S.Schmitt ( gf )
	Version  9.1    07.12.1993	U.Schneiders (tonf)
	Version  10	13.01.1994	S.Schmitt/U.Schneiders
	Version  10.1   28.12.1994	U.Schneiders (togf)
	Version  11	24.01.1995	S.Schmitt/U.Schneiders
					(Pol. ueber R und C)
	Version  11.1   10.07.1996	S.Schmitt (ecqnfsch neu)
H*/
 
#include <_calc.h>

list calc_neg( a1, t1 )
obj a1;
single t1;

{       /*** Deklarationen und Vorbesetzungen. ***/

	list V;
	single r;
	obj b1, b2, B1, B2, M, erg;
	bind( a1 );
	init( b1, b2, B1, B2, M, erg, V );

	/*** Abfangen ungueltiger Eingaben. ***/

	if ( a1 == -BASIS )        return( -BASIS );
	if( t1 > 39 || t1 == 30 || t1 == 23 || t1 == 16 || t1 < (-16)
         || t1 == (-1) || t1 == (-2) || t1 == (-5) || t1 == (-6)
         || t1 == (-9) || t1 == (-10) || t1 == (-13) || t1 == (-14) )
	{	mistake( 71 );
		return( ERROR );
	}

	/*** Objekterkennung und Negation. ***/

	if( (t1 > 1 && t1 < 5) || (t1 > 6 && t1 < 10)
         || (t1 > 11 && t1 < 15) || t1 == 18 || t1 == 20 || t1 == 22
         || t1 == 25 || t1 == 27 || t1 == 29 || t1 == 32 || t1 == 34
	 || t1 == 36 || t1 == 38 || t1 == 39 )
	{       V = lfirst( a1 );
		r = llength( V );
		a1 = lsecond( a1 );
	}

	if( ( t1 > 16 && t1 < 23 ) || t1 == (-7) || t1 == (-8) )
		M = lfirst( varlist[modsch].varwert );
	else if( ( t1 > 23 && t1 < 30 ) || t1 == (-11) || t1 == (-12) )
		M = lfirst( varlist[nfsch].varwert );
	else if( ( t1 > 30 && t1 < 37 ) || t1 == (-15) || t1 == (-16) )
		M = lfirst( varlist[gfsch].varwert );

	switch( t1 )
	{       case 0: erg = ineg( a1 );
			break;
		case 1: erg = rneg( a1 );
			break;
		case 2: a1 = pineg( r, a1 );
			erg = list2( V, a1 );
			break;
		case 3: a1 = prneg( r, a1 );
			erg = list2( V, a1 );
			break;
		case 4: erg = rfrneg( r, a1 );
			erg = list2( V, erg );
			break;
		case 5: erg = maineg( a1 );
			break;
		case 6: erg = marneg( a1 );
			break;
		case 7: erg = mapineg( r, a1 );
			erg = list2( V, erg );
			break;
		case 8: erg = maprneg( r, a1 );
			erg = list2( V, erg );
			break;
		case 9: erg = marfrneg( r, a1 );
			erg = list2( V, erg );
			break;
		case 10:erg = vecineg( a1 );
			break;
		case 11:erg = vecrneg( a1 );
			break;
		case 12:erg = vecpineg( r,a1 );
			erg = list2( V,erg );
			break;
		case 13:erg = vecprneg( r,a1 );
			erg = list2( V,erg );
			break;
		case 14:erg = vecrfrneg( r,a1 );
			erg = list2( V,erg );
			break;
		case 15:erg = flneg( a1 );
			break;
		case 17:if( ssch ) erg = msneg( M, a1 );
			else       erg = mineg( M, a1 );
			break;
		case 18:if( ssch ) erg = pmsneg( r, M, a1 );
			else	   erg = pmineg( r, M, a1 );
			erg = list2( V, erg );
			break;
		case 19:if( ssch ) erg = mamsneg( M, a1 );
			else       erg = mamineg( M, a1 );
			break;
		case 20:if( ssch ) erg = mapmsneg( r, M, a1 );
			else	   erg = mapmineg( r, M, a1 );
			erg = list2( V, erg );
			break;
		case 21:if( ssch ) erg = vecmsneg( M, a1 );
			else       erg = vecmineg( M, a1 );
			break;
		case 22:if( ssch ) erg = vecpmsneg( r, M, a1 );
			else	   erg = vecpmineg( r, M, a1 );
			erg = list2( V, erg );
			break;
		case 24:erg = nfneg( M, a1 );
			break;
		case 25:erg = pnfneg( r, M, a1 );
			erg = list2( V, erg );
			break;
		case 26:erg = manfneg( M, a1 );
			break;
		case 27:erg = mapnfneg( r, M, a1 );
			erg = list2( V, erg );
			break;
		case 28:erg = vecnfneg( M, a1 );
			break;
		case 29:erg = vecpnfneg( r, M, a1 );
			erg = list2( V, erg );
			break;
		case 31:if( gfchar == 2 ) erg = gf2neg( M, a1 );
			else erg = gfsneg( gfchar, M, a1 );
			break;
		case 32:if( gfchar == 2 ) erg = pgf2neg( r, M, a1 );
			else erg = pgfsneg( r, gfchar, M, a1 );
			erg = list2( V, erg);
			break;
		case 33:erg = magfsneg( gfchar, M, a1 );
			break;
		case 34:erg = mapgfsneg( r, gfchar, M, a1 );
			erg = list2( V, erg );
			break;
		case 35:erg = vecgfsneg( gfchar, M, a1 );
			break;
		case 36:erg = vecpgfsneg( r, gfchar, M, a1 );
			erg = list2( V, erg );
			break;
		case 37:erg = cneg( a1 );
			break;
		case 38:a1 = pflneg( r, a1 );
			erg = list2( V, a1 );
			break;
		case 39:a1 = pcneg( r, a1 );
			erg = list2( V, a1 );
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
		       	   {	if(!isponecrac(erg,a1))
			   	{	mistake(112);
					return(ERROR);
			   	}
		           	erg=ecracneg(erg,a1);
			   }
			   else
			   {	a1 = tonftyper( a1, t1 );
				t1 = t1 - 8;
				M = lfirst( varlist[nfsch].varwert );
				if( t1 == (-11) )
				{ b2 = itonf( 1 );
			          if( !a1 )    a1 = list3( 0, b2, 0 );
			          else
			          {    b1 = lcopy( a1 );
				       a1 = lsuffix( b1, b2 );
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
					          if( !iselecnfsnf( M, b1, b2, a1 ) )
					          {    mistake( 112 );
						       return( ERROR );
					          }
					          erg = ecnfsnfneg( M, b1, b2, a1 );
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
					          if( !iselecnf( M, b1, B1, b2, B2, erg, a1 ) )
					          {    mistake( 112 );
						       return( ERROR );
					          }
					          erg = ecnfneg( M, b1, B1, b2, B2, erg, a1 );
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
				{ if(ecqnfsch!=_0)
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
					          if( !iselecnfsnf( M, b1, b2, a1 ) )
					          {    mistake( 112 );
						       return( ERROR );
					          }
					          erg = ecnfsnfneg( M, b1, b2, a1 );
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
					          if( !iselecnf( M, b1, B1, b2, B2, erg, a1 ) )
					          {    mistake( 112 );
						       return( ERROR );
					          }
					          erg = ecnfneg( M, b1, B1, b2, B2, erg, a1 );
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
			   { 	mistake( 45 );
				return( ERROR );
			   }
			   erg = lfirst( erg );
			   if( !a1 )    a1 = list3( 0, 1, 0 );
			   else
			   {    b1 = lcopy( a1 );
				a1 = lsuffix( b1, 1 );
			   }
			   if( r==(-14) )
			   {	a1 = togftyper(a1,t1,1);
				if(a1==ERROR) return(ERROR);
				t1 = t1-8;
			   }
			   switch( r )
			   {    case (-5): b1 = lfirst( erg );
					   b2 = lsecond( erg );
					   if( !iselecmpsnf( M, b1, b2, a1 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecmpsnfneg( M, b1, b2, a1 );
			   		   b1 = ecmpsrpp( M, erg );
					   break;
				case (-6): b1 = lfirst( erg );
					   B1 = lsecond( erg );
					   b2 = lthird( erg );
					   B2 = lfourth( erg );
					   erg = lfifth( erg );
					   if( !iselecmp( M, b1, B1, b2, B2, erg, a1 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecmpneg( M, b1, B1, b2, B2, erg, a1 );
			   		   b1 = ecmpsrpp( M, erg );
					   break;
				case (-14):b1 = lfirst( erg );
			   	           B1 = lsecond( erg );
			   	           b2 = lthird( erg );
			   	           B2 = lfourth( erg );
			   	           erg = lfifth( erg );
					   M = lfirst( varlist[gfsch].varwert );
			   	           if( !iselecgf2( M, b1, B1, b2, B2, erg, a1 ) )
			   	           {    mistake( 112 );
					        return( ERROR );
			   	           }
			   	           erg = ecgf2neg( M, b1, B1, b2, B2, erg, a1 );
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
			   {	a1 = togftyper(a1,t1,1);
				if(a1==ERROR) return(ERROR);
				t1 = t1-8;
			   }
			   switch( r )
			   {    case (-5): b1 = lfirst( erg );
					   b2 = lsecond( erg );
					   if( !iselecmpsnf( M, b1, b2, a1 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecmpsnfneg( M, b1, b2, a1 );
			   		   erg = ecmpsrpp( M, erg );
					   break;
				case (-6): b1 = lfirst( erg );
					   B1 = lsecond( erg );
					   b2 = lthird( erg );
					   B2 = lfourth( erg );
					   erg = lfifth( erg );
					   if( !iselecmp( M, b1, B1, b2, B2, erg, a1 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecmpneg( M, b1, B1, b2, B2, erg, a1 );
			   	           erg = ecmpsrpp( M, erg );
					   break;
				case (-14):b1 = lfirst( erg );
			   	           B1 = lsecond( erg );
			   	           b2 = lthird( erg );
			   	           B2 = lfourth( erg );
			   	           erg = lfifth( erg );
					   M = lfirst( varlist[gfsch].varwert );
			   	           if( !iselecgf2( M, b1, B1, b2, B2, erg, a1 ) )
			   	           {    mistake( 112 );
					        return( ERROR );
			   	           }
			   	           erg = ecgf2neg( M, b1, B1, b2, B2, erg, a1 );
			   	           b1 = ecgf2srpp( M, erg );
					   break;
			   }
			   break;
		case (-11):if( !ecsch )
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
			   b2 = itonf( 1 );
			   if( !a1 )    a1 = list3( 0, b2, 0 );
			   else
			   {    b1 = lcopy( a1 );
				a1 = lsuffix( b1, b2 );
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
					   if( !iselecnfsnf( M, b1, b2, a1 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecnfsnfneg( M, b1, b2, a1 );
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
					   if( !iselecnf( M, b1, B1, b2, B2, erg, a1 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecnfneg( M, b1, B1, b2, B2, erg, a1 );
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
					   if( !iselecnfsnf( M, b1, b2, a1 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecnfsnfneg( M, b1, b2, a1 );
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
					   if( !iselecnf( M, b1, B1, b2, B2, erg, a1 ) )
					   {    mistake( 112 );
						return( ERROR );
					   }
					   erg = ecnfneg( M, b1, B1, b2, B2, erg, a1 );
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
			   if( !a1 )    a1 = list3( 0, b2, 0 );
			   else
			   {    b1 = lcopy( a1 );
				a1 = lsuffix( b1, b2 );
			   }
			   b1 = lfirst( erg );
			   B1 = lsecond( erg );
			   b2 = lthird( erg );
			   B2 = lfourth( erg );
			   erg = lfifth( erg );
			   if( !iselecgf2( M, b1, B1, b2, B2, erg, a1 ) )
			   {    mistake( 112 );
				return( ERROR );
			   }
			   erg = ecgf2neg( M, b1, B1, b2, B2, erg, a1 );
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
			   b1 = lfirst( erg );
			   B1 = lsecond( erg );
			   b2 = lthird( erg );
			   B2 = lfourth( erg );
			   erg = lfifth( erg );
			   if( !iselecgf2( M, b1, B1, b2, B2, erg, a1 ) )
			   {    mistake( 112 );
				return( ERROR );
			   }
			   erg = ecgf2neg( M, b1, B1, b2, B2, erg, a1 );
			   erg = ecgf2srpp( M, erg );
			   break;
	}
	erg = list2( erg, t1 );
	return( erg );
}
