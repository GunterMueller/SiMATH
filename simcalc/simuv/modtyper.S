/*C
			     modtyper( a1, a2, t1, t2, b1, b2, esch )
	"Z/mZ Typer ".
	single modtyper( a1,a2,t1,t2,b1,b2,esch ); obj a1,a2; 
					single t1,t2,esch; obj *b1, *b2;
	X = modtyper( a1, a2, t1, t2, b1, b2, esch );

	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2, wobei wenig-
        stens eine der beiden Kennungen ein Element ueber Z/mZ aus-
        zeichnet. modtyper ermittelt die minimale gemeinsame Kennung
        X. Dabei werden die Objekte a1 und a2 ihrer neuen Kennung X
        entsprechend angepasst und in b1 und b2 zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      06.07.1992      U.Schneiders 
H*/

#include<_calc.h>

single modtyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{
	single sch=0, t3, r;
	int M, N;
	list VL, VL1, VL2;
	obj H, B1, B2;
	init( VL, VL1, VL2, M, N, H, B1, B2 );
	bind( a1, a2 );

	*b1 = 0; *b2 = 0;

	/*** Abfangen ungueltiger Angleichungen ***/

	if( ( t1 < 0 && t2 >= 0 ) || ( t1 >= 0 && t2 < 0 )
           || ( t1 > 13 && t1 < 17 ) || ( t2 > 13 && t2 < 17 )
	   || t1 > 22 || t2 > 22
	   || t1 == 4 || t2 == 4 || t1 == 9 || t2 == 9 || t1 == 37 
	   || t2 == 37 || t1 == 38 || t2 == 38 || t1 == 39 || t2 == 39
           || ( ( ( t1 >= 0 && t1 < 4 ) || t1 == 17 || t1 == 18 ) && t2 > 18 )		
           || ( ( ( t2 >= 0 && t2 < 4 ) || t2 == 17 || t2 == 18 ) && t1 > 18 )		
           || ( ( ( t1 > 4 && t1 < 9 ) || t1 == 19 || t1 == 20 ) && ( t2 == 17 || t2 == 18 || t2 == 21 || t2 == 22 ) )
           || ( ( ( t2 > 4 && t2 < 9 ) || t2 == 19 || t2 == 20 ) && ( t1 == 17 || t1 == 18 || t1 == 21 || t1 == 22 ) )
           || ( ( ( t1 > 9 && t1 < 14 ) || t1 == 21 || t1 == 22 ) && t2 < 21 )		
           || ( ( ( t2 > 9 && t2 < 14 ) || t2 == 21 || t2 == 22 ) && t1 < 21 ) )		
	{       if(esch) mistake( 71 );
		return( -BASIS );
	}

	/*** Typangleichung ***/

	if( ( ( t1 == 2 || t1 == 3 ) && t2 == 17)
	 || ( ( t2 == 2 || t2 == 3 ) && t1 == 17 )
	 || ( ( t1 == 7 || t1 == 8 ) && t2 == 19 )
	 || ( ( t2 == 7 || t2 == 8 ) && t1 == 19 )
         || ( ( t1 == 12 || t1 == 13 ) && t2 == 21 )
	 || ( ( t2 == 12 || t2 == 13 ) && t1 == 21 ) ) t3 = smax( t1, t2 ) + 1;
	else  t3 = smax( t1, t2 );

	if( t1 < t2 )
	{       sch = 1;
		H = a1;
		a1 = a2;
		a2 = H;
		H = t1;
		t1 = t2;
		t2 = H;
	}
	if( t1 == 17 && t2 == 17 )
	{	*b1 = a1;
		*b2 = a2;
		return( 17 );
	}
	M = lfirst( varlist[modsch].varwert );

	switch( t2 )
	{ 	case 0: switch( t1 )
			{	case 17:*b1 = a1;
			                if( ssch ) *b2 = mshom( M, a2 );
					else       *b2 = mihom( M, a2 );
					break;
				case 18:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
			                if( ssch ) B2 = mshom( M, a2 );
					else       B2 = mihom( M, a2 );
					B2 = pvinsert( 0, B2, r );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 1: N = lsecond( a2 );
	                if ( igcd( N, M ) != 1 )
			{       if(esch) mistake2( 233, a2, M );
		        	return( ERROR );
			}
	 	        N = miinv( M, N );
			a2 = lfirst( a2 );
			if( ssch )
			{       a2 = mshom( M, a2 );
				B2 = msprod( M, a2, N );
                        }         
			else    
			{ 	a2 = mihom( M, a2 );
				B2 = miprod( M, a2, N );
                       	}
			switch( t1 )
			{	case 17:*b1 = a1;
					*b2 = B2;
					break;
				case 18:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					B2 = pvinsert( 0, B2, r );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
	 	case 2: switch( t1 )
			{	case 17:VL = lfirst( a2 );
					r = llength( VL );
					B2 = lsecond( a2 );
					if( ssch )  B2 = pitopms( r, B2, M );
					else        B2 = pitopmi( r, B2, M );
					*b2 = list2( VL, B2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 18:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					r = llength( VL2 );
					if( ssch )  a2 = pitopms( r, a2, M );
					else        a2 = pitopmi( r, a2, M );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
	        case 3:	VL = lfirst( a2 );
			a2 = lsecond( a2 );
			r = llength( VL );
			B2 = prnumden( r, a2, &N );
			if( igcd( M, N ) != 1 )
			{       if(esch) mistake1( 242, M );
				return( ERROR );
			}
			N = miinv( M, N );
			if( ssch )
			{	B2 = pitopms( r, B2, M );
				B2 = pmsmsprod( r, M, B2, N );
                        }
			else      
			{	B2 = pitopmi( r, B2, M );
				B2 = pmimiprod( r, M, B2, N );
                        }
	 	        switch( t1 )
			{	case 17:*b2 = list2( VL, B2 );
				        B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 18:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = pvmix( VL1, VL, a1, B2, &B1, &a2 );
					*b1 = list2( VL2, B1 );
					*b2 = list2( VL2, a2 );
					break;
			}
			break;
		case 17:*b1 = a1;
			VL = lfirst( a1 );
			r = llength( VL );
			B2 = pvinsert( 0, a2, r );
			*b2 = list2( VL, B2 );
			break;
		case 18:VL1 = lfirst( a1 );
			a1 = lsecond( a1 );
			VL2 = lfirst( a2 );
			a2 = lsecond( a2 );
			VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
			*b1 = list2( VL, B1 );
			*b2 = list2( VL, B2 );
			break;
		case 5:
		case 6:
		case 7:
		case 8:
		case 19:
		case 20:t3 = mamodtyper( a1,a2,t1,t2,&B1,&B2,esch );
			if( t3 == ERROR ) return( t3 );
			*b1 = B1;
			*b2 = B2;
			break;
		case 10:
		case 11:
		case 12:
		case 13:
		case 21:
		case 22:t3 = vecmodtyper( a1,a2,t1,t2,&B1,&B2,esch );
			if( t3 == ERROR ) return( t3 );
			*b1 = B1;
			*b2 = B2;
			break;
	}

	if( sch )
	{       H = *b1;
		*b1 = *b2;
		*b2 = H;
	}
	return( t3 );
}
