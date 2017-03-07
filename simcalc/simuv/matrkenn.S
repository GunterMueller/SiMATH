/*C
			matrkenn( c )

	"Matrix-Kennungstest"
	list matrkenn( c );
	list c;

	matrkenn untersucht, ob eine Matrix mit Elementen
	aus Q   nur aus Elementen       aus Z
	aus P(Z) "   "      "           aus Z
	aus P(Q) "   "      "           aus Z bzw. Q bzw. P(Z)
	aus F(Q) "   "      "           aus Z bzw. Q bzw. P(Z) bzw. P(Q)
	besteht. Falls ja, wird die Matrix ueber dem entsprechenden
	Bereich dargestellt.
	Ausserdem wird die Matrix, falls sie aus Polynomen bzw. rationa-
	len Funktionen besteht, bzgl. der kleinst moeglichen Variablen-
	liste dargestellt.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      26.08.1991      U.Schneiders
	Version  1.1    12.07.1993      U.Schneiders
	Version  1.2    01.09.1993      U.Schneiders ( NF -> Q )
H*/
/*cS
	matrkenn ruft auf: calc_isint, iqrem, kenntest, lcomp, lconc
			   lcopy, linv, llength, mlist, pnftoprip, prtopica,
			   pvred, rcons, usdiff, vlsort
	Macros: lfirst, list2, lred, lsecond, lthird
Sc*/
 
#include <_calc.h>

list matrkenn( c )
list c;
{
	list el, en, pQ, H, J, M, N, T, Vh, VL, VN, Z;
	single h, k, n, r, rh, rn, s, sch, sch1;
	init( el, en, pQ, H, J, M, N, T, Vh, VL, VN, Z );
	bind( c );

	M = lcopy( c );
	k = lsecond( M );
	M = lfirst( M );
	if( k > 6 )          
	{       VL = lfirst( M );
		r = llength( VL );
		M = lsecond( M );
	}
	N = _0; sch = 0; VN = _0; rn = 0;
        if( k < 10 )  n = 5;
	else if( k < 23 )  n = 19;
	else if( k < 30 )  n = 5;
	else n = 33;
	while( M != _0 )
	{       Z = lfirst( M );
		M = lred( M );
		T = _0;
		while( Z != _0 )
		{       el = lfirst( Z );
			Z = lred( Z );
			if( !el )
			{       if( k < 10 ) el = list2( 0, 0 );
				else if( k < 23 ) el = list2( 0, 17 );
				else if( k < 30 ) el = list2( 0, 0 );
				else el = list2( 0, 31 );
				T = lcomp( el, T );
				h = k;
				k = 0;
			}
			switch( k )
			{       case  6: en = lsecond( el );
					 if( en == 1 )
					 {  el = lfirst( el );
				            el = list2( el, 0 );
                                            T = lcomp( el, T );
					 }
					 else
					 {  J = lfirst( el );
					    iqrem( J, en, &pQ, &en );
					    if( en == 0 )
					    {   pQ = list2( pQ, 0 );
						T = lcomp( pQ, T );
                                            }
					    else sch = 1;
					 }
					 break;
				case 26:if( !lsecond(el) )
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
				case  7: 
				case 20: 
				case 27: 
				case 34: el = pvred( r, el, VL, &Vh );
					 rh = llength( Vh );
					 if( rh != r )
					 {  H = usdiff( Vh, VN );
					    H = lconc( VN, H );
					    VN = vlsort( H, &J );
					    rn = llength( VN );
					    if( r != rn )
					    {   if( !rh )
					        {   if( k == 7 )  el = list2( el, 0 );
                                                    else if( k == 20 ) el = list2( el, 17 );
						    else if( k == 27 ) 
						    {  if( !lsecond(el) )
							{   en = lfirst( el );
					    		    el = lthird( el );
					    		    if( en == 1 )  el = list2( el, 0 );
					    		    else
					    		    {	el = rcons( el, en );
								el = list2( el, 1 );
								if( n < 6 ) n = 6;
					    		   }
							}
							else
							{	el = list2( el, 24 );
								if(n<6) n = 26;
								else if(n<26) n=27;
							}
						    }
						    else el = list2( el, 31 );
						}
						else
						{   if( k!=27 ) el = list2( Vh, el );
						    if( k == 7 )
                                                    {  el = list2( el, 2 );
						       n = 7;
                                                    }
						    else if( k == 20 )
                                                    {  el = list2( el, 18 );
						       n = 20;
					            }	
						    else if( k == 27 )  
						    {     el = pnftoprip( rh, el, &sch1 );
							  if( sch1 )
							  {	el = prtopica( rh, el, &sch1 );
								el = list2( Vh, el );
								if( sch1 )  
								{ el = list2( el, 2 ); 
								  if( n < 7 )  n = 7;
								}
								else 
								{ el = list2( el, 3 );
								  if( n < 8 ) n = 8;		
								}
							  }
							  else
							  {	el = list2( Vh, el );
								el = list2( el, 25 );
						                n = 27;
							  }
						    }
						    else
						    {	el = list2( el, 32 );
							n = 34;
						    }
						}
						T = lcomp( el, T );
					    }
					    else if( k == 27 )
					    {	el = pnftoprip( rh, el, &sch1 );
						if( sch1 )
						{   el = prtopica( rh, el, &sch1 );
						    el = list2( Vh, el );
						    if( sch1 )
						    {	el = list2( el, 2 );
							if( n < 7 ) n = 7;
							else if(n==26) n=27;
						    }
						    else
						    {	el = list2( el, 3 );
							if( n < 8 ) n = 8;
							else if(n==26) n=27;
						    }
						    T = lcomp( el, T );
						}	
						else sch =1;
					    }
					    else sch = 1;
					 }
					 else if( k == 27 )
					 {   el = pnftoprip( rh, el, &sch1 );
					     if( sch1 )
					     {   el = prtopica( rh, el, &sch1 );
					         el = list2( Vh, el );
					         if( sch1 )
					         {	el = list2( el, 2 );
							if( n < 7 ) n = 7;
							else if(n==26) n=27;
					         }
					         else
					         {	el = list2( el, 3 );
							if( n < 8 ) n = 8;
							else if(n==26) n=27;
					         }
					         T = lcomp( el, T );
					     }	
					     else sch =1;
					 }
					 else   sch = 1;
					 break;
				case  8: if( r != rn )
					 {  el = pvred( r, el, VL, &Vh );
					    rh = llength( Vh );
					    if( rh != r )
					    {  H = usdiff( Vh, VN );
					       H = lconc( VN, H );
					       VN = vlsort( H, &J );
					       rn = llength( VN );
					    }
					    else
					    {  VN = VL;  rn = r; }
					 }
					 else
					 {   Vh = VL; rh = r; }
					 if( r != rn || n < 8 )
					 {  if( !rh )
					    {   if( ( n == 5 || n == 7 ) && calc_isint( el ) )
						{   el = lfirst( el );
						    el = list2( el, 0);
						}
						else
						{   el = list2( el, 1 );
						    if( n == 5 ) n = 6;
						    else if( n == 7 ) n = 8;
						}
					     }
					     else
					     {  s = 0;
						if( n == 5 || n == 7 )
						{  el = prtopica( rh, el, &s );
						   if( !s )  n = 8;
						   else      n = 7;
					        }		
						else if( n == 6 ) n = 8;
						el = list2( Vh, el );
						if( s ) el = list2( el, 2 );
						else    el = list2( el, 3 );
					     }
					     if( r == rn && n == 8 ) sch = 1;
					     else   T = lcomp( el, T );
					 }
					 else   sch = 1;
					 break;
				case  9: el = list2( VL, el );
					 el = list2( el, 4 );
					 el = kenntest( el );
					 s = lsecond( el );
					 if( s > 1 )
					 {  J = lfirst( el );
					    Vh = lfirst( J );
					    rh = llength( Vh );
					 }
					 else
					 {  Vh = _0; rh = 0;   }
					 if( rh != r )
					 {  H = usdiff( Vh, VN );
					    H = lconc( VN, H );
					    VN = vlsort( H, &J );
					    rn = llength( VN );
					 }
					 else
					 {  VN = VL;  rn = r; }
					 if( rn != r || n < 9 )
					 {  T = lcomp( el, T );
					    if( n == 5 )  n = s+5;
					    else if( n == 6 && s > 1 )
					    {    if( s < 4 ) n = 8;
						 else        n = 9;
					    }
					    else if( n == 7 && ( s == 1 || s == 3 ) )  n = 8;
					    else if( n == 7 && s == 4 )     n = 9;
					    else if( n == 8 && s == 4 )     n = 9;
					    if( rn == r && n == 9 ) sch = 1;
					 }
					 else          sch = 1;
					 break;
			}
			if( sch ) break;
			if( !k ) k = h;
		}
		if( sch ) break;
		T = linv( T );
		N = lcomp( T, N );
	}
	if( sch )       return( c );
	N = linv( N );
	N = mlist( N, n );
	return( N );
}
