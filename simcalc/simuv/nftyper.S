/*C
			     nftyper( a1, a2, t1, t2, b1, b2 )
	"number field Typer ".
	single nftyper( a1,a2,t1,t2,b1,b2 ); obj a1,a2; single t1,t2;
					     obj *b1, *b2;
	X = nftyper( a1, a2, t1, t2, b1, b2 );

	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2, wobei wenig-
        stens eine der beiden Kennungen ein Element ueber einem Zahl-
        koerper auszeichnet. nftyper ermittelt die minimale gemeinsame
        Kennung X. Dabei werden die Objekte a1 und a2 ihrer neuen Ken-
        nung X entsprechend angepasst und in b1 und b2 zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      04.06.1992      U.Schneiders 
	Version  2      17.01.1995	S.Schmitt/U.Schneiders
					(R,C, Pol. ueber R und C)
H*/

#include<_calc.h>

single nftyper( a1, a2, t1, t2, b1, b2 )
obj a1, a2;
single t1, t2;
obj *b1, *b2;

{
	single t3, r;
	list VL, VL1, VL2;
	obj B1, B2;
	init( VL, VL1, VL2, B1, B2 );
	bind( a1, a2 );

	*b1 = 0; *b2 = 0;

	/*** Abfangen ungueltiger Angleichungen ***/

	if( ( t1 < 0 && t2 >= 0 ) || ( t1 >= 0 && t2 < 0 )
           || (t1>13 && t1<24 && t1!=15) || (t2>13 && t2<24 && t2!=15)
	   || t1 == 4 || t2 == 4 || t1 == 9 || t2 == 9
           || ( ( ( t1 >= 0 && t1 < 4 ) || t1 == 24 || t1 == 25 ) && t2 > 25 && t2 < 37 )		
           || ( ( ( t2 >= 0 && t2 < 4 ) || t2 == 24 || t2 == 25 ) && t1 > 25 && t1 < 37 )		
           || ( ( ( t1 > 4 && t1 < 9 ) || t1 == 26 || t1 == 27 ) && ( t2 == 24 || t2 == 25 || t2 == 28 || t2 == 29 ) )
           || ( ( ( t2 > 4 && t2 < 9 ) || t2 == 26 || t2 == 27 ) && ( t1 == 24 || t1 == 25 || t1 == 28 || t1 == 29 ) )
           || ( ( ( t1 > 9 && t1 < 14 ) || t1 == 28 || t1 == 29 ) && t2 < 28 )		
           || ( ( ( t2 > 9 && t2 < 14 ) || t2 == 28 || t2 == 29 ) && t1 < 28 ) )		
	{       mistake( 71 );
		return( -BASIS );
	}

	if( ( ( t1==15 || t1==37 || t1==38 || t1==39) && t2 > 25 ) 
         || ( ( t2==15 || t2==37 || t2==38 || t2==39) && t1 > 25 ) )
	{	mistake(71);
		return(ERROR);
	}
	if( t1==15 || t1==37 || t1==38 || t1==39 || t2==15 || t2==37 || t2==38 || t2==39 )
	{	VL = lfirst( varlist[nfsch].varwert );
		VL1 = list4( 2, 1, 0, 1 );
		if(!oequal(VL,VL1))
		{	mistake(71);
			return( -BASIS );
		}
	}

	/*** Typangleichung ***/

	if( ( ( t1 == 2 || t1 == 3 || t1 == 38 ) && t2 == 24 )
	 || ( ( t2 == 2 || t2 == 3 || t2 == 38 ) && t1 == 24 )
	 || ( t1==25 && t2 ==38 ) || ( t1==38 && t2==25 )
	 || ( ( t1 == 7 || t1 == 8 ) && t2 == 26 )
	 || ( ( t2 == 7 || t2 == 8 ) && t1 == 26 )
         || ( ( t1 == 12 || t1 == 13 ) && t2 == 28 )
	 || ( ( t2 == 12 || t2 == 13 ) && t1 == 28 ) ) t3 = smax( t1, t2 ) + 1;
	else if( ( t1==24 && t2==15 ) || ( t1==15 && t2==24 ) ) t3 = 37;
	else if( ( t1==25 && (t2==15 || t2==37) ) 
              || ( t2==25 && (t1==15 || t1==37) ) ) t3 = 39;
	else  t3 = smax( t1, t2 );

	switch( t2 )
	{ 	case 0: switch( t1 )
			{	case 24:*b1 = a1;
					*b2 = itonf( a2 );
					break;
				case 25:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					B2 = itonf( a2 );
					B2 = pvinsert( 0, B2, r );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
	 	case 1: switch( t1 )
			{	case 24:*b1 = a1;
					*b2 = rtonf( a2 );
					break;
				case 25:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					B2 = rtonf( a2 );
					B2 = pvinsert( 0, B2, r );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
	 	case 2: switch( t1 )
			{	case 24:VL = lfirst( a2 );
					r = llength( VL );
					B2 = lsecond( a2 );
					B2 = pitopnf( r, B2 );
					*b2 = list2( VL, B2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 25:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					r = llength( VL2 );
					a2 = pitopnf( r, a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
	 	case 3: switch( t1 )
			{	case 24:VL = lfirst( a2 );
					r = llength( VL );
					B2 = lsecond( a2 );
					B2 = prtopnf( r, B2 );
					*b2 = list2( VL, B2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 25:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					r = llength( VL2 );
					a2 = prtopnf( r, a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 15:switch( t1 )
			{	case 24:*b1 = nftocs( a1 );
					*b2 = fltoc( a2 );
					break;
				case 25:VL = lfirst( a1 );
					r = llength( VL );
					a1 = lsecond( a1 );
					B1 = pnftopcs( r, a1 );
					*b1 = list2( VL, B1 );
					B2 = fltoc( a2 );
					B2 = pvinsert( 0,B2,r );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 37:switch( t1 )
			{	case 24:*b1 = nftocs( a1 );
					*b2 = a2;
					break;
				case 25:VL = lfirst( a1 );
					r = llength( VL );
					a1 = lsecond( a1 );
					B1 = pnftopcs( r, a1 );
					*b1 = list2( VL, B1 );
					B2 = pvinsert( 0,a2,r );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 24:switch( t1 )
			{	case 0:*b2 = a2;
					*b1 = itonf( a1 );
					break;
				case 1:*b2 = a2;
					*b1 = rtonf( a1 );
					break;
				case 2: VL = lfirst( a1 );
					r = llength( VL );
					B1 = lsecond( a1 );
					B1 = pitopnf( r, B1 );
					*b1 = list2( VL, B1 );
					B2 = pvinsert( 0, a2, r );
					*b2 = list2( VL, B2 );
					break;
				case 3: VL = lfirst( a1 );
					r = llength( VL );
					B1 = lsecond( a1 );
					B1 = prtopnf( r, B1 );
					*b1 = list2( VL, B1 );
					B2 = pvinsert( 0, a2, r );
					*b2 = list2( VL, B2 );
					break;
				case 24:*b1 = a1;
					*b2 = a2;
					break;
				case 25:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					B2 = pvinsert( 0, a2, r );
					*b2 = list2( VL, B2 );
					break;
				case 15:*b1 = fltoc( a1 );
					*b2 = nftocs( a2 );
					break; 
				case 37:*b1 = a1;
					*b2 = nftocs( a2 );
					break;
				case 38:VL = lfirst( a1 );
					r = llength( VL );
					a1 = lsecond( a1 );
					B1 = pfltopc( r,a1 );
					*b1 = list2( VL, B1 );
					B2 = nftocs( a2 );
					B2 = pvinsert(0,B2,r);
					*b2 = list2( VL,B2 );
					break;
				case 39:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					B2 = nftocs( a2 );
					B2 = pvinsert(0,B2,r);
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 25:switch( t1 )
			{	case 0: *b2 = a2;
  				        VL = lfirst( a2 );
					r = llength( VL );
					B1 = itonf( a1 );
					B1 = pvinsert( 0, B1, r );
					*b1 = list2( VL, B1 );
					break;
				case 1: *b2 = a2;
  				        VL = lfirst( a2 );
					r = llength( VL );
					B1 = rtonf( a1 );
					B1 = pvinsert( 0, B1, r );
					*b1 = list2( VL, B1 );
					break;
				case 2: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					a1 = pitopnf( r, a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 3: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					a1 = prtopnf( r, a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 24:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 25:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 15:VL = lfirst(a2);
					r = llength(VL);
					a2 = lsecond(a2);
					B2 = pnftopcs( r,a2 );
					*b2 = list2(VL,B2);
					B1 = fltoc( a1 );
					B1 = pvinsert(0,B1,r);
					*b1 = list2(VL,B1);
					break;
				case 37:VL = lfirst(a2);
					r = llength(VL);
					a2 = lsecond(a2);
					B2 = pnftopcs( r,a2 );
					*b2 = list2(VL,B2);
					B1 = pvinsert(0,a1,r);
					*b1 = list2(VL,B1);
					break;
				case 38:VL1 = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL1);
					a1 = pfltopc(r,a1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					r = llength(VL2);
					a2 = pnftopcs( r,a2);
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2 );
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
				case 39:VL1 = lfirst(a1);
					a1 = lsecond(a1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					r = llength(VL2);
					a2 = pnftopcs( r,a2);
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2 );
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
			}
			break;
		case 38:switch( t1 )
			{	case 24:VL = lfirst(a2);
					r = llength(VL);
					a2 = lsecond(a2);
					B2 = pfltopc( r,a2);
					*b2 = list2( VL, B2 );
					B1 = nftocs( a1 );
					B1 = pvinsert( 0,B1,r );
					*b1 = list2(VL,B1);
					break;
				case 25:VL1 = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL1);
					a1 = pnftopcs( r,a1 );
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					r = llength(VL2);
					a2 = pfltopc( r,a2 );	
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2 );
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
			}
			break;
		case 39:switch( t1 )
			{	case 24:VL = lfirst(a2);
					r = llength(VL);
					*b2 = a2;
					B1 = nftocs( a1 );
					B1 = pvinsert( 0,B1,r );
					*b1 = list2(VL,B1);
					break;
				case 25:VL1 = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL1);
					a1 = pnftopcs( r,a1 );
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2 );
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
			}
			break;
		case 5:
		case 6:
		case 7:
		case 8:
		case 26:
		case 27:t3 = manftyper( a1,a2,t1,t2,&B1,&B2 );
			if( t3 == ERROR ) return( t3 );
			*b1 = B1;
			*b2 = B2;
			break;
		case 10:
		case 11:
		case 12:
		case 13:
		case 28:
		case 29:t3 = vecnftyper( a1,a2,t1,t2,&B1,&B2 );
			if( t3 == ERROR ) return( t3 );
			*b1 = B1;
			*b2 = B2;
			break;
	}
	return( t3 );
}
