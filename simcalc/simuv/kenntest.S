/*C
			kenntest( c )

	"Kennungstest"
	list kenntest( c );
	list c;

	kenntest untersucht, ob eine Variable ueber Q oder ein Poly-
	nom ueber Q echt rational ist; falls nicht, so werden beide
	entsprechend umgeformt und ueber Z dargestellt.
	Handelt es sich bei einem Polynom um eine Konstante, so formt
	es kenntest in eine Variable um. Rationale Polynome werden
	auf ihre einfachst moegliche Form gebracht.
	Ist c eine reelle Zahl, die schon aus Z ist, so wird sie in
	diese Darstellung umgewandelt.

	Warnung: Es darf keine leere Polynomvariablenliste  ueberge-
		 ben werden!

	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      7.12.87         C.Hollinger/U.Schneiders
	Version  1.2   13.10.89         C.Hollinger/U.Schneiders
					   ( Null abfangen )
	Version  1.3   03.12.90         U.Schneiders ( ellip. Kurve )
	Version  1.4   26.08.91         U.Schneiders ( Matr., Vekt. )
	Version  1.5   14.01.92         U.Schneiders ( Reelle Zahlen )
	Version  1.6   15.05.92         U.Schneiders ( M und NF )
	Version  1.7   06.04.1993	S.Schmitt/U.Schneiders
	Version  1.8   12.07.1993	U.Schneiders
	Version  1.9   31.08.1993	U.Schneiders (NF -> Q)
	Version  1.10  07.12.1993	U.Schneiders (NF -> Q fuer Pkte)
	Version  1.11  10.07.1996	S.Schmitt (ecqnfsch neu)
H*/
 
#include <_calc.h>

list kenntest( c )
list c;

{
	list A, P, A1, A2,VL,VL1, VL2, hz, T;
	single erg, n, r, sch, na, za , z2;
	obj ZA, Za, NA, Na, wert, w ,z,z1;
	int nenn, Z, N, pQ, pR;
	init( A, P, A1, A2 );
	init( ZA, Za, NA, Na, wert, w, z, z1, nenn, Z, N, pQ, pR );
	init( VL, VL1, VL2, hz, T );
	bind( c );

	if ( c == -BASIS ) return( -BASIS );
	A = lfirst( c );
	n = lsecond( c );
	if( ( A == 0 && n != (-3 ) && n != (-7) && n != (-11) && n != (-15)  && n!=15 && n != 17 && n != 31  && n!=37 ) 
	|| ( ( ( n > 1 && n < 5 ) || n == 25 ) && lsecond( A ) == 0 ) )
	{     c = list2( 0, 0 );
	      return( c );
	}

	switch( n )
	{       case 1: N = lsecond( A );
			if ( N == 1 ) {
				Z = lfirst( A );
				c = list2( Z, 0 );
			}
			else
			{       Z = lfirst( A );
				nenn = iqrem( Z, N, &pQ, &pR );
				if( pR == 0 )  c = list2( pQ, 0 );
			}
			break;
		case 24:if( !lsecond(A) )
			{	N = lfirst( A );
				A = lthird( A );
				if( N == 1 )  c = list2( A, 0 );
				else
				{	A = rcons( A, N );
					c = list2( A, 1 );
				}
			}
			break;
		case 2:
		case 18:
		case 25:
		case 32:
		case 38:
		case 39:VL = lfirst( A );
			r = llength( VL );
			A = lsecond( A );
			P = pvred( r, A, VL, &A2 );
			r = llength( A2 );
			if ( !r )
		        { 	if( n == 2 ) c = list2( P, 0 );
				else if( n == 18 ) c = list2( P, 17 );
				else if( n == 25 ) 
				{    if( !lsecond(P) )
				     {	N = lfirst( P );
					A = lthird( P );
					if( N == 1 )  c = list2( A, 0 );
					else
					{	A = rcons( A, N );
						c = list2( A, 1 );
					}
				     }
				     else c = list2( P, 24 );
				}
				else if( n == 32 ) c = list2( P, 31 );
				else if( n == 38 ) c = list2( P, 15 );
				else
				{	if(!P) c=list2(0,15);
					else if(!lsecond(P))
					{	P=lfirst(P);
						c=list2(P,15);
					}	
					else c=list2(P,37);
				}
			}
			else
		        {   if( n == 25 )
			    {   P = pnftoprip( r, P, &sch );
				if( sch )
				{	P = prtopica( r, P, &sch );
					c = list2( A2, P );
					if( sch )  c = list2( c, 2 ); 
					else       c = list2( c, 3 );
				}
				else
				{	c = list2( A2, P );
					c = list2( c, 25 );
				}
			    }
			    else if( n == 39 )
			    {	P=pctopflip( r, P, &sch );
				c=list2(A2,P);
				if(sch) c=list2(c,38);
				else c=list2(c,39);
			    }
			    else
			    {	c = list2( A2, P );
			    	c = list2( c, n );
			    }
			}
			break;
		case 3: VL = lfirst( A );
			r = llength( VL );
			A = lsecond( A );
			P = pvred( r, A, VL, &A2 );
			r = llength( A2 );
			if ( !r ) {
				erg = calc_isint( P );
				if ( erg ) {
					P = lfirst( P );
					c = list2( P, 0 );
				}
				else c = list2( P, 1 );
			}
			else {
				P = prtopica( r, P, &sch );
				c = list2( A2, P );
				if ( sch ) c = list2( c, 2 );
				else c = list2( c, 3 );
			}
			break;
		case 4: VL = lfirst( A );
			A = lsecond( A );
			ZA = lfirst( A );
			NA = lsecond( A );
			ZA = list2( VL,ZA );
			ZA = list2( ZA, 2 );
			ZA = kenntest( ZA );
			z1 = lfirst( ZA );
			z2 = lsecond( ZA );
			if( z1 == 0 && z2 == 0 )     c = list2( 0,0 );
			else
			{       NA = list2( VL,NA );
				NA = list2( NA, 2 );
				NA = kenntest( NA );
				na = lsecond( NA );
				switch( na )
				{       case 0: wert = lfirst( NA );
						if( wert == 1 )
						c = ZA;
						else
						{ hz = list2( 1 ,wert);
						  za = lsecond( ZA );
						  if( za < 2 )
						  {  ZA = calc_prod( hz, lfirst( ZA ),1,za );
						     ZA = kenntest( ZA );
						     c = ZA;
						  }
						  else
						  {  ZA = lfirst( ZA );
						     ZA = calc_prod( hz,ZA, 1, za );
						     ZA = kenntest( ZA );
						     c = ZA;
						  }
						}
						break;
					case 1: w = lfirst( NA );
						wert = linv( w );
						za = lsecond( ZA );
						if( za < 2 )
						{  ZA = calc_prod( wert, lfirst( ZA ),1,za );
						   ZA = kenntest( ZA );
						   c = ZA;
						 }
						else
						{  ZA = lfirst( ZA );
						   ZA = calc_prod( wert,ZA, 1, za );
						   ZA = kenntest( ZA );
						   c = ZA;
						 }
						 break;
					 case 2: za = lsecond( ZA );
						 ZA = lfirst( ZA );
						 NA = lfirst( NA );
						 VL = lfirst( NA );
						 r = llength( VL );
						 NA = lsecond( NA );
						 if( za == 0 )
						 { ZA = pvinsert( 0, ZA, r );
						   ZA = rfrcons( r, ZA, NA );
						   ZA = list2( VL,ZA );
						   ZA = list2( ZA,4 );
						 }
						 else
						 { if( za == 1 )
						   {  z = lfirst( ZA );
						      z = pvinsert( 0, z, r );
						      nenn = lsecond( ZA );
						      NA = list2( VL, NA );
						      NA = calc_prod( NA, nenn, 2, 0 );
						      NA = lfirst( NA );
						      NA = lsecond( NA );
						      ZA = rfrcons( r, z, NA );
						      ZA = list2( VL,ZA );
						      ZA = list2( ZA,4 );
						   }
						   else
						   {  VL1 = lfirst( ZA );
						      ZA = lsecond( ZA );
						      VL2 = pvmix( VL1, VL, ZA, NA, &Za, &Na );
						      r = llength( VL2 );
						      ZA = rfrcons( r, Za, Na );
						      ZA = list2( VL2,ZA );
						      ZA = list2( ZA,4 );
						   }
						 }
						 c = ZA;
						 break;
				}
			}
			break;
		case 6:
		case 7:
		case 8:
		case 9:
		case 20:
		case 27:
		case 34:c = matrkenn( c );
			break;
		case 11:
		case 12:
		case 13:
		case 14:
		case 22:
		case 29: 
		case 36: c = veckenn( c );
			 break;
	/**	case 15: na = lfirst( A );
			 if( na >= 0 )
			 {      A = lred( A );
				while( na-- )  A = lcomp( 0,A );
				if( llength( A ) == 1 ) A = lfirst( A );
				c = list2( A, 0 );
			 }
			 break;**/
		case 37: if( !A ) c = list2(0,15 );
			 else if(!lsecond(A))
			 {	A = lfirst(A);
				/***na = lfirst(A);
				if(na >= 0)
				{	A = lred(A);
					while(na--) A=lcomp(0,A);
					if(llength(A) == 1) A=lfirst(A);
					c=list2(A,0);
				}
				else  c=list2(A,15);***/
				c=list2(A,15);
			 }
			 break;
		case (-2):wert=lfirst(A);
			  wert=lfirst(wert);
			  ZA=lfirst(wert);
			  Za=lsecond(wert);
			  NA=lthird(wert);
			  if(!ZA && !Za && !NA)  c = list2( A, (-1) );

			break;
		case (-6): if( !lfirst( A ) && !lsecond( A ) && !lthird( A ) )
			   {    A = lred3( A );
				c = list2( A, (n+1) );
			   }
			break;
		case (-9): if(ecqnfsch!=_0)
			   {	A=lfirst(A);
				A=lfirst(A);
				A=lred3(A);
			   }
			   w = lfirst( A );
			   wert = lsecond( A );	
			   if( (!wert || !lsecond( wert )) && (!w || !lsecond( w )) )
			   {	if( w )
				{	Na = lfirst( w );
					w = lthird( w );
					w = rcons( w, Na );
				}
				if( wert )
				{	NA = lfirst( wert );
					wert = lthird( wert );
					wert = rcons( wert, NA );
				}
				c = ecrinit( 0,0,0, w, wert );
				c = list2( c, (-1) );
			   }
			   break;
		case (-10):if(ecqnfsch!=_0)
			   {	P=A;
				A=lfirst(A);
				A=lfirst(A);
			   }
			   if( !lfirst( A ) && !lsecond( A ) && !lthird( A ) )
			   {    A = lred3( A );
				w = lfirst( A );
			   	wert = lsecond( A );	
			   	if( (!wert || !lsecond( wert )) && (!w || !lsecond( w )) )
			   	{	if( w )
					{	Na = lfirst( w );
						w = lthird( w );
						w = rcons( w, Na );
					}
					if( wert )
					{	NA = lfirst( wert );
						wert = lthird( wert );
						wert = rcons( wert, NA );
					}
					c = ecrinit( 0,0,0, w, wert );
					c = list2( c, (-1) );
			   	}
				else 	
				{	if(ecqnfsch!=_0) c=list2(P,(-9));
					else c = list2( A, (-9) );
				}
			   }
			   else
			   {	w = lfirst( A );
				z = lsecond( A );
				wert = lthird( A );
				z1 = lfourth( A );
				Za = lfifth( A );
				if( (!wert || !lsecond( wert ) ) &&
				    (!w || !lsecond( w ) ) &&
				    (!z || !lsecond( z ) ) &&
				    (!z1 || !lsecond( z1 ) ) &&
				    (!Za || !lsecond( Za ) ) )
				{	if( w )
					{	Na = lfirst( w );
						w = lthird( w );
						w = rcons( w, Na );
					}	
					if( wert )
					{	Na = lfirst( wert );
						wert = lthird( wert );
						wert = rcons( wert, Na );
					}	
					if( z )
					{	Na = lfirst( z );
						z = lthird( z );
						z = rcons( z, Na );
					}	
					if( z1 )
					{	Na = lfirst( z1 );
						z1 = lthird( z1 );
						z1 = rcons( z1, Na );
					}	
					if( Za )
					{	Na = lfirst( Za );
						Za = lthird( Za );
						Za = rcons( Za, Na );
					}	
					c = ecrinit( w, z, wert, z1, Za );
					c = list2( c, (-2) );
				}	
			   }
			   break;
		case (-11): if( !A ) 
			    {	c = list3( 0,1,0 );
				c = list2( c, (-3) );	
			    }
			    else
			    {	wert = lfirst( A );
				w = lsecond( A );
				if( (!wert || !lsecond( wert )) && (!w || !lsecond( w )) )
				{	if( (!wert || lfirst(wert) == 1)
					 && (!w || lfirst(w) == 1 ) )
					{	if( wert ) wert = lthird( wert );
						if( w ) w = lthird( w );
						c = list3( wert, w, 1 );
						c = list2( c, (-3) );
					}
					else
				        {	if( wert )
						{	Za = lthird( wert );
							Na = lfirst( wert );
							Za = rcons( Za, Na );
						}
						else
						{	Za = 0;
							Na = 1;
						}
				        	if( w )
						{	ZA = lthird( w );
							NA = lfirst( w );
							ZA = rcons( ZA, NA );
						}
						else
						{	ZA = 0;
							NA = 1;
						}
						Na = ilcm( Na, NA );
						NA = itor( Na );
						Za = rprod( Za, NA );
						ZA = rprod( ZA, NA );
					        if( Za ) Za = lfirst(Za);
						if( ZA ) ZA = lfirst(ZA);
						Za = iprod( Za, Na );
						ZA = iprod( ZA, Na );
						ZA = iprod( ZA, Na );
						c = list3( Za, ZA, Na );
						c = list2( c, (-3) );
					}
				}
			   }
			break;
		case (-12): if( !lthird( A ) )
			    {	c = list3( 0,1,0 );
				c = list2( c, (-4) );
			    }
			    else
			    {	wert = lfirst( A );
				w = lsecond( A );
				z = lthird( A );
				if( (!wert || !lsecond( wert )) && (!w || !lsecond( w )) && !lsecond(z) )
				{       if( (!wert || lfirst(wert) == 1)
					 && (!w || lfirst(w) == 1 ) 
					 && lfirst( z ) == 1 )
					{	if( wert ) wert = lthird( wert );
						if( w ) w = lthird( w );
						z = lthird( z );
						c = list3( wert, w, z );
						c = list2( c, (-4) );
					}
					else
					{	if( wert )
						{ Za = lthird( wert );
						  Na = lfirst( wert );
						  Za = rcons( Za, Na );
						}
						else
						{ Za = 0;
						  Na = 1;
						}
						if( w )
						{ ZA = lthird( w );
						  NA = lfirst( w );
						  ZA = rcons( ZA, NA );
						}
						else
						{ ZA = 0;
						  NA = 1;
						}
						z1 = lfirst( z );
						z = lthird( z );
						z = rcons( z, z1 );
						Na = ilcm( Na, NA );
						Na = ilcm( Na, z1 );
						Na = itor( Na );
						z = rprod( z, Na );
						z = lfirst( z );
						wert = rprod( wert, Na );
						if( wert ) wert = lfirst( wert );
						wert = iprod( wert, z );
						w = rprod( w, Na );
						if( w ) w = lfirst( w );
						w = iprod( w, z );
						w = iprod( w, z );
						c = list3( wert, w, z );
						c = list2( c, (-4) );
					}
				}
			   }
			   break;
		default:break;
	}
	return ( c );
}
