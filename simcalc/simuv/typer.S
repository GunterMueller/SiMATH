/*C
			     typer( a1, a2, t1, t2, b1, b2, esch )
	"Typer".
	single typer( a1, a2, t1, t2, b1, b2, esch );  obj a1, a2; 
					single t1, t2, esch; obj *b1, *b2;
	X = typer( a1, a2, t1, t2, b1, b2, esch );

	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. typer er-
	mittelt die minimale gemeinsame Kennung X. Dabei werden die
	Objekte a1 und a2 ihrer neuen Kennung X entsprechend ange-
	passt und in b1 und b2 zurueckgegeben.
	esch gibt an, ob die Fehlermeldungen gedruckt werden.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      20.06.1988      C.Hollinger/U.Schneiders
	Version  2      24.10.1988      C.Hollinger/U.Schneiders
	Version  2.1    10.07.1989      C.Hollinger/U.Schneiders
	Version  3      20.01.1992      U.Schneiders ( Reelle Zahlen )
	Version  3.1    04.06.1992      U.Schneiders ( mod und NF )
	Version  4	17.01.1995	S.Schmitt/U.Schneiders
				  	(Pol. ueber R und C)
H*/

#include<_calc.h>

single typer( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{
	single t3, r;
	list VL, VL1, VL2;
	obj n1, n2, z1, z2, bz1, bn1, bz2, bn2, B1, B2;
	init( VL, VL1, VL2, n1, n2, z1, z2, bz1, bn1, bz2, bn2, B1, B2 );
	bind( a1, a2 );

	*b1 = 0; *b2 = 0;

	/*** Typer fuer Rechnungen ueber endlichen Koerpern ***/

	if( ( t1 > 29 && t1 < 37 ) || ( t2 > 29 && t2 < 37 ) )
	{	t3 = gftyper( a1,a2,t1,t2,&B1,&B2,esch );
		if( t3 == ERROR ) return( ERROR );
		*b1 = B1;
		*b2 = B2;
		return(t3);
	}

	/*** Typer fuer Rechnungen ueber Z/mZ ***/
	
	if( ( t1 > 15 && t1 < 23 ) || ( t2 > 15 && t2 < 23 ) )
	{     t3 = modtyper( a1,a2,t1,t2,&B1,&B2,esch );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = B1;
	      *b2 = B2;
	      return( t3 );
	}		

	/*** Typer fuer Rechnungen ueber Zahlkoerpern ***/
	
	if( ( t1 > 22 && t1 < 30 ) || ( t2 > 22 && t2 < 30 ) )
	{     t3 = nftyper( a1,a2,t1,t2,&B1,&B2 );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = B1;
	      *b2 = B2;
	      return( t3 );
	}		

	/*** Abfangen ungueltiger Angleichungen ***/

	if( ( t1 <= 4 && t2 >= 5 && t2 < 15 ) || ( t1 >= 5 && t1 < 15 && t2 <= 4 )
	    || ( t1 < 0 && t2 >= 0 ) || ( t1 >= 0 && t2 < 0 )
	    || ( (t1==15 || t1==37 || t1==38 || t1==39) && t2>3 && t2<15 )
	    || ( (t2==15 || t2==37 || t2==38 || t2==39) && t1>3 && t1<15 ) )
	{       if(esch) mistake( 71 );
		return( -BASIS );
	}

	if( t1 < 0 && t2 < 0 &&
               ( t1!=(-3) || t2!=(-3) ) && ( t1!=(-4) || t2!=(-4) ) 
               && ( t1!=(-7) || t2!=(-7) ) && ( t1!=(-8) || t2!=(-8) ) 
               && ( t1!=(-11) || t2!=(-11) ) && ( t1!=(-12) || t2!=(-12) ) 
               && ( t1!=(-15) || t2!=(-15) ) && ( t1!=(-16) || t2!=(-16) ) 
	       && ( t1!=(-3) || t2!=(-11) ) && ( t1!=(-11) || t2!=(-3 ) )
	       && ( t1!=(-4) || t2!=(-12) ) && ( t1!=(-12) || t2!=(-4) )
	       && ( t1!=(-7) || t2!=(-15) ) && ( t1!=(-15) || t2!=(-7 ) )
	       && ( t1!=(-8) || t2!=(-16) ) && ( t1!=(-16) || t2!=(-8) ) ) 
	{	if(esch) mistake(85);
		return(ERROR);
	}


	/*** Typangleichung ***/

	if( t1 >= 0 ) t3 = smax( t1, t2 );
	else t3 = smin( t1, t2 );
	switch( t2 )
	{       case 0: switch( t1 )
			{       case 0: *b1 = a1;
					*b2 = a2;
					break;
				case 1: *b1 = a1;
					*b2 = itor( a2 );
					break;
				case 2: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					B2 = pvinsert( 0, a2, r );
					*b2 = list2( VL, B2 );
					break;
				case 3: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					B2 = pvinsert( 0, a2, r );
					B2 = pitopr( r, B2 );
					*b2 = list2( VL, B2 );
					break;
				case 4: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					if( a2 )
					{  B2 = pvinsert( 0, a2, r );
					   n2 = pvinsert( 0, 1, r );
					   B2 = list2( B2, n2 );
					}
					else B2 = 0;
					*b2 = list2( VL, B2 );
					break;
				case 15:*b1 = a1;
					*b2 = itofl( a2 );
					break;
				case 37:*b1 = a1;
					*b2 = itoc( a2 );
					break;
				case 38:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					B2 = pvinsert( 0, a2, r );
					B2 = pitopfl( r, B2 );
					*b2 = list2( VL, B2 );
					break;
				case 39:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					B2 = pvinsert( 0, a2, r );
					B2 = pitopc( r, B2 );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 1: switch( t1 )
			{       case 0: *b1 = itor( a1 );
					*b2 = a2;
					break;
				case 1: *b1 = a1;
					*b2 = a2;
					break;
				case 2: VL = lfirst( a1 );
					r = llength( VL );
					a1 = lsecond( a1 );
					B1 = pitopr( r, a1 );
					*b1 = list2( VL, B1 );
					B2 = pvinsert( 0, a2, r );
					*b2 = list2( VL, B2 );
					t3 = 3;
					break;
				case 3: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					B2 = pvinsert( 0, a2, r );
					*b2 = list2( VL, B2 );
					break;
				case 4: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					z2 = lfirst( a2 );
					n2 = lsecond( a2 );
					z2 = pvinsert( 0, z2, r );
					n2 = pvinsert( 0, n2, r );
					B2 = list2( z2, n2 );
					*b2 = list2( VL, B2 );
					break;
				case 15:*b1 = a1;
					*b2 = rtofl( a2 );
					break;
				case 37:*b1 = a1;
					*b2 = rtoc( a2 );
					break;
				case 38:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					B2 = pvinsert( 0, a2, r );
					B2 = prtopfl( r, B2 );
					*b2 = list2( VL, B2 );
					break;
				case 39:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					B2 = pvinsert( 0, a2, r );
					B2 = prtopc( r, B2 );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 2: switch( t1 )
			{       case 0: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 1: VL = lfirst( a2 );
					r = llength( VL );
					a2 = lsecond( a2 );
					B2 = pitopr( r, a2 );
					*b2 = list2( VL, B2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					t3 = 3;
					break;
				case 2: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 3: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					r = llength( VL2 );
					a2 = lsecond( a2 );
					a2 = pitopr( r, a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 4: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					z1 = lfirst( a1 );
					n1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, z1, a2, &bz1, &B2 );
					VL = pvmix( VL1, VL, n1, B2, &bn1, &B2 );
					r = llength( VL );
					n2 = pvinsert( 0, 1, r );
					B1 = list2( bz1, bn1 );
					*b1 = list2( VL, B1 );
					B2 = list2( B2, n2 );
					*b2 = list2( VL, B2 );
					break;
				case 15:VL = lfirst( a2 );
					r = llength( VL );
					a2 = lsecond( a2 );
					B2 = pitopfl( r, a2 );
					*b2 = list2( VL, B2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					t3 = 38;
					break;
				case 37:VL = lfirst( a2 );
					r = llength( VL );
					a2 = lsecond( a2 );
					B2 = pitopc( r, a2 );
					*b2 = list2( VL, B2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					t3 = 39;
					break;
				case 38:VL1 = lfirst(a1);
					a1 = lsecond(a1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					r = llength( VL2 );
					a2 = pitopfl( r, a2 );
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2);
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
				case 39:VL1 = lfirst(a1);
					a1 = lsecond(a1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					r = llength( VL2 );
					a2 = pitopc( r, a2 );
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2);
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
					
			}
			break;
		case 3: switch( t1 )
			{       case 0: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					B1 = pvinsert( 0, a1, r );
					B1 = pitopr( r, B1 );
					*b1 = list2( VL, B1 );
					break;
				case 1: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 2: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					a1 = pitopr( r, a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 3: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 4: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					z1 = lfirst( a1 );
					n1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					r = llength( VL2 );
					a2 = lsecond( a2 );
					a2 = prnumden( r, a2, &n2 );
					VL = pvmix( VL1, VL2, z1, a2, &bz1, &B2 );
					VL = pvmix( VL1, VL, n1, B2, &bn1, &B2 );
					r = llength( VL );
					n2 = pvinsert( 0, n2, r );
					B1 = list2( bz1, bn1 );
					*b1 = list2( VL, B1 );
					B2 = list2( B2, n2 );
					*b2 = list2( VL, B2 );
					break;
				case 15:VL = lfirst( a2 );
					r = llength( VL );
					a2 = lsecond( a2 );
					B2 = prtopfl( r, a2 );
					*b2 = list2( VL, B2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					t3 = 38;
					break;
				case 37:VL = lfirst( a2 );
					r = llength( VL );
					a2 = lsecond( a2 );
					B2 = prtopc( r, a2 );
					*b2 = list2( VL, B2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					t3 = 39;
					break;
				case 38:VL1 = lfirst(a1);
					a1 = lsecond(a1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					r = llength( VL2 );
					a2 = prtopfl( r, a2 );
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2);
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
				case 39:VL1 = lfirst(a1);
					a1 = lsecond(a1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					r = llength( VL2 );
					a2 = prtopc( r, a2 );
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2);
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
					
			}
			break;
		case 4: switch( t1 )
			{       case 0: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					if( a1 )
					{  B1 = pvinsert( 0, a1, r );
					   n1 = pvinsert( 0, 1, r );
					   B1 = list2( B1, n1 );
					}
					else B1 = 0;
					*b1 = list2( VL, B1 );
					break;
				case 1: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					z1 = lfirst( a1 );
					n1 = lsecond( a1 );
					z1 = pvinsert( 0, z1, r );
					n1 = pvinsert( 0, n1, r );
					B1 = list2( z1, n1 );
					*b1 = list2( VL, B1 );
					break;
				case 2: VL2 = lfirst( a2 ),
					a2 = lsecond( a2 );
					z2 = lfirst( a2 );
					n2 = lsecond( a2 );
					VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL = pvmix( VL2, VL1, z2, a1, &bz2, &B1 );
					VL = pvmix( VL2, VL, n2, B1, &bn2, &B1 );
					r = llength( VL );
					n1 = pvinsert( 0, 1, r );
					B2 = list2( bz2, bn2 );
					*b2 = list2( VL, B2 );
					B1 = list2( B1, n1 );
					*b1 = list2( VL, B1 );
					break;
				case 3: VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					z2 = lfirst( a2 );
					n2 = lsecond( a2 );
					VL1 = lfirst( a1 );
					r = llength( VL1 );
					a1 = lsecond( a1 );
					a1 = prnumden( r, a1, &n1 );
					VL = pvmix( VL2, VL1, z2, a1, &bz2, &B1 );
					VL = pvmix( VL2, VL, n2, B1, &bn2, &B1 );
					r = llength( VL );
					n1 = pvinsert( 0, n1, r );
					B2 = list2( bz2, bn2 );
					*b2 = list2( VL, B2 );
					B1 = list2( B1, n1 );
					*b1 = list2( VL, B1 );
					break;
				case 4: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					z1 = lfirst( a1 );
					n1 =  lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					z2 = lfirst( a2 );
					n2 =  lsecond( a2 );
					VL = pvmix( VL1, VL2, z1, z2, &bz1, &bz2 );
					VL = pvmix( VL1, VL2, n1, n2, &bn1, &bn2 );
					B1 = list2( bz1, bn1 );
					*b1 = list2( VL, B1 );
					B2 = list2( bz2, bn2 );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 5: switch( t1 )
			{       case 5: *b1 = a1;
					*b2 = a2;
					break;
				case 6:
				case 7:
				case 8:
				case 9: t3 = matrtyper( a1,a2,t1,t2,&B1,&B2 );
					*b1 = B1;
					*b2 = B2;
					break;
			}
			break;
		case 6: switch( t1 )
			{       case 5: t3 = matrtyper( a1,a2,t1,t2,&B1,&B2 );
					*b1 = B1;
					*b2 = B2;
					break;
				case 6: *b1 = a1;
					*b2 = a2;
					break;
				case 7:
				case 8:
				case 9: t3 = matrtyper( a1,a2,t1,t2,&B1,&B2 );
					*b1 = B1;
					*b2 = B2;
					break;
			}
			break;
		case 7:
		case 8:
		case 9: t3 = matrtyper( a1,a2,t1,t2,&B1,&B2 );
			*b1 = B1;
			*b2 = B2;
			break;
		case 15:switch( t1 )
			{       case 0: *b2 = a2;
					*b1 = itofl( a1 );
					break;
				case 1: *b2 = a2;
					*b1 = rtofl( a1 );
					break;
				case 2: VL = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL);
					B1 = pitopfl(r,a1);
					*b1 = list2(VL,B1);
					B2 = pvinsert(0,a2,r);
					*b2 = list2(VL,B2);
					t3 = 38;
					break;
				case 3: VL = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL);
					B1 = prtopfl(r,a1);
					*b1 = list2(VL,B1);
					B2 = pvinsert(0,a2,r);
					*b2 = list2(VL,B2);
					t3 = 38;
					break;
				case 15:*b1 = a1;
					*b2 = a2;
					break;
				case 37:*b1 = a1;
					*b2 = fltoc( a2 );
					break;
				case 38:*b1 = a1;
					VL = lfirst(a1);
					r  = llength(VL);
					B2 = pvinsert(0,a2,r);
					*b2 = list2(VL,B2);
					break;
				case 39:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					B2 = fltoc(a2);
					B2 = pvinsert(0,B2,r);
					*b2 = list2(VL,B2);
					break;
			}
			break;
		case 37:switch( t1 )
			{	case 0: *b2 = a2;
					*b1 = itoc( a1 );
					break;
				case 1: *b2 = a2;
					*b1 = rtoc( a1 );
					break;
				case 2: VL = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL);
					B1 = pitopc(r,a1);
					*b1 = list2(VL,B1);
					B2 = pvinsert(0,a2,r);
					*b2 = list2(VL,B2);
					t3 = 39;
					break;
				case 3: VL = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL);
					B1 = prtopc(r,a1);
					*b1 = list2(VL,B1);
					B2 = pvinsert(0,a2,r);
					*b2 = list2(VL,B2);
					t3 = 39;
					break;
				case 15:*b2 = a2;
					*b1 = fltoc( a1 );
					break;
				case 37:*b2 = a2;
					*b1 = a1;
					break;
				case 38:VL = lfirst(a1);
					a1 = lsecond(a1);
					r  = llength(VL);
					B1 = pfltopc(r,a1);
					*b1 = list2(VL,B1);
					B2 = pvinsert(0,a2,r);
					*b2 = list2(VL,B2);
					t3 = 39;
					break;
				case 39:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					B2 = pvinsert(0,B2,r);
					*b2 = list2(VL,B2);
					break;
			}
			break;
		case 38:switch( t1 )
			{	case 0: *b2 = a2;
					VL = lfirst(a2);
					r = llength(VL);
					B1 = itofl(a1);
					B1 = pvinsert(0,B1,r);
					*b1 = list2(VL,B1); 
					break;
				case 1: *b2 = a2;
					VL = lfirst(a2);
					r = llength(VL);
					B1 = rtofl(a1);
					B1 = pvinsert(0,B1,r);
					*b1 = list2(VL,B1); 
					break;
				case 2: VL1 = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					a1 = pitopfl( r,a1 );
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2);
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
				case 3: VL1 = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					a1 = prtopfl( r,a1 );
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2);
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
				case 15:*b2 = a2;
					VL = lfirst(a2);
					r = llength(VL);
					B1 = pvinsert(0,a1,r);
					*b1 = list2(VL,B1);	
					break;
				case 37:VL = lfirst(a2);
					a2 = lsecond(a2);
					r = llength(VL);
					B2 = pfltopc( r,a2);
					*b2 = list2(VL,B2);
					B1 = pvinsert(0,a1,r);
					*b1 = list2(VL,B1);
					t3 = 39;
					break;
				case 38:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 39:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					r = llength(VL2);
					a2 = lsecond( a2 );
					a2 = pfltopc( r, a2);
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;		
			}
			break;
		case 39:switch( t1 )
			{	case 0: *b2 = a2;
					VL = lfirst(a2);
					r = llength(VL);
					B1 = itoc(a1);
					B1 = pvinsert(0,B1,r);
					*b1 = list2(VL,B1); 
					break;
				case 1: *b2 = a2;
					VL = lfirst(a2);
					r = llength(VL);
					B1 = rtoc(a1);
					B1 = pvinsert(0,B1,r);
					*b1 = list2(VL,B1); 
					break;
				case 2: VL1 = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					a1 = pitopc( r,a1 );
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2);
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
				case 3: VL1 = lfirst(a1);
					a1 = lsecond(a1);
					r = llength(VL1);
					VL2 = lfirst(a2);
					a2 = lsecond(a2);
					a1 = prtopc( r,a1 );
					VL = pvmix( VL1,VL2,a1,a2,&B1,&B2);
					*b1 = list2(VL,B1);
					*b2 = list2(VL,B2);
					break;
				case 15:*b2 = a2;
					VL = lfirst(a2);
					r = llength(VL);
					B1 = fltoc(a1);
					B1 = pvinsert(0,B1,r);
					*b1 = list2(VL,B1);	
					break;
				case 37:*b2 = a2;
					VL = lfirst(a2);
					r = llength(VL);
					B1 = pvinsert(0,a1,r);
					*b1 = list2(VL,B1);
					break;
				case 38:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					a1 = pfltopc( r, a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
				case 39:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = lfirst( a2 );
					a2 = lsecond( a2 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;		
			}
			break;
		case (-3):
		case (-4):
		case (-7):
		case (-8):
		case (-11):
		case (-12):
		case (-15):
		case (-16):*b1 = a1;
			   *b2 = a2;
			   break;
	}
	return( t3 );
}
