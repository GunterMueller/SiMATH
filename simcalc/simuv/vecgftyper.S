/*C
			vecgftyper( V1,V2,t1,t2,B1,B2,esch)

	"Vektor over Galois-field typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single vecgftyper( V1,V2,t1,t2,B1,B2,esch);  list V1,V2; 
				single t1,t2,esch; list *B1,*B2;
	X = vecgftyper( V1,V2,t1,t2,B1,B2,esch);

	t1 bzw t2 ist die Kennung der Vektoren V1 bzw V2. vecgftyper er-
	mittelt die minimal gemeinsame Kennung X. Dabei werden die Vek-
	toren V1 und V2 entsprechend ihrer gemeinsamen Kennung angepasst
	und an B1 und B2 zurueckgegeben.
C*/
/*H
	Version  1      23.06.1993      S.Schmitt
	Version  1.1    05.03.1996      S.Schmitt ( GF(2) )
H*/
 
#include<_calc.h>

single vecgftyper( V1, V2, t1, t2, B1, B2, esch )
list V1, V2;
single t1, t2, esch;
list *B1, *B2;

{
	single n, r, sch=0, t3;
	obj el, el1, H;
	list VL, VL1, VL2;
	init( el, el1, H, VL, VL1, VL2 );
	bind( V1, V2 );

	*B1 = _0;
	*B2 = _0;
	
	if(t1==14 || t2==14 || t1==28 || t2==28 || t1==29 || t2==29 || ((t1 == 21 || t2 == 21 || t1 == 22 || t2 == 22) && lfirst(varlist[modsch].varwert) != gfchar))
	{ 	if(esch) mistake(71);
		return(ERROR);
	}
	
	if( t1 < t2 )
	{       sch = 1;
		H = V1;
		V1 = V2;
		V2 = H;
		H = t1;
		t1 = t2;
		t2 = H;
	}
	if((t2==12 || t2==13 || t2==22 ) && t1==35)  t3=36;
	else t3=t1;


	/*** Anpassung an min. gemeinsame Kennung. ***/

	switch( t2 )
	{       case 10: switch( t1 )
			{       case 35:*B1 = V1;
					if(gfchar!=2) *B2=vecitovecgfs(gfchar,V2);
					else *B2=vecitovecgf2(V2);
					break;
				case 36:*B1 = V1;
					VL = lfirst( V1 );
					r = llength( VL );
					H = V2;
					V2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = mshom( gfchar, el );
					    if(el)
					    {	el=list2(0,el);
						if(gfchar==2) el=udpm2tosb(el);
					    }
					    el = pvinsert( 0,el,r );
					    V2 = lcomp( el, V2 );
					}
					V2 = linv( V2 );
					*B2 = list2( VL,V2 );
					break;
			}
			break;
	        case 11: V2 = vecrtovecmi( gfchar, V2 );
			if( V2 == ERROR )
			{       if(esch) mistake1( 244, gfchar );
			    	return( ERROR );
			}
			switch( t1 )
			{       case 35:if(gfchar!=2) *B2=vecitovecgfs(gfchar,V2);
					else *B2=vecitovecgf2(V2);	
					*B1 = V1;
					break;
				case 36:*B1 = V1;
					VL = lfirst( V1 );
					r = llength( VL );
					H = V2;
					V2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el=mshom(gfchar,el);
					    if(el)
					    {	el=list2(0,el);
						if(gfchar==2) el=udpm2tosb(el);
					    }
					    el = pvinsert( 0,el,r );
					    V2 = lcomp( el, V2 );
					}
					V2 = linv( V2 );
					*B2 = list2( VL,V2 );
					break;
			}
			break;
		case 12: switch( t1 )
			{	case 35:VL = lfirst( V2 );
					r = llength( VL );
					V2= lsecond( V2 );
					V2=vecpitovpms(r,V2,gfchar);
					if(gfchar!=2) V2=vpmstovpgfs(r,gfchar,V2);
					else V2=vpm2tovpgf2(r,V2);
					*B2 = list2( VL,V2 );
					H = V1;
					V1 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    V1 = lcomp( el, V1 );
					}
					V1 = linv( V1 );
					*B1 = list2( VL,V1 );
					break;
			        case 36:VL1 = lfirst( V1 );
					VL2 = lfirst( V2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B1 = V1;
					        r = llength( VL2 );
						V2 = lsecond( V2 );
						V2=vecpitovpms(r,V2,gfchar);
						if(gfchar!=2) V2=vpmstovpgfs(r,gfchar,V2);
						else V2=vpm2tovpgf2(r,V2);
						*B2 = list2( VL2,V2 );
					}
					else
					{       V1 = lsecond( V1 );
						V2 = lsecond( V2 );
						el = lfirst( V2 );
						r = llength( VL2 );
						el = pitopms( r, el, gfchar );
						if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
						el1 = lfirst( V1 );
						VL = pvmix( VL1,VL2,el,el1,&el,&el1 );
						H = V2;
						V2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							el = pitopms( r, el, gfchar );
							if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							else el=pm2topgf2(r,el);
							VL = pvmix( VL2,VL,el,el1,&el,&el1);
							V2 = lcomp( el, V2 );
						}
						V2 = linv( V2 );
					        *B2 = list2( VL,V2 );
						H = V1;
						V1 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL1,VL,el,el1,&el,&el1);
							V1 = lcomp( el, V1 );
						}
						V1 = linv( V1 );
						*B1 = list2( VL,V1 );
					}
					break;
			}
			break;
		case 13:VL2 = lfirst( V2 );
			V2 = lsecond( V2 );
			r = llength( VL2 );
			V2 = vecprtovpmi( r, V2, gfchar );
			if( V2 == ERROR )
			{       if(esch) mistake1( 244, gfchar );
				return( ERROR );
			}
			switch( t1 )
			{	case 35:if(gfchar!=2) V2=vpmstovpgfs(r,gfchar,V2);
					else V2=vpm2tovpgf2(r,V2);
					*B2 = list2( VL2,V2 );
					H = V1;
					V1 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    V1 = lcomp( el, V1 );
					}
					V1 = linv( V1 );
					*B1 = list2( VL2,V1 );
					break;
			        case 36:VL1 = lfirst( V1 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B1 = V1;
						if(gfchar!=2) V2=vpmstovpgfs(r,gfchar,V2);
						else V2=vpm2tovpgf2(r,V2);
						*B2 = list2( VL2,V2 );
					}
					else
					{       V1 = lsecond( V1 );
						el = lfirst( V2 );
						if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
						el1 = lfirst( V1 );
						VL = pvmix( VL1,VL2,el,el1,&el,&el1 );
						H = V2;
						V2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							else el=pm2topgf2(r,el);
							VL = pvmix( VL2,VL,el,el1,&el,&el1);
							V2 = lcomp( el, V2 );
						}
						V2 = linv( V2 );
					        *B2 = list2( VL,V2 );
						H = V1;
						V1 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL1,VL,el,el1,&el,&el1);
							V1 = lcomp( el, V1 );
						}
						V1 = linv( V1 );
						*B1 = list2( VL,V1 );
					}
					break;
			}
			break;
		case 21:switch( t1 )
			{       case 35:*B1 = V1;
					if(gfchar!=2) *B2=vecitovecgfs(gfchar,V2);
					else *B2=vecitovecgf2(V2);
					break;
				case 36:*B1 = V1;
					VL = lfirst( V1 );
					r = llength( VL );
					H = V2;
					V2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    if(el)
					    {	el=list2(0,el);
						if(gfchar==2) el=udpm2tosb(el);
					    }
					    el = pvinsert( 0,el,r );
					    V2 = lcomp( el, V2 );
					}
					V2 = linv( V2 );
					*B2 = list2( VL,V2 );
					break;
			}
			break;
		case 22:switch( t1 )
			{	case 35:VL = lfirst( V2 );
					r = llength( VL );
					V2= lsecond( V2 );
					if(gfchar!=2) V2=vpmstovpgfs(r,gfchar,V2);
					else V2=vpm2tovpgf2(r,V2);
					*B2 = list2( VL,V2 );
					H = V1;
					V1 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    V1 = lcomp( el, V1 );
					}
					V1 = linv( V1 );
					*B1 = list2( VL,V1 );
					break;
			        case 36:VL1 = lfirst( V1 );
					VL2 = lfirst( V2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B1 = V1;
					        r = llength( VL2 );
						V2 = lsecond( V2 );
						if(gfchar!=2) V2=vpmstovpgfs(r,gfchar,V2);
						else V2=vpm2tovpgf2(r,V2);
						*B2 = list2( VL2,V2 );
					}
					else
					{       V1 = lsecond( V1 );
						V2 = lsecond( V2 );
						el = lfirst( V2 );
						r = llength( VL2 );
						if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
						else el=pm2topgf2(r,el);
						el1 = lfirst( V1 );
						VL = pvmix( VL1,VL2,el,el1,&el,&el1 );
						H = V2;
						V2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							if(gfchar!=2) el=pmstopgfs(r,gfchar,el);
							else el=pm2topgf2(r,el);
							VL = pvmix( VL2,VL,el,el1,&el,&el1);
							V2 = lcomp( el, V2 );
						}
						V2 = linv( V2 );
					        *B2 = list2( VL,V2 );
						H = V1;
						V1 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL1,VL,el,el1,&el,&el1);
							V1 = lcomp( el, V1 );
						}
						V1 = linv( V1 );
						*B1 = list2( VL,V1 );
					}
					break;
			}
			break;
		case 35:switch(t1)
			{	case 35:*B1=V1;
				        *B2=V2;
					break;
				case 36:*B1 = V1;
					VL = lfirst( V1 );
					r = llength( VL );
					H = V2;
					V2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    V2 = lcomp( el, V2 );
					}
					V2 = linv( V2 );
					*B2 = list2( VL,V2 );
					break;
			}
			break;
		case 36:VL1 = lfirst( V1 );
			VL2 = lfirst( V2 );
			n = oequal( VL1,VL2 );
			if( n )
			{	*B1 = V1;
				*B2 = V2;
			}
			else
			{       V1 = lsecond( V1 );
				V2 = lsecond( V2 );
				el = lfirst( V2 );
				el1 = lfirst( V1 );
				VL = pvmix( VL1,VL2,el,el1,&el,&el1 );
				H = V2;
				V2 = _0;
				while( H != _0 )
				{       el = lfirst( H );
					H = lred( H );
					VL = pvmix( VL2,VL,el,el1,&el,&el1);
					V2 = lcomp( el, V2 );
				}
				V2 = linv( V2 );
				*B2 = list2( VL,V2 );
				H = V1;
				V1 = _0;
				while( H != _0 )
				{       el = lfirst( H );
					H = lred( H );
					VL = pvmix( VL1,VL,el,el1,&el,&el1);
					V1 = lcomp( el, V1 );
				}
				V1 = linv( V1 );
				*B1 = list2( VL,V1 );
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
