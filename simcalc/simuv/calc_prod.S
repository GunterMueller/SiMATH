/*C
			calc_prod( a1, a2, t1, t2 )

	"calculator product".
	list calc_prod(a1,a2,t1,t2); obj a1, a2; single t1, t2;
	erg = calc_prod( a1, a2, t1, t2 );
	t1 bzw. t2 ist die Kennung des Objekts a1 bzw. a2.
	Berechnet wird das Produkt von a1 und a2.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen
	'erg' zugeordnet.
	Laeuft calc_prod fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  2      23.06.1988      C.Hollinger/U.Schneiders
	Version  3      26.04.1989      C.Hollinger/U.Schneiders
	Version  3.1    05.06.1989      C.Hollinger
	Version  4      12.07.1989      C.Hollinger/U.Schneiders
	Version  5      28.11.1990      U.Schneiders
	Version  6      20.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  7      20.07.1992      U.Schneiders ( nf und mod )
	Version  7.1	13.04.1993	S.Schmitt
	Version  8	05.07.1993	S.Schmitt ( gf )
	Version  8.1	12.07.1993	U.Schneiders
	Version  8.2	07.12.1993	U.Schneiders (tonf)
	Version  9	13.01.1994	S.Schmitt/U.Schneiders
	Version  9.1	29.12.1994	U.Schneiders (togf)
	Version  10	24.01.1995	S.Schmitt/U.Schneiders
					(Polynome ueber R und C)
	Version  10.1	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/
 
#include <_calc.h>

list calc_prod( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj erg, b1, b2, B1, B2;
	list VL;
	pol F;
	int p, M;
	single r, t3, n, m;
	bind( a1, a2 );
	init( erg, b1, b2, B1, B2, VL, F, p, M );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );

	if(t2<0 && t1>=0)
	{	b1=a1; a1=a2; a2=b1;
		t3=t1; t1=t2; t2=t3;
	}

	/*** a1 und a2 Vektoren ***/
	if( ( t1 > 9 && t1 < 15 && t2 > 9 && t2 < 15 ) 
         || ( t1 > 20 && t1 < 23 && t2 > 20 && t2 < 23 )
	 || ( t1 > 27 && t1 < 30 && t2 > 27 && t2 < 30 )
	 || ( t1 > 34 && t1 < 37 && t2 > 34 && t2 < 37 ) 
	 || ( t1 > 9 && t1 < 14 && ( t2 == 21 || t2 == 22 || t2 == 28 || t2 == 29 || t2 == 35 || t2 == 36 ) ) 
	 || ( t2 > 9 && t2 < 14 && ( t1 == 21 || t1 == 22 || t1 == 28 || t1 == 29 || t1 == 35 || t2 == 36 ) )
	 || ( ( t1 == 21 || t1 == 22 ) && ( t2 == 35 || t2 == 36 ) )
	 || ( ( t2 == 21 || t2 == 22 ) && ( t1 == 35 || t1 == 36 ) ) )
	{       mistake( 256 );
		return( -BASIS );
	}

	/*** Skalarmultiplikation. ***/

	if( ( ( ( t1 >= 0 && t1 < 5 ) || t1 == 17 || t1 == 18 || t1 == 24 || t1 == 25 || t1 == 31 || t1 == 32 )
           && ( ( t2 >=5 && t2 < 15 ) || ( t2 > 18 && t2 < 23 ) || ( t2 > 25 && t2 < 30 ) || ( t2 > 32 && t2 < 37 ) ) )
	 || ( ( ( t2 >= 0 && t2 < 5 ) || t2 == 17 || t2 == 18 || t2 == 24 || t2 == 25 || t2 == 31 || t2 == 32 )
           && ( ( t1 >=5 && t1 < 15 ) || ( t1 > 18 && t1 < 23 ) || ( t1 > 25 && t1 < 30 ) || ( t1 > 32 && t1 < 37 ) ) ) )
	{       erg = calc_smul( a1, a2, t1, t2 );
		return( erg );
	}

	/*** Matrix-Vektorprodukt. ***/

	else if( ( ( (t1 > 4 && t1 < 10) || t1 == 19 || t1 == 20 || t1 == 26 || t1 == 27 || t1 == 33 || t1 == 34 )
                && ( (t2 > 9 && t2 < 15) || t2 == 21 || t2 == 22 || t2 == 28 || t2 == 29 || t2 == 35 || t2 == 36 ) )
	      || ( ( (t2 > 4 && t2 < 10) || t2 == 19 || t2 == 20 || t2 == 26 || t2 == 27 || t2 == 33 || t2 == 34 )
                && ( (t1 > 9 && t1 < 15) || t1 == 21 || t1 == 22 || t1 == 28 || t1 == 29 || t1 == 35 || t1 == 36 ) ) )
	{       erg = calc_mvprod( a1, a2, t1, t2 );
		return( erg );
	}

	/*** Punktmultiplikation fuer elliptische Kurven ***/

	else if( (!t2 || t2==1) && ( t1 > (-5) && t1 < (-2) ) )
	{       if( (!t2 && !issingle( a2 )) || (t2==1 && !issingle(lfirst(a2)) && !issingle(lsecond(a2))) )
		{       mistake( 127 );
			return( ERROR );
		}
		if(t2==1)
		{	B2=lsecond(a2);
			a2=lfirst(a2);
			b2=calc_cons(B2,a1,0,t1);
			if(b2==ERROR) return(ERROR);
			if(a2==1) return(b2);
			t2=0;
			a1=lfirst(b2);
		}
		if( !ecsch )
		{    mistake( 111 );
		     return( ERROR );
	        }
		erg = varlist[ecsch].varwert;
	        r = lsecond( erg );
	        erg = lfirst( erg );
		if( r != (-1) && r != (-2) && r != (-9) && r != (-10) )
		{	mistake( 45 );
			return( ERROR );
		}
		if( r > (-3 ) )
		{	if(!isponecrac(erg,a1))
			{	mistake(112);
				return(ERROR);
			}
			erg=ecracmul(erg,a1,a2);
			erg=list2(erg,t1);	
			return( erg );
		}
		a1 = tonftyper( a1, t1 );
		t1 = t1 - 8;
	}
	else if( !t2 && ( t1 > (-9) && t1 < (-6) ) )
	{  /*     if( !issingle( a2 ) )
		{       mistake( 127 );
			return( ERROR );
		} */
		if( !ecsch )
		{    mistake( 111 );
		     return( ERROR );
	        }
		erg = varlist[ecsch].varwert;
	        r = lsecond( erg );
	        erg = lfirst( erg );
		if( r != (-5) && r != (-6) && r != (-14) )
		{	mistake( 45 );
			return( ERROR );
		}
	        if( r==(-14) )
		{	a1 = togftyper(a1,t1,1);
			if(a1==ERROR) return(ERROR);
			t1 = t1-8;
		}
		else 
		{
		if(isign(a2)<0)
		{	a2 = iabs(a2);
			m=1;
		}
		else m=0;
		p = lfirst( varlist[modsch].varwert );

		switch( t1 )
		{       case (-7): if( !a1 )  a1 = list3( 0, 1, 0 );
				   else
				   {    b1 = lcopy( a1 );
					a1 = lsuffix( b1, 1 );
				   }
				   switch( r )
				   {    case (-5): b1 = lfirst( erg );
						   b2 = lsecond( erg );
						   if( !iselecmpsnf( p, b1, b2, a1 ) )
						   {    mistake( 112 );
							return( ERROR );
						   }
						   erg = ecmpsnfmul( p, b1, b2, a2, a1 );
						   if(m) erg = ecmpsnfneg(p,b1,b2,erg);
						   break;
					case (-6): b1 = lfirst( erg );
						   B1 = lsecond( erg );
						   b2 = lthird( erg );
						   B2 = lfourth( erg );
						   erg = lfifth( erg );
						   if( !iselecmp( p, b1, B1, b2, B2, erg, a1 ) )
						   {    mistake( 112 );
							return( ERROR );
						   }
						   F = ecmpmul( p, b1, B1, b2, B2, erg, a2, a1 );
						   if(m) erg = ecmpneg(p, b1, B1, b2, B2, erg, F );
						   else erg = F;
						   break;
				   }
				   b1 = ecmpsrpp( p, erg );
				   if( !lthird( b1 ) )  erg = 0;
				   else
				   {    B1 = lfirst( b1 );
					B2 = lsecond( b1 );
					erg = list2( B1, B2 );
				   }
				   break;
			case (-8): switch( r )
				   {    case (-5): b1 = lfirst( erg );
						   b2 = lsecond( erg );
						   if( !iselecmpsnf( p, b1, b2, a1 ) )
						   {    mistake( 112 );
							return( ERROR );
						   }
						   erg = ecmpsnfmul( p, b1, b2, a2, a1 );
						   if(m) erg = ecmpsnfneg(p, b1, b2, erg);
						   break;
					case (-6): b1 = lfirst( erg );
						   B1 = lsecond( erg );
						   b2 = lthird( erg );
						   B2 = lfourth( erg );
						   erg = lfifth( erg );
						   if( !iselecmp( p, b1, B1, b2, B2, erg, a1 ) )
						   {    mistake( 112 );
							return( ERROR );
						   }
						   F = ecmpmul( p, b1, B1, b2, B2, erg, a2, a1 );
						   if(m) erg = ecmpneg(p, b1, B1, b2, B2, erg, F);
					           else erg = F;
						   break;
				   }
				   erg = ecmpsrpp( p, erg );
				   break;
		}
		erg = list2( erg, t1 );
		return( erg );
		}
	}
	if( !t2 && ( t1 > (-13) && t1 < (-10) ) )
	{       if( !issingle( a2 ) )
		{       mistake( 127 );
			return( ERROR );
		}
		if( !ecsch )
		{    mistake( 111 );
		     return( ERROR );
	        }
		erg = varlist[ecsch].varwert;
	        r = lsecond( erg );
	        erg = lfirst( erg );
		if( r != (-9) && r != (-10) && r != (-1) && r != (-2) )
		{	mistake( 45 );
			return( ERROR );
		}
		if( r > (-3) )
		{	erg = tonftyper( erg, r );
			r = r - 8;
		}
		F = lfirst( varlist[nfsch].varwert );
		if(ecqnfsch!=_0)
		{	erg = lfirst(erg);
			erg = lfirst(erg);
			if(r==(-9)) erg = lred3(erg);
		}
		if(a2<0) 
		{	a2 = sabs(a2);
			m=1;
		}	
		else m=0;

		switch( t1 )
		{       case (-11):VL = itonf( 1 );
				   if( !a1 )  a1 = list3( 0, VL, 0 );
				   else
				   {    p = lcopy( a1 );
					a1 = lsuffix( p, VL );
				   }
				   switch( r )
				   {    case (-9): b1 = lfirst( erg );
						   b2 = lsecond( erg );
						   if(llength(ecqnfsch)==3)
						   {  b1=qnftonf(b1,24);
						      b2=qnftonf(b2,24);
						   }
						   if( !iselecnfsnf( F, b1, b2, a1 ) )
						   {    mistake( 112 );
							return( ERROR );
						   }
						   erg = ecnfsnfmul( F, b1, b2, a2, a1 );
						   if(m) erg = ecnfsnfneg(F, b1, b2, erg );
						   break;
					case (-10):b1 = lfirst( erg );
						   B1 = lsecond( erg );
						   b2 = lthird( erg );
						   B2 = lfourth( erg );
						   erg = lfifth( erg );
						   if(llength(ecqnfsch)==3)
						   {  b1=qnftonf(b1,24);
						      b2=qnftonf(b2,24);
						      B1=qnftonf(B1,24);
						      B2=qnftonf(B2,24);
						      erg=qnftonf(erg,24);
						   }
						   if( !iselecnf( F, b1, B1, b2, B2, erg, a1 ) )
						   {    mistake( 112 );
							return( ERROR );
						   }
						   VL = ecnfmul( F, b1, B1, b2, B2, erg, a2, a1 );
						   if(m) erg = ecnfneg(F, b1, B1, b2, B2, erg, VL);
						   else erg = VL;
						   break;
				   }
				   b1 = ecnfsrpp( F, erg );
				   if( !lthird( b1 ) )  erg = 0;
				   else
				   {    B1 = lfirst( b1 );
					B2 = lsecond( b1 );
					erg = list2( B1, B2 );
				   }
				   break;
			case (-12):switch( r )
				   {    case (-9): b1 = lfirst( erg );
						   b2 = lsecond( erg );
						   if(llength(ecqnfsch)==3)
						   {  b1=qnftonf(b1,24);
						      b2=qnftonf(b2,24);
						   }
						   if( !iselecnfsnf( F, b1, b2, a1 ) )
						   {    mistake( 112 );
							return( ERROR );
						   }
						   erg = ecnfsnfmul( F, b1, b2, a2, a1 );
						   if(m) erg = ecnfsnfneg(F, b1, b2, erg);
						   break;
					case (-10):b1 = lfirst( erg );
						   B1 = lsecond( erg );
						   b2 = lthird( erg );
						   B2 = lfourth( erg );
						   erg = lfifth( erg );
						   if(llength(ecqnfsch)==3)
						   {  b1=qnftonf(b1,24);
						      b2=qnftonf(b2,24);
						      B1=qnftonf(B1,24);
						      B2=qnftonf(B2,24);
						      erg=qnftonf(erg,24);
						   }
						   if( !iselecnf( F, b1, B1, b2, B2, erg, a1 ) )
						   {    mistake( 112 );
							return( ERROR );
						   }
						   VL = ecnfmul( F, b1, B1, b2, B2, erg, a2, a1 );
						   if(m) erg = ecnfneg(F, b1, B1, b2, B2, erg, VL);
						   else erg = VL;
						   break;
				   }
				   erg = ecnfsrpp( F, erg );
				   break;
		}
		erg = list2( erg, t1 );
		return( erg );
	}
	else if( !t2 && ( t1 == (-15) || t1 == (-16) ) )
	{      /* if( !issingle( a2 ) )
		{       mistake( 127 );
			return( ERROR );
		} */
		if( !ecsch )
		{    mistake( 111 );
		     return( ERROR );
	        }
		erg = varlist[ecsch].varwert;
	        r = lsecond( erg );
	        erg = lfirst( erg );
		if( r != (-14) && r != (-6) )
		{	mistake( 45 );
			return( ERROR );
		}
		if( r==(-6) )
		{	erg = togftyper(erg,r,1);
			if(erg==ERROR) return(ERROR);
			r=r-8;
		}
		F = lfirst( varlist[gfsch].varwert );
		if(isign(a2)<0)
		{	a2 = iabs(a2);
			m=1;
		}
		else m=0;

		switch( t1 )
		{       case (-15):b2 = list2( 0, 1);
				   b2 = udpm2tosb( b2 );
				   if( !a1 )  a1 = list3( 0, b2, 0 );
				   else
				   {    b1 = lcopy( a1 );
					a1 = lsuffix( b1, b2 );
				   }
				   b1 = lfirst( erg );
				   B1 = lsecond( erg );
				   b2 = lthird( erg );
				   B2 = lfourth( erg );
				   erg = lfifth( erg );
				   if( !iselecgf2( F, b1, B1, b2, B2, erg, a1 ) )
				   {    mistake( 112 );
					return( ERROR );
				   }
				   VL = ecgf2mul( F, b1, B1, b2, B2, erg, a2, a1 );
				   if(m) erg = ecgf2neg(F, b1, B2, b2, B2, erg, VL);
				   else erg = VL; 
				   b1 = ecgf2srpp( F, erg );
				   if( !lthird( b1 ) )  erg = 0;
				   else
				   {    B1 = lfirst( b1 );
					B2 = lsecond( b1 );
					erg = list2( B1, B2 );
				   }
				   break;
			case (-16):b1 = lfirst( erg );
			           B1 = lsecond( erg );
				   b2 = lthird( erg );
				   B2 = lfourth( erg );
				   erg = lfifth( erg );
				   if( !iselecgf2( F, b1, B1, b2, B2, erg, a1 ) )
				   {    mistake( 112 );
					return( ERROR );
				   }
				   VL = ecgf2mul( F, b1, B1, b2, B2, erg, a2, a1 );
				   if(m) erg = ecgf2neg(F, b1, B1, b2, B2, erg, VL);
				   else erg = VL;
				   erg = ecgf2srpp( F, erg );
				   break;
		}
		erg = list2( erg, t1 );
		return( erg );
	}

	else if( t2 < 0 || t1 < 0 || t2 > 39 || t1 > 39 )
	{       mistake( 71 );
		return( ERROR );
	}

	t3 = typer( a1, a2, t1, t2, &b1, &b2, 1 );
	if( t3 == -BASIS )      return( -BASIS );

	/*** Ueberpruefung der Dimensionen. ***/

	if( ( t3 > 1 && t3 < 5 ) || ( t3 > 6 && t3 < 10 )
           || t3 == 18 || t3 == 20 || t3 == 25 || t3 == 27
	   || t3 == 32 || t3 == 34 || t3 == 38 || t3 == 39 )
	{       VL = lfirst( b1 );
		r = llength( VL );
		b1 = lsecond( b1 );
		b2 = lsecond( b2 );
	}

	/*** Man braucht M schon hier wegen der speziellen Bit-Darstellung
		von Matrizen ueber Z/2Z.				***/

	if( t3 > 16 && t3 < 21 )
		M = lfirst( varlist[modsch].varwert );

	if( ( t3 > 4  && t3 < 10 ) || t3 == 19 || t3 == 20 
           || t3 == 26 || t3 == 27 || t3 == 33 || t3 == 34 )
	{       if(t3==19 && M==2)
		{	n=lfirst(b2);
			m=llength(b1)-1;
		}
		else
		{	n = manrcol( b2 );
			m = manrrow( b1 );
		}
		if( n != m )
		{       mistake( 72 );
			return( -BASIS );
		}
	}

	if( t3 > 23 && t3 < 28 )
		F = lfirst( varlist[nfsch].varwert );
	else if( t3 > 30 && t3 < 37 )
		M = lfirst( varlist[gfsch].varwert );

	/*** Multiplikation. ***/

	switch( t3 )
	{       case 0: erg = iprod( b1, b2 );
			break;
		case 1: erg = rprod( b1, b2 );
			break;
		case 2: if( !expover( r, b1, b2 ) ) return( -BASIS );
			erg = piprod( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 3: if( !expover( r, b1, b2 ) ) return( -BASIS );
			erg = prprod( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 4: if(b1) B1 = lfirst( b1 );
			if(b2) B2 = lfirst( b2 );
			if( !expover( r, B1, B2 ) ) return( -BASIS );
			if(b1) B1 = lsecond( b1 );
			if(b2) B2 = lsecond( b2 );
			if( !expover( r, B1, B2 ) ) return( -BASIS );
			erg = rfrprod( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 5: erg = maiprod( b2, b1 );
			break;
		case 6: erg = marprod( b2, b1 );
			break;
		case 7: erg = mapiprod( r, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 8: erg = maprprod( r, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 9: erg = marfrprod( r, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 15:erg = flprod( b2, b1 );
			break;
		case 17:if( ssch ) erg = msprod( M, b2, b1 );
			else       erg = miprod( M, b2, b1 );
			break;
		case 18:if( ssch ) erg = pmsprod( r, M, b2, b1 );
			else       erg = pmiprod( r, M, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 19:if(M==2) erg=mam2prod(b2,b1);
			else if( ssch ) erg = mamsprod( M, b2, b1 );
			else       erg = mamiprod( M, b2, b1 );
			break;
		case 20:if( ssch ) erg = mapmsprod( r, M, b2, b1 );
			else       erg = mapmiprod( r, M, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 24:erg = nfprod( F, b2, b1 );
			break;
		case 25:erg = pnfprod( r, F, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 26:erg = manfprod( F, b2, b1 );
			break;
		case 27:erg = mapnfprod( r, F, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 31:if( gfchar == 2 )  erg = gf2prod( M, b1, b2 );
			else  erg = gfsprod( gfchar, M, b1, b2 );
			break;
		case 32:if( !expover( r, b1, b2 ) ) return( ERROR );
			if(gfchar == 2 )  erg = pgf2prod( r, M, b1, b2 );
			else  erg = pgfsprod( r, gfchar, M, b1, b2 );	
			erg = list2( VL, erg );
			break;
		case 33:if(gfchar==2) erg=magf2prod(M,b2,b1);
			else erg = magfsprod( gfchar, M, b2, b1 );
			break;
		case 34:if(gfchar==2) erg=mapgf2prod(r,M,b2,b1);
			else erg = mapgfsprod( r, gfchar, M, b2, b1 );
			erg = list2( VL, erg );
			break;
		case 37:erg = cprod(b2, b1);
			break;
		case 38:if( !expover( r, b1, b2 ) ) return( -BASIS );
			erg = pflprod( r, b1, b2 );
			erg = list2( VL, erg );
			break;
		case 39:if( !expover( r, b1, b2 ) ) return( -BASIS );
			erg = pcprod( r, b1, b2 );
			erg = list2( VL, erg );
			break;
	}
	erg = list2( erg, t3 );
	return( erg );
}
