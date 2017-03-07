/*C
			vmtyper( a1, a2, t1, t2, b1, b2, esch );

	"vector matrix typer".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	single vmtyper( a1, a2, t1, t2, b1, b2, esch );   obj a1, a1; 
					single t1, t2, esch; obj b1, b2 ;
	X = vmtyper( a1, a2, t1, t2, b1, b2, esch );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. vmtyper er-
	mittelt die minimale Kennung X fuer die Matrix. Dabei werden
	die Objekte und a2 der Kennung X  entsprechend angepasst und
	in b1 der Vektor und in b2 die Matrix zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      26.04.1989      C.Hollinger/U.Schneiders
	Version  1.1    24.05.1989      C.Hollinger (vtyper -> vmtyper)
	Version  2      10.07.1989      C.Hollinger/U.Schneiders
	Version  3      13.07.1992      U.Schneiders ( nf und mod )
	Version  4	01.07.1993	S.Schmitt ( gf )
H*/

#include <_calc.h>

single vmtyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{
	obj A1, A2, NA1, el, el1, el2, h;
	list M, VL, VL1, VL2, Z, ZM;
	single n, r, rn, t3;
	init( A1, A2, NA1, el, el1, el2, h, M, VL, VL1, VL2, Z, ZM );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	if( t1 < 10 || t1 == 19 || t1 == 20 || t1 == 26 || t1 == 27
	 || t1 == 33 || t1 == 34 )
	{       h = t1;
		t1 = t2;
		t2 = h;
		h = a1;
		a1 = a2;
		a2 = h;
	}

	/*** Typer fuer Rechnungen ueber endlichen Koerpern ***/
	if( t1 == 35 || t1 == 36 || t2 == 33 || t2 == 34 ) 
	{	t3 = vmgftyper( a1,a2,t1,t2,&A1,&A2, esch );
		if( t3 == ERROR ) return(ERROR);
		*b1 = A1;
		*b2 = A2;
		return(t3);
	}

	/*** Typer fuer Rechnungen ueber Z/mZ ***/
	
	if( t1 == 21 || t1 == 22 || t2 == 19 || t2 == 20 )
	{     t3 = vmmodtyper( a1,a2,t1,t2,&A1,&A2, esch );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = A1;
	      *b2 = A2;
	      return( t3 );
	}		

	/*** Typer fuer Rechnungen ueber Zahlkoerpern ***/
	
	if( t1 == 28 || t1 == 29 || t2 == 26 || t2 == 27 )
	{     t3 = vmnftyper( a1,a2,t1,t2,&A1,&A2 );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = A1;
	      *b2 = A2;
	      return( t3 );
	}		

	/***    Typangleichung  ***/

	switch( t2 )
	{       case 5: switch( t1 )
			{       case 10: *b1 = a1;
					 *b2 = a2;
					 t3 = 5;
					 break;
				case 11: *b1 = a1;
					 *b2 = maitomar( a2 );
					 t3 = 6;
					 break;
				case 12: *b1 = a1;
					 VL = lfirst( a1 );
					 r = llength( VL );
					 A2 = maitomapi( r,a2 );
					 *b2 = list2( VL,A2 );
					 t3 = 7;
					 break;
				case 13: *b1 = a1;
					 VL = lfirst( a1 );
					 r = llength( VL );
					 A2 = maitomapi( r,a2 );
					 A2 = mapitomapr( r,A2 );
					 *b2 = list2( VL,A2 );
					 t3 = 8;
					 break;
				case 14: *b1 = a1;
					 VL = lfirst( a1 );
					 r = llength( VL );
					 A2 = maitomapi( r,a2 );
					 A2 = mapitomarfr( r,A2 );
					 *b2 = list2( VL,A2 );
					 t3 = 9;
					 break;
			}
			break;
		case 6: switch( t1 )
			{       case 10: *b1 = vecitovecr( a1 );
					 *b2 = a2;
					 t3 = 6;
					 break;
				case 11: *b1 = a1;
					 *b2 = a2;
					 t3 = 6;
					 break;
				case 12: VL = lfirst( a1 );
					 r = llength( VL );
					 A1 = lsecond( a1 );
					 A1 = vecpitovpr( r,A1 );
					 A2 = martomapr( r,a2 );
					 *b1 = list2( VL,A1 );
					 *b2 = list2( VL,A2 );
					 t3 = 8;
					 break;
				case 13: *b1 = a1;
					 VL = lfirst( a1 );
					 r = llength( VL );
					 A2 = martomapr( r,a2 );
					 *b2 = list2( VL,A2 );
					 t3 = 8;
					 break;
				case 14: *b1 = a1;
					 VL = lfirst( a1 );
					 r = llength( VL );
					 A2 = martomapr( r,a2 );
					 A2 = maprtomarfr( r,A2 );
					 *b2 = list2( VL,A2 );
					 t3 = 9;
					 break;
			}
			break;
		case 7: switch( t1 )
			{       case 10: VL = lfirst( a2 );
					 r = llength( VL );
					 A1 = vecitovecpi( r,a1 );
					 *b1 = list2( VL,A1 );
					 *b2 = a2;
					 t3 = 7;
					 break;
				case 11: VL = lfirst( a2 );
					 r = llength( VL );
					 A1 = vecrtovecpr( r,a1 );
					 *b1 = list2( VL,A1 );
					 A2 = lsecond( a2 );
					 A2 = mapitomapr( r,A2 );
					 *b2 = list2( VL,A2 );
					 t3 = 8;
					 break;
				case 12: t3 = 7;
					 VL1 = lfirst( a1 );
					 VL2 = lfirst( a2 );
					 n = oequal( VL1,VL2 );
					 if( n )
					 {       *b1 = a1;
						 *b2 = a2;
					 }
					 else
					 {       A1 = lsecond( a1 );
						 NA1 = lfirst( A1 );
						 A2 = lsecond( a2 );
						 M = _0;
						 while( A2 != _0 )
						 {       Z = lfirst( A2 );
							 A2 = lred( A2 );
							 ZM = _0;
							 while( Z != _0 )
							 {  el = lfirst( Z );
							    Z = lred( Z );
							    VL = pvmix( VL1,VL2,NA1,el,&h,&el );
							    ZM = lcomp( el,ZM );
							 }
							 ZM = linv( ZM );
							 M = lcomp( ZM,M );
						 }
						 M = linv( M );
						 *b2 = list2( VL, M );
						 M = list1( h );
						 A1 = lred( A1 );
						 while( A1 != _0 )
						 {       el = lfirst( A1 );
							 A1 = lred( A1 );
							 VL = pvmix( VL,VL1,h,el,&NA1,&el );
							 M = lcomp( el,M );
						 }
						 M = linv( M );
						 *b1 = list2( VL,M );
					 }
					 break;
				case 13: t3 = 8;
					 VL1 = lfirst( a1 );
					 VL2 = lfirst( a2 );
					 r = llength( VL2 );
					 A2 = lsecond( a2 );
					 A2 = mapitomapr( r,A2 );
					 n = oequal( VL1,VL2 );
					 if( n )
					 {       *b1 = a1;
						 *b2 = list2( VL2,A2 );
					 }
					 else
					 {       A1 = lsecond( a1 );
						 NA1 = lfirst( A1 );
						 M = _0;
						 while( A2 != _0 )
						 {       Z = lfirst( A2 );
							 A2 = lred( A2 );
							 ZM = _0;
							 while( Z != _0 )
							 {  el = lfirst( Z );
							    Z = lred( Z );
							    VL = pvmix( VL1,VL2, NA1,el,&h,&el );
							    ZM = lcomp( el,ZM );
							 }
							 ZM = linv( ZM );
							 M = lcomp( ZM,M );
						 }
						 M = linv( M );
						 *b2 = list2( VL,M );
						 M = list1( h );
						 A1 = lred( A1 );
						 while( A1 != _0 )
						 {       el = lfirst( A1 );
							 A1 = lred( A1 );
							 VL = pvmix( VL,VL1,h,el,&NA1,&el );
							 M = lcomp( el,M );
						 }
						 M = linv( M );
						 *b1 = list2( VL,M );
					 }
					 break;
				case 14: t3 = 9;
					 VL1 = lfirst( a1 );
					 VL2 = lfirst( a2 );
					 A2 = lsecond( a2 );
					 r = llength( VL1 );
					 n = oequal( VL1,VL2 );
					 if( n )
					 {       *b1 = a1;
						 M = _0;
						 el1 = pvinsert( 0,1,r );
						 while( A2 != _0 )
						 {       Z = lfirst( A2 );
							 A2 = lred( A2 );
							 ZM = _0;
							 while( Z != _0 )
							 {  el = lfirst( Z );
							    Z = lred( Z );
							    if( el ) el = list2( el,el1 );
							    ZM = lcomp( el,ZM );
							 }
							 ZM = linv( ZM );
							 M = lcomp( ZM,M );
						 }
						 M = linv( M );
						 *b2 = list2( VL,M );
					 }
					 else
					 {       A1 = lsecond( a1 );
						 NA1 = lfirst( A1 );
						 if( NA1 ) NA1 = lfirst( NA1 );
						 A2 = lsecond( a2 );
						 M = _0;
						 while( A2 != _0 )
						 {       Z = lfirst( A2 );
							 A2 = lred( A2 );
							 ZM = _0;
							 while( Z != _0 )
							 {  el = lfirst( Z );
							    Z = lred( Z );
							    if( el )
							    {	VL = pvmix( VL1,VL2,NA1,el,&h,&el );
							    	r = llength( VL );
							    	el1 = pvinsert( 0, 1, r );
							    	el = list2( el,el1 );
							    }
							    ZM = lcomp( el,ZM );
							 }
							 ZM = linv( ZM );
							 M = lcomp( ZM,M );
						 }
						 M = linv( M );
						 *b2 = list2( VL,M );
						 M = _0;
						 while( A1 != _0 )
						 {       el = lfirst( A1 );
							 A1 = lred( A1 );
							 if( el )
							 {  el1 = lsecond( el );
							    el = lfirst( el );
							    VL = pvmix( VL,VL1,h,el,&NA1,&el );
							    VL = pvmix( VL,VL1,h,el1,&NA1,&el1 );
							    el = list2( el,el1 );
							 }
							 M = lcomp( el,M );
						 }
						 M = linv( M );
						 *b1 = list2( VL,M );
					 }
					 break;
			}
			break;
		case 8: t3 = 8;
			switch( t1 )
			{       case 10: VL = lfirst( a2 );
					 r = llength( VL );
					 A1 = vecitovecr( a1 );
					 A1 = vecrtovecpr( r,A1 );
					 *b1 = list2( VL,A1 );
					 *b2 = a2;
					 break;
				case 11: VL = lfirst( a2 );
					 r = llength( VL );
					 A1 = vecrtovecpr( r,a1 );
					 *b1 = list2( VL,A1 );
					 *b2 = a2;
					 break;
				case 12: VL1 = lfirst( a1 );
					 VL2 = lfirst( a2 );
					 r = llength( VL1 );
					 A1 = lsecond( a1 );
					 A1 = vecpitovpr( r,A1 );
					 n = oequal( VL1, VL2 );
					 if( n )
					 {       *b1 = list2( VL1,A1 );
						 *b2 = a2;
					 }
					 else
					 {       NA1 = lfirst( A1 );
						 A2 = lsecond( a2 );
						 M = _0;
						 while( A2 != _0 )
						 {       Z = lfirst( A2 );
							 A2 = lred( A2 );
							 ZM = _0;
							 while( Z != _0 )
							 {  el = lfirst( Z );
							    Z = lred( Z );
							    VL = pvmix( VL1,VL2, NA1,el,&h,&el );
							    ZM = lcomp( el,ZM );
							 }
							 ZM = linv( ZM );
							 M = lcomp( ZM,M );
						 }
						 M = linv( M );
						 *b2 = list2( VL,M );
						 M = list1( h );
						 A1 = lred( A1 );
						 while( A1 != _0 )
						 {       el = lfirst( A1 );
							 A1 = lred( A1 );
							 VL = pvmix( VL,VL1,h,el,&NA1,&el );
							 M = lcomp( el,M );
						 }
						 M = linv( M );
						 *b1 = list2( VL, M );
					 }
					 break;
				case 13: VL1 = lfirst( a1 );
					 VL2 = lfirst( a2 );
					 n = oequal( VL1,VL2 );
					 if( n )
					 {       *b1 = a1;
						 *b2 = a2;
					 }
					 else
					 {       A1 = lsecond( a1 );
						 NA1 = lfirst( A1 );
						 A2 = lsecond( a2 );
						 M = _0;
						 while( A2 != _0 )
						 {       Z = lfirst( A2 );
							 A2 = lred( A2 );
							 ZM = _0;
							 while( Z != _0 )
							 {  el = lfirst( Z );
							    Z = lred( Z );
							    VL = pvmix( VL1,VL2, NA1, el, &h, &el );
							    ZM = lcomp( el,ZM );
							 }
							 ZM = linv( ZM );
							 M = lcomp( ZM,M );
						 }
						 M = linv( M );
						 *b2 = list2( VL,M );
						 M = list1( h );
						 A1 = lred( A1 );
						 while( A1 != _0 )
						 {       el = lfirst( A1 );
							 A1 = lred( A1 );
							 VL = pvmix( VL,VL1,h,el,&NA1,&el );
							 M = lcomp( el,M );
						 }
						 M = linv( M );
						 *b1 = list2( VL,M );
					 }
					 break;
				case 14: t3 = 9;
					 VL1 = lfirst( a1 );
					 VL2 = lfirst( a2 );
					 A2 = lsecond( a2 );
					 r = llength( VL2 );
					 n = oequal( VL1,VL2 );
					 if( n )
					 {       *b1 = a1;
						 M = _0;
						 while( A2 != _0 )
						 {       Z = lfirst( A2 );
							 A2 = lred( A2 );
							 ZM = _0;
							 while( Z != _0 )
							 {  el = lfirst( Z );
							    Z = lred( Z );
							    if( el )
							    {  el = prnumden( r, el, &el1 );
							       el1 = pvinsert( 0, el1, r );
							       el = list2( el,el1 );
							    }
							    ZM = lcomp( el,ZM );
							 }
							 ZM = linv( ZM );
							 M = lcomp( ZM,M );
						 }
						 M = linv( M );
						 *b2 = list2( VL,M );
					 }
					 else
					 {       A1 = lsecond( a1 );
						 NA1 = lfirst( A1 );
						 if( NA1 ) NA1 = lfirst( NA1 );
						 A2 = lsecond( a2 );
						 M = _0;
						 while( A2 != _0 )
						 {       Z = lfirst( A2 );
							 A2 = lred( A2 );
							 ZM = _0;
							 while( Z != _0 )
							 {  el = lfirst( Z );
							    Z = lred( Z );
							    if( el )
							    {  el = prnumden( r, el, &el1 );
							       VL = pvmix( VL1,VL2,NA1,el,&h,&el );
							       rn = llength( VL );
							       el1 = pvinsert( 0, el1, rn );
							       el = list2( el,el1 );
							    }
							    ZM = lcomp( el,ZM );
							 }
							 ZM = linv( ZM );
							 M = lcomp( ZM,M );
						 }
						 M = linv( M );
						 *b2 = list2( VL,M );
						 M = _0;
						 while( A1 != _0 )
						 {       el = lfirst( A1 );
							 A1 = lred( A1 );
							 if( el )
							 {  el1 = lsecond( el );
							    el = lfirst( el );
							    VL = pvmix( VL,VL1,h,el,&NA1,&el );
							    VL = pvmix( VL,VL1,h,el1,&NA1,&el1 );
							    el = list2( el,el1 );
						         }
							 M = lcomp( el,M );
						 }
						 M = linv( M );
						 *b1 = list2( VL,M );
					 }
					 break;
			}
			break;
		case 9: t3 = 9;
			switch( t1 )
			{       case 10:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = vecitovecpi( r,a1 );
					a1 = vecpitovrfr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 11:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = vecrtovecpr( r,a1 );
					a1 = vecprtovrfr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 12:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					r = llength( VL1 );
					A1 = lsecond( a1 );
					if( n )
					{       M = _0;
						el1 = pvinsert( 0,1,r );
						while( A1 != _0 )
						{       el = lfirst( A1 );
							A1 = lred( A1 );
							if( el ) el = list2( el,el1 );
							M = lcomp( el,M );
						}
						M = linv( M );
						*b1 = list2( VL1,M );
						*b2 = a2;
					}
					else
					{       A2 = lsecond( a2 );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						if( el2 ) el2 = lfirst( el2 );
						el = lfirst( A1 );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						M = _0;
						r = llength( VL );
						el1 = pvinsert( 0,1,r );
						while( A1 != _0 )
						{  el = lfirst( A1 );
						   A1 = lred( A1 );
						   if( el )
						   {  VL = pvmix( VL1,VL,el,el2,&el,&el2 );
						      el = list2( el, el1 );
						   }	
						   M = lcomp( el, M );
						}
						M = linv( M );
						*b1 = list2( VL,M );
						M = _0;
						while( A2 != _0 )
						{  Z = lfirst( A2 );
						   A2 = lred( A2 );
						   ZM = _0;
						   while( Z != _0 )
						   {  el = lfirst( Z );
						      Z = lred( Z );
						      if( el )
						      {   el1 = lsecond( el );
						          el = lfirst( el );
						          VL = pvmix( VL2,VL,el,el2,&el,&el2 );
						          VL = pvmix( VL2,VL,el1,el2,&el1,&el2 );
						          el = list2( el,el1 );
						      }
						      ZM = lcomp( el,ZM );
						   }
						   ZM = linv( ZM );
						   M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
					}
					break;
				case 13:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					r = llength( VL1 );
					A1 = lsecond( a1 );
					if( n )
					{       M = _0;
						while( A1 != _0 )
						{       el = lfirst( A1 );
							A1 = lred( A1 );
							if( el )
							{  el = prnumden( r, el, &el1 );
							   el1 = pvinsert( 0, el1, r );
							   el = list2( el,el1 );
							}
							M = lcomp( el,M );
						}
						M = linv( M );
						*b1 = list2( VL1,M );
						*b2 = a2;
					}
					else
					{       A2 = lsecond( a2 );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						if( el2 ) el2 = lfirst( el2 );
						el = lfirst( A1 );
						el = prnumden( r, el, &el1 );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						M = _0;
						rn = llength( VL );
						while( A1 != _0 )
						{       el = lfirst( A1 );
							A1 = lred( A1 );
							if( el )
							{  el = prnumden( r, el, &el1 );
							   VL = pvmix( VL1,VL,el,el2,&el,&el2 );
							   el1 = pvinsert( 0, el1, rn );
							   el = list2( el,el1 );
							}
							M = lcomp( el,M );
						}
						M = linv( M );
						*b1 = list2( VL,M );
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{       el = lfirst( Z );
								Z = lred( Z );
								if( el )
								{ el1 = lsecond( el );
								  el = lfirst( el );
								  VL = pvmix( VL2,VL,el,el2,&el,&el2 );
								  VL = pvmix( VL2,VL,el1,el2,&el1,&el2 );
								  el = list2( el,el1 );
								}
								ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
					}
					break;
				case 14:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
					{       *b1 = a1;
						*b2 = a2;
					}
					else
					{       A1 = lsecond( a1 );
						A2 = lsecond( a2 );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						if( el2 ) el2 = lfirst( el2 );
						el = lfirst( A1 );
						if( el ) el = lfirst( el );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						M = _0;
						while( A1 != _0 )
						{       el = lfirst( A1 );
							A1 = lred( A1 );
							if( el )
							{  el1 = lsecond( el );
							   el = lfirst( el );
							   VL = pvmix( VL1,VL,el,el2,&el,&el2 );
							   VL = pvmix( VL1,VL,el1,el2,&el1,&el2 );
							   el = list2( el,el1 );
							}
							M = lcomp( el,M );
						}
						M = linv( M );
						*b1 = list2( VL,M );
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{  el = lfirst( Z );
							   Z = lred( Z );
							   if( el )
							   {	el1 = lsecond( el );
							   	el = lfirst( el );
							   	VL = pvmix( VL2,VL,el,el2,&el,&el2 );
							   	VL = pvmix( VL2,VL,el1,el2,&el1,&el2 );
							   	el = list2( el,el1 );
							   }
							   ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
					}
					break;
			}
			break;
	}
	return( t3 );
}
