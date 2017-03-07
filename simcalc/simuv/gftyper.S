/*C
			     gftyper( a1, a2, t1, t2, b1, b2, esch )
	"Galois-field Typer ".
	single gftyper( a1,a2,t1,t2,b1,b2,esch ); obj a1,a2; single t1,t2;
					     obj *b1, *b2; single esch;
	X = gftyper( a1, a2, t1, t2, b1, b2, esch );

	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2, wobei wenig-
        stens eine der beiden Kennungen ein Element ueber einem 
	endlichen Koerper auszeichnet. gftyper ermittelt die minimale 
	gemeinsame Kennung X. Dabei werden die Objekte a1 und a2 ihrer 
	neuen Kennung X entsprechend angepasst und in b1 und b2 
	zurueckgegeben. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      21.06.1993	    S.Schmitt  
H*/

#include<_calc.h>

single gftyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{
	single sch=0, t3, r;
	list VL, VL1, VL2;
	obj B1, B2, H, N;
	init( VL, VL1, VL2, B1, B2, H, N );
	bind( a1, a2 );

	*b1 = 0; *b2 = 0;

	/*** Abfangen ungueltiger Angleichungen ***/

	if( t1 < 0 || t2 < 0 
           || ( t1 > 22 && t1 < 31 ) || ( t2 > 22 && t2 < 31 )
	   || t1 == 4 || t2 == 4 || t1 == 9 || t2 == 9 || t1 == 14 
	   || t2 == 14 || t1 == 15 || t2 == 15 || t1 == 16 || t2 == 16
	   || t1 == 37 || t2 == 37 || t1 == 38 || t2 == 38 || t1 == 39
	   || t2 == 39
           || ( ( ( t1 >= 0 && t1 < 4 ) || t1 == 17 || t1 == 18 || t1 == 31 || t1 == 32 ) && t2 > 32 )		
           || ( ( ( t2 >= 0 && t2 < 4 ) || t2 == 17 || t2 == 18 || t2 == 31 || t2 == 32 ) && t1 > 32 )		
           || ( ( ( t1 > 4 && t1 < 9 ) || t1 == 19 || t1 == 20 || t1 == 33 || t1 == 34 ) && ( t2 == 31 || t2 == 32 || t2 == 35 || t2 == 36 ) )
           || ( ( ( t2 > 4 && t2 < 9 ) || t2 == 19 || t2 == 20 || t2 == 33 || t2 == 34 ) && ( t1 == 31 || t1 == 32 || t1 == 35 || t1 == 36 ) )
           || ( ( ( t1 > 9 && t1 < 14 ) || t1 == 21 || t1 == 22 || t1 == 35 || t1 == 36 ) && t2 < 35 )		
           || ( ( ( t2 > 9 && t2 < 14 ) || t2 == 21 || t2 == 22 || t2 == 35 || t2 == 36 ) && t1 < 35 ) 		
	   || ( ( ( t1 > 16 && t1 < 23 ) || ( t2 > 16 && t2 < 23 ) ) &&   lfirst(varlist[modsch].varwert) != gfchar ) )
	{       if(esch) mistake( 71 );
		return( ERROR );
	}

	/*** Typangleichung ***/

	if( t1 < t2 )
	{       sch = 1;
		H = a1;
		a1 = a2;
		a2 = H;
		H = t1;
		t1 = t2;
		t2 = H;
	}

	if( ( t2 == 2 || t2 == 3 || t2 == 18 ) && t1 == 31 )
	  	t3 = 32;
	else  t3 = t1;

	switch( t2 )
	{ 	case 0: *b1=a1;
			B2=mshom(gfchar,a2);
			if(B2)
			{	B2=list2(0,B2);
				if(gfchar==2) B2=udpm2tosb(B2);
			}
			switch( t1 )
			{	case 31:*b2 = B2;
					break;
				case 32:VL = lfirst( a1 );
					r = llength( VL );
					B2 = pvinsert( 0, B2, r );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 1: B2 = lsecond( a2 );
	                if ( igcd( B2, gfchar ) != 1 )
			{       if(esch) mistake2( 233, a2, gfchar );
		        	return( ERROR );
			}
			B2=mshom(gfchar,B2);
			B2=msinv(gfchar,B2);
			a2 = lfirst( a2 );
			a2 = mshom( gfchar, a2 );
			B2 = msprod( gfchar, a2, B2 );
			if(B2)
			{	B2=list2(0,B2);
				if(gfchar==2) B2=udpm2tosb(B2);
			}
			switch( t1 )
			{	case 31:*b1 = a1;
					*b2 = B2;
					break;
				case 32:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					B2 = pvinsert( 0, B2, r );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
	 	case 2: 
			VL=lfirst(a2);
			r=llength(VL);	
			a2=lsecond(a2);
			a2=pitopms(r,a2,gfchar);
			if(gfchar!=2) 
			{
				a2=pmstopgfs(r,gfchar,a2);
			}
			else  
			{
				a2=pm2topgf2(r,a2);
			}
			switch( t1 )
			{	case 31:*b2 = list2( VL, a2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 32:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = pvmix( VL1, VL, a1, a2, &B1, &B2 );
					*b1 = list2( VL2, B1 );
					*b2 = list2( VL2, B2 );
					break;
			}
			break;
	        case 3:	VL = lfirst( a2 );
			a2 = lsecond( a2 );
			r = llength( VL );
			B2 = prnumden( r, a2, &N );
			if( igcd( gfchar, N ) != 1 )
			{       if(esch) mistake1( 242, gfchar );
				return( ERROR );
			}
			N = mshom( gfchar, N );
			N = msinv( gfchar, N );
			B2 = pitopms( r, B2, gfchar );
			B2 = pmsmsprod( r, gfchar, B2, N );
			if(gfchar!=2)  B2=pmstopgfs(r,gfchar,B2);
			else   B2=pm2topgf2(r,B2);
			switch( t1 )
			{	case 31:*b2 = list2( VL, B2 );
				        B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, B1 );
					break;
				case 32:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL2 = pvmix( VL1, VL, a1, B2, &B1, &a2 );
					*b1 = list2( VL2, B1 );
					*b2 = list2( VL2, a2 );
					break;
			}
			break;
		case 17:if(a2)
			{	B2=list2(0,a2);
				if(gfchar==2) B2=udpm2tosb(B2);
			}
			else B2=a2;
			*b1=a1;
			if(t1==32)
			{ 	VL = lfirst( a1 );
				r = llength( VL );
				B2 = pvinsert( 0, B2, r );
				*b2 = list2( VL, B2 );
			}
			else  *b2=B2;
			break;
		case 18:VL2 = lfirst(a2);
			r = llength(VL2);
			a2 = lsecond(a2);
			if(gfchar!=2) a2=pmstopgfs(r,gfchar,a2);
			else  a2=pm2topgf2(r,a2);
			switch( t1 )
			{	case 31:*b2 = list2( VL2, a2 );
					B1 = pvinsert( 0, a1, r );
					*b1 = list2( VL2, B1 );
					break;
				case 32:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					VL = pvmix( VL1, VL2, a1, a2, &B1, &B2 );
					*b1 = list2( VL, B1 );
					*b2 = list2( VL, B2 );
					break;
			}
			break;
		case 31:switch(t1)
			{	case 31:*b1 = a1;
					*b2 = a2;
					break;
				case 32:VL=lfirst(a1);
					r=llength(VL);
					B2=pvinsert(0,a2,r);
					*b2=list2(VL,B2);
					*b1=a1;
					break;
			}
			break;
		case 32:VL2=lfirst(a2);
			a2=lsecond(a2);
			VL1=lfirst(a1);
			a1=lsecond(a1);
			VL=pvmix(VL1,VL2,a1,a2,&B1,&B2);
			*b1=list2(VL,B1);
			*b2=list2(VL,B2);
			break;
		case 5:
		case 6:
		case 7:
		case 8:
		case 19:
		case 20:
		case 33:
		case 34:t3 = magftyper( a1,a2,t1,t2,&B1,&B2,esch );
			if(t3 == ERROR) return(t3);
			*b1=B1;
			*b2=B2;
			break;
		case 10:
		case 11:
		case 12:
		case 13:
		case 21:
		case 22:
		case 35:
		case 36:t3=vecgftyper(a1,a2,t1,t2,&B1,&B2,esch);	
			if(t3 == ERROR) return(t3);
			*b1=B1;
			*b2=B2;
			break;
	}
	if(sch)
	{	H=(*b1);
		*b1=(*b2);
		*b2=H;
	}
	return(t3);
}
