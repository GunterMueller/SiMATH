/*C
			calc_exp( a1, a2, t1, t2 )

	"calculator exponentiation".
	list calc_exp(a1,a2,t1,t2); obj a1, a2; single t1, t2;
	erg = calc_exp( a1, a2, t1, t2 );

	t1 bzw. t2 ist die Kennung des Objekts a1 bzw. a2.
	Berechnet wird a2 hoch a1.
	Der Exponent a1 muss dabei eine ganze Zahl sein, die betrags-
	maessig kleiner ist als BASIS, oder eine Zahl aus Q\Z, deren
	Zaehler und Nenner beide betragsmaessig kleiner sind als BASIS.
	Das Ergebnis wird mit zugehoeriger Kennung der Variablen 'erg' 
	zugeordnet.

	Fallunterscheidung:
	a2 aus Z, Q, R: 		a1 aus Z, Q\R
					a1 aus R: so muss a2 >= 0 sein.
	a2 aus C:			a1 aus Q mit a1 = n/(2^a),
					|n| < BASIS.
	a2 aus Z/mZ:			a1 aus Q mit a1 = n/(2^a): 
					fuer m > BASIS: m Primzahl.
	a2 aus NF:			a1 aus Z.
	a2 aus GF: 			a1 aus Z.
	a2 aus P[Z], P[Q], P(Q):	a1 aus Z.
	a2 aus P[Z/mZ], P[NF], P[GF]
	       P[R], P[C]:		a1 aus Z, a1 >= 0.
	a2 Matrix:			a1 aus Z: fuer a1 < 0: a2 
					invertierbar.
	 
	Laeuft calc_exp fehlerhaft ab, so ist erg = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1987      H.Stroeher/M.Mang
	Version  2      02.11.1988      C.Hollinger/U.Schneiders
	Version  3      12.07.1989      C.Hollinger/U.Schneiders
	Version  4      21.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  5      03.08.1992      U.Schneiders ( mod und nf )
	Version  6	28.12.1992	U.Schneiders ( flpow )
	Version  7	15.07.1993	S.Schmitt ( gf )
	Version  8	20.01.1994	S.Schmitt/U.Schneiders 
	Version  8.1	25.01.1995	S.Schmitt ( Polynome ueber R und C )
H*/
 
#include <_calc.h>

list calc_exp( a1, a2, t1, t2 )
obj a1, a2;
single t1, t2;

{       /*** Deklarationen ***/

	obj erg, erg1, erg2, n, z, D, M;
	single n1, n2, r, m1, m2, t;
	int A2, hz;
	list VL;
	init( erg, erg1, erg2, n, z, VL, A2, hz, D, M );
	VL = _0;
	bind( a1, a2 );

	/*** Abfangen ungueltiger Eingaben ***/

	if ( a1 == -BASIS || a2 == -BASIS ) return( -BASIS );
	if( ( t2 > 9  && t2 < 15 ) || t2 == 21 || t2 == 22 || t2 == 28 || t2 == 29 || t2 == 35 || t2 == 36 )
	{       mistake( 235 );
		return( -BASIS );
	}
	if( t2 < 0 )
	{       mistake( 236 );
		return( -BASIS );
	}
	if( t1 < 0 || ( t1 > 1 && t1 != 15 ) )
	{       mistake( 11 );
		return( -BASIS );
	}
	if( t1 == 15 && ( t2 && t2 != 1 && t2 != 15 ) )
	{	mistake( 71 );
		return( ERROR );
	}
	if ( t2 == 16 || t2 == 23 || t2 == 30 || t2 > 39 )
	{       mistake( 71 );
		return( -BASIS );
	}
	if ( t2 != 17 && t1 == 0 )
	{       if ( a1 >= BASIS || a1 <= -BASIS ) {
		  mistake( 237 );
		  return( -BASIS );
		}
	}
	else if( t1==1 )

	{       n1 = lfirst( a1 );
		n2 = lsecond( a1 );
		if( t2 != 17 )
		{   if ( n1 >= BASIS || n1 <= -BASIS ) {
		     mistake( 238 );
		     return( -BASIS );
		   }
		   if ( t2 != 37 && n2 >= BASIS ) {
		     mistake( 239 );
		     return( -BASIS );
		   }
		}
		if( ( t2 > 4 && t2 < 15 ) || t2 == 19 || t2 == 20 || t2 == 26 || t2 == 27 || t2 == 33 || t2 == 34 )
		{       mistake( 73 );
			return( -BASIS );
		}
		if( ( t2 > 1 && t2 < 15 ) || t2 == 18 || t2 == 25 || t2 == 32 || t2==38 || t2==39 )
		{       mistake( 12 );
			return( -BASIS );
		}
		if( t2 == 17 || t2 == 37 )
		{	r = imp2d( n2 );
			if( ip2quot( n2, r ) != 1 )
			{	mistake( 171 );
				return( ERROR );
			}
		}
		if( t2 == 24 )
		{	mistake( 172 );
			return( ERROR );
		}
		if( t2 == 31 )
		{	mistake( 225 );
			return( ERROR );
		}
	}

	if( t2 > 16 && t2 < 23 )  M = lfirst( varlist[modsch].varwert );
	else if( t2 > 23 && t2 < 30 ) M = lfirst( varlist[nfsch].varwert );
	else if( t2 > 30 && t2 < 37 ) M = lfirst( varlist[gfsch].varwert );

	if( ( t2 > 1 && t2 < 5 ) || ( t2 > 6 && t2 < 10 ) || t2 == 18 || t2 == 20 || t2 == 25 || t2 == 27 || t2 == 32 || t2 == 34 || t2==38 || t2==39 )
	{       VL = lfirst( a2 );
		a2 = lsecond( a2 );
		r = llength( VL );
	}
	if( ( t2 > 4  && t2 < 15 ) || t2 == 19 || t2 == 20 || t2 == 26 || t2 == 27 || t2 == 33 || t2 == 34 )
	{       if(t2==19 && M==2)
		{	m1=llength(a2)-1;
			m2=lfirst(a2);
		}
		else
		{	m1 = manrrow( a2 );
			m2 = manrcol( a2 );
		}
		if( m1 != m2 )
		{       mistake( 75 );
			return( -BASIS );
		}
		D = 0;
		if( a1 < 0 )
		{       switch( t2 )
			{       case 5: D = maidet( a2 );
					D = list2( D, 0 );
					break;
				case 6: D = mardet( a2 );
					D = list2( D , 1 );
					break;
				case 7: D = mapidet( r, a2 );
					D = list2( VL, D );
					D = list2( D, 2 );
					break;
				case 8: D = maprdet( r, a2 );
					D = list2( VL, D );
					D = list2( D, 3 );
					break;
				case 9: D = marfrdet( r, a2 );
					D = list2( VL, D );
					D = list2( D, 4 );
					break;
				case 19:if(M==2)
					{	a2=mam2tomams(a2);
						D=mamsdet(M,a2);
						a2=mamstomam2(a2);
					}
					else if( ssch ) D = mamsdet( M, a2 );
					else	   D = mamidet( M, a2 );
					D = list2( D, 17 );
					break;
				case 20:if( ssch ) D = mapmsdet( r, M, a2 );
					else       D = mapmidet( r, M, a2 );
					D = list2( VL, D );
					D = list2( D, 18 );
					break;
				case 26:D = manfdet( M, a2 );
					D = list2( D, 24 );
					break;
				case 27:D = mapnfdet( r, M, a2 );
					D = list2( VL, D );
					D = list2( D, 25 );
					break;
				case 33:if(gfchar==2) D=magf2det(M,a2);
					else D = magfsdet( gfchar, M, a2 );
					D = list2( D, 31 );
					break;
				case 34:if(gfchar==2) D=mapgf2det(r,M,a2);
					else D = mapgfsdet( r, gfchar, M, a2 );
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
	}

	/*** Exponentiation ***/

	switch( t2 ) {
		case 0: switch( t1 ) {
			case 0:  /*** Exponent und Basis sind ganzzahlig ***/
				if ( a1 >= 0 )
				{       erg = iexp( a2,a1 );
					erg = list2( erg,0 );
				}
				else
				{       if( !a2 )
					{       mistake( 10 );
						return( ERROR );
					}
					a1 = -a1;
					erg = iexp( a2,a1 );
					erg = itor( erg );
					erg = rinv( erg );
					erg = list2( erg,1 );
				}
				break;
			case 1: /*** Ganzzahlige Basis und rationaler Exponent ***/
				a1 = rabs( a1 );
				erg = iexpr( a2, a1 );
				if( erg != ERROR )
				{       if( n1 < 0 )
					{       if( !lsecond( erg ) )
						{       erg = lfirst( erg );
							if( !erg )
							{	mistake( 10 );
								return( ERROR );
							}
							erg = itor( erg );
							erg = rinv( erg );
							erg = list2( erg,1 );
						}
						else if(lsecond(erg)==15)
						{       erg = lfirst( erg );
							if( !erg )
							{	mistake( 10 );
								return( ERROR );
							}
							erg1 = itofl( 1 );
							erg = flquot( erg1, erg );
							erg = list2( erg, 15 );
						}
						else
						{	erg = lfirst(erg);
							if(!erg)
							{	mistake(10);
								return(ERROR);
							}
							erg1 = itoc(1);
							erg = cquot(erg1,erg);
							erg = list2(erg,37);
						}
					}
				}
				break;
			case 15: /*** Ganzzahlige Basis und reeller Exponent ***/
				if( isign( a2 ) < 0 )
				{	mistake( 200 );
					return( ERROR );
				}
				a2 = itofl( a2 );
				erg = flpow( a2, a1 );
				erg = list2( erg, 15 );
				break;
			}
			break;
		case 1: switch( t1 ) {
			case 0: /*** Basis rational und Exponent ganzzahlig ***/
				 if ( a1 >= 0 )
				 {      erg = rexp( a2,a1 );
					erg = list2( erg,1 );
				 }
				 else
				 {      a1 = (-a1);
					a2 = rinv( a2 );
					erg = rexp( a2,a1);
					erg = list2( erg,1 );
				 }
				 break;
			case 1: /*** Basis und Exponent sind rational ***/
				a1 = rabs( a1 );
				erg = rexpr( a2,a1 );
				if( erg != ERROR )
				{       if( n1 < 0 )
					{       if( !lsecond( erg ) )
						{       erg = lfirst( erg );
							if( !erg )
							{       mistake( 10 );
								return( ERROR );
							}
							erg = itor( erg );
							erg = rinv( erg );
							erg = list2( erg,1 );
						}
						else if(lsecond(erg)==15)
						{       erg = lfirst( erg );
							if( !erg )
							{	mistake( 10 );
								return( ERROR );
							}
							erg1 = itofl( 1 );
							erg = flquot( erg1, erg );
							erg = list2( erg, 15 );
						}
						else
						{       erg = lfirst( erg );
							if( !erg )
							{	mistake( 10 );
								return( ERROR );
							}
							erg1 = itoc( 1 );
							erg = cquot( erg1, erg );
							erg = list2( erg, 37 );
						}
					}
				}
				break;
			case 15: /*** rationale Basis und reeller Exponent ***/
				if( rsign( a2 ) < 0 )
				{	mistake( 200 );
					return( ERROR );
				}
				a2 = rtofl( a2 );
				erg = flpow( a2, a1 );
				erg = list2( erg, 15 );
				break;
			}
			break;
		case 2: /*** Basis Polynom ueber Z, Exponent ganzzahlig ***/
			if( !expoverint( r, a2, a1 ) ) return( -BASIS );
			if( a1 >= 0 )
			{       erg = piexp( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg, 2 );
			}
			else
			{       erg2 = piexp( r, a2, -a1 );
				erg1 = pvinsert( 0, 1, r );
				erg = rfrcons( r, erg1, erg2 );
				erg = list2( VL, erg );
				erg = list2( erg, 4 );
			}
			break;
		case 3: /*** Basis Polynom ueber Q, Exponent ganzzahlig ***/
			if( !expoverint( r, a2, a1 ) )  return( -BASIS );
			if( a1 >= 0 )
			{       erg = prexp( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg, 3 );
			}
			else
			{       erg2 = prexp( r, a2, -a1 );
				erg2 = prnumden( r, erg2, &hz );
				erg1 = pvinsert( 0, hz, r );
				erg = rfrcons( r, erg1, erg2 );
				erg = list2( VL, erg );
				erg = list2( erg, 4 );
			}
			break;
		case 4: /*** Basis rationale Funktion, Exponent ganzzahlig ***/
			z = list2( VL, lfirst( a2 ) );
			n = list2( VL, lsecond( a2 ) );
			erg1 = calc_exp( a1, z, 0, 2 );
			if ( erg1 == -BASIS ) erg = -BASIS;
			else
			{       erg2 = calc_exp( a1, n, 0, 2 );
				if ( erg2 == -BASIS ) erg = -BASIS;
				else
				{       erg1 = lfirst( erg1 );
					erg1 = lsecond( erg1 );
					erg2 = lfirst( erg2 );
					erg2 = lsecond( erg2 );
					if( a1 >= 0 )
						erg = rfrcons( r, erg1, erg2 );
					else
						erg = rfrquot( r, erg1, erg2 );
					erg = list2( VL, erg );
					erg = list2( erg, 4 );
				}
			}
			break;
		case 5: /*** Basis Matrix ueber Z, Exponent ganzzahlig ***/
			if( a1 < 0 &&  D != -1 && D != 1 )
			{       a2 = maitomar( a2 );
				erg = marexp( a2, a1 );
				erg = list2( erg, 6 );
			}
			else
			{       erg = maiexp( a2, a1 );
				erg = list2( erg, 5 );
			}
			break;
		case 6: /*** Basis Matrix ueber Q, Exponent ganzzahlig ***/
			erg = marexp( a2, a1 );
			erg = list2( erg, 6 );
			break;
		case 7: /*** Basis Matrix von Pol. ueber Z, Exp. ganzzahlig ***/
			if( a1 < 0 &&  !m1 && D != -1 && D != 1 )
			{       a2 = mapitomapr( r, a2 );
				erg = maprexp( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg, 8 );
			}
			else if( a1 < 0 && m1 == 2 )
			{       a2 = mapitomarfr( r, a2 );
				erg = marfrexp( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg, 9 );
			}
			else
			{       erg = mapiexp( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg, 7 );
			}
			break;
		case 8: /*** Basis Matrix von Pol. ueber Q, Exp. ganzzahlig ***/
			if( a1 < 0 && m2 == 3 )
			{       a2 = maprtomarfr( r, a2 );
				erg = marfrexp( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg, 9 );
			}
			else
			{       erg = maprexp( r, a2, a1 );
				erg = list2( VL, erg );
				erg = list2( erg, 8 );
			}
			break;
		case 9: /*** Basis Matrix von rat. Fkt., Exp. ganzzahlig ***/
			erg = marfrexp( r, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 9 );
			break;
		case 15:switch( t1 ) {
			case 0:  /*** Basis floating point, Expon. ganzzahlig ***/
				if ( a1 < 0 && !a2 )
				{       mistake( 10 );
					return( ERROR );
				}
				erg = flsexp( a2,a1 );
				erg = list2( erg, 15 );
				break;
			case 1: /*** Basis floating point, Expon. rational ***/
				a1 = rabs( a1 );
				erg = flexpr( a2, a1 );
				if( erg != ERROR )
				{       if( n1 < 0 )
					{       if( lsecond( erg )==15 )
						{       erg = lfirst( erg );
							if( !erg )
							{       mistake( 10 );
								return( ERROR );
							}
							erg1 = itofl( 1 );
							erg = flquot( erg1, erg );
							erg = list2( erg, 15 );
						}
						else
						{       erg = lfirst( erg );
							if( !erg )
							{       mistake( 10 );
								return( ERROR );
							}
							erg1 = itoc( 1 );
							erg = cquot( erg1, erg );
							erg = list2( erg, 37 );
						}
					}
				}
				break;
			case 15: /*** reelle Basis und reeller Exponent ***/
				if( flsign( a2 ) < 0 )
				{	mistake( 200 );
					return( ERROR );
				}
				erg = flpow( a2, a1 );
				erg = list2( erg, 15 );
				break;
			}
			break;
		case 37:switch( t1) {
			case 0:  /*** Basis aus C, Exponent ganzzahlig ***/
				if(a1 >= 0)  erg = csexp(a2,a1);
				else
				{	if(!a2) 
					{	mistake(10);
						return(ERROR);
					}
					a1 = -a1;
					erg = csexp(a2,a1);
					erg = cquot(itoc(1),erg);
				}
				erg = list2(erg,37);
				break;
			case 1: /*** Basis aus C, Exponent rational ***/
				if(n1 >= 0)  erg = csexp(a2,n1);
				else
				{	if(!a2) 
					{	mistake(10);
						return(ERROR);
					}
					n1 = -n1;
					erg = csexp(a2,n1);
					erg = cquot(itoc(1),erg);
				}
				for(;r;r--) erg = csqrt(erg);
				erg = list2(erg,37);
				break;
			}
			break;
		case 17:switch( t1 ) {
			case 0:  /*** Basis aus Z/mZ, Expon. ganzzahlig ***/
				if( a1 >= 0 )
					erg = miexp( M, a2, a1 );
				else
				{	if( !a2 )
					{	mistake( 10 );
						return( ERROR );
					}
					a1 = -a1;
					erg = miexp( M, a2, a1 );
					if( igcd( erg, M ) != 1 )
					{       a2 = list2( 1, erg );
						mistake2( 233, a2, M );
		        			return( ERROR );
					}
					if( ssch )  erg = msinv( M, erg );
					else 	    erg = miinv( M, erg );
				}
				erg = list2( erg, 17 );
				break;
			case 1: /*** Basis aus Z/mZ, Expon. rational ***/
				if( n1 >= 0 )
					erg = miexp( M, a2, n1 );
				else
				{	if( !a2 )
					{	mistake( 10 );
						return( ERROR );
					}
					n1 = -n1;
					erg = miexp( M, a2, n1 );
					if( igcd( erg, M ) != 1 )
					{       a2 = list2( 1, erg );
						mistake2( 233, a2, M );
		        			return( ERROR );
					}
					if( ssch )  a2 = msinv( M, erg );
					else 	    a2 = miinv( M, erg );
				}
				m1 = r; 
				if( pzsch && M != 2 )
				{	/*t = mshom( 4, M );*/
					for( ; r; r-- )
					{    D = mipsqrt( M, a2 );
			     		/*   if( t == 3 && D == (-1) )
			     		     {	if( ssch ) a2 = msneg( M, a2 );
						else	   a2 = mineg( M, a2 );
						D = mipsqrt( M, a2 );
			     		     }*/
			     		     if( D == (-1) )
			     	             {	m1 = sexp( 2, m1-r );	
				                if( m1 == 2 ) mistake1( 240, a2 ); 
				                else if( m1 > 2 ) mistake2( 241, m1, a2 );
						else mistake( 175 );
				                return( ERROR );
			                     }
			                     if( D == (-2) )
			                     {  mistake( 195 );
				                return( ERROR );
			                     }
			                     a2 = D;
			              }
				}
				else
				{	for( ; r; r-- )
					{    D = misqrt( M, a2 );
			     		     if( D == (-1) )
			                     {	m1 = sexp( 2, m1-r );	
				                if( m1 == 2 ) mistake1( 240, a2 );
				                else if( m1 > 2 ) mistake2( 241, m1, a2 ); 
						else mistake( 175 );
				                return( ERROR );
			                     }
			     		     a2 = D;
			               }
		                }
				erg = list2( a2, 17 ); 
				break;
			}
			break;
		case 18:if( a1 < 0 )
			{	mistake( 160 );
				return( ERROR );
			}
			if( ssch ) erg = pmsexp( r, M, a2, a1 );
			else       erg = pmiexp( r, M, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 18 );
			break;
		case 19:if( a1 < 0 && igcd( M, D ) != 1 )
			{	mistake( 169 );
				return( ERROR );
			}
			if(M==2) 
			{	if(a1<0)
				{	a2=mam2inv(a2);
					a1=(-a1);
				}
				erg=mam2exp(a2,a1);
			}
			else if(ssch) erg=mamsexp(M,a2,a1);
			else erg = mamiexp( M, a2, a1 );
			erg = list2( erg, 19 );
			break;
		case 20:if( a1 < 0 && ( ( m1 == 17 && igcd( D, M ) != 1 ) || m1 == 18 ) )
			{	mistake( 169 );
				return( ERROR );
			}
			if( ssch ) erg = mapmsexp( r, M, a2, a1 );
			else       erg = mapmiexp( r, M, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 20 );
			break;
		case 24:if( a1 < 0 && !a2 )
			{	mistake( 10 );
				return( ERROR );
			}
			erg = nfexp( M, a2, a1 );
			erg = list2( erg, 24 );
			break;
		case 25:if( a1 < 0 )
			{	mistake( 170 );
				return( ERROR );
			}
			erg = pnfexp( r, M, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 25 );
			break;
		case 26:erg = manfexp( M, a2, a1 );
			erg = list2( erg, 26 );
			break;
		case 27:if( a1 < 0 &&  m1 == 25 )
			{	mistake( 169 );
				return( ERROR );
			}
			erg = mapnfexp( r, M, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 27 );
			break;
		case 31:if( a1 > 0 )
			{	if( gfchar == 2 ) erg = gf2exp( M, a2, a1 );
				else erg = gfsexp( gfchar, M, a2, a1 );
			}
			else
			{	if( !a2 )
				{	mistake( 10 );
					return( ERROR );
				}
				a1 = -a1;
				if( gfchar == 2 ) erg = gf2exp( M, a2, a1 );
				else erg = gfsexp( gfchar, M, a2, a1 );
				if( erg == 0 )
				{ 	mistake( 10 );
					return( ERROR );
				}
				if( gfchar == 2 ) erg = gf2inv( M, erg );
				else erg = gfsinv( gfchar, M, erg );
			}
			erg = list2( erg, 31 );
			break;
		case 32:if( a1 < 0 )
			{	mistake( 160 );
				return( ERROR );
			}
			if( gfchar == 2 ) erg = pgf2exp( r, M, a2, a1 );
			else erg = pgfsexp( r, gfchar, M, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 32 );
			break;
		case 33:if(gfchar==2) erg=magf2exp(M,a2,a1);
			else erg = magfsexp( gfchar, M, a2, a1 );
			erg = list2( erg, 33 );
			break;	
		case 34:if( a1 < 0 && m1 == 32 )
			{	mistake( 169 );
				return( ERROR );
			}
			if(gfchar==2) erg=mapgf2exp(r,M,a2,a1);
			else erg = mapgfsexp( r, gfchar, M, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 34 );
			break;
		case 38:if( a1 < 0 )
			{	mistake( 160 );
				return( ERROR );
			}
			erg = pflexp( r, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 38 );
			break;
		case 39:if( a1 < 0 )
			{	mistake( 160 );
				return( ERROR );
			}
			erg = pcexp( r, a2, a1 );
			erg = list2( VL, erg );
			erg = list2( erg, 39 );
			break;
	}
	return( erg );
}
