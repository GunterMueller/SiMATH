/*C
			veckenn( c )

	"Vektor-Kennungstest"
	list veckenn( c );
	list c;

	veckenn untersucht, ob ein Vektor mit Elementen
	aus Q   nur aus Elementen       aus Z
	aus P(Z) "   "      "           aus Z
	aus P(Q) "   "      "           aus Z bzw. Q bzw. P(Z)
	aus F(Q) "   "      "           aus Z bzw. Q bzw. P(Z) bzw. P(Q)
	besteht. Falls ja, wird der Vektor ueber dem entsprechenden
	Bereich dargestellt.
	Ausserdem wird der Vektor, falls er aus Polynomen bzw. rationa-
	len Funktionen besteht, bzgl. der kleinst moeglichen Variablen-
	liste dargestellt.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      27.08.1991      U.Schneiders
	Version  1.1    12.07.1993      U.Schneiders
	Version  1.2    02.09.1993      U.Schneiders (NF -> Q)
H*/
/*cS
	veckenn ruft auf: calc_isint, iqrem, kenntest, lcomp, lconc
			  lcopy, linv, llength, pnftoprip, prtopica, pvred, 
			  rcons, usdiff, vlist, vlsort
	Macros: lfirst, list2, lred, lsecond, lthird
Sc*/
 
#include <_calc.h>

list veckenn( c )
list c;
{
	list el, en, pQ, H, J, M, N, Vh, VL, VN;
	single h, k, n, r, rh, rn, s, sch, sch1;
	init( el, en, pQ, H, J, M, N, Vh, VL, VN );
	bind( c );

	M = lcopy( c );
	k = lsecond( M );
	M = lfirst( M );
	if( k > 11 ) 
	{       VL = lfirst( M );
		r = llength( VL );
		M = lsecond( M );
	}
	N = _0; sch = 0; VN = _0; rn = 0;
        if( k < 15 )  n = 10;
	else if( k < 23 ) n = 21;
	else if( k < 30 ) n = 10;
	else n = 35;
	while( M != _0 )
	{       el = lfirst( M );
		M = lred( M );
		if( !el )
		{       if( k < 15 ) el = list2( 0, 0 );
			else if( k < 23 ) el = list2( 0, 17 );
			else if( k < 30 ) el = list2( 0, 0 );
			else el = list2( 0, 31 );
			N = lcomp( el, N );
			h = k;
			k = 0;
		}
		switch( k )
		{       case 11: en = lsecond( el );
				 if( en == 1 )
				 {      el = lfirst( el );
					el = list2( el, 0 );
					N = lcomp( el, N );
				 }
				 else
				 {      J = lfirst( el );
					iqrem( J, en, &pQ, &en );
					if( en == 0 )
					{       pQ = list2( pQ, 0 );
						N = lcomp( pQ, N );
					}
					else sch = 1;
				 }
				 break;
			case 28:if( !lsecond(el) )
				{   en = lfirst( el );
				    el = lthird( el );
				    if( en == 1 )  el = list2( el, 0 );
				    else
				    {	el = rcons( el, en );
					el = list2( el, 1 );
					n = 6;
				    }
				}
				else sch = 1;
				break;
			case 12:
			case 22:
			case 29: 
			case 36: el = pvred( r, el, VL, &Vh );
				 rh = llength( Vh );
				 if( rh != r )
				 {      H = usdiff( Vh, VN );
					H = lconc( VN, H );
					VN = vlsort( H, &J );
					rn = llength( VN );
					if( r != rn )
					{   if( !rh )
					    {   if( k == 12 )  el = list2( el, 0 );
					        else if( k == 22 )  el = list2( el, 17 );
						else if( k == 29 ) 
						{  if( !lsecond(el) )
						   {   en = lfirst( el );
					    	       el = lthird( el );
					    	       if( en == 1 )  el = list2( el, 0 );
					    	       else
					    	       {	el = rcons( el, en );
								el = list2( el, 1 );
								if( n < 11 ) n = 11;
					    	       }
						    }
						    else
						    {	el = list2( el, 24 );
							if(n<12) n=28;
							else if(n<28) n=29;
						    }
						}
						else el = list2( el, 31 );
					    }
					    else
					    {   if( k!=29) el = list2( Vh, el );
						if( k == 12 )
                                                {  el = list2( el, 2 );
						   n = 12;
						}
						else if( k == 22 )
                                                {  el = list2( el, 18 );
						   n = 22;
						}
						else if( k == 29 )  
						{     el = pnftoprip( rh, el, &sch1 );
						      if( sch1 )
						      {	el = prtopica( rh, el, &sch1 );
							el = list2( Vh, el );
							if( sch1 )  
							{ el = list2( el, 2 ); 
							  if( n < 12 )  n = 12;
							}
							else 
							{ el = list2( el, 3 );
							  if( n < 13 ) n = 13;		
							}
						      }
						      else
						      {	el = list2( Vh, el );
							el = list2( el, 25 );
						        n = 29;
						      }
						}
						else
						{  el = list2( el, 32 );
						   n = 36;
						}
					     }
					     N = lcomp( el, N );
					 }
					 else if( k == 29 )
					 {	el = pnftoprip( rh, el, &sch1 );
						if( sch1 )
						{   el = prtopica( rh, el, &sch1 );
						    el = list2( Vh, el );
						    if( sch1 )
						    {	el = list2( el, 2 );
							if( n < 12 ) n = 12;
							else if(n==28) n=29;
						    }
						    else
						    {	el = list2( el, 3 );
							if( n < 13 ) n = 13;
							else if(n==28) n=29;
						    }
						    N = lcomp( el, N );
						}	
						else sch =1;
					 }
					 else    sch =1;
				 }
				 else if( k == 29 )
				 {	el = pnftoprip( rh, el, &sch1 );
					if( sch1 )
					{   el = prtopica( rh, el, &sch1 );
					    el = list2( Vh, el );
					    if( sch1 )
					    {	el = list2( el, 2 );
						if( n < 12 ) n = 12;
						else if(n==28) n=29;
					    }
					    else
					    {	el = list2( el, 3 );
						if( n < 13 ) n = 13;
						else if(n==28) n=29;
					    }
					    N = lcomp( el, N );
					}	
					else sch =1;
				 }
				 else   sch = 1;
				 break;
			case 13: if( r != rn )
				 {      el = pvred( r, el, VL, &Vh );
					rh = llength( Vh );
					if( rh != r )
					{      H = usdiff( Vh, VN );
					       H = lconc( VN, H );
					       VN = vlsort( H, &J );
					       rn = llength( VN );
					}
					else
					{       VN = VL;  rn = r; }
				 }
				 else
				 {      Vh = VL; rh = r; }
				 if( r != rn || n < 13 )
				 {      if( !rh )
					{       if( ( n == 10 || n == 12 ) && calc_isint( el ) )
						{       el = lfirst( el );
							el = list2( el, 0);
						}
						else
						{       el = list2( el, 1 );
							if( n == 10 ) n = 11;
							else if( n == 12 ) n = 13;
						}
					}
					else
					{       s = 0;
						if( n == 10 || n == 12 )
						{       el = prtopica( rh, el, &s );
							if( !s )  n = 13;
							else      n = 12;
						}
						else if( n == 11 ) n = 13;
						el = list2( Vh, el );
						if( s ) el = list2( el, 2 );
						else    el = list2( el, 3 );
					}
					if( r == rn && n == 13 ) sch = 1;
					else   N = lcomp( el, N );
				 }
				 else   sch = 1;
				 break;
			case 14: el = list2( VL, el );
				 el = list2( el, 4 );
				 el = kenntest( el );
				 s = lsecond( el );
				 if( s > 1 )
				 {      J = lfirst( el );
					Vh = lfirst( J );
					rh = llength( Vh );
				 }
				 else
				 {      Vh = _0; rh = 0;   }
				 if( rh != r )
				 {      H = usdiff( Vh, VN );
					H = lconc( VN, H );
					VN = vlsort( H, &J );
					rn = llength( VN );
				 }
				 else
				 {       VN = VL;  rn = r; }
				 if( rn != r || n < 14 )
				 {       N = lcomp( el, N );
					 if( n == 10 )  n = s+10;
					 else if( n == 11 && s > 1 )
					 {       if( s < 4 ) n = 13;
						 else        n = 14;
					 }
					 else if( n == 12 && ( s == 1 || s == 3 ) )  n = 13;
					 else if( n == 12 && s == 4 )     n = 14;
					 else if( n == 13 && s == 4 )     n = 14;
					 if( rn == r && n == 14 ) sch = 1;
				 }
				 else          sch = 1;
				 break;
		}
		if( sch ) break;
		if( !k ) k = h;
	}
	if( sch )       return( c );
	N = linv( N );
	N = vlist( N, n );
	return( N );
}
