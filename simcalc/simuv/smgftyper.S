/*C
			smgftyper( a1, a2, t1, t2, b1, b2, esch );

	"scalar matrix over Galois-field typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single smgftyper( a1, a2, t1, t2, b1, b2, esch ); obj a1,a1; 
					single t1,t2,esch; obj b1,b2 ;
	X = smgftyper( a1, a2, t1, t2, b1, b2, esch );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. smgftyper er-
	mittelt die minimale Kennung X fuer die Matrix. Dabei werden
	die Objekte a1 und a2 der Kennung X entsprechend angepasst
	und in b1 das Skalar, b2 die Matrix zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.06.1993      S.Schmitt
	Version  1.1    07.03.1996      S.Schmitt ( GF(2) )
H*/

#include <_calc.h>

single smgftyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{       obj el, H, N;
	list VL, VL1, VL2, Z, ZM;
	single n, r, t3;
	init( el, H, N, VL, VL1, VL2, Z, ZM );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	if( t1 == 4 || t2 == 4 || t1 == 9 || t2 == 9 || ( t1 > 22 && t1 < 31 ) || ( t2 > 22 && t2 < 31 ) || ( ( ( t1 > 15 && t1 < 23 ) || ( t2 > 15 && t2 < 23 ) ) && lfirst( varlist[modsch].varwert ) != gfchar ) )
	{       if(esch) mistake( 71 );
		return( -BASIS );
	}

	if( t2 < 4 || t2 == 17 || t2 == 18 || t2 == 31 || t2 == 32 ) 
	{       H = t1;
		t1 = t2;
		t2 = H;
		H = a1;
		a1 = a2;
		a2 = H;
	}

	/***    Typangleichung  ***/

	switch( t2 )
	{       case 5: switch( t1 )
			{       case 31:*b1 = a1;
					if(gfchar!=2) *b2=maitomagfs(gfchar,a2);
					else *b2=maitomagf2(a2);
					t3 = 33;
					break;
				case 32:*b1 = a1;
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
						el = mshom(gfchar,el);
						if(el) 
						{	el=list2(0,el);
							if(gfchar==2) el=udpm2tosb(el);
						}
						el=pvinsert(0,el,r);
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
			{       case 31:*b1 = a1;
					if(gfchar!=2) *b2=maitomagfs(gfchar,a2);
					else *b2=maitomagf2(a2);
					t3 = 33;
					break;
				case 32:*b1 = a1;
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
			{       case 31:VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,a1 );
					a2 = lsecond( a2 );
					a2 = mapitomapms( r, a2, gfchar );
					if(gfchar!=2) a2=mpmstompgfs(r,gfchar,a2);
					else a2=mpm2tompgf2(r,a2);
					*b2 = list2( VL,a2 );
					t3 = 34;
					break;
     				case 32:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b1 = a1;
					        r = llength( VL2 );
						a2 = lsecond( a2 );
						a2 = mapitomapms( r, a2, gfchar );
						if(gfchar!=2) a2 = mpmstompgfs( r, gfchar, a2 );
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
						if(gfchar!=2) el = pmstopgfs( r, gfchar, el );
						else el=pm2topgf2(r,el);
						VL = pvmix( VL2,VL1,el,a1,&el,&a1 );
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
						          if(gfchar!=2) el = pmstopgfs( r, gfchar, el );
							  else el=pm2topgf2(r,el);
						 	  VL = pvmix( VL2,VL,el,a1,&el,&a1);
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
			{	case 31:if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
					else a2=mpm2tompgf2(r,a2);
					*b2 = list2( VL,a2 );
					a1 = pvinsert( 0,a1,r );
					*b1 = list2( VL,a1 );
					t3 = 34;
					break;
        			case 32:VL1 = lfirst( a1 );
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
						if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
						VL2 = pvmix( VL,VL1,el,a1,&el,&a1 );
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
							  if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							  else el=pm2topgf2(r,el);
							  VL2 = pvmix( VL,VL2,el,a1,&el,&a1);
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
			{	case 31:*b1 = a1;
					if(gfchar!=2) *b2 = maitomagfs( gfchar, a2 );
					else *b2=maitomagf2(a2);
					t3 = 33;
					break;
				case 32:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					H=a2;
					a2=_0;
					while(H!=_0)
					{	Z=lfirst(H);
						H=lred(H);
						ZM=_0;
						while(Z!=_0)
						{   el=lfirst(Z);
						    Z=lred(Z);
						    if(el) 
						    {	el=list2(0,el);
							if(gfchar==2) el=udpm2tosb(el);
						    }
						    el=pvinsert(0,el,r);
						    ZM=lcomp(el,ZM);	
						}
						ZM=linv(ZM);
						a2=lcomp(ZM,a2);
					}
					a2=linv(a2);
					*b2=list2(VL,a2);
					t3 = 34;
					break;
			}
			break;
		case 20:switch( t1 )
			{	case 31:VL = lfirst(a2);
					r = llength(VL);
					a1 = pvinsert(0,a1,r);
					*b1 = list2(VL,a1);
					a2 = lsecond(a2);
					if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
					else a2=mpm2tompgf2(r,a2);
					*b2 = list2(VL,a2);
					t3 = 34;
					break;
				case 32:VL1 = lfirst(a1);
					VL2 = lfirst(a2);
					n=oequal(VL1,VL2);
					if(n)
					{	*b1 = a1;
						r = llength(VL2);
						a2 = lsecond(a2);
						if(gfchar!=2) a2 = mpmstompgfs(r,gfchar,a2);
						else a2=mpm2tompgf2(r,a2);
						*b2 = list2(VL2,a2);
					}
					else
					{	a1 = lsecond(a1);
						a2 = lsecond(a2);
						Z = lfirst(a2);
						el = lfirst(Z);
						r = llength(VL2);
						if(gfchar!=2) el = pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
						VL=pvmix(VL2,VL1,el,a1,&el,&a1);
						*b1 = list2(VL,a1);
						H = a2;
						a2 = _0;
						while(H!=_0)
						{	Z = lfirst(H);
							H = lred(H);
							ZM = _0;
							while(Z!=_0)
							{  el=lfirst(Z);
							   Z=lred(Z);
							   if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							   else el=pm2topgf2(r,el);
							   VL=pvmix(VL2,VL,el,a1,&el,&a1);
							   ZM=lcomp(el,ZM);
							}
							ZM=linv(ZM);
							a2=lcomp(ZM,a2);
						}
						a2=linv(a2);
						*b2=list2(VL,a2);
					}
					t3 = 34;
					break;
			}
			break;
		case 33:switch( t1 )
			{	case 0: *b2 = a2;
			                a1 = mshom( gfchar, a1 );
					if(a1) 
					{	a1=list2(0,a1);
						if(gfchar==2) a1=udpm2tosb(a1);
					}
				        *b1 = a1;	
					t3 = 33;
					break;
				case 1: N = lsecond( a1 );
	                                if ( igcd( N, gfchar ) != 1 )
			                {   if(esch) mistake2( 233, a1, gfchar );
		        	            return( ERROR );
			                }
					N = mshom( gfchar, N );
	 	                        N = msinv( gfchar, N );
                                        a1 = lfirst( a1 );
			                a1 = mshom( gfchar, a1 );
                                        a1 = msprod( gfchar, a1, N );
					if(a1) 
					{	a1=list2(0,a1);
						if(gfchar==2) a1=udpm2tosb(a1);
					}
					*b1 = a1;
					*b2 = a2;
					t3 = 33;
					break;
				case 2: VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
			                a1 = pitopms( r, a1, gfchar );
					if(gfchar!=2) a1 = pmstopgfs( r, gfchar, a1 );
					else a1=pm2topgf2(r,a1);
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
				case 3: VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
					H = prnumden( r, a1, &N );
					if( igcd( gfchar, N ) != 1 )
					{       if(esch) mistake1( 242, gfchar );
						return( ERROR );
					}
					N = mshom( gfchar, N );
					N = msinv( gfchar, N );
					a1 = pitopms( r, H, gfchar );
					a1 = pmsmsprod( r, gfchar, a1, N );
					if(gfchar!=2) a1=pmstopgfs(r,gfchar,a1);
					else a1=pm2topgf2(r,a1);
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
				case 17:if(a1) 
					{	a1=list2(0,a1);
						if(gfchar==2) a1=udpm2tosb(a1);
					}
					*b1 = a1;
					*b2 = a2;
					t3 = 33;
					break;
				case 18:VL = lfirst( a1 );
					r = llength( VL );
					a1 = lsecond(a1);
					if(gfchar!=2) a1=pmstopgfs(r,gfchar,a1);
					else a1=pm2topgf2(r,a1);	
					*b1 = list2(VL,a1);
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
				case 31:*b1 = a1;
					*b2 = a2;
					t3 = 33;
					break;
				case 32:*b1 = a1;
					VL = lfirst(a1);
					r = llength(VL);
					H = a2;
					a2 = _0;
					while(H!=_0)
					{	Z = lfirst(H);
						H = lred(H);
						ZM = _0;
						while(Z!=_0)
						{  el = lfirst(Z);
						   Z = lred(Z);
						   el = pvinsert(0,el,r);
						   ZM = lcomp(el,ZM);
						}
						ZM = linv(ZM);
						a2 = lcomp(ZM,a2);
					}
					a2 = linv(a2);
					*b2 = list2(VL,a2);
					t3 = 34;
					break;
			}
			break;
		case 34:switch( t1 )
			{	case 0: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
			                a1 = mshom( gfchar, a1 );
					if(a1) 
					{	a1=list2(0,a1);
						if(gfchar==2) a1=udpm2tosb(a1);
					}
				        a1 = pvinsert( 0, a1, r );	
					*b1 = list2( VL, a1 );
					t3 = 34;
					break;
				case 1: N = lsecond( a1 );
	                                if ( igcd( N, gfchar ) != 1 )
			                {   if(esch) mistake2( 233, a1, gfchar );
		        	            return( ERROR );
			                }
					N = mshom( gfchar, N );
	 	                        N = msinv( gfchar, N );
                                        a1 = lfirst( a1 );
			                a1 = mshom( gfchar, a1 );
                                        a1 = msprod( gfchar, a1, N );
					if(a1) 
					{	a1=list2(0,a1);
						if(gfchar==2) a1=udpm2tosb(a1);
					}
					VL = lfirst( a2 );
					r = llength( VL );
				        a1 = pvinsert( 0, a1, r );	
					*b1 = list2( VL, a1 );
					*b2 = a2;
					t3 = 34;
					break;
				case 2: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
					        r = llength( VL1 );
						a1 = lsecond( a1 );
						a1=pitopms(r, a1, gfchar);
						if(gfchar!=2) a1=pmstopgfs(r,gfchar,a1);
						else a1=pm2topgf2(r,a1);
						*b1 = list2( VL1,a1 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						r = llength( VL1 );
						a1=pitopms(r, a1, gfchar);
						if(gfchar!=2) a1=pmstopgfs(r,gfchar,a1);
						else a1=pm2topgf2(r,a1);
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
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
							  VL = pvmix( VL2,VL,el,a1,&el,&a1);
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
				case 3: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					H = prnumden( r, a1, &N );
					if( igcd( gfchar, N ) != 1 )
					{       if(esch) mistake1( 242, gfchar );
						return( ERROR );
					}
					N = mshom(gfchar, N);
					N = msinv( gfchar, N );
					a1 = pitopms( r, H, gfchar );
					a1 = pmsmsprod( r, gfchar, a1, N );
					if(gfchar!=2) a1=pmstopgfs(r,gfchar,a1);
					else a1=pm2topgf2(r,a1);
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
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
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
							  VL = pvmix( VL2,VL,el,a1,&el,&a1);
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
				case 17:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					if(a1) 
					{	a1=list2(0,a1);
						if(gfchar==2) a1=udpm2tosb(a1);
					}
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, a1 );
					t3 = 34;
					break;
				case 18:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					r = llength(VL1);
					a1 = lsecond(a1);
					if(gfchar!=2) a1=pmstopgfs(r,gfchar,a1);
					else a1=pm2topgf2(r,a1);
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						*b1 = list2(VL1,a1);
					}
					else
					{       a2 = lsecond( a2 );
						ZM = lfirst( a2 );
						el = lfirst( ZM );
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
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
							  VL = pvmix( VL2,VL,el,a1,&el,&a1);
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
				case 31:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, a1 );
					t3 = 34;
					break;
				case 32:VL1 = lfirst( a1 );
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
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
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
							  VL = pvmix( VL2,VL,el,a1,&el,&a1);
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
