/*C
			calc_cons( a1, a2, t1, t2 )

	"calculator rational number construction"
	list calc_cons(a1,a2,t1,t2); obj a1,a2; single t1,t2;
	erg = calc_cons( a1, a2, t1, t2 );

	t1 bzw. t2 ist die Kennung des Objekts a1 bzw. a2.
	Das Objekt a2 wird durch das Objekt a1 dividiert.
	Dabei muss der Dividend stets ungleich 0 sein.
	Das Ergebnis wird mit maximaler Kennung der Variablen  'erg'
	zugeordnet. Die zugehoerige Kennung wird in kenntest ermittelt,
	das ausserhalb aufgerufen wird.
	Laeuft calc_cons fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      12.05.1987      H.Stroeher/M.Mang
	Version  2       8.02.1988      C.Hollinger/U.Schneiders
	Version  2.1    23.06.1988      C.Hollinger/U.Schneiders
	Version  3      12.07.1989      C.Hollinger/U.Schneiders
	Version  4      20.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  5      03.08.1992      U.Schneiders ( mod und nf )
	Version  6	15.07.1993	S.Schmitt ( gf )
	Version  6.1	15.01.1997	S.Schmitt ( Fehler beseitigt fuer
						    t3=38,39 )
H*/
 
#include <_calc.h>

list calc_cons( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen und Vorbesetzungen ***/

	obj erg, b1, b2, B1, B2, D, M;
	list VL;
	single r, t3, m, n, m1;
	init( erg, b1, b2, VL, B1, B2, D, M );
	bind( a1, a2 );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );
	if ( a1 == 0 )
	{       mistake( 10 );
		return( -BASIS );
	}
	if( ( t1>9 && t1<15 ) || ( t2>9 && t2<15 )
           || t1==21 || t1==22 || t1==28 || t1==29 || t1==35 || t1==36
           || t2==21 || t2==22 || t2==28 || t2==29 || t2==35 || t2==36 )
	{       mistake( 234 );
		return( -BASIS );
	}
	if( t1<0 || ( t2<0 && ( ( t2!=(-3) && t2!=(-4) ) || t1!=0 ) ) 
	    || t1==16 || t2==16 || t1==23 || t2==23 || t1==30 || t2==30 )
	{       mistake( 71 );
		return( ERROR );
	}
	if( t1>37 || ((t2==15 || t2>36) && t1!=0 && t1!=1 && t1!=15 && t1!=37)) 
	{       mistake( 71 );
		return( ERROR );
	}

	if(t2>=0) t3 = typer( a1, a2, t1, t2, &b1, &b2, 1 );
	else 
	{	t3=t2;
		b2=a2;
		b1=a1;
	}
	if( t3 == -BASIS ) return( -BASIS );

	if( t3 > 16 && t3 < 21 ) M = lfirst( varlist[modsch].varwert );
	else if( t3 > 23 && t3 < 28 ) M = lfirst( varlist[nfsch].varwert );
	else if( t3 > 30 && t3 < 35 ) M = lfirst( varlist[gfsch].varwert );	

	/* Beginn der Division */

	if( ( t3 > 4 && t3 < 10 ) || t3 == 19 || t3 == 20 || t3 == 26 || t3 == 27 || t3 == 33 || t3 == 34 )
	{       if( ( t3 > 6 && t3 < 10 ) || t3 == 20 || t3 == 27 || t3 == 34 )
		{       VL = lfirst( b1 );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			r = llength( VL );
		}
		if(t3==19 && M==2)
		{	m=llength(b1)-1;
			n=lfirst(b1);
		}
		else
		{	m = manrrow( b1 );
			n = manrcol( b1 );
		}
		if( m != n )
		{       mistake( 76 );
			return( -BASIS );
		}
		if(t3==19 && M==2) n=lfirst(b2);
		else 	n = manrcol( b2 );
		if( m != n )
		{       mistake( 72 );
			return( -BASIS );
		}
		switch( t3 )
		{       case 5: D = maidet( b1 );
				D = list2( D,0 );
				break;
			case 6: D = mardet( b1 );
				D = list2( D,1 );
				break;
			case 7: D = mapidet( r,b1 );
				D = list2( VL,D );
				D = list2( D,2 );
				break;
			case 8: D = maprdet( r,b1 );
				D = list2( VL,D );
				D = list2( D,3 );
				break;
			case 9: D = marfrdet( r,b1 );
				D = list2( VL,D );
				D = list2( D,4 );
				break;
			case 19:if(M==2)
				{	b1=mam2tomams(b1);
					D=mamsdet(M,b1);
					b1=mamstomam2(b1);
				}
				else if( ssch ) D = mamsdet( M, b1 );
				else	   D = mamidet( M, b1 );
				D = list2( D, 17 );
				break;
			case 20:if( ssch ) D = mapmsdet( r, M, b1 );
				else       D = mapmidet( r, M, b1 );
				D = list2( VL, D );
				D = list2( D, 18 );
				break;
			case 26:D = manfdet( M, b1 );
				D = list2( D, 24 );
				break;
			case 27:D = mapnfdet( r, M, b1 );
				D = list2( VL, D );
				D = list2( D, 25 );
				break;
			case 33:if(gfchar==2) D=magf2det(M,b1);
				else D = magfsdet( gfchar, M, b1 );
				D = list2( D, 31 );
				break;
			case 34:if(gfchar==2) D=mapgf2det(r,M,b1);
				else D = mapgfsdet( r, gfchar, M, b1 );
				D = list2( VL, D );
				D = list2( D, 32 );
				break;
		}
		D = kenntest( D );
		m1 = lsecond( D );
		D = lfirst( D );
		if( !D )
		{       mistake( 76 );
			return( -BASIS );
		}
	}

	switch( t3 )
	{       case (-3):
		case (-4):mistake(38);
			  return(ERROR);
			  break;
	  /***  case (-3):
		case (-4):if(!issingle(b1))
			  {	mistake(127);
				return(ERROR);
			  }
			  if(!ecsch)
			  {	mistake(111);
				return(ERROR);
			  }
			  M=lfirst(varlist[ecsch].varwert);
			  if(!isponecrac(M,b2))
			  {	mistake(112);
				return(ERROR);
			  }
			  VL=lfirst(lfirst(M));
			  while(VL!=_0)
			  {	erg=lfirst(VL);
				VL=lred(VL);
				if(erg && lsecond(erg)!=1)
				{	mistake(332);
					return(ERROR);
				}
			  }
			  erg=ecimina1(M);
			  VL=ecracbtmin(M);
			  b2=ecrbtp(b2,VL);
			  if(!lthird(b2))***/  /** P=O **/
	/**		  {	erg=list2(b2,t3);
				break;
			  }	
			  erg=ecimindiv(M,b2,b1);
			  if(erg==ERROR) return(ERROR);
			  if(llength(erg)!=3)
			  {	if(!assch){
				printf(" The point PT(");
				if(ps) fprintf(datei,"out: The point PT(");
				VL=lfirst(b2);
				D=lsecond(b2);
				B1=lthird(b2);
				if(t3==(-3))
				{  b2=iprod(B1,B1);
				   VL=rcons(VL,b2);
				   b2=iprod(B1,b2);
				   D=rcons(D,b2);
				   putr(VL);
				   printf(", ");
				   putr(D);
				   if(ps)
				   {  fputr(VL,datei);
				      fprintf(datei,", ");
				      fputr(D,datei);
				   }
				}
				else
				{  VL=rcons(VL,B1);
				   b2=iprod(B1,B1);
				   D=rcons(D,b2);
				   putr(VL);
				   printf(", ");
				   putr(D);
				   printf(", ");
				   puti(B1);
				   if(ps)
				   {  fputr(VL,datei);
				      fprintf(datei,", ");
				      fputr(D,datei);
				      fprintf(datei,", ");
				      fputi(B1,datei);
				   }
				}
			        printf(") is not divisible by %i !\n",b1);
			       	if(ps) fprintf(datei,") is not divisible by %i !\n",b1);
				} 
				return(ERROR);
			  }
			  if(!oequal(VL,list4(0,0,0,1)))
			  {	b1=lfirst(VL);
				b2=lsecond(VL);	
				B1=lthird(VL);
				B2=lfourth(VL);
				b1=rneg(b1);
				b2=rneg(b2);
				b2=rprod(b2,B2);
				B2=rinv(B2);
				D=rprod(B2,B2);
				D=rprod(B2,D);
				B1=rneg(B1);
				B1=rprod(B1,D);
				VL=list4(b1,b2,B1,B2);
				erg=ecrbtp(erg,VL);
			  }
			  erg=list2(erg,t3);
			  break;**/
		case 0: erg = rcons( b2,b1 );
			erg = list2( erg,1 );
			break;
		case 1: erg = rquot( b2,b1 );
			erg = list2( erg,1 );
			break;
		case 2: VL = lfirst( b1 );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			r = llength( VL );
			erg = rfrcons( r, b2, b1 );
			erg = list2( VL,erg );
			erg = list2( erg,4 );
			break;
		case 3: VL = lfirst( b1 );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			r = llength( VL );
			b1 = prtorfr( r,b1 );
			b2 = prtorfr( r,b2 );
			erg = rfrquot( r, b2, b1 );
			erg = list2( VL,erg );
			erg = list2( erg,4 );
			break;
		case 4: VL = lfirst( b1 );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			r = llength( VL );
			if(b1) B1 = lfirst( b1 );
			if(b2) B2 = lsecond( b2 );
			if( !expover( r, B1, B2 ) ) return( -BASIS );
			if(b1) B1 = lsecond( b1 );
			if(b2) B2 = lfirst( b2 );
			if( !expover( r, B1, B2 ) ) return( -BASIS );
			erg = rfrquot( r, b2, b1 );
			erg = list2( VL,erg );
			erg = list2( erg,4 );
			break;
		case 5: if( D != 1 && D != -1 )
			{       b1 = maitomar( b1 );
				b2 = maitomar( b2 );
				b1 = marinv( b1 );
				erg = marprod( b2,b1 );
				erg = list2( erg,6 );
			}
			else
			{       b1 = maiinv( b1 );
				erg = maiprod( b2,b1 );
				erg = list2( erg,5 );
			}
			break;
		case 6: b1 = marinv( b1 );
			erg = marprod( b2,b1 );
			erg = list2( erg,6 );
			break;
		case 7: if( !m1 && D != 1 && D != -1 )
			{       b1 = mapitomapr( r, b1 );
				b2 = mapitomapr( r, b2 );
				b1 = maprinv( r, b1 );
				erg = maprprod( r, b2, b1 );
				erg = list2( VL, erg );
				erg = list2( erg, 8 );
			}
			else if( m1 == 2 )
			{       b1 = mapitomarfr( r,b1 );
				b2 = mapitomarfr( r,b2 );
				b1 = marfrinv( r,b1 );
				erg = marfrprod( r, b2, b1 );
				erg = list2( VL,erg );
				erg = list2( erg,9 );
			}
			else
			{       b1 = mapiinv( r,b1 );
				erg = mapiprod( r, b2, b1 );
				erg = list2( VL,erg );
				erg = list2( erg,7 );
			}
			break;
		case 8: if( m1 == 1 )
			{       b1 = maprinv( r,b1 );
				erg = maprprod( r, b2, b1 );
				erg = list2( VL,erg );
				erg = list2( erg,8 );
			}
			else
			{       b1 = maprtomarfr( r,b1 );
				b2 = maprtomarfr( r,b2 );
				b1 = marfrinv( r,b1 );
				erg = marfrprod( r, b2, b1 );
				erg = list2( VL,erg );
				erg = list2( erg,9 );
			}
			break;
		case 9: b1 = marfrinv( r,b1 );
			erg = marfrprod( r, b2, b1 );
			erg = list2( VL,erg );
			erg = list2( erg,9 );
			break;
		case 15:erg = flquot( b2,b1 );
			erg = list2( erg, 15 );
			break;
		case 37:erg = cquot(b2, b1);
			erg = list2(erg,37);
			break;
		case 17:if( igcd( b1, M ) != 1 )
			{	mistake( 168 );
				return( ERROR );
			}
			if( ssch ) erg = msquot( M, b2, b1 );
			else       erg = miquot( M, b2, b1 );
			erg = list2( erg, 17 );
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
				VL=lfirst(b2);
				r=llength(VL);
				b2=lsecond(b2);
				if(ssch) 
				{	b1=mshom(M,a1);
					erg=pmsmsquot(r,M,b2,b1);
				}
				else
				{	b1=mihom(M,a1);
					erg=pmimiquot(r,M,b2,b1);
				}
				erg=list2(VL,erg);
				erg=list2(erg,18);
				break;
			}
			VL = lfirst( b1 );
			r = llength( VL );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );	
			if( ssch )  erg = pmsqrem( r, M, b2, b1, &D );
			else 	    erg = pmiqrem( r, M, b2, b1, &D );
			if( D )
			{	mistake( 160 );
				return( ERROR );
			}
			erg = list2( VL, erg );
			erg = list2( erg, 18 );
			break;
		case 19:if( igcd( D, M ) != 1 )
			{	mistake( 169 );
				return( ERROR );
			}
			if(M==2)
			{	b1=mam2inv(b1);
				erg=mam2prod(b2,b1);
			}
			else if( ssch ) 
			{	b1 = mamsinv( M, b1 );
				erg = mamsprod( M, b2, b1 );
			}
			else
			{	b1 = mamiinv( M, b1 );
				erg = mamiprod( M, b2, b1 );
			}
			erg = list2( erg, 19 );
			break;
		case 20:if( ( m1 == 17 && igcd( D, M ) != 1 ) || m1 == 18 )
			{	mistake( 169 );
				return( ERROR );
			}
                  /*	if( m1 == 18 )
			{	B1 = lfirst( D );
				D = lsecond( D );
				m = llength( B1 );
                                if( ( ssch  && !ispmsunit( m, M, D ) ) || ( !ssch && !ispmiunit( m, M, D ) ) )
				{	mistake( 169 );
					return( ERROR );
				}
			}  */ 
			if( ssch )
			{	b1 = mapmsinv( r, M, b1 );
				erg = mapmsprod( r, M, b2, b1 );
			}
			else
			{	b1 = mapmiinv( r, M, b1 );
				erg = mapmiprod( r, M, b2, b1 );
			}
			erg = list2( VL, erg );
			erg = list2( erg, 20 );
			break;
		case 24:erg = nfquot( M, b2, b1 );
			erg = list2( erg, 24 );
			break;
		case 25:VL = lfirst( b1 );
			r = llength( VL );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );	
		        erg = pnfqrem( r, M, b2, b1, &D );
			if( D )
			{	mistake( 170 );
				return( ERROR );
			}
			erg = list2( VL, erg );
			erg = list2( erg, 25 );
			break;
		case 26:b1 = manfinv( M, b1 );
			erg = manfprod( M, b2, b1 );
			erg = list2( erg, 26 );
			break;
		case 27:if( m1 == 25 )
			{	mistake( 169 );
				return( ERROR );
			}
			b1 = mapnfinv( r, M, b1 );
			erg = mapnfprod( r, M, b2, b1 );
			erg = list2( VL, erg );
			erg = list2( erg, 27 );
			break;
		case 31:if( gfchar == 2 ) erg = gf2quot( M, b2, b1 );
			else erg = gfsquot( gfchar, M, b2, b1 );
			erg = list2( erg, 31 );
			break;
		case 32:VL = lfirst(b1);
			b1 = lsecond(b1);
			b2 = lsecond(b2);
			r = llength(VL);
			if( gfchar == 2 ) erg = pgf2qrem( r, M, b2, b1, &D );
			else erg = pgfsqrem( r, gfchar, M, b2, b1, &D );
			if( D )
			{	mistake( 160 );
				return( ERROR );
			}
			erg = list2( VL, erg );
			erg = list2( erg, 32 );
			break;
		case 33:if(gfchar==2)
			{ 	b1=magf2inv(M,b1);
				erg=magf2prod(M,b2,b1);
			}
			else
			{	b1 = magfsinv( gfchar, M, b1 );
				erg = magfsprod( gfchar, M, b2, b1 );
			}
			erg = list2( erg, 33 );
			break;
		case 34:if( m1 == 32 )
			{	mistake( 169 );
				return( ERROR );
			}
			if(gfchar==2)
			{ 	b1=mapgf2inv(r,M,b1);
				erg=mapgf2prod(r,M,b2,b1);
			}
			else
			{	b1 = mapgfsinv( r, gfchar, M, b1 );
				erg = mapgfsprod( r, gfchar, M, b2, b1 );
			}
			erg = list2( VL, erg );
			erg = list2( erg, 34 );
			break;
		case 38:VL = lfirst( b1 );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			r = llength( VL );
			for(m=1;m<=r;m++) b1=lsecond(b1);
			erg=itofl(1);
			b1=flquot(erg,b1);
			erg=pflflprod(r,b2,b1);
			erg=list2(VL,erg);
			erg=list2(erg,38);
			break;
		case 39:VL = lfirst( b1 );
			b1 = lsecond( b1 );
			b2 = lsecond( b2 );
			r = llength( VL );
			for(m=1;m<=r;m++) b1=lsecond(b1);
			erg=itoc(1);
			b1=cquot(erg,b1);
			erg=pccprod(r,b2,b1);
			erg=list2(VL,erg);
			erg=list2(erg,39);
			break;
	}
	return( erg );
}
