/*C
		      vtyper( a1, a2, t1, t2, b1, b2, esch )

	"vectortyper".
	Quellbibliothek: srclib.calc
	Include-Datei: _calc.h
	single vtyper( a1,a2,t1,t2,b1,b2, esch );  list a1,a2; 
				single t1,t2, esch; list *b1,*b2;
	X = vtyper( a1, a2, t1, t2, b1, b2, esch );

	t1 bzw t2 ist die Kennung der Vektoren a1 bzw a2. vtyper er-
	mittelt die minimale, gemeinsame Kennung X. Dabei werden die
	Vektoren a1 und a2 entsprechend ihrer gemeinsamen Kennung an-
	gepasst und an b1 und b2 zurueckgegeben.
C*/
/*H
	Version  1      24.05.1988      C.Hollinger
	Version  2      10.07.1989      C.Hollinger/U.Schneiders
	Version  3      21.07.1992      U.Schneiders ( mod und nf )
H*/
 
#include<_calc.h>

single vtyper( a1, a2, t1, t2, b1, b2, esch )
list a1, a2;
single t1, t2, esch;
list *b1, *b2;

{
	single n, r, rn, sch=0, t3;
	obj el, el1, el2, h;
	list VL, VL1, VL2;
	init( el, el1, el2, h, VL, VL1, VL2 );
	bind( a1, a2 );

	*b1 = _0;
	*b2 = _0;

	/*** Typer fuer Rechnung ueber endlichen Koerpern ***/

	if( ( t1 > 34 && t1 < 37 ) || ( t2 > 34 && t2 < 37 ) )
	{	t3 = vecgftyper(a1,a2,t1,t2,&el1,&el2, esch );
		if(t3==ERROR)  return(ERROR);
		*b1=el1;
		*b2=el2;
		return(t3);
	}

	/*** Typer fuer Rechnungen ueber Z/mZ ***/
	
	if( ( t1 > 20 && t1 < 23 ) || ( t2 > 20 && t2 < 23 ) )
	{     t3 = vecmodtyper( a1,a2,t1,t2,&el1,&el2, esch );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = el1;
	      *b2 = el2;
	      return( t3 );
	}		
	
	/*** Typer fuer Rechnungen ueber Zahlkoerpern ***/
	
	if( ( t1 > 27 && t1 < 30 ) || ( t2 > 27 && t2 < 30 ) )
	{     t3 = vecnftyper( a1,a2,t1,t2,&el1,&el2 );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = el1;
	      *b2 = el2;
	      return( t3 );
	}		

	if( t1 > t2 )
	{       sch = 1;
		h = a1;
		a1 = a2;
		a2 = h;
		h = t1;
		t1 = t2;
		t2 = h;
	}

	/*** Anpassung an min. gemeinsame Kennung. ***/

	switch( t1 )
	{       case 10:switch( t2 )
			{       case 10:t3 = 10;
					*b1 = a1;
					*b2 = a2;
					break;
				case 11:t3 = 11;
					*b2 = a2;
					a1 = vecitovecr( a1 );
					*b1 = a1;
					break;
				case 12:t3 = 12;
					*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = vecitovecpi( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 13:t3 = 13;
					*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = vecitovecr( a1 );
					a1 = vecrtovecpr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 14:t3 = 14;
					*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = vecitovecpi( r,a1 );
					a1 = vecpitovrfr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
			}
			break;
		case 11:switch( t2 )
			{       case 11:t3 = 11;
					*b1 = a1;
					*b2 = a2;
					break;
				case 12:t3 = 13;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = vecrtovecpr( r,a1 );
					a2 = lsecond( a2 );
					a2 = vecpitovpr( r,a2 );
					*b1 = list2( VL,a1 );
					*b2 = list2( VL,a2 );
					break;
				case 13:t3 = 13;
					*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = vecrtovecpr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 14:t3 = 14;
					*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = vecrtovecpr( r,a1 );
					a1 = vecprtovrfr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
			}
			break;
		case 12:switch( t2 )
			{       case 12:t3 = 12;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					h = oequal( VL1,VL2 );
					if( h )
					{       *b1 = a1;
						*b2 = a2;
					}
					else
					{  a1 = lsecond( a1 );
					   a2 = lsecond( a2 );
					   el = lfirst( a1 );
					   el2 = lfirst( a2 );
					   VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
					   h = a1;
					   a1 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      VL = pvmix( VL1,VL,el,el2,&el,&el2);
					      a1 = lcomp( el,a1 );
					   }
					   a1 = linv( a1 );
					   *b1 = list2( VL,a1 );
					   h = a2;
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      VL = pvmix( VL2,VL,el,el2,&el,&el2);
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					}
					break;
				case 13:t3 = 13;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1, VL2 );
					r = llength( VL1 );
					a1 = lsecond( a1 );
					a2 = lsecond( a2 );
					if( !n )
					{  el = lfirst( a1 );
					   el2 = lfirst( a2 );
					   VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
					}
					h = a1;
					a1 = _0;
					while( h != _0 )
					{  el = lfirst( h );
					   h = lred( h );
					   el = pitopr( r,el);
					   if( !n )
					      VL = pvmix( VL1,VL,el,el2,&el,&el2 );
					   a1 = lcomp( el,a1 );
					}
					a1 = linv( a1 );
					if( !n )  *b1 = list2( VL,a1 );
					else      *b1 = list2( VL1,a1 );
					if( n )   *b2 = list2( VL2,a2 );
					else
					{  h = a2;
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      VL = pvmix( VL2,VL,el,el2,&el,&el2);
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					}
					break;
				case 14:t3 = 14;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					a1 = lsecond( a1 );
					h = oequal( VL1,VL2 );
					if( h )
					{       *b2 = a2;
						h = a1;
						a1 = _0;
						r = llength( VL1 );
						el1 = pvinsert( 0,1,r );
						while( h != _0 )
						{  el = lfirst( h );
						   h = lred( h );
						   if( el ) el = list2( el,el1 );
						   a1 = lcomp( el,a1 );
						}
						a1 = linv( a1 );
						*b1 = list2( VL1,a1 );
					}
					else
					{  a2 = lsecond( a2 );
					   el = lfirst( a1 );
					   el2 = lfirst( a2 );
					   if( el2 ) el2 = lfirst( el2 );
					   VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
					   r = llength( VL );
					   el1 = pvinsert( 0,1,r );
					   h = a1;
					   a1 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {	VL = pvmix( VL1,VL,el,el2,&el,&el2);
					        el = list2( el,el1 );
					      }
					      a1 = lcomp( el,a1 );
					   }
					   a1 = linv( a1 );
					   *b1 = list2( VL,a1 );
					   h = a2;
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {	el1 = lsecond( el );
					         el = lfirst( el );
					         VL = pvmix( VL2,VL,el,el2,&el,&el2);
					         VL = pvmix( VL2,VL,el1,el2,&el1,&el2);
					         el = list2( el,el1 );
					      }
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					}
					break;
			}
			break;
		case 13:switch( t2 )
			{       case 13:t3 = 13;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					h = oequal( VL1,VL2 );
					if( h )
					{       *b1 = a1;
						*b2 = a2;
					}
					else
					{       a1 = lsecond( a1 );
						el = lfirst( a1 );
						a2 = lsecond( a2 );
						el2 = lfirst( a2 );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						h = a1;
						a1 = _0;
						while( h != _0 )
						{       el = lfirst( h );
							h = lred( h );
							VL = pvmix( VL1,VL,el,el2,&el,&el2);
							a1 = lcomp( el,a1 );
						}
						a1 = linv( a1 );
						*b1 = list2( VL,a1 );
						h = a2;
						a2 = _0;
						while( h != _0 )
						{       el = lfirst( h );
							h = lred( h );
							VL = pvmix( VL2,VL,el,el2,&el,&el2 );
							a2 = lcomp( el,a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					break;
				case 14:t3 = 14;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					h = oequal( VL1,VL2 );
					if( h )
					{       *b2 = a2;
						h = a1;
						a1 = _0;
						while( h != _0 )
						{  el = lfirst( h );
						   h = lred( h );
						   if( el )
						   {	el = prnumden( r, el, &el1 );
						        el1 = pvinsert( 0, el1, r );
						        el = list2( el,el1 );
						   }
						   a1 = lcomp( el,a1 );
						}
						a1 = linv( a1 );
						*b1 = list2( VL1,a1 );
					}
					else
					{  a2 = lsecond( a2 );
					   el = lfirst( a1 );
					   el = prnumden( r, el, &el1 );
					   el2 = lfirst( a2 );
					   if( el2 ) el2 = lfirst( el2 );
					   VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
					   rn = llength( VL );
					   h = a1;
					   a1 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {	el = prnumden( r, el, &el1 );
					        VL = pvmix( VL1,VL,el,el2,&el,&el2);
					        el1 = pvinsert( 0, el1, rn );
					        el = list2( el,el1 );
					      }
					      a1 = lcomp( el,a1 );
					   }
					   a1 = linv( a1 );
					   *b1 = list2( VL,a1 );
					   h = a2;
					   a2 = _0;
					   while( h != _0 )
					   {  el = lfirst( h );
					      h = lred( h );
					      if( el )
					      {	el1 = lsecond( el );
					        el = lfirst( el );
					        VL = pvmix( VL2,VL,el,el2,&el,&el2);
					        VL = pvmix( VL2,VL,el1,el2,&el1,&el2);
					        el = list2( el, el1 );
					      }
					      a2 = lcomp( el,a2 );
					   }
					   a2 = linv( a2 );
					   *b2 = list2( VL,a2 );
					}
					break;
			}
			break;
		case 14:t3 = 14;
			VL1 = lfirst( a1 );
			VL2 = lfirst( a2 );
			h = oequal( VL1,VL2 );
			if( h )
			{       *b1 = a1;
				*b2 = a2;
			}
			else
			{       a1 = lsecond( a1 );
				el = lfirst( a1 );
				if( el ) el = lfirst( el );
				a2 = lsecond( a2 );
				el2 = lfirst( a2 );
				if( el2 ) el2 = lfirst( el2 );
				VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
				h = a1;
				a1 = _0;
				while( h != _0 )
				{       el = lfirst( h );
					h = lred( h );
					if( el )
					{  el1 = lsecond( el );
					   el = lfirst( el );
					   VL = pvmix( VL1,VL,el,el2,&el,&el2);
					   VL = pvmix( VL1,VL,el1,el2,&el1,&el2);
					   el = list2( el,el1 );
					}
					a1 = lcomp( el,a1 );
				}
				a1 = linv( a1 );
				*b1 = list2( VL,a1 );
				h = a2;
				a2 = _0;
				while( h != _0 )
				{       el = lfirst( h );
					h = lred( h );
					if( el )
					{  el1 = lsecond( el );
					   el = lfirst( el );
					   VL = pvmix( VL2,VL,el,el2,&el,&el2);
					   VL = pvmix( VL2,VL,el1,el2,&el1,&el2);
					   el = list2( el,el1 );
					}
					a2 = lcomp( el,a2 );
				}
				a2 = linv( a2 );
				*b2 = list2( VL,a2 );
			}
			break;
	}
	if( sch )
	{       h = *b1;
		*b1 = *b2;
		*b2 = h;
	}
	return( t3 );
}
