/*C
			vecmodtyper( V1,V2,t1,t2,B1,B2,esch)

	"Vektor over Z/mZ typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single vecmodtyper( V1,V2,t1,t2,B1,B2,esch);  list V1,V2; 
				single t1,t2,esch; list *B1,*B2;
	X = vecmodtyper( V1,V2,t1,t2,B1,B2,esch);

	t1 bzw t2 ist die Kennung der Vektoren V1 bzw V2. vecmodtyper er-
	mittelt die minimal gemeinsame Kennung X. Dabei werden die Vek-
	toren V1 und V2 entsprechend ihrer gemeinsamen Kennung angepasst
	und an B1 und B2 zurueckgegeben.
C*/
/*H
	Version  1      06.07.1992      U.Schneiders
H*/
/*cS
	vecmodtyper ruft auf: lcomp, linv, llength, mihom, mshom, 
	                      oequal, pitopmi, pitopms, pvinsert, pvmix 
			      vecitovecmi, vecitovecms, vecpitovpmi,
			      vecpitovpms, vecprtovpmi, vecrtovecmi
		      Macros: lfirst, list2, lred, lsecond
Sc*/
 
#include<_calc.h>

single vecmodtyper( V1, V2, t1, t2, B1, B2, esch )
list V1, V2;
single t1, t2, esch;
list *B1, *B2;

{
	single n, r, sch=0, t3;
	int M;
	obj el, el2, H;
	list VL, VL1, VL2;
	init( M, el, el2, H, VL, VL1, VL2 );
	bind( V1, V2 );

	*B1 = _0;
	*B2 = _0;
	
	if( t1 > 22 || t2 > 22 || t1 == 14 || t2 == 14 )
	{	if(esch) mistake( 71 );
		return( ERROR );
	}

	if( t1 > t2 )
	{       sch = 1;
		H = V1;
		V1 = V2;
		V2 = H;
		H = t1;
		t1 = t2;
		t2 = H;
	}

	if( t1 == 21 && t2 == 21 )
	{	*B1 = V1;
		*B2 = V2;
		return( 21 );
	}
	M = lfirst( varlist[modsch].varwert );

	/*** Anpassung an min. gemeinsame Kennung. ***/

	switch( t1 )
	{       case 10: switch( t2 )
			{       case 21:t3 = 21;
					*B2 = V2;
					if( ssch ) *B1 = vecitovecms( M, V1 );
		        		else       *B1 = vecitovecmi( M, V1 );
					break;
				case 22:t3 = 22;
					*B2 = V2;
					VL = lfirst( V2 );
					r = llength( VL );
					H = V1;
					V1 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    if( ssch ) el = mshom( M, el );
					    else el = mihom( M, el );
					    el = pvinsert( 0,el,r );
					    V1 = lcomp( el, V1 );
					}
					V1 = linv( V1 );
					*B1 = list2( VL,V1 );
					break;
			}
			break;
	        case 11: V1 = vecrtovecmi( M, V1 );
			if( V1 == ERROR )
			{       if(esch) mistake1( 244, M );
			    	return( ERROR );
			}
			switch( t2 )
			{       case 21:t3 = 21;
					*B2 = V2;
					*B1 = V1;
					break;
				case 22:t3 = 22;
					*B2 = V2;
					VL = lfirst( V2 );
					r = llength( VL );
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
			}
			break;
		case 12: switch( t2 )
			{	case 21:t3 = 22;
					VL = lfirst( V1 );
					r = llength( VL );
					V1 = lsecond( V1 );
					if( ssch ) V1 = vecpitovpms( r, V1, M );
					else V1 = vecpitovpmi( r, V1, M );
					*B1 = list2( VL,V1 );
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
			        case 22:t3 = 22;
					VL1 = lfirst( V1 );
					VL2 = lfirst( V2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B2 = V2;
					        r = llength( VL1 );
						V1 = lsecond( V1 );
						if(ssch) V1 = vecpitovpms( r, V1, M );
						else V1 = vecpitovpmi( r, V1, M );
						*B1 = list2( VL1,V1 );
					}
					else
					{       V1 = lsecond( V1 );
						V2 = lsecond( V2 );
						el = lfirst( V1 );
						r = llength( VL1 );
						if(ssch) el = pitopms( r, el, M );
						else el = pitopmi( r, el, M );
						el2 = lfirst( V2 );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						H = V1;
						V1 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							if(ssch) el = pitopms( r, el, M );
							else el = pitopmi( r, el, M );
							VL = pvmix( VL1,VL,el,el2,&el,&el2);
							V1 = lcomp( el, V1 );
						}
						V1 = linv( V1 );
					       *B1 = list2( VL,V1 );
						H = V2;
						V2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL2,VL,el,el2,&el,&el2);
							V2 = lcomp( el, V2 );
						}
						V2 = linv( V2 );
						*B2 = list2( VL,V2 );
					}
					break;
			}
			break;
		case 13:VL = lfirst( V1 );
			V1 = lsecond( V1 );
			r = llength( VL );
			V1 = vecprtovpmi( r, V1, M );
			if( V1 == ERROR )
			{       if(esch) mistake1( 244, M );
				return( ERROR );
			}
			switch( t2 )
			{	case 21:t3 = 22;
					*B1 = list2( VL,V1 );
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
			        case 22:t3 = 22;
					VL2 = lfirst( V2 );
					n = oequal( VL,VL2 );
					if( n )
				        {	*B2 = V2;
						*B1 = list2( VL,V1 );
					}
					else
					{	V2 = lsecond( V2 );
						el = lfirst( V1 );
						el2 = lfirst( V2 );
						VL1 = pvmix( VL,VL2,el,el2,&el,&el2 );
						H = V1;
						V1 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL1 = pvmix( VL,VL1,el,el2,&el,&el2);
							V1 = lcomp( el, V1 );
						}
						V1 = linv( V1 );
					        *B1 = list2( VL1,V1 );
						H = V2;
						V2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL1 = pvmix( VL2,VL1,el,el2,&el,&el2);
							V2 = lcomp( el, V2 );
						}
						V2 = linv( V2 );
						*B2 = list2( VL1,V2 );
					}
					break;
			}
			break;
		case 21:t3 = 22;
			*B2 = V2;
			VL = lfirst( V2 );
			r = llength( VL );
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
		case 22:t3 = 22;
			VL1 = lfirst( V1 );
			VL2 = lfirst( V2 );
			n = oequal( VL1,VL2 );
			if( n )
			{	*B1 = V1;
			        *B2 = V2;
			}
			else
			{       V1 = lsecond( V1 );
				V2 = lsecond( V2 );
				el = lfirst( V1 );
				el2 = lfirst( V2 );
				VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
				H = V1;
				V1 = _0;
				while( H != _0 )
				{       el = lfirst( H );
					H = lred( H );
					VL = pvmix( VL1,VL,el,el2,&el,&el2);
					V1 = lcomp( el, V1 );
				}
				V1 = linv( V1 );
			       *B1 = list2( VL,V1 );
				H = V2;
				V2 = _0;
				while( H != _0 )
				{       el = lfirst( H );
					H = lred( H );
					VL = pvmix( VL2,VL,el,el2,&el,&el2);
					V2 = lcomp( el, V2 );
				}
				V2 = linv( V2 );
				*B2 = list2( VL,V2 );
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
