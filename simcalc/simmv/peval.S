/*C
			peval( VL, P, kenP, wert, pos )

	"polynomial evaluation "
	list peval( VL, P, kenP, wert, pos );
	list VL, P,wert;
	single kenP, *pos;

	peval wertet das Polynom, die rationale Funktion, die Matrix
	oder den Vektor P mit der Variablenliste VL und Kennung
	kenP fuer die Variablen, deren Adressen in pos stehen,
	mit dem Wert wert aus. Ist wert undefiniert, so ergibt sich
	wert zu dem Polynom, das aus dem letzten  Eintrag in pos
	resultiert. pos wird um diese letzte Position gekuerzt.
	Auswertung erfolgt dann wie oben. Dabei wird das aus-
	gewertete Struktur P mit angepasster Kennung zurueckgegeben.
	Laeuft die Auswertung fehlerhaft ab, so wird -BASIS
	zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1     18.01.88         C.Hollinger/U.Schneiders
	Version  2     15.03.88         C.Hollinger/U.Schneiders
	Version  3     30.10.89         C.Hollinger/U.Schneiders
					( Matrizen und Vektoren )
	Version  4     22.09.92         U.Schneiders ( mod und nf )
	Version  5     27.07.93         U.Schneiders ( gf )
	Version  6     01.02.95		S.Schmitt ( R und C )
H*/
 
#include<_calc.h>

list peval( VL, P, kenP, wert, pos )
list VL, P;
single kenP;
list wert;
single *pos;

{       single kenw, r, i, h, rw;
	list V, Vw, VP;
	obj w1, M, N;
	init( w1, M, N, V, Vw, VP );
	bind( VL, P, wert );

	r = llength( VL );
	if( wert == _0 )
	{       i = 0;
		while( pos[ i ] != -1 )   i++;
		h = pos[ i-1 ];
		pos[ i-1 ] = -1;
		V = lelt( VL, h );
		V = list1( V );
		wert = list2( 1, 1 );
		wert = list2( V, wert );
		wert = list2( wert, 2 );
	}
	kenw = lsecond( wert );

	if( ( ( kenP == 4 || kenP == 9 || kenP == 14 ) && kenw > 4 )
         || ( kenP>17 && kenP<23 
		&& kenw>4 && kenw!=17 && kenw!=18 && kenw!=31 && kenw!=32 )
	 || ( kenP>24 && kenP<30 
		&& ( ( kenw>15 && kenw<24 ) || ( kenw>25 && kenw<37 ) ) )
	 || ( kenP>31 && kenP<37 
		&& ( kenw==15 || ( kenw>18 && kenw<31 ) || kenw>32) )
	 || ( ( kenP==38 || kenP==39 ) 
		&& kenw>4 && kenw!=15 && kenw!=24 && kenw!=25 && kenw<37 ) )
	{	mistake( 71 );
		return( ERROR );
	}

	if( kenw == 4 && ( kenP > 17 && kenP < 23 ) )
	{	mistake( 160 );
		return( ERROR );
	}
	if( kenw == 4 && ( kenP > 24 && kenP < 30 ) )
	{	mistake( 170 );
		return( ERROR );
	}
	if( kenw == 4 && ( kenP > 30 && kenP < 37 ) )
	{	mistake( 160 );
		return( ERROR );
	}
	if( kenw == 4 && ( kenP==38 || kenP==39 ) )
	{	mistake( 160 );
		return( ERROR );
	}
	if( ( ( kenP>25 && kenP<30) || ( kenP>4 && kenP<15 ) )
	   && ( kenw==15 || kenw>36 ) )
	{	mistake(77);
		return(ERROR);
	}
	if( ( ( kenP==38 || kenP==39 ) && ( kenw==24 || kenw==25 ) )
	 || ( kenP==25 && ( kenw==15 || kenw>36 ) ) )
	{	M = lfirst( varlist[nfsch].varwert );
		N = list4( 2, 1, 0, 1 );
		if(!oequal(M,N))
		{	mistake(173);
			return( ERROR );
		}
	}
	if( ( ( ( kenw == 17 || kenw == 18 ) && kenP > 31 )
         || ( ( kenw == 31 || kenw == 32 ) && kenP > 17 && kenP < 23 ) )
	 && lfirst( varlist[modsch].varwert ) != gfchar )
	{	mistake(266);
		return( ERROR );
	}

	w1 = lfirst( wert );
	if( kenw<2 || kenw==15 || kenw==17 || kenw==24 || kenw==31 || kenw==37 )
	{       Vw = _0;
		rw = 0;
	}
	else
	{       Vw = lfirst( w1 );
		rw = llength( Vw );
		w1 = lsecond( w1 );
	}

	/*** Abarbeitung nach entsprechender Kennung ***/

	switch( kenP )
	{       case 2:switch( kenw )
		       { case 0:
			 case 2: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = pitransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 0 );
				else
				{       P = list2( VP, P );
					P = list2( P, 2 );
				}
				break;
			case 1:
			case 3: P = pitopr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = prtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 1 );
				else
				{       P = list2( VP, P );
					P = list2( P, 3 );
				}
				break;
		       case 4:  P = pitopr( r, P );
				P = prtorfr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = rfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 1 );
				else
				{       P = list2( VP, P );
					P = list2( P, 4 );
				}
				break;
			 case 15:
			 case 38:P=pitopfl(r,P);
				VP=VL;
				while( *pos != -1 )
				{	V=lelt(VL, *pos);
					P=pfltransf(r,P,VP,rw,w1,Vw,V,&VP);
					r=llength(VP);
					pos++;
				}
				if(VP==_0) P=list2(P,15);
				else
				{	P=list2(VP,P);
					P=list2(P,38);
				}
				break;
		         case 17:
			 case 18:M = lfirst( varlist[modsch].varwert );
				if( ssch )  P = pitopms( r, P, M );
				else        P = pitopmi( r, P, M );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if( ssch ) P = pmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					else P = pmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 17 );
				else
				{       P = list2( VP, P );
					P = list2( P, 18 );
				}
				break;
		         case 24:
			 case 25:M = lfirst( varlist[nfsch].varwert );
				P = pitopnf( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = pnftransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 24 );
				else
				{       P = list2( VP, P );
					P = list2( P, 25 );
				}
				break;
		         case 31:
			 case 32:M = lfirst( varlist[gfsch].varwert );
				P = pitopms( r, P, gfchar );
				if( gfchar != 2 ) P = pmstopgfs( r, gfchar, P );
				else P = pm2topgf2( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if( gfchar != 2 ) P = pgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
					else P = pgf2transf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 31 );
				else
				{       P = list2( VP, P );
					P = list2( P, 32 );
				}
				break;
			 case 37:
			 case 39:P=pitopc(r,P);
				VP=VL;
				while( *pos != -1 )
				{	V=lelt(VL, *pos);
					P=pctransf(r,P,VP,rw,w1,Vw,V,&VP);
					r=llength(VP);
					pos++;
				}
				if(VP==_0) P=list2(P,37);
				else
				{	P=list2(VP,P);
					P=list2(P,39);
				}
				break;
		      }
		      break;
		case 3:switch( kenw )
		       { case 0:
			 case 2: w1 = pitopr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = prtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 1 );
				else
				{       P = list2( VP, P );
					P = list2( P, 3 );
				}
				break;
			case 1:
			case 3: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = prtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 1 );
				else
				{       P = list2( VP, P );
					P = list2( P, 3 );
				}
				break;
			case 4: P = prtorfr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = rfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 1 );
				else
				{       P = list2( VP, P );
					P = list2( P, 4 );
				}
				break;
			 case 15:
			 case 38:P=prtopfl(r,P);
				VP=VL;
				while( *pos != -1 )
				{	V=lelt(VL, *pos);
					P=pfltransf(r,P,VP,rw,w1,Vw,V,&VP);
					r=llength(VP);
					pos++;
				}
				if(VP==_0) P=list2(P,15);
				else
				{	P=list2(VP,P);
					P=list2(P,38);
				}
				break;
		         case 17:
			 case 18:M = lfirst( varlist[modsch].varwert );
				P = prnumden( r, P, &N );
				if( igcd( M, N ) != 1 )
				{       mistake1( 242, M );
					return( ERROR );
				}
				N = mihom( M, N );
				N = miinv( M, N );
				if( ssch )
				{	P = pitopms( r, P, M );
					P = pmsmsprod( r, M, P, N );
                        	}
				else      
				{	P = pitopmi( r, P, M );
					P = pmimiprod( r, M, P, N );
                        	}
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if( ssch ) P = pmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					else P = pmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 17 );
				else
				{       P = list2( VP, P );
					P = list2( P, 18 );
				}
				break;
		         case 24:
			 case 25:M = lfirst( varlist[nfsch].varwert );
				P = prtopnf( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = pnftransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 24 );
				else
				{       P = list2( VP, P );
					P = list2( P, 25 );
				}
				break;
		         case 31:
			 case 32:M = lfirst( varlist[gfsch].varwert );
				P = prnumden( r, P, &N );
				if( igcd( gfchar, N ) != 1 )
				{       mistake1( 242, gfchar );
					return( ERROR );
				}
				N = mshom( gfchar, N );
				N = msinv( gfchar, N );
				P = pitopms( r, P, gfchar );
				P = pmsmsprod( r, gfchar, P, N );
				if(gfchar!=2)  P=pmstopgfs(r,gfchar,P);
				else   P=pm2topgf2(r,P);
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if( gfchar != 2 ) P = pgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
					else P = pgf2transf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 31 );
				else
				{       P = list2( VP, P );
					P = list2( P, 32 );
				}
				break;
			 case 37:
			 case 39:P=prtopc(r,P);
				VP=VL;
				while( *pos != -1 )
				{	V=lelt(VL, *pos);
					P=pctransf(r,P,VP,rw,w1,Vw,V,&VP);
					r=llength(VP);
					pos++;
				}
				if(VP==_0) P=list2(P,37);
				else
				{	P=list2(VP,P);
					P=list2(P,39);
				}
				break;
		       }
		       break;
		case 4:switch( kenw )
		       { case 0:
			 case 2: w1 = pitopr( rw, w1 );
				w1 = prtorfr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = rfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 1 );
				else
				{       P = list2( VP, P );
					P = list2( P, 4 );
				}
				break;
			case 1:
			case 3: w1 = prtorfr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = rfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 1 );
				else
				{       P = list2( VP, P );
					P = list2( P, 4 );
				}
				break;
			case 4: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = rfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 1 );
				else
				{       P = list2( VP, P );
					P = list2( P, 4 );
				}
				break;
		       }
		       break;
		case 7:switch( kenw )
		       { case 0:
			 case 2: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = mapitransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 5 );
				else
				{       P = list2( VP, P );
					P = list2( P, 7 );
				}
				break;
			case 1:
			case 3: P = mapitomapr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = maprtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 6 );
				else
				{       P = list2( VP, P );
					P = list2( P, 8 );
				}
				break;
		       case 4:  P = mapitomapr( r, P );
				P = maprtomarfr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = marfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 6 );
				else
				{       P = list2( VP, P );
					P = list2( P, 9 );
				}
				break;
		         case 17:
			 case 18:M = lfirst( varlist[modsch].varwert );
				if( ssch )  P = mapitomapms( r, P, M );
				else        P = mapitomapmi( r, P, M );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if( ssch ) P = mapmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					else P = mapmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 19 );
				else
				{       P = list2( VP, P );
					P = list2( P, 20 );
				}
				break;
		         case 24:
			 case 25:M = lfirst( varlist[nfsch].varwert );
				P = mapitomapnf( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = mapnftransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 26 );
				else
				{       P = list2( VP, P );
					P = list2( P, 27 );
				}
				break;
		         case 31:
			 case 32:M = lfirst( varlist[gfsch].varwert );
				P = mapitomapms( r, P, gfchar );
				if(gfchar!=2) P=mpmstompgfs(r,gfchar,P);
				else P=mpm2tompgf2(r,P);
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if(gfchar!=2) P = mapgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
					else P=mapgf2transf(r,M,P,VP,rw,w1,Vw,V,&VP);
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 33 );
				else
				{       P = list2( VP, P );
					P = list2( P, 34 );
				}
				break;
		      }
		      break;
		case 8:switch( kenw )
		       { case 0:
			 case 2: w1 = pitopr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = maprtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 6 );
				else
				{       P = list2( VP, P );
					P = list2( P, 8 );
				}
				break;
			case 1:
			case 3: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = maprtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 6 );
				else
				{       P = list2( VP, P );
					P = list2( P, 8 );
				}
				break;
			case 4: P = maprtomarfr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = marfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 6 );
				else
				{       P = list2( VP, P );
					P = list2( P, 9 );
				}
				break;
		         case 17:
			 case 18:M = lfirst( varlist[modsch].varwert );
				P = maprtomapmi( r, P, M );
				if( P == ERROR )
				{       mistake1( 243, M );
					return( ERROR );
				}
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if( ssch ) P = mapmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					else P = mapmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 19 );
				else
				{       P = list2( VP, P );
					P = list2( P, 20 );
				}
				break;
		         case 24:
			 case 25:M = lfirst( varlist[nfsch].varwert );
				P = maprtomapnf( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = mapnftransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 26 );
				else
				{       P = list2( VP, P );
					P = list2( P, 27 );
				}
				break; 
		         case 31:
			 case 32:M = lfirst( varlist[gfsch].varwert );
				P = maprtomapmi( r, P, gfchar );
				if( P == ERROR )
				{       mistake1( 243, gfchar );
					return( ERROR );
				}
				if(gfchar!=2) P=mpmstompgfs(r,gfchar,P);
				else P=mpm2tompgf2(r,P);
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if(gfchar!=2) P = mapgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
					else P=mapgf2transf(r,M,P,VP,rw,w1,Vw,V,&VP);
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 33 );
				else
				{       P = list2( VP, P );
					P = list2( P, 34 );
				}
				break;
		       }
		       break;
		case 9:switch( kenw )
		       { case 0:
			 case 2: w1 = pitopr( rw, w1 );
				w1 = prtorfr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = marfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 6 );
				else
				{       P = list2( VP, P );
					P = list2( P, 9 );
				}
				break;
			case 1:
			case 3: w1 = prtorfr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = marfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 6 );
				else
				{       P = list2( VP, P );
					P = list2( P, 9 );
				}
				break;
			case 4: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = marfrtransf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 6 );
				else
				{       P = list2( VP, P );
					P = list2( P, 9 );
				}
				break;
		       }
		       break;
		case 12:switch( kenw )
		       { case 0:
			 case 2: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecpitransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 10 );
				else
				{       P = list2( VP, P );
					P = list2( P, 12 );
				}
				break;
			case 1:
			case 3: P = vecpitovpr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecprtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 11 );
				else
				{       P = list2( VP, P );
					P = list2( P, 13 );
				}
				break;
		       case 4:  P = vecpitovpr( r, P );
				P = vecprtovrfr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecrfrtrnsf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 11 );
				else
				{       P = list2( VP, P );
					P = list2( P, 14 );
				}
				break;
		         case 17:
			 case 18:M = lfirst( varlist[modsch].varwert );
				if( ssch )  P = vecpitovpms( r, P, M );
				else        P = vecpitovpmi( r, P, M );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if( ssch ) P = vpmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					else P = vpmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 21 );
				else
				{       P = list2( VP, P );
					P = list2( P, 22 );
				}
				break;
		         case 24:
			 case 25:M = lfirst( varlist[nfsch].varwert );
				P = vecpitovpnf( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vpnftransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 28 );
				else
				{       P = list2( VP, P );
					P = list2( P, 29 );
				}
				break;
		         case 31:
			 case 32:M = lfirst( varlist[gfsch].varwert );
				P = vecpitovpms( r, P, gfchar );
				if(gfchar!=2) P=vpmstovpgfs(r,gfchar,P);
				else P=vpm2tovpgf2(r,P);
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if(gfchar!=2) P=vpgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
					else P=vpgf2transf(r,M,P,VP,rw,w1,Vw,V,&VP);
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 35 );
				else
				{       P = list2( VP, P );
					P = list2( P, 36 );
				}
				break;
		      }
		      break;
		case 13:switch( kenw )
		       { case 0:
			 case 2: w1 = pitopr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecprtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 11 );
				else
				{       P = list2( VP, P );
					P = list2( P, 13 );
				}
				break;
			case 1:
			case 3: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecprtransf( r, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 11 );
				else
				{       P = list2( VP, P );
					P = list2( P, 13 );
				}
				break;
			case 4: P = vecprtovrfr( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecrfrtrnsf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 11 );
				else
				{       P = list2( VP, P );
					P = list2( P, 14 );
				}
				break;
		         case 17:
			 case 18:M = lfirst( varlist[modsch].varwert );
				P = vecprtovpmi( r, P, M );
				if( P == ERROR )
				{  mistake1( 244, M );
				   return( ERROR );
				}
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if( ssch ) P = vpmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					else P = vpmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 21 );
				else
				{       P = list2( VP, P );
					P = list2( P, 22 );
				}
				break;
		         case 24:
			 case 25:M = lfirst( varlist[nfsch].varwert );
				P = vecprtovpnf( r, P );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vpnftransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 28 );
				else
				{       P = list2( VP, P );
					P = list2( P, 29 );
				}
				break;
		         case 31:
			 case 32:M = lfirst( varlist[gfsch].varwert );
				P = vecprtovpmi( r, P, gfchar );
				if( P == ERROR )
				{  mistake1( 244, gfchar );
				   return( ERROR );
				}
				if(gfchar!=2) P=vpmstovpgfs(r,gfchar,P);
				else P=vpm2tovpgf2(r,P);
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					if(gfchar!=2) P = vpgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
					else P=vpgf2transf(r,M,P,VP,rw,w1,Vw,V,&VP);
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 35 );
				else
				{       P = list2( VP, P );
					P = list2( P, 36 );
				}
				break;
		       }
		       break;
		case 14:switch( kenw )
		       { case 0:
			 case 2: w1 = pitopr( rw, w1 );
				w1 = prtorfr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecrfrtrnsf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 11 );
				else
				{       P = list2( VP, P );
					P = list2( P, 14 );
				}
				break;
			case 1:
			case 3: w1 = prtorfr( rw, w1 );
				VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecrfrtrnsf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 11 );
				else
				{       P = list2( VP, P );
					P = list2( P, 14 );
				}
				break;
			case 4: VP = VL;
				while( *pos != -1 )
				{       V = lelt( VL, *pos );
					P = vecrfrtrnsf( r, P, VP, rw, w1, Vw, V, &VP );
					if( P == (-BASIS-1) )
					{       mistake( 10 );
						return( -BASIS );
					}
					r = llength( VP );
					pos++;
				}
				if( VP == _0 )    P =list2( P, 11 );
				else
				{       P = list2( VP, P );
					P = list2( P, 14 );
				}
				break;
		       }
		       break;
		case 18:
		case 20:
	        case 22:if( kenw < 31 )
				M = lfirst( varlist[modsch].varwert );
			else
				M = lfirst( varlist[gfsch].varwert );
		       switch( kenw )
		       { case 0:if( ssch ) w1 = mshom( M, w1 );
				else       w1 = mihom( M, w1 );
				break;
		         case 2:if( ssch ) w1 = pitopms( rw, w1, M );
				else       w1 = pitopmi( rw, w1, M );
				break;
		         case 1:N = lsecond( w1 );
	                	if ( igcd( N, M ) != 1 )
				{       mistake2( 233, w1, M );
		        		return( ERROR );
				}
				N = mihom( M, N );
	 	        	N = miinv( M, N );
				w1 = lfirst( w1 );
				if( ssch )
				{       w1 = mshom( M, w1 );
					w1 = msprod( M, w1, N );
                        	}         
				else    
				{ 	w1 = mihom( M, w1 );
					w1 = miprod( M, w1, N );
                       		}
				break;
		         case 3:w1 = prnumden( rw, w1, &N );
				if( igcd( M, N ) != 1 )
				{       mistake1( 242, M );
					return( ERROR );
				}
				N = mihom( M, N );
				N = miinv( M, N );
				if( ssch )
				{	w1 = pitopms( rw, w1, M );
					w1 = pmsmsprod( rw, M, w1, N );
                        	}
				else      
				{	w1 = pitopmi( rw, w1, M );
					w1 = pmimiprod( rw, M, w1, N );
                        	}
				break;
			case 31:
			case 32:if( kenP == 18 )
				{   if(gfchar!=2) P=pmstopgfs(r,gfchar,P);
				    else P=pm2topgf2(r,P);
				}
				else if( kenP == 20 )
				{   if(gfchar!=2) P=mpmstompgfs(r,gfchar,P);
				    else P=mpm2tompgf2(r,P);
				}
				else
				{   if(gfchar!=2) P=vpmstovpgfs(r,gfchar,P);
				    else P=vpm2tovpgf2(r,P);
				}
				kenP = kenP + 14;
				break;
		        }
			VP = VL;
			while( *pos != -1 )
			{       V = lelt( VL, *pos );
				if( ssch ) 
				{   switch( kenP )
				    {	case 18: P = pmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
						 break;
					case 20: P = mapmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
						 break;
					case 22: P = vpmstransf( r, M, P, VP, rw, w1, Vw, V, &VP );
						 break;
					case 32: if( gfchar != 2 ) P = pgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
						 else P = pgf2transf( r, M, P, VP, rw, w1, Vw, V, &VP );
						 break;
					case 34: if(gfchar!=2) P = mapgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
						 else P=mapgf2transf(r,M,P,VP,rw,w1,Vw,V,&VP);
						 break;
					case 36: if(gfchar!=2) P = vpgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
					 	 else P=vpgf2transf(r,M,P,VP,rw,w1,Vw,V,&VP);
						 break;
				    }
				}
				else 
				{	if( kenP == 18 )
					P = pmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					else if( kenP == 20 )
					P = mapmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
					else 
					P = vpmitransf( r, M, P, VP, rw, w1, Vw, V, &VP );
				}
				r = llength( VP );
				pos++;
			}
			if( VP == _0 )    P =list2( P, (kenP-1) );
			else
			{       P = list2( VP, P );
				P = list2( P, kenP );
			}
		       break;
		case 25:
		case 27:
		case 29:M = lfirst( varlist[nfsch].varwert );
                       switch( kenw )
		       { case 0:w1 = itonf( w1 );
				break;
		         case 2:w1 = pitopnf( rw, w1 );
			 	break;
		         case 1:w1 = rtonf( w1 );
				break;
		         case 3:w1 = prtopnf( rw, w1 );
			 	break;
			 case 15:
			 case 38:w1=pfltopc( rw, w1 );
				P=pnftopcs(r,P);
				break;
			 case 37:
			 case 39:P=pnftopcs(r,P);
				break;
		       }
			VP = VL;
			while( *pos != -1 )
			{       V = lelt( VL, *pos );
				if( kenw==15 || kenw>36 ) P=pctransf(r,P,VP,rw,w1,Vw,V,&VP);
				else if( kenP==25 ) P=pnftransf(r,M,P,VP,rw,w1,Vw,V,&VP);
				else if( kenP==27 ) P=mapnftransf(r,M,P,VP,rw,w1,Vw,V,&VP);
				else P=vpnftransf(r,M,P,VP,rw,w1,Vw,V,&VP );
				r = llength( VP );
				pos++;
			}
			if( kenw==15 || kenw>36 )
			{	if( VP==_0) P=list2(P,37);
				else 
				{	P=list2(VP,P);
					P=list2(P,39);
				}
			}
			else if( VP == _0 )    P =list2( P, (kenP-1) );
			else
			{       P = list2( VP, P );
				P = list2( P, kenP );
			}
		       break;
		case 32:
		case 34:
		case 36:M = lfirst( varlist[gfsch].varwert );
		       switch( kenw )
		       { case 0:w1 = mshom( gfchar, w1 );
				if( w1 )
				{	w1 = list2( 0, w1 );
					if( gfchar == 2 ) w1 = udpm2tosb(w1);
				}
				break;
		         case 2:w1 = pitopms( rw, w1, gfchar );
				if( gfchar != 2 ) w1 = pmstopgfs( rw, gfchar, w1 );
				else w1 = pm2topgf2( rw, w1 );
				break;
		         case 1:N = lsecond( w1 );
	                	if ( igcd( N, gfchar ) != 1 )
				{       mistake2( 233, w1, gfchar );
		        		return( ERROR );
				}
				N = mshom( gfchar, N );
	 	        	N = msinv( gfchar, N );
				w1 = lfirst( w1 );
				w1 = mshom( gfchar, w1 );
				if( w1 )
				{	w1 = msprod( gfchar, w1, N );
					w1 = list2( 0, w1 );
					if( gfchar == 2 ) w1 = udpm2tosb(w1);
                       		}
				break;
		         case 3:w1 = prnumden( rw, w1, &N );
				if( igcd( gfchar, N ) != 1 )
				{       mistake1( 242, gfchar );
					return( ERROR );
				}
				N = mshom( gfchar, N );
				N = msinv( gfchar, N );
				w1 = pitopms( rw, w1, gfchar );
				w1 = pmsmsprod( rw, gfchar, w1, N );
				if(gfchar!=2)  w1=pmstopgfs(rw,gfchar,w1);
				else   w1=pm2topgf2(rw,w1);
				break;
			case 17:if( w1 )
				{	w1 = list2( 0, w1 );
					if( gfchar == 2 ) w1 = udpm2tosb(w1);
				}
				break;
			case 18:if( gfchar != 2 ) w1 = pmstopgfs( rw, gfchar, w1 );
				else w1 = pm2topgf2( rw, w1 );
				break;
		        }
			VP = VL;
			while( *pos != -1 )
			{       V = lelt( VL, *pos );
				if( kenP == 32 )
				{   if( gfchar != 2 ) P = pgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
				    else P = pgf2transf( r, M, P, VP, rw, w1, Vw, V, &VP );
				}
				else if( kenP == 34 )
				{   if(gfchar!=2) P = mapgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
				    else P=mapgf2transf(r,M,P,VP,rw,w1,Vw,V,&VP);
				}
				else 
				{   if(gfchar!=2) P = vpgfstransf( r, gfchar, M, P, VP, rw, w1, Vw, V, &VP );
				    else P=vpgf2transf(r,M,P,VP,rw,w1,Vw,V,&VP);
				}
				r = llength( VP );
				pos++;
			}
			if( VP == _0 )    P =list2( P, (kenP-1) );
			else
			{       P = list2( VP, P );
				P = list2( P, kenP );
			}
		       break;
		case 38:switch( kenw )
		       { case 0:w1 = itofl( w1 );
				break;
		         case 2:w1 = pitopfl( rw, w1 );
			 	break;
		         case 1:w1 = rtofl( w1 );
				break;
		         case 3:w1 = prtopfl( rw, w1 );
			 	break;
			 case 24:w1=nftocs(w1);
				P=pfltopc(r,P);
				break;
			 case 25:w1=pnftopcs(rw,w1);
				P=pfltopc(r,P);
				break;
			 case 37:
			 case 39:P=pfltopc(r,P);
				break;
		       }
			VP = VL;
			while( *pos != -1 )
			{       V = lelt( VL, *pos );
				if( kenw==24 || kenw==25 || kenw==37 || kenw==39 ) 
					P=pctransf(r,P,VP,rw,w1,Vw,V,&VP);
				else P=pfltransf(r,P,VP,rw,w1,Vw,V,&VP );
				r = llength( VP );
				pos++;
			}
			if( kenw==24 || kenw==25 || kenw>36 )
			{	if( VP==_0) P=list2(P,37);
				else 
				{	P=list2(VP,P);
					P=list2(P,39);
				}
			}
			else if( VP==_0 ) P=list2(P,15);
			else
			{	P=list2(VP,P);
				P=list2(P,38);
			}
			break;
		case 39:switch( kenw )
		       { case 0:w1 = itoc( w1 );
				break;
		         case 2:w1 = pitopc( rw, w1 );
			 	break;
		         case 1:w1 = rtoc( w1 );
				break;
		         case 3:w1 = prtopc( rw, w1 );
			 	break;
			 case 15:w1=fltoc(w1);
				break;
			 case 24:w1=nftocs(w1);
				break;
			 case 25:w1=pnftopcs(rw,w1);
				break;
			 case 38:w1=pfltopc(rw,w1);
				break;
		       }
			VP = VL;
			while( *pos != -1 )
			{       V = lelt( VL, *pos );
				P=pctransf(r,P,VP,rw,w1,Vw,V,&VP);
				r = llength( VP );
				pos++;
			}
			if( VP==_0) P=list2(P,37);
			else 
			{	P=list2(VP,P);
				P=list2(P,39);
			}
			break;
	}
	return( P );
}
