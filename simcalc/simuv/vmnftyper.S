/*C
			vmnftyper( a1, a2, t1, t2, b1, b2 );

	"vector matrix over number field typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single vmnftyper( a1, a2, t1, t2 ); obj a1, a1; single t1, t2;
				            obj b1, b2 ;
	X = vmnftyper( a1, a2, t1, t2, b1, b2 );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. vmnftyper er-
	mittelt die minimale Kennung X fuer die Matrix. Dabei werden
	die Objekte und a2 der Kennung X  entsprechend angepasst und
	in b1 der Vektor und in b2 die Matrix zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      20.07.1992      U.Schneiders
H*/
/*cS
	vmnftyper ruft auf: itonf, lcomp, linv, llength, maitomanf,
 			    mapitomapnf, maprtomapnf, martomanf,
                            mistake, oequal, pitopnf, prtopnf,
			    pvinsert, pvmix, rtonf, vecitovecnf,
			    vecpitovpnf, vecprtovpnf, vecrtovecnf
		    Macros: lfirst, list2, lred, lsecond
Sc*/

#include <_calc.h>

single vmnftyper( a1, a2, t1, t2, b1, b2 )
obj a1, a2;
single t1, t2;
obj *b1, *b2;

{
	obj el, el2;
	list H, VL, VL1, VL2, Z, ZM;
	single n, r, t3;
	init( el, el2, H, VL, VL1, VL2, Z, ZM );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	if( t2 == 9 || t1 == 14 || t2 == 19 || t2 == 20 || t1 == 21 || t1 == 22 )
	{       mistake( 71 );
		return( -BASIS );
	}

	/***    Typangleichung  ***/

	switch( t2 )
	{       case 5: switch( t1 )
			{       case 28:*b1 = a1;
					*b2 = maitomanf( a2 );
					t3 = 26;
					break;
				case 29:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   Z = lfirst( H );
				            H = lred( H );
					    ZM = _0;
					    while( Z != _0 )
					    {   el = lfirst( Z );
					        Z = lred( Z );
						el = itonf( el );
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 27;
					break;
			}
			break;
	        case 6: switch( t1 )
			{       case 28:*b1 = a1;
					*b2 = martomanf( a2 );
					t3 = 26;
					break;
				case 29:t3 = 27;
					*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   Z = lfirst( H );
				            H = lred( H );
					    ZM = _0;
					    while( Z != _0 )
					    {   el = lfirst( Z );
					        Z = lred( Z );
						el = rtonf( el );
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					break;
			}
			break;
	        case 7: switch( t1 )
			{       case 28:VL = lfirst( a2 );
					r = llength( VL );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{	el = lfirst( H );
						H = lred( H );
						el = pvinsert( 0, el, r );
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL,a1 );
					a2 = lsecond( a2 );
					a2 = mapitomapnf( r, a2 );
					*b2 = list2( VL,a2 );
					t3 = 27;
					break;
			        case 29:t3 = 27;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b1 = a1;
					        r = llength( VL2 );
						a2 = lsecond( a2 );
						a2 = mapitomapnf( r, a2 );
						*b2 = list2( VL2,a2 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						Z = lfirst( a2 );
						el = lfirst( Z );
						r = llength( VL2 );
						el = pitopnf( r, el );
						el2 = lfirst( a1 );
						VL = pvmix( VL2,VL1,el,el2,&el,&el2 );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{	el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL1, VL, el, el2, &el, &el2 );
							a1 = lcomp( el, a1 );
						}
						a1 = linv( a1 );
						*b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
						          el = pitopnf( r, el );
							  VL = pvmix( VL2,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					break;
			}
			break;
		case 8: VL = lfirst( a2 );
			a2 = lsecond( a2 );
			r = llength( VL );
			switch( t1 )
			{	case 28:t3 = 27;
					a2 = maprtomapnf( r, a2 );
					*b2 = list2( VL,a2 );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{	el = lfirst( H );
						H = lred( H );
						el = pvinsert( 0, el, r );
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL,a1 );
					break;
			        case 29:t3 = 27;
					VL1 = lfirst( a1 );
					n = oequal( VL,VL1 );
					if( n )
				        {	*b1 = a1;
						a2 = maprtomapnf( r, a2 );
						*b2 = list2( VL,a2 );
					}
					else
					{	a1 = lsecond( a1 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						el = prtopnf( r, el );
						el2 = lfirst( a1 );
						VL2 = pvmix( VL,VL1,el,el2,&el,&el2 );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{	el = lfirst( H );
							H = lred( H );
							VL2 = pvmix( VL1, VL2, el, el2, &el, &el2 );
							a1 = lcomp( el, a1 );
						}
						a1 = linv( a1 );
					        *b1 = list2( VL2,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  el = prtopnf( r, el );
							  VL2 = pvmix( VL,VL2,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL2,a2 );
					}
					break;
			}
			break;
		case 26:switch( t1 )
			{	case 10:*b2 = a2;
			                *b1 = vecitovecnf( a1 );
					t3 = 26;
					break;
				case 11:*b1 = vecrtovecnf( a1 );
					*b2 = a2;
					t3 = 26;
					break;
				case 12:VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
			                a1 = vecpitovpnf( r, a1 );
					*b1 = list2( VL, a1 );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   Z = lfirst( H );
				            H = lred( H );
					    ZM = _0;
					    while( Z != _0 )
					    {   el = lfirst( Z );
					        Z = lred( Z );
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL, a2 );
					t3 = 27;
					break;
				case 13:VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
					a1 = vecprtovpnf( r, a1 );
			                *b1 = list2( VL, a1 );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   Z = lfirst( H );
				            H = lred( H );
					    ZM = _0;
					    while( Z != _0 )
					    {   el = lfirst( Z );
					        Z = lred( Z );
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL, a2 );
					t3 = 27;
					break;
				case 28:*b1 = a1;
					*b2 = a2;
					t3 = 26;
					break;
				case 29:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   Z = lfirst( H );
				            H = lred( H );
					    ZM = _0;
					    while( Z != _0 )
					    {   el = lfirst( Z );
					        Z = lred( Z );
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 27;
					break;
			}
			break;
		case 27:switch( t1 )
			{	case 10:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{	el = lfirst( H );
						H = lred( H );
			                	el = itonf( el );
				        	el = pvinsert( 0, el, r );	
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL, a1 );
					t3 = 27;
					break;
				case 11:VL = lfirst( a2 );
					r = llength( VL );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{	el = lfirst( H );
						H = lred( H );
						el = rtonf( el );
				        	el = pvinsert( 0, el, r );	
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL, a1 );
					*b2 = a2;
					t3 = 27;
					break;
				case 12:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
					        r = llength( VL1 );
						a1 = lsecond( a1 );
						a1 = vecpitovpnf( r, a1 );
						*b1 = list2( VL1,a1 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						r = llength( VL1 );
						el2 = lfirst( a1 );
						el2 = pitopnf( r, el2 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						VL = pvmix( VL1,VL2,el2,el,&el2,&el );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{	el = lfirst( H );
							H = lred( H );
							el = pitopnf( r, el );
				        		VL = pvmix( VL1, VL, el, el2, &el, &el2 );
							a1 = lcomp( el, a1 );
						}
						a1 = linv( a1 );
					        *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  VL = pvmix( VL2,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 27;
					break;
				case 13:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						a1 = vecprtovpnf( r, a1 );
						*b1 = list2( VL1,a1 );
					}
					else
					{	a2 = lsecond( a2 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						el2 = lfirst( a1 );
						el2 = prtopnf( r, el2 );
						VL = pvmix( VL1,VL2,el2,el,&el2,&el );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{	el = lfirst( H );
							H = lred( H );
							el = prtopnf( r, el );
				        		VL = pvmix( VL1, VL, el, el2, &el, &el2 );
							a1 = lcomp( el, a1 );
						}
						a1 = linv( a1 );
					        *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  VL = pvmix( VL2,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 27;
					break;
				case 28:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{ 	el = lfirst( H );
						H = lred( H );
						el = pvinsert( 0, el, r );
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL, a1 );
					t3 = 27;
					break;
				case 29:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						*b1 = a1;
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						el2 = lfirst( a1 );
						VL = pvmix( VL1,VL2,el2,el,&el2,&el );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{ 	el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL1, VL, el, el2, &el, &el2 );
							a1 = lcomp( el, a1 );
						}
						a1 = linv( a1 );
						*b1 = list2( VL, a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  VL = pvmix( VL2,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 27;
					break;
			}
			break;
	}
	return( t3 );
}
