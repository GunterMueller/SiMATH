/*C
			smtyper( a1, a2, t1, t2, b1, b2, esch );

	"scalar matrix typer".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	single smtyper( a1, a2, t1, t2, b1, b2, esch );   obj a1,a1; 
					single t1,t2,esch; obj b1,b2 ;
	X = smtyper( a1, a2, t1, t2, b1, b2, esch );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. smtyper er-
	mittelt die minimale Kennung X fuer die Matrix. Dabei werden
	die Objekte a1 und a2 der Kennung X entsprechend angepasst
	und in b1 das Skalar, b2 die Matrix zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      10.01.1989      C.Hollinger/U.Schneiders
	Version  1.1    31.05.1989      C.Hollinger (styper -> smtyper)
	Version  2      10.07.1989      C.Hollinger/U.Schneiders
	Version  3      13.07.1992      U.Schneiders ( nf und mod )
	Version  4      28.06.1993      S.Schmitt (gf)
H*/

#include <_calc.h>

single smtyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{       obj A1, A2, NA1, el, el1, el2, h;
	list M, VL, VL1, VL2, Z, ZM;
	single n, r, t3;
	init( A1, A2, NA1, el, el1, el2, h, M, VL, VL1, VL2, Z, ZM );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	
	/*** Typer fuer Rechnungen ueber endlichen Koerpern ***/

	if( ( t1 > 30 && t1 < 35 ) || ( t2 > 30 && t2 < 35 ) )
	{	t3=smgftyper(a1,a2,t1,t2,&A1,&A2,esch);
		if( t3 == ERROR )  return( ERROR );
		*b1=A1;
		*b2=A2;
		return( t3 );
	}

	/*** Typer fuer Rechnungen ueber Z/mZ ***/
	
	if( ( t1 > 16 && t1 < 21 ) || ( t2 > 16 && t2 < 21 ) )
	{     t3 = smmodtyper( a1,a2,t1,t2,&A1,&A2,esch );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = A1;
	      *b2 = A2;
	      return( t3 );
	}		

	/*** Typer fuer Rechnungen ueber Zahlkoerpern ***/
	
	if( ( t1 > 23 && t1 < 28 ) || ( t2 > 23 && t2 < 28 ) )
	{     t3 = smnftyper( a1,a2,t1,t2,&A1,&A2 );
	      if( t3 == ERROR )  return( ERROR );
	      *b1 = A1;
	      *b2 = A2;
	      return( t3 );
	}		

	if( t1 > t2 )
	{       h = t1;
		t1 = t2;
		t2 = h;
		h = a1;
		a1 = a2;
		a2 = h;
	}

	/***    Typangleichung  ***/

	switch( t2 )
	{       case 5: switch( t1 )
			{       case 0: *b1 = a1;
					*b2 = a2;
					t3 = 5;
					break;
				case 1: *b1 = a1;
					*b2 = maitomar( a2 );
					t3 = 6;
					break;
				case 2: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					A2 = maitomapi( r,a2 );
					*b2 = list2( VL,A2 );
					t3 = 7;
					break;
				case 3: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					A2 = maitomapi( r,a2 );
					A2 = mapitomapr( r,A2 );
					*b2 = list2( VL,A2 );
					t3 = 8;
					break;
				case 4: *b1 = a1;
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
			{       case 0: *b1 = itor( a1 );
					*b2 = a2;
					t3 = 6;
					break;
				case 1: *b1 = a1;
					*b2 = a2;
					t3 = 6;
					break;
				case 2: VL = lfirst( a1 );
					r = llength( VL );
					A1 = lsecond( a1 );
					A1 = pitopr( r,A1 );
					A2 = martomapr( r,a2 );
					*b1 = list2( VL,A1 );
					*b2 = list2( VL,A2 );
					t3 = 8;
					break;
				case 3: *b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					A2 = martomapr( r,a2 );
					*b2 = list2( VL,A2 );
					t3 = 8;
					break;
				case 4: *b1 = a1;
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
			{       case 0: VL = lfirst( a2 );
					r = llength( VL );
					A1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,A1 );
					*b2 = a2;
					t3 = 7;
					break;
				case 1: VL = lfirst( a2 );
					r = llength( VL );
					A1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,A1 );
					A2 = lsecond( a2 );
					A2 = mapitomapr( r,A2 );
					*b2 = list2( VL,A2 );
					t3 = 8;
					break;
				case 2: t3 = 7;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
					{       *b1 = a1;
						*b2 = a2;
					}
					else
					{       A1 = lsecond( a1 );
						NA1 = A1;
						A2 = lsecond( a2 );
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{  el = lfirst( Z );
							   Z = lred( Z );
							   VL = pvmix( VL1,VL2,NA1,el,&A1,&el );
							   ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
						*b1 = list2( VL,A1 );
					}
					break;
				case 3: t3 = 8;
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
						NA1 = A1;
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{  el = lfirst( Z );
							   Z = lred( Z );
							   VL = pvmix( VL1,VL2,NA1,el,&A1,&el );
							   ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
						*b1 = list2( VL,A1 );
					}
					break;
				case 4: t3 = 9;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					A2 = lsecond( a2 );
					r = llength( VL2 );
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
						*b2 = list2( VL2,M );
					}
					else
					{       A1 = lsecond( a1 );
						NA1 = lsecond( A1 );
						A1 = lfirst( A1 );
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{  el = lfirst( Z );
							   Z = lred( Z );
							   if( el )
							   {	VL = pvmix( VL1,VL2,NA1,el,&el2,&el );
							   	r = llength( VL );
							   	el1 = pvinsert( 0,1,r );
							   	el = list2( el,el1 );
							   }
							   ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
						VL = pvmix( VL,VL1,el2,A1,&el2,&A1 );
						VL = pvmix( VL,VL1,el2,NA1,&el2,&NA1 );
						A1 = list2( A1,NA1 );
						*b1 = list2( VL,A1 );
					}
					break;
			}
			break;
		case 8: t3 = 8;
			switch( t1 )
			{       case 0: VL = lfirst( a2 );
					r = llength( VL );
					A1 = itor( a1 );
					A1 = pvinsert( 0, A1, r );
					*b1 = list2( VL,A1 );
					*b2 = a2;
					break;
				case 1: VL = lfirst( a2 );
					r = llength( VL );
					A1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,A1 );
					*b2 = a2;
					break;
				case 2: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					r = llength( VL1 );
					A1 = lsecond( a1 );
					A1 = pitopr( r,A1 );
					n = oequal( VL1,VL2 );
					if( n )
					{       *b1 = list2( VL1,A1 );
						*b2 = a2;
					}
					else
					{       A2 = lsecond( a2 );
						NA1 = A1;
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{  el = lfirst( Z );
							   Z = lred( Z );
							   VL = pvmix( VL1,VL2,NA1,el,&A1,&el );
							   ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
						*b1 = list2( VL,A1 );
					}
					break;
				case 3: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
					{       *b1 = a1;
						*b2 = a2;
					}
					else
					{       A1 = lsecond( a1 );
						NA1 = A1;
						A2 = lsecond( a2 );
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{  el = lfirst( Z );
							   Z = lred( Z );
							   VL = pvmix( VL1,VL2,NA1,el,&A1,&el );
							   ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
						*b1 = list2( VL,A1 );
					}
					break;
				case 4: t3 = 9;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1, VL2 );
					A2 = lsecond( a2 );
					r = llength( VL2 );
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
							   {	el = prnumden( r, el, &el1 );
							   	el1 = pvinsert( 0, el1, r );
							   	el = list2( el,el1 );
							   }
							   ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL2,M );
					}
					else
					{       A1 = lsecond( a1 );
						NA1 = lsecond( A1 );
						A1 = lfirst( A1 );
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
							      VL = pvmix( VL1,VL2,NA1,el,&el2,&el );
							      n = llength( VL );
							      el1 = pvinsert( 0, el1, n );
							      el = list2( el,el1 );
							   }
							   ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL, M );
						VL = pvmix( VL,VL1,el2,A1,&el2,&A1 );
						VL = pvmix( VL,VL1,el2,NA1,&el2, &NA1 );
						A1 = list2( A1,NA1 );
						*b1 = list2( VL,A1 );
					}
					break;
			}
			break;
		case 9: t3 = 9;
			switch( t1 )
			{       case 0: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					a1 = pitorfr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 1: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					a1 = prtorfr( r,a1 );
					*b1 = list2( VL,a1 );
					break;
				case 2: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					A1 = lsecond( a1 );
					r = llength( VL1 );
					n = oequal( VL1,VL2 );
					if( n )
					{       *b2  = a2;
						el1 = pvinsert( 0,1,r );
						A1 = list2( A1,el1 );
						*b1 = list2( VL1,A1 );
					}
					else
					{       A2 = lsecond( a2 );
						ZM = lfirst( A2 );
						el = lfirst( ZM );
						if( el ) el = lfirst( el );
						VL = pvmix( VL1, VL2, A1, el, &A1, &el );
						r = llength( VL );
						el2 = pvinsert( 0,1,r );
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{       el = lfirst( Z );
								Z = lred( Z );
								if( el )
								{  el1 = lsecond( el );
								   el = lfirst( el );
								   VL = pvmix( VL2, VL, el, A1, &el, &A1 );
								   VL = pvmix( VL2, VL, el1, A1, &el1, &A1 );
								   el = list2( el,el1 );
								}
								ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
						A1 = list2( A1,el2 );
						*b1 = list2( VL,A1 );
					}
					break;
				case 3: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					A1 = lsecond( a1 );
					r = llength( VL1 );
					n = oequal( VL1,VL2 );
					if( n )
					{       *b2  = a2;
						A1 = prnumden( r, A1, &el1 );
						el1 = pvinsert( 0, el1, r );
						A1 = list2( A1,el1 );
						*b1 = list2( VL1,A1 );
					}
					else
					{       A2 = lsecond( a2 );
						ZM = lfirst( A2 );
						el = lfirst( ZM );
						if( el ) el = lfirst( el );
						A1 = prnumden( r, A1, &el2 );
						VL = pvmix( VL1, VL2, A1, el, &A1, &el );
						r = llength( VL );
						el2 = pvinsert( 0, el2, r );
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{       el = lfirst( Z );
								Z = lred( Z );
								if( el )
								{  el1 = lsecond( el );
								   el = lfirst( el );
								   VL = pvmix( VL2,VL,el,A1,&el,&A1 );
								   VL = pvmix( VL2, VL,el1,A1,&el1,&A1 );
								   el = list2( el,el1 );
								}
								ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
						A1 = list2( A1,el2 );
						*b1 = list2( VL,A1 );
					}
					break;
				case 4: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1, VL2 );
					if( n )
					{       *b2  = a2;
						*b1 = a1;
					}
					else
					{       A1 = lsecond( a1 );
						A2 = lsecond( a2 );
						ZM = lfirst( A2 );
						el = lfirst( ZM );
						if( el ) el = lfirst( el );
						el2 = lsecond( A1 );
						A1 = lfirst( A1 );
						VL = pvmix( VL1,VL2,A1,el,&A1,&el );
						VL = pvmix( VL1,VL,el2,A1,&el2,&A1 );
						M = _0;
						while( A2 != _0 )
						{       Z = lfirst( A2 );
							A2 = lred( A2 );
							ZM = _0;
							while( Z != _0 )
							{       el = lfirst( Z );
								Z = lred( Z );
								if( el )
								{  el1 = lsecond( el );
								   el = lfirst( el );
								   VL = pvmix( VL2, VL, el, A1, &el, &A1 );
								   VL = pvmix( VL2, VL, el1, A1, &el1, &A1 );
								   el = list2( el,el1 );
								}
								ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							M = lcomp( ZM,M );
						}
						M = linv( M );
						*b2 = list2( VL,M );
						A1 = list2( A1,el2 );
						*b1 = list2( VL,A1 );
					}
					break;
			}
			break;
	}

	/*** gegfalls  vertauschen. ***/

	return( t3 );
}
