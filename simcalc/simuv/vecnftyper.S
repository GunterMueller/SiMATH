/*C
			vecnftyper( V1,V2,t1,t2,B1,B2)

	"vector over number field typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single vecnftyper( V1,V2,t1,t2,B1,B2);  list V1,V2; single t1,t2;
					       list *B1,*B2;
	X = vecnftyper( V1,V2,t1,t2,B1,B2);

	t1 bzw t2 ist die Kennung der Vektoren V1 bzw V2. vecnftyper er-
	mittelt die minimal gemeinsame Kennung X. Dabei werden die Vek-
	toren V1 und V2 entsprechend ihrer gemeinsamen Kennung angepasst
	und an B1 und B2 zurueckgegeben.
C*/
/*H
	Version  1      06.07.1992      U.Schneiders
H*/
/*cS
	vecnftyper ruft auf: itonf, lcomp, linv, llength, oequal,
			     pitopnf, prtopnf, pvinsert, pvmix, 
			     rtonf, vecitovecnf, vecpitovpnf,
			     vecprtovpnf, vecrtovecnf
		    Macros: lfirst, list2, lred, lsecond
Sc*/
 
#include<_calc.h>

single vecnftyper( V1, V2, t1, t2, B1, B2 )
list V1, V2;
single t1, t2;
list *B1, *B2;

{
	single n, r, sch=0, t3;
	obj el, el2, H;
	list VL, VL1, VL2;
	init( el, el2, H, VL, VL1, VL2 );
	bind( V1, V2 );

	*B1 = _0;
	*B2 = _0;

	if( ( t1 > 13 && t1 < 24 ) || ( t2 > 13 && t2 < 24 ) )
	{	mistake( 71 );
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

	if( t1 == 28 && t2 == 28 )
	{	*B1 = V1;
		*B2 = V2;
		return( 28 );
	}

	/*** Anpassung an min. gemeinsame Kennung. ***/

	switch( t1 )
	{       case 10:switch( t2 )
			{       case 28:t3 = 28;
					*B2 = V2;
					*B1 = vecitovecnf( V1 );
					break;
				case 29:t3 = 29;
					*B2 = V2;
					VL = lfirst( V2 );
					r = llength( VL );
					H = V1;
					V1 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = itonf( el );
					    el = pvinsert( 0,el,r );
					    V1 = lcomp( el, V1 );
					}
					V1 = linv( V1 );
					*B1 = list2( VL,V1 );
					break;
			}
			break;
	        case 11:switch( t2 )
			{       case 28:t3 = 28;
					*B2 = V2;
					*B1 = vecrtovecnf( V1 );
					break;
				case 29:t3 = 29;
					*B2 = V2;
					VL = lfirst( V2 );
					r = llength( VL );
					H = V1;
					V1 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = rtonf( el );
					    el = pvinsert( 0,el,r );
					    V1 = lcomp( el, V1 );
					}
					V1 = linv( V1 );
					*B1 = list2( VL,V1 );
					break;
			}
			break;
		case 12:switch( t2 )
			{	case 28:t3 = 29;
					VL = lfirst( V1 );
					r = llength( VL );
					V1 = lsecond( V1 );
					V1 = vecpitovpnf( r, V1 );
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
			        case 29:t3 = 29;
					VL1 = lfirst( V1 );
					VL2 = lfirst( V2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B2 = V2;
					        r = llength( VL1 );
						V1 = lsecond( V1 );
						V1 = vecpitovpnf( r, V1 );
						*B1 = list2( VL1,V1 );
					}
					else
					{       V1 = lsecond( V1 );
						V2 = lsecond( V2 );
						el = lfirst( V1 );
						r = llength( VL1 );
						el = pitopnf( r, el );
						el2 = lfirst( V2 );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						H = V1;
						V1 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							el = pitopnf( r, el );
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
		case 13:switch( t2 )
			{	case 28:t3 = 29;
					VL = lfirst( V1 );
					r = llength( VL );
					V1 = lsecond( V1 );
					V1 = vecprtovpnf( r, V1 );
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
			        case 29:t3 = 29;
					VL1 = lfirst( V1 );
					VL2 = lfirst( V2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B2 = V2;
					        r = llength( VL1 );
						V1 = lsecond( V1 );
						V1 = vecprtovpnf( r, V1 );
						*B1 = list2( VL1,V1 );
					}
					else
					{       V1 = lsecond( V1 );
						V2 = lsecond( V2 );
						el = lfirst( V1 );
						r = llength( VL1 );
						el = prtopnf( r, el );
						el2 = lfirst( V2 );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						H = V1;
						V1 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							el = prtopnf( r, el );
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
		case 28:t3 = 29;
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
		case 29:t3 = 29;
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
