/*C
			svtyper( a1, a2, t1, t2, b1, b2, esch );

	"scalar vector typer".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	single svtyper( a1, a2, t1, t2, b1, b2, esch );   obj a1,a1; 
				single t1,t2,esch; obj b1,b2 ;
	X = svtyper( a1, a2, t1, t2, b1, b, esch2 );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. svtyper er-
	mittelt die minimale Kennung X fuer die Vektor. Dabei werden
	die Objekte a1 und a2 der Kennung X entsprechend angepasst
	und in b1 das Skalar, b2 der Vektor zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      31.05.1989      C.Hollinger
	Version  2      12.07.1989      C.Hollinger/U.Schneiders
	Version  3      13.07.1992      U.Schneiders ( nf und mod )
	Version  4      01.07.1993	S.Schmitt ( gf )
H*/

#include <_calc.h>

single svtyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{       obj el, el1, el2, el3, h, Na1;
	list VL, VL1, VL2;
	single r, rn, t3;
	init( Na1, el, el1, el2, el3, h, VL, VL1, VL2 );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	/*** Typer fuer Rechnungen ueber endlichen Koerpern ***/

	if( t1 == 31 || t1 == 32 || t1 == 35 || t1 == 36
	 || t2 == 31 || t2 == 32 || t2 == 35 || t2 == 36 )
	{	t3 = svgftyper( a1,a2,t1,t2,&el1,&el2,esch );
		if( t3 == ERROR ) return( ERROR );
		*b1 = el1;
		*b2 = el2;
		return(t3);
	}

	/*** Typer fuer Rechnungen ueber Z/mZ ***/
	
	if( t1 == 17 || t1 == 18 || t1 == 21 || t1 == 22
	 || t2 == 17 || t2 == 18 || t2 == 21 || t2 == 22 )
	{     t3 = svmodtyper( a1,a2,t1,t2,&el1,&el2,esch );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = el1;
	      *b2 = el2;
	      return( t3 );
	}		

	/*** Typer fuer Rechnungen ueber Zahlkoerpern ***/
	
	if( t1 == 24 || t1 == 25 || t1 == 28 || t1 == 29
         || t2 == 24 || t2 == 25 || t2 == 28 || t2 == 29 )
	{     t3 = svnftyper( a1,a2,t1,t2,&el1,&el2 );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = el1;
	      *b2 = el2;
	      return( t3 );
	}		

	if( t1 > t2 )
	{       h = a1;
		a1 = a2;
		a2 = h;
		h = t1;
		t1 = t2;
		t2 = h;
	}

	/*** Typangleichung. ***/

	switch( t2 )
	{
		case 10:switch( t1 )
			{       case 0: *b1 = a1;
					*b2 = a2;
					t3 = 10;
					break;
				case 1: *b1 = a1;
					*b2 = vecitovecr( a2 );
					t3 = 11;
					break;
				case 2: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					h = vecitovecpi( r,a2 );
					*b2 = list2( VL,h );
					t3 = 12;
					break;
				case 3: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					h = vecitovecr( a2 );
					h = vecrtovecpr( r,h );
					*b2 = list2( VL,h );
					t3 = 13;
					break;
				case 4: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					a2 = vecitovecpi( r,a2 );
					a2 = vecpitovrfr( r,a2 );
					*b2 = list2( VL,a2 );
					t3 = 14;
					break;
			}
			break;
		case 11:switch( t1 )
			{       case 0: *b1 = itor( a1 );
					*b2 = a2;
					t3 = 11;
					break;
				case 1: *b1 = a1;
					*b2 = a2;
					t3 = 11;
					break;
				case 2: VL = lfirst( a1 );
					r = llength( VL );
					a1 = lsecond( a1 );
					a1 = pitopr( r,a1 );
					a2 = vecrtovecpr( r,a2 );
					*b1 = list2( VL,a1 );
					*b2 = list2( VL,a2 );
					t3 = 13;
					break;
				case 3: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					a2 = vecrtovecpr( r,a2 );
					*b2 = list2( VL,a2 );
					t3 = 13;
					break;
				case 4: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					a2 = vecrtovecpr( r,a2 );
					a2 = vecprtovrfr( r,a2 );
					*b2 = list2( VL,a2 );
					t3 = 14;
					break;
			}
			break;
		case 12:switch( t1 )
			{       case 0: VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,a1 );
					*b2 = a2;
					t3 = 12;
					break;
				case 1: VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					a2 = lsecond( a2 );
					a2 = vecpitovpr( r,a2 );
					*b1 = list2( VL,a1 );
					*b2 = list2( VL,a2 );
					t3 = 13;
					break;
				case 2: t3 = 12;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					h = oequal( VL1, VL2 );
					if( h )
					{       *b1 = a1;
						*b2 = a2;
					}
					else
					{  a1 = lsecond( a1 );
					   Na1 = a1;
					   a2 = lsecond( a2 );
					   h = a2;
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      VL = pvmix( VL1,VL2,Na1,el,&a1,&el );
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   *b1 = list2( VL,a1 );
					}
					break;
				case 3: t3 = 13;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					r = llength( VL2 );
					a2 = lsecond( a2 );
					a2 = vecpitovpr( r,a2 );
					h = oequal( VL1, VL2 );
					if( h )
					{       *b1 = a1;
						*b2 = list2( VL2,a2 );
					}
					else
					{  a1 = lsecond( a1 );
					   Na1 = a1;
					   h = a2;
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      VL = pvmix( VL1,VL2,Na1,el,&a1,&el );
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   *b1 = list2( VL,a1 );
					}
					break;
				case 4: t3 = 14;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					h = oequal( VL1, VL2 );
					if( h )
					{       *b1 = a1;
						r = llength( VL1 );
						a2 = lsecond( a2 );
						a2 = vecpitovrfr( r,a2 );
						*b2 = list2( VL1,a2 );
					}
					else
					{  a1 = lsecond( a1 );
					   Na1 = lsecond( a1 );
					   a1 = lfirst( a1 );
					   a2 = lsecond( a2 );
					   h = a2;
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {	VL = pvmix( VL1,VL2,Na1,el,&el1,&el );
					      	r = llength( VL );
					      	el1 = pvinsert( 0,1,r );
					      	el = list2( el,el1 );
					      }
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   a2 = lfirst( a2 );
					   if( a2 )  a2 = lfirst( a2 );
					   VL = pvmix( VL1,VL,a1,a2,&a1,&a2 );
					   VL = pvmix( VL1,VL,Na1,a2,&Na1,&a2 );
					   a1 = list2( a1,Na1 );
					   *b1 = list2( VL,a1 );
					}
					break;
			}
			break;
		case 13: t3 = 13;
			switch( t1 )
			{       case 0: VL = lfirst( a2 );
					r = llength( VL );
					a1 = itor( a1 );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,a1 );
					*b2 = a2;
					break;
				case 1: VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,a1 );
					*b2 = a2;
					break;
				case 2: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					r = llength( VL1 );
					a1 = lsecond( a1 );
					a1 = pitopr( r,a1 );
					h = oequal( VL1, VL2 );
					if( h )
					{       *b1 = list2( VL1,a1 );
						*b2 = a2;
					}
					else
					{  Na1 = a1;
					   h = lsecond( a2 );
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      VL = pvmix( VL1,VL2,Na1,el,&a1,&el );
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   *b1 = list2( VL,a1 );
					}
					break;
				case 3: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					h = oequal( VL1, VL2 );
					if( h )
					{       *b1 = a1;
						*b2 = a2;
					}
					else
					{  a1 = lsecond( a1 );
					   Na1 = a1;
					   h = lsecond( a2 );
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      VL = pvmix( VL1,VL2,Na1,el,&a1,&el );
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   *b1 = list2( VL,a1 );
					}
					break;
				case 4: t3 = 14;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					h = oequal( VL1, VL2 );
					if( h )
					{       *b1 = a1;
						r = llength( VL1 );
						a2 = lsecond( a2 );
						a2 = vecprtovrfr( r,a2 );
						*b2 = list2( VL1,a2 );
					}
					else
					{  a1 = lsecond( a1 );
					   Na1 = lsecond( a1 );
					   a1 = lfirst( a1 );
					   a2 = lsecond( a2 );
					   h = a2;
					   a2 = _0;
					   r = llength( VL2 );
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {	el = prnumden( r, el, &el1 );
					      	VL = pvmix( VL1,VL2,Na1,el,&el2,&el );
					      	rn = llength( VL );
					      	el1 = pvinsert( 0,1,rn );
					      	el = list2( el,el1 );
					      }
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   a2 = lfirst( a2 );
					   if( a2 ) a2 = lfirst( a2 );
					   VL = pvmix( VL1,VL,a1,a2,&a1,&a2 );
					   VL = pvmix( VL1,VL,Na1,a2,&Na1,&a2 );
					   a1 = list2( a1,Na1 );
					   *b1 = list2( VL,a1 );
					}
					break;
			}
			break;
		case 14:t3 = 14;
			switch( t1 )
			{       case 0: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0,a1,r );
					a1 = pitorfr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 1: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0,a1,r );
					a1 = prtorfr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 2: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					r = llength( VL1 );
					a1 = lsecond( a1 );
					h = oequal( VL1, VL2 );
					if( h )
					{       a1 = pitorfr( r,a1 );
						*b1 = list2( VL1,a1 );
						*b2 = a2;
					}
					else
					{  Na1 = a1;
					   h = lsecond( a2 );
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {	el1 = lsecond( el );
					      	el = lfirst( el );
					      	VL = pvmix( VL1,VL2,Na1,el,&a1,&el );
					      	VL = pvmix( VL1,VL2,Na1,el1,&a1,&el1 );
					      	el = list2( el,el1 );
					      }
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   r = llength( VL );
					   el2 = pvinsert( 0, 1, r );
					   a1 = list2( a1, el2 );
					   *b1 = list2( VL,a1 );
					}
					break;
				case 3: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					r = llength( VL1 );
					a1 = lsecond( a1 );
					h = oequal( VL1, VL2 );
					if( h )
					{       a1 = prtorfr( r,a1 );
						*b1 = list2( VL1,a1 );
						*b2 = a2;
					}
					else
					{  Na1 = a1;
					   Na1 = prnumden( r, Na1, &el2 );
					   h = lsecond( a2 );
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {  el1 = lsecond( el );
					         el = lfirst( el );
					         VL = pvmix( VL1,VL2,Na1,el,&a1,&el );
					         VL = pvmix( VL1,VL2,Na1,el1,&a1,&el1 );
					         el = list2( el,el1 );
					      }
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   r = llength( VL );
					   el2 = pvinsert( 0, el2, r );
					   a1 = list2( a1,el2 );
					   *b1 = list2( VL,a1 );
					}
					break;
				case 4: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					h = oequal( VL1, VL2 );
					if( h )
					{       *b1 = a1;
						*b2 = a2;
					}
					else
					{  a1 = lsecond( a1 );
					   Na1 = lsecond( a1 );
					   a1 = lfirst( a1 );
					   h = lsecond( a2 );
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {  el1 = lsecond( el );
					         el = lfirst( el );
					         VL = pvmix( VL1,VL2,Na1,el,&el2,&el );
					         VL = pvmix( VL1,VL2,a1,el1,&el3,&el1 );
					         el = list2( el,el1 );
					      }
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					   a1 = list2( el3,el2 );
					   *b1 = list2( VL,a1 );
					}
					break;
			}
			break;
	}

	/*** gegfalls  vertauschen. ***/

	return( t3 );
}
