/*C
			vmgftyper( a1, a2, t1, t2, b1, b2, esch );

	"vector matrix over Galois-field typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single vmgftyper( a1, a2, t1, t2, b1,b2, esch ); obj a1, a1; 
					single t1, t2, esch; obj b1, b2 ;
	X = vmgftyper( a1, a2, t1, t2, b1, b2, esch );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. vmgftyper er-
	mittelt die minimale Kennung X fuer die Matrix. Dabei werden
	die Objekte a1 und a2 der Kennung X  entsprechend angepasst und
	in b1 der Vektor und in b2 die Matrix zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      01.07.1993      S.Schmitt
	Version  1.1    07.03.1996      S.Schmitt ( GF(2) )
H*/

#include <_calc.h>

single vmgftyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{
	obj el, el2;
	list H, VL, VL1, VL2, Z, ZM;
	single n, r, t3;
	init( el, el2, H, VL, VL1, VL2, Z, ZM );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	if( t2 == 9 || t1 == 14 || t2 == 26 || t2 == 27 || t1 == 28 || t1 == 29 || ( ( t1 == 21 || t1 == 22 || t2 == 19 || t2 == 20 ) && lfirst( varlist[modsch].varwert ) != gfchar ) )
	{       if(esch) mistake( 71 );
		return( -BASIS );
	}

	/***    Typangleichung  ***/

	switch( t2 )
	{       case 5: switch( t1 )
			{       case 35:*b1 = a1;
					if(gfchar!=2) *b2=maitomagfs(gfchar,a2);
					else *b2=maitomagf2(a2);
					t3 = 33;
					break;
				case 36:*b1 = a1;
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
						el = mshom( gfchar, el );
						if(el) 
						{	el=list2(0,el);
							if(gfchar==2) el=udpm2tosb(el);
						}
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 34;
					break;
			}
			break;
	        case 6: a2 = martomami( gfchar, a2 );
			if( a2 == ERROR )
			{       if(esch) mistake1( 243, gfchar );
			    	return( ERROR );
			}
			switch( t1 )
			{       case 35:*b1 = a1;
					if(gfchar!=2) *b2=maitomagfs(gfchar,a2);
					else *b2=maitomagf2(a2);
					t3 = 33;
					break;
				case 36:*b1 = a1;
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
						if(el) 
						{	el=list2(0,el);
							if(gfchar==2) el=udpm2tosb(el);
						}
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 34;
					break;
			}
			break;
	        case 7: switch( t1 )
			{       case 35:VL = lfirst( a2 );
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
					a2 = mapitomapms( r, a2, gfchar );
					if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
					else a2=mpm2tompgf2(r,a2);
					*b2 = list2( VL,a2 );
					t3 = 34;
					break;
			        case 36:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b1 = a1;
					        r = llength( VL2 );
						a2 = lsecond( a2 );
						a2 = mapitomapms(r,a2,gfchar);
						if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
						else a2=mpm2tompgf2(r,a2);
						*b2 = list2( VL2,a2 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						Z = lfirst( a2 );
						el = lfirst( Z );
						r = llength( VL2 );
						el = pitopms( r, el, gfchar );
						if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
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
						          el = pitopms( r, el, gfchar );
							  if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
							  else el=pm2topgf2(r,el);
							  VL = pvmix( VL2,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 34;
					break;
			}
			break;
		case 8: VL = lfirst( a2 );
			a2 = lsecond( a2 );
			r = llength( VL );
			a2 = maprtomapmi( r, a2, gfchar );
			if( a2 == ERROR )
			{       if(esch) mistake1( 243, gfchar );
				return( ERROR );
			}
			switch( t1 )
			{	case 35:if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
					else a2=mpm2tompgf2(r,a2);
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
					t3 = 34;
					break;
			        case 36:VL1 = lfirst( a1 );
					n = oequal( VL,VL1 );
					if( n )
				        {	*b1 = a1;
						if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
						else a2=mpm2tompgf2(r,a2);
						*b2 = list2( VL,a2 );
					}
					else
					{	a1 = lsecond( a1 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
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
							  if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
							  else el=pm2topgf2(r,el);
							  VL2 = pvmix( VL,VL2,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL2,a2 );
					}
					t3 = 34;
					break;
			}
			break;
		case 19:if(lfirst(varlist[modsch].varwert)==2) 
							a2=mam2tomams(a2);
			switch( t1 )
			{       case 35:*b1 = a1;
					if(gfchar!=2) *b2=maitomagfs(gfchar,a2);
					else *b2=maitomagf2(a2);
					t3 = 33;
					break;
				case 36:*b1 = a1;
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
						if(el) 
						{	el=list2(0,el);
							if(gfchar==2) el=udpm2tosb(el);
						}
						el = pvinsert( 0,el,r );
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    a2 = lcomp( ZM, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 34;
					break;
			}
			break;
	        case 20: switch( t1 )
			{       case 35:VL = lfirst( a2 );
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
					if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
					else a2=mpm2tompgf2(r,a2);
					*b2 = list2( VL,a2 );
					t3 = 34;
					break;
			        case 36:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b1 = a1;
					        r = llength( VL2 );
						a2 = lsecond( a2 );
						if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
						else a2=mpm2tompgf2(r,a2);
						*b2 = list2( VL2,a2 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						Z = lfirst( a2 );
						el = lfirst( Z );
						r = llength( VL2 );
						if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
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
							  if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
							  else el=pm2topgf2(r,el);
							  VL = pvmix( VL2,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							a2 = lcomp( ZM, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 34;
					break;
			}
			break;
		case 33:switch( t1 )
			{	case 10:*b2 = a2;
			                if(gfchar!=2) *b1=vecitovecgfs(gfchar,a1);
					else *b1=vecitovecgf2(a1);
					t3 = 33;
					break;
				case 11: a1 = vecrtovecmi( gfchar, a1 );
					if( a1 == ERROR )
					{       if(esch) mistake1( 244, gfchar );
			    			return( ERROR );
					}
					if(gfchar!=2) *b1=vecitovecgfs(gfchar,a1);
					else *b1=vecitovecgf2(a1);
					*b2 = a2;
					t3 = 33;
					break;
				case 12:VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
			                a1 = vecpitovpms( r, a1, gfchar);
					if(gfchar!=2) a1=vpmstovpgfs(r,gfchar,a1);
					else a1=vpm2tovpgf2(r,a1);
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
					t3 = 34;
					break;
				case 13:VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
					a1 = vecprtovpmi( r, a1, gfchar);
					if( a1 == ERROR )
					{       if(esch) mistake1( 244, gfchar );
						return( ERROR );
					}
					if(gfchar!=2) a1 = vpmstovpgfs(r,gfchar,a1);
					else a1=vpm2tovpgf2(r,a1);
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
					t3 = 34;
					break;
				case 21:*b2 = a2;
					if(gfchar!=2) *b1 = vecitovecgfs(gfchar,a1);
					else *b1=vecitovecgf2(a1);
					t3 = 33;
					break;
				case 22:VL = lfirst(a1);
					r = llength(VL);
					a1 = lsecond(a1);
					if(gfchar!=2) a1 = vpmstovpgfs(r,gfchar,a1);
					else a1=vpm2tovpgf2(r,a1);
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
					t3 = 34;
					break;
				case 35:*b1 = a1;
					*b2 = a2;
					t3 = 33;
					break;
				case 36:*b1 = a1;
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
					t3 = 34;
					break;
			}
			break;
		case 34:switch( t1 )
			{	case 10:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{	el = lfirst( H );
						H = lred( H );
			                	el = mshom( gfchar, el );
						if(el) 
						{	el=list2(0,el);
							if(gfchar==2) el=udpm2tosb(el);
						}
				        	el = pvinsert( 0, el, r);
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL, a1 );
					t3 = 34;
					break;
				case 11:a1 = vecrtovecmi( gfchar, a1 );
					if( a1 == ERROR )
					{       if(esch) mistake1( 244, gfchar );
			    			return( ERROR );
					}
					VL = lfirst( a2 );
					r = llength( VL );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{	el = lfirst( H );
						H = lred( H );
						if(el) 
						{	el=list2(0,el);
							if(gfchar==2) el=udpm2tosb(el);
						}
				        	el = pvinsert( 0, el, r);
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL, a1 );
					*b2 = a2;
					t3 = 34;
					break;
				case 12:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
					        r = llength( VL1 );
						a1 = lsecond( a1 );
						a1 = vecpitovpms(r,a1,gfchar);
						if(gfchar!=2) a1 = vpmstovpgfs(r,gfchar,a1);
						else a1=vpm2tovpgf2(r,a1);
						*b1 = list2( VL1,a1 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						r = llength( VL1 );
						el2 = lfirst( a1 );
						el2 = pitopms( r, el2, gfchar );
						if(gfchar!=2) el2 = pmstopgfs(r,gfchar,el2);
						else el2=pm2topgf2(r,el2);
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						VL = pvmix( VL1,VL2,el2,el,&el2,&el );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{	el = lfirst( H );
							H = lred( H );
							el = pitopms( r, el, gfchar );
							if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
							else el=pm2topgf2(r,el);
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
					t3 = 34;
					break;
				case 13:VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					a1 = vecprtovpmi( r, a1, gfchar);
					if( a1 == ERROR )
					{       if(esch) mistake1( 244, gfchar );
						return( ERROR );
					}
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						if(gfchar!=2) a1 = vpmstovpgfs(r,gfchar,a1);
						else a1=vpm2tovpgf2(r,a1);
						*b1 = list2( VL1,a1 );
					}
					else
					{	a2 = lsecond( a2 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						el2 = lfirst( a1 );
						if(gfchar!=2) el2 = pmstopgfs(r,gfchar,el2);
						else el2=pm2topgf2(r,el2);
						VL = pvmix( VL1,VL2,el2,el,&el2,&el );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{	el = lfirst( H );
							H = lred( H );
							if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
							else el=pm2topgf2(r,el);
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
					t3 = 34;
					break;
				case 21:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					H = a1;
					a1 = _0;
					while( H != _0 )
					{ 	el = lfirst( H );
						H = lred( H );
						if(el) 
						{	el=list2(0,el);
							if(gfchar==2) el=udpm2tosb(el);
						}
						el = pvinsert( 0, el, r );
						a1 = lcomp( el, a1 );
					}
					a1 = linv( a1 );
					*b1 = list2( VL, a1 );
					t3 = 34;
					break;
				case 22:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					r = llength(VL1);
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						a1 = lsecond(a1);
						if(gfchar!=2) a1 = vpmstovpgfs(r,gfchar,a1);
						else a1=vpm2tovpgf2(r,a1);
						*b1 = list2(VL1,a1);
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						el2 = lfirst( a1 );
						if(gfchar!=2) el2=pmstopgfs(r,gfchar,el2);
						else el2=pm2topgf2(r,el2);
						VL = pvmix( VL1,VL2,el2,el,&el2,&el );
						H = a1;
						a1 = _0;
						while( H != _0 )
						{ 	el = lfirst( H );
							H = lred( H );
							if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							else el=pm2topgf2(r,el);
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
					t3 = 34;
					break;
				case 35:*b2 = a2;
					VL = lfirst(a2);
					r = llength(VL);
					H = a1;
					a1 = _0;
					while(H!=_0)
					{	el = lfirst(H);
						H = lred(H);
						el = pvinsert(0,el,r);
						a1 = lcomp(el,a1);
					}
					a1 = linv(a1);
					*b1 = list2(VL,a1); 
					t3 = 34;
					break;
				case 36:VL1 = lfirst(a1);
					VL2 = lfirst(a2);
					n = oequal(VL1,VL2);
					if(n) 
					{	*b2 = a2;
						*b1 = a1;
					}
					else
					{	a1 = lsecond(a1);
						a2 = lsecond(a2);
						ZM = lfirst(a2);
						el = lfirst(ZM);
						el2 = lfirst(a1);
						VL = pvmix(VL1,VL2,el2,el,&el2,&el);
						H = a1;
						a1 = _0;
						while(H!=_0)
						{	el = lfirst(H);
							H = lred(H);
							VL = pvmix(VL1,VL,el,el2,&el,&el2);
							a1 = lcomp(el,a1);
						}
						a1 = linv(a1);
						*b1 = list2(VL,a1);
						H = a2;
						a2 = _0;
						while(H!=_0)
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
					t3 = 34;
					break;
			}
			break;
	}
	return( t3 );
}
