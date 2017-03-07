/*C
			svnftyper( a1, a2, t1, t2, b1, b2 );

	"scalar vector over number field typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single svnftyper( a1, a2, t1, t2 ); obj a1,a1; single t1,t2;
				            obj b1,b2 ;
	X = svnftyper( a1, a2, t1, t2, b1, b2 );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. svnftyper er-
	mittelt die minimale Kennung X fuer den Vektor. Dabei werden
	die Objekte a1 und a2 der Kennung X entsprechend angepasst
	und in b1 das Skalar, b2 der Vektor zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.07.1992      U.Schneiders
H*/
/*cS
	svnftyper ruft auf: itonf, lcomp, linv, llength, mistake,
                            oequal, pitopnf, pvinsert, pvmix
			    vecitovecnf, vecpitovpnf, vecprtovpnf,
			    vecrtovecnf
	            Macros: lfirst, list2, lred, lsecond
Sc*/

#include <_calc.h>

single svnftyper( a1, a2, t1, t2, b1, b2 )
obj a1, a2;
single t1, t2;
obj *b1, *b2;

{       obj el, H;
	list VL, VL1, VL2;
	single n, r, t3;
	init( el, H, VL, VL1, VL2 );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	if( t1 == 4 || t2 == 4 || ( t1 == 14 && t1 < 24 ) 
         || ( t2 == 14 && t2 < 24 ) )
	{       mistake( 71 );
		return( -BASIS );
	}

	if( t2 < 4 || t2 == 24 || t2 == 25 ) 
	{       H = t1;
		t1 = t2;
		t2 = H;
		H = a1;
		a1 = a2;
		a2 = H;
	}

	/***    Typangleichung  ***/

	switch( t2 )
	{       case 10: switch( t1 )
			{       case 24:*b1 = a1;
		        		*b2 = vecitovecnf( a2 );
					t3 = 28;
					break;
				case 25:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = itonf( el );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 29;
					break;
			}
			break;
	        case 11: switch( t1 )
			{       case 24:*b1 = a1;
				        *b2 = vecrtovecnf( a2 );
					t3 = 28;
					break;
				case 25:t3 = 29;
					*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = rtonf( el );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					break;
			}
			break;
		case 12: switch( t1 )
			{       case 24:VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,a1 );
					a2 = lsecond( a2 );
					a2 = vecpitovpnf( r, a2 );
					*b2 = list2( VL,a2 );
					t3 = 29;
					break;
			        case 25:t3 = 29;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b1 = a1;
					        r = llength( VL2 );
						a2 = lsecond( a2 );
						a2 = vecpitovpnf( r, a2 );
						*b2 = list2( VL2,a2 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						el = lfirst( a2 );
						r = llength( VL2 );
						el = pitopnf( r, el );
						VL = pvmix( VL2,VL1,el,a1,&el,&a1 );
					       *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
						        el = pitopnf( r, el );
							VL = pvmix( VL2,VL,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					break;
			}
			break;
		case 13:VL = lfirst( a2 );
			a2 = lsecond( a2 );
			r = llength( VL );
			switch( t1 )
			{	case 24:t3 = 29;
			                a2 = vecprtovpnf( r, a2 );
					*b2 = list2( VL,a2 );
					a1 = pvinsert( 0,a1,r );
					*b1 = list2( VL,a1 );
					break;
			        case 25:t3 = 29;
					VL1 = lfirst( a1 );
					n = oequal( VL,VL1 );
					if( n )
				        {	*b1 = a1;
						a2 = vecprtovpnf( r, a2 );
						*b2 = list2( VL,a2 );
					}
					else
					{	a1 = lsecond( a1 );
						el = lfirst( a2 );
						el = prtopnf( r, el );
						VL2 = pvmix( VL,VL1,el,a1,&el,&a1 );
					        *b1 = list2( VL2,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							el = prtopnf( r, el );
							VL2 = pvmix( VL,VL2,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL2,a2 );
					}
					break;
			}
			break;
		case 28:switch( t1 )
			{	case 0: *b2 = a2;
					*b1 = itonf( a1 );
					t3 = 28;
					break;
				case 1: *b1 = rtonf( a1 );
					*b2 = a2;
					t3 = 28;
					break;
				case 2: VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
					a1 = pitopnf( r, a1 );
					*b1 = list2( VL, a1 );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL, a2 );
					t3 = 29;
					break;
				case 3: VL = lfirst( a1 );
					r = llength( VL );
					a1 = lsecond( a1 );
					a1 = prtopnf( r, a1 );
			                *b1 = list2( VL, a1 );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL, a2 );
					t3 = 29;
					break;
				case 24:*b1 = a1;
					*b2 = a2;
					t3 = 28;
					break;
				case 25:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 29;
					break;
			}
			break;
		case 29:switch( t1 )
			{	case 0: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = itonf( a1 );
				        a1 = pvinsert( 0, a1, r );	
					*b1 = list2( VL, a1 );
					t3 = 29;
					break;
				case 1: VL = lfirst( a2 );
					r = llength( VL );
					a1 = rtonf( a1 );
				        a1 = pvinsert( 0, a1, r );	
					*b1 = list2( VL, a1 );
					*b2 = a2;
					t3 = 29;
					break;
				case 2: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					r = llength( VL1 );
					a1 = lsecond( a1 );
					a1 = pitopnf( r, a1 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						*b1 = list2( VL1,a1 );
					}
					else
					{	a2 = lsecond( a2 );
						el = lfirst( a2 );
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
					        *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL2,VL,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 29;
					break;
				case 3: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					a1 = prtopnf( r, a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						*b1 = list2( VL1,a1 );
					}
					else
					{       a2 = lsecond( a2 );
						el = lfirst( a2 );
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
					        *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL2,VL,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 29;
					break;
				case 24:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, a1 );
					t3 = 29;
					break;
				case 25:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						*b1 = a1;
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						el = lfirst( a2 );
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
					        *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL2,VL,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 29;
					break;
			}
			break;
	}

	return( t3 );
}
