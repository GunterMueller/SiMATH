/*C
			magftyper( A1,A2,t1,t2,B1,B2,esch)

	"matrix over Galois-field typer".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	single magftyper( A1,A2,t1,t2,B1,B2,esch);  list A1,A2; 
					single t1,t2,esch; list *B1,*B2;
	X = magftyper( A1,A2,t1,t2,B1,B2,esch);

	t1 bzw t2 ist die Kennung der Matrizen A1 bzw A2. magftyper er-
	mittelt die minimal gemeinsame Kennung X. Dabei werden die Ma-
	trizen A1 und A2 entsprechend ihrer gemeinsamen Kennung angepasst
	und an B1 und B2 zurueckgegeben.
C*/
/*H
	Version  1      23.06.1993      S.Schmitt
	Version  1.1    05.03.1996      S.Schmitt ( GF(2) )
H*/
 
#include<_calc.h>

single magftyper( A1, A2, t1, t2, B1, B2, esch )
list A1, A2;
single t1, t2, esch;
list *B1, *B2;

{
	single n, r, sch=0, t3;
	obj el, el1, H;
	list VL, VL1, VL2, Z, ZM;
	init( el, el1, H, VL, VL1, VL2, Z, ZM );
	bind( A1, A2 );

	*B1 = _0;
	*B2 = _0;

	if( t1 < t2 )
	{       sch = 1;
		H = A1;
		A1 = A2;
		A2 = H;
		H = t1;
		t1 = t2;
		t2 = H;
	}
	if((t2==7 || t2==8 || t2==20) && t1==33)  t3=34;
	else t3=t1;


	/*** Anpassung an min. gemeinsame Kennung. ***/

	switch( t2 )
	{       case 5: switch( t1 )
			{       case 33:*B1 = A1;
					if(gfchar!=2) *B2=maitomagfs(gfchar,A2);
					else *B2=maitomagf2(A2);
					break;
				case 34:*B1 = A1;
					VL = lfirst( A1 );
					r = llength( VL );
					H = A2;
					A2 = _0;
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
					    A2 = lcomp( ZM, A2 );
					}
					A2 = linv( A2 );
					*B2 = list2( VL,A2 );
					break;
			}
			break;
	        case 6: A2 = martomami( gfchar, A2 );
			if( A2 == ERROR )
			{       if(esch) mistake1( 243, gfchar );
			    	return( ERROR );
			}
			switch( t1 )
			{       case 33:*B1 = A1;
					if(gfchar!=2) *B2=maitomagfs(gfchar,A2);
					else *B2=maitomagf2(A2);
					break;
				case 34:*B1 = A1;
					VL = lfirst( A1 );
					r = llength( VL );
					H = A2;
					A2= _0;
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
					    A2 = lcomp( ZM, A2 );
					}
					A2 = linv( A2 );
					*B2 = list2( VL,A2 );
					break;
			}
			break;
		case 7: switch( t1 )
			{	case 33:VL = lfirst( A2 );
					r = llength( VL );
					A2 = lsecond( A2 );
					A2 = mapitomapms(r,A2,gfchar);
					if(gfchar!=2) A2=mpmstompgfs(r,gfchar,A2);
					else A2=mpm2tompgf2(r,A2);
					*B2 = list2( VL,A2 );
					H = A1;
					A1 = _0;
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
					    A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					*B1 = list2( VL,A1 );
					break;
			        case 34:VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B1 = A1;
					        r = llength( VL1 );
						A2 = lsecond( A2 );
						A2 = mapitomapms(r,A2,gfchar);
						if(gfchar!=2) A2 = mpmstompgfs(r,gfchar,A2);
						else A2=mpm2tompgf2(r,A2);
						*B2 = list2( VL2,A2 );
					}
					else
					{       A1 = lsecond( A1 );
						A2 = lsecond( A2 );
						Z = lfirst( A2 );
						el = lfirst( Z );
						r = llength( VL2 );
						el = pitopms(r,el,gfchar);
						if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
						ZM = lfirst( A1 );
						el1 = lfirst( ZM );
						VL = pvmix( VL1,VL2,el,el1,&el,&el1 );
						H = A2;
						A2 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  el = pitopms( r, el, gfchar );
							  if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							  else el=pm2topgf2(r,el);
							  VL = pvmix( VL2,VL,el,el1,&el,&el1);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A2 = lcomp( ZM, A2 );
						}
						A2 = linv( A2 );
					        *B2 = list2( VL,A2 );
						H = A1;
						A1 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  VL = pvmix( VL1,VL,el,el1,&el,&el1);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A1 = lcomp( ZM, A1 );
						}
						A1 = linv( A1 );
						*B1 = list2( VL,A1 );
					}
					break;
			}
			break;
		case 8: VL2 = lfirst( A2 );
			A2 = lsecond( A2 );
			r = llength( VL2 );
			A2 = maprtomapmi( r, A2, gfchar );
			if( A2 == ERROR )
			{       if(esch) mistake1( 243, gfchar );
				return( ERROR );
			}
			switch( t1 )
			{	case 33:if(gfchar!=2) A2=mpmstompgfs(r,gfchar,A2);
					else A2=mpm2tompgf2(r,A2);
					*B2 = list2( VL2,A2 );
					H = A1;
					A1 = _0;
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
					    A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					*B1 = list2( VL2,A1 );
					break;
			        case 34:VL1 = lfirst( A1 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B1 = A1;
						if(gfchar!=2) A2=mpmstompgfs(r,gfchar,A2);
						else A2=mpm2tompgf2(r,A2);
						*B2 = list2( VL2,A2 );
					}
					else
					{       A1 = lsecond( A1 );
						Z = lfirst( A2 );
						el = lfirst( Z );
						if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
						ZM = lfirst( A1 );
						el1 = lfirst( ZM );
						VL = pvmix( VL1,VL2,el,el1,&el,&el1 );
						H = A2;
						A2 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							  else el=pm2topgf2(r,el);
							  VL = pvmix( VL2,VL,el,el1,&el,&el1);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A2 = lcomp( ZM, A2 );
						}
						A2 = linv( A2 );
					        *B2 = list2( VL,A2 );
						H = A1;
						A1 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  VL = pvmix( VL1,VL,el,el1,&el,&el1);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A1 = lcomp( ZM, A1 );
						}
						A1 = linv( A1 );
						*B1 = list2( VL,A1 );
					}
					break;
			}
			break;
		case 19:*B1 = A1;
			if(lfirst(varlist[modsch].varwert)==2) 
							A2=mam2tomams(A2);
			switch(t1)
			{       case 33:if(gfchar!=2) *B2=maitomagfs(gfchar,A2);
					else *B2=maitomagf2(A2);
					break;
				case 34:VL = lfirst( A1 );
					r = llength( VL );
					H = A2;
					A2 = _0;
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
						el=pvinsert(0,el,r);
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    A2 = lcomp( ZM, A2 );
					}
					A2 = linv( A2 );
					*B2 = list2( VL,A2 );
					break;
			}
			break;
		case 20:switch( t1 )
			{	case 33:VL = lfirst( A2 );
					r = llength( VL );
					A2 = lsecond( A2 );
					if(gfchar!=2) A2=mpmstompgfs(r,gfchar,A2);
					else A2=mpm2tompgf2(r,A2);
					*B2 = list2( VL,A2 );
					H = A1;
					A1 = _0;
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
					    A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					*B1 = list2( VL,A1 );
					break;
			        case 34:VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B1 = A1;
					        r = llength( VL1 );
						A2 = lsecond( A2 );
						if(gfchar!=2) A2=mpmstompgfs(r,gfchar,A2);
						else A2=mpm2tompgf2(r,A2);
						*B2 = list2( VL2,A2 );
					}
					else
					{       A1 = lsecond( A1 );
						A2 = lsecond( A2 );
						Z = lfirst( A2 );
						el = lfirst( Z );
						r = llength( VL2 );
						if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
						ZM = lfirst( A1 );
						el1 = lfirst( ZM );
						VL = pvmix( VL1,VL2,el,el1,&el,&el1 );
						H = A2;
						A2 = _0;
						while(H!=_0)
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							  else el=pm2topgf2(r,el);
							  VL = pvmix( VL2,VL,el,el1,&el,&el1);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A2 = lcomp( ZM, A2 );
						}
						A2 = linv( A2 );
					        *B2 = list2( VL,A2 );
						H = A1;
						A1 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  VL = pvmix( VL1,VL,el,el1,&el,&el1);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A1 = lcomp( ZM, A1 );
						}
						A1 = linv( A1 );
						*B1 = list2( VL,A1 );
					}
					break;
			}
			break;
		case 33:switch(t1)
			{	case 33:*B1=A1;
					*B2=A2;
					break;
				case 34:*B1 = A1;
					VL = lfirst( A1 );
					r = llength( VL );
					H = A2;
					A2 = _0;
					while( H != _0 )
					{   Z = lfirst( H );
				            H = lred( H );
					    ZM = _0;
					    while( Z != _0 )
					    {   el = lfirst( Z );
					        Z = lred( Z );
						el=pvinsert(0,el,r);
						ZM = lcomp( el,ZM );
					    }
					    ZM = linv( ZM );
					    A2 = lcomp( ZM, A2 );
					}
					A2 = linv( A2 );
					*B2 = list2( VL,A2 );
					break;
			}
			break;
		case 34:VL1 = lfirst( A1 );
			VL2 = lfirst( A2 );
			n = oequal( VL1,VL2 );
			if( n )
			{	*B1=A1;
				*B2=A2;
			}
			else
			{       A1 = lsecond( A1 );
				A2 = lsecond( A2 );
				Z = lfirst( A2 );
				el = lfirst( Z );
				ZM = lfirst( A1 );
				el1 = lfirst( ZM );
				VL = pvmix( VL1,VL2,el,el1,&el,&el1 );
				H = A2;
				A2 = _0;
				while( H != _0 )
				{       Z = lfirst( H );
					H = lred( H );
					ZM = _0;
					while( Z != _0 )
					{ el = lfirst( Z );
					  Z = lred( Z );
					  VL = pvmix( VL2,VL,el,el1,&el,&el1);
					  ZM = lcomp( el,ZM );
					}
					ZM = linv( ZM );
					A2 = lcomp( ZM, A2 );
				}
				A2 = linv( A2 );
				*B2 = list2( VL,A2 );
				H = A1;
				A1 = _0;
				while( H != _0 )
				{       Z = lfirst( H );
					H = lred( H );
					ZM = _0;
					while( Z != _0 )
					{ el = lfirst( Z );
					  Z = lred( Z );
					  VL = pvmix( VL1,VL,el,el1,&el,&el1);
					  ZM = lcomp( el,ZM );
					}
					ZM = linv( ZM );
					A1 = lcomp( ZM, A1 );
				}
				A1 = linv( A1 );
				*B1 = list2( VL,A1 );
			}
			break;
	}
	if( sch )
	{       H = *B1;
		*B1 = *B2;
		*B2 = H;
	}
	return( t3 );
}
