/*C
			vmmodtyper( a1, a2, t1, t2, b1, b2, esch );

	"vector matrix over Z/mZ typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single vmmodtyper( a1, a2, t1, t2, b1, b2, esch ); obj a1, a1; 
				single t1, t2, esch; obj b1, b2 ;
	X = vmmodtyper( a1, a2, t1, t2, b1, b2, esch );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. vmmodtyper er-
	mittelt die minimale Kennung X fuer die Matrix. Dabei werden
	die Objekte und a2 der Kennung X  entsprechend angepasst und
	in b1 der Vektor und in b2 die Matrix zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.07.1992      U.Schneiders
H*/

#include <_calc.h>

single vmmodtyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{
	obj el, el2;
	list H, VL, VL1, VL2, Z, ZM;
	single n, r, t3;
	int M;
	init( el, el2, H, VL, VL1, VL2, Z, ZM, M );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	if( t2 == 9 || t1 == 14 || t2 == 26 || t2 == 27 || t1 == 28 || t1 == 29 )
	{       if(esch) mistake( 71 );
		return( -BASIS );
	}
	M = lfirst( varlist[modsch].varwert );

	/***    Typangleichung  ***/

	switch( t2 )
	{       case 5: switch( t1 )
			{       case 21:*b1 = a1;
					if( ssch ) *b2 = maitomams( M, a2 );
		        		else       *b2 = maitomami( M, a2 );
					if(M==2) *b2=mamstomam2(*b2);
					t3 = 19;
					 break;
				case 22:*b1 = a1;
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
						if( ssch ) el = mshom( M, el );
						else el = mihom( M, el );
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 20;
					break;
			}
			break;
	        case 6: a2 = martomami( M, a2 );
			if( a2 == ERROR )
			{       if(esch) mistake1( 243, M );
			    	return( ERROR );
			}
			switch( t1 )
			{       case 21:*b1 = a1;
					*b2 = a2;
					if(M==2) *b2=mamstomam2(*b2);
					t3 = 19;
					break;
				case 22:t3 = 20;
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
			{       case 21:VL = lfirst( a2 );
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
					if( ssch ) a2 = mapitomapms( r, a2, M );
					else a2 = mapitomapmi( r, a2, M );
					*b2 = list2( VL,a2 );
					t3 = 20;
					break;
			        case 22:t3 = 20;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b1 = a1;
					        r = llength( VL2 );
						a2 = lsecond( a2 );
						if(ssch) a2 = mapitomapms( r, a2, M );
						else a2 = mapitomapmi( r, a2, M );
						*b2 = list2( VL2,a2 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						Z = lfirst( a2 );
						el = lfirst( Z );
						r = llength( VL2 );
						if(ssch) el = pitopms( r, el, M );
						else el = pitopmi( r, el, M );
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
						          if(ssch) el = pitopms( r, el, M );
						          else el = pitopmi( r, el, M );
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
			a2 = maprtomapmi( r, a2, M );
			if( a2 == ERROR )
			{       if(esch) mistake1( 243, M );
				return( ERROR );
			}
			switch( t1 )
			{	case 21:t3 = 20;
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
			        case 22:t3 = 20;
					VL1 = lfirst( a1 );
					n = oequal( VL,VL1 );
					if( n )
				        {	*b1 = a1;
						*b2 = list2( VL,a2 );
					}
					else
					{	a1 = lsecond( a1 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
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
		case 19:switch( t1 )
			{	case 10:*b2 = a2;
			                if( ssch ) *b1 = vecitovecms( M, a1 );
					else  *b1 = vecitovecmi( M, a1 );
					t3 = 19;
					break;
				case 11: a1 = vecrtovecmi( M, a1 );
					if( a1 == ERROR )
					{       if(esch) mistake1( 244, M );
			    			return( ERROR );
					}
					*b1 = a1;
					*b2 = a2;
					t3 = 19;
					break;
				case 12:VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
			                if( ssch ) a1 = vecpitovpms( r, a1, M );
					else a1 = vecpitovpmi( r, a1, M );
					*b1 = list2( VL, a1 );
					H = a2;
					a2 = _0;
					if(M==2) H=mam2tomams(H);
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
					t3 = 20;
					break;
				case 13:VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
					a1 = vecprtovpmi( r, a1, M );
					if( a1 == ERROR )
					{       if(esch) mistake1( 244, M );
						return( ERROR );
					}
			                *b1 = list2( VL, a1 );
					H = a2;
					a2 = _0;
					if(M==2) H=mam2tomams(H);
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
					t3 = 20;
					break;
				case 21:*b1 = a1;
					*b2 = a2;
					t3 = 19;
					break;
				case 22:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					if(M==2) H=mam2tomams(H);
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
					t3 = 20;
					break;
			}
			break;
		case 20:switch( t1 )
			{	case 10:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{	el = lfirst( H );
						H = lred( H );
			                	if( ssch ) el = mshom( M, el );
						else el = mihom( M, el );
				        	el = pvinsert( 0, el, r );	
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL, a1 );
					t3 = 20;
					break;
				case 11:a1 = vecrtovecmi( M, a1 );
					if( a1 == ERROR )
					{       if(esch) mistake1( 244, M );
			    			return( ERROR );
					}
					VL = lfirst( a2 );
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
					*b1 = list2( VL, a1 );
					*b2 = a2;
					t3 = 20;
					break;
				case 12:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
					        r = llength( VL1 );
						a1 = lsecond( a1 );
						if(ssch) a1 = vecpitovpms( r, a1, M );
						else a1 = vecpitovpmi( r, a1, M );
						*b1 = list2( VL1,a1 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						r = llength( VL1 );
						el2 = lfirst( a1 );
						if(ssch) el2 = pitopms( r, el2, M );
						else el2 = pitopmi( r, el2, M );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						VL = pvmix( VL1,VL2,el2,el,&el2,&el );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{	el = lfirst( H );
							H = lred( H );
							if(ssch) el = pitopms( r, el, M );
							else el = pitopmi( r, el, M );
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
					t3 = 20;
					break;
				case 13:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					a1 = vecprtovpmi( r, a1, M );
					if( a1 == ERROR )
					{       if(esch) mistake1( 244, M );
						return( ERROR );
					}
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						*b1 = list2( VL1,a1 );
					}
					else
					{	a2 = lsecond( a2 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						el2 = lfirst( a1 );
						VL = pvmix( VL1,VL2,el2,el,&el2,&el );
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
							  VL = pvmix( VL2,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 20;
					break;
				case 21:*b2 = a2;
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
					t3 = 20;
					break;
				case 22:VL1 = lfirst( a1 );
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
					t3 = 20;
					break;
			}
			break;
	}
	return( t3 );
}
