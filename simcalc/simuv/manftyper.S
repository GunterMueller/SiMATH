/*C
			manftyper( A1,A2,t1,t2,B1,B2)

	"matrix over number field typer".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	single manftyper( A1,A2,t1,t2,B1,B2);  list A1,A2; single t1,t2;
					       list *B1,*B2;
	X = manftyper( A1,A2,t1,t2,B1,B2);

	t1 bzw t2 ist die Kennung der Matrizen A1 bzw A2. manftyper er-
	mittelt die minimal gemeinsame Kennung X. Dabei werden die Ma-
	trizen A1 und A2 entsprechend ihrer gemeinsamen Kennung angepasst
	und an B1 und B2 zurueckgegeben.
C*/
/*H
	Version  1      06.07.1992      U.Schneiders
H*/
/*cS
	manftyper ruft auf: itonf, lcomp, linv, llength, maitomanf,
			    mapitomapnf, maprtomapnf, martomanf,
			    oequal, pitopnf, prtopnf, pvinsert, pvmix, 
			    rtonf
		    Macros: lfirst, list2, lred, lsecond
Sc*/
 
#include<_calc.h>

single manftyper( A1, A2, t1, t2, B1, B2 )
list A1, A2;
single t1, t2;
list *B1, *B2;

{
	single n, r, sch=0, t3;
	obj el, el2, H;
	list VL, VL1, VL2, Z, ZM;
	init( el, el2, H, VL, VL1, VL2, Z, ZM );
	bind( A1, A2 );

	*B1 = _0;
	*B2 = _0;

	if( t1 > t2 )
	{       sch = 1;
		H = A1;
		A1 = A2;
		A2 = H;
		H = t1;
		t1 = t2;
		t2 = H;
	}

	if( t1 == 26 && t2 == 26 )
	{	*B1 = A1;
		*B2 = A2;
		return( 26 );
	}

	/*** Anpassung an min. gemeinsame Kennung. ***/

	switch( t1 )
	{       case 5: switch( t2 )
			{       case 26:t3 = 26;
					*B2 = A2;
					*B1 = maitomanf( A1 );
					break;
				case 27:t3 = 27;
					*B2 = A2;
					VL = lfirst( A2 );
					r = llength( VL );
					H = A1;
					A1 = _0;
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
					    A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					*B1 = list2( VL,A1 );
					break;
			}
			break;
	        case 6: switch( t2 )
			{       case 26:t3 = 26;
					*B2 = A2;
					*B1 = martomanf( A1 );
					break;
				case 27:t3 = 27;
					*B2 = A2;
					VL = lfirst( A2 );
					r = llength( VL );
					H = A1;
					A1 = _0;
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
					    A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					*B1 = list2( VL,A1 );
					break;
			}
			break;
		case 7: switch( t2 )
			{	case 26:t3 = 27;
					VL = lfirst( A1 );
					r = llength( VL );
					A1 = lsecond( A1 );
					A1 = mapitomapnf( r, A1 );
					*B1 = list2( VL,A1 );
					H = A2;
					A2 = _0;
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
					    A2 = lcomp( ZM, A2 );
					}
					A2 = linv( A2 );
					*B2 = list2( VL,A2 );
					break;
			        case 27:t3 = 27;
					VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B2 = A2;
					        r = llength( VL1 );
						A1 = lsecond( A1 );
						A1 = mapitomapnf( r, A1 );
						*B1 = list2( VL1,A1 );
					}
					else
					{       A1 = lsecond( A1 );
						A2 = lsecond( A2 );
						Z = lfirst( A1 );
						el = lfirst( Z );
						r = llength( VL1 );
						el = pitopnf( r, el );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						H = A1;
						A1 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  el = pitopnf( r, el );
							  VL = pvmix( VL1,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A1 = lcomp( ZM, A1 );
						}
						A1 = linv( A1 );
					       *B1 = list2( VL,A1 );
						H = A2;
						A2 = _0;
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
							A2 = lcomp( ZM, A2 );
						}
						A2 = linv( A2 );
						*B2 = list2( VL,A2 );
					}
					break;
			}
			break;
		case 8: switch( t2 )
			{	case 26:t3 = 27;
					VL = lfirst( A1 );
					r = llength( VL );
					A1 = lsecond( A1 );
					A1 = maprtomapnf( r, A1 );
					*B1 = list2( VL,A1 );
					H = A2;
					A2 = _0;
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
					    A2 = lcomp( ZM, A2 );
					}
					A2 = linv( A2 );
					*B2 = list2( VL,A2 );
					break;
			        case 27:t3 = 27;
					VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B2 = A2;
					        r = llength( VL1 );
						A1 = lsecond( A1 );
						A1 = maprtomapnf( r, A1 );
						*B1 = list2( VL1,A1 );
					}
					else
					{       A1 = lsecond( A1 );
						A2 = lsecond( A2 );
						Z = lfirst( A1 );
						el = lfirst( Z );
						r = llength( VL1 );
						el = prtopnf( r, el );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
						H = A1;
						A1 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  el = prtopnf( r, el );
							  VL = pvmix( VL1,VL,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A1 = lcomp( ZM, A1 );
						}
						A1 = linv( A1 );
					       *B1 = list2( VL,A1 );
						H = A2;
						A2 = _0;
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
							A2 = lcomp( ZM, A2 );
						}
						A2 = linv( A2 );
						*B2 = list2( VL,A2 );
					}
					break;
			}
			break;
		case 26:t3 = 27;
			*B2 = A2;
			VL = lfirst( A2 );
			r = llength( VL );
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
		case 27:t3 = 27;
			VL1 = lfirst( A1 );
			VL2 = lfirst( A2 );
			n = oequal( VL1,VL2 );
			if( n )
			{	*B1 = A1;
			        *B2 = A2;
			}
			else
			{       A1 = lsecond( A1 );
				A2 = lsecond( A2 );
				Z = lfirst( A1 );
				el = lfirst( Z );
				ZM = lfirst( A2 );
				el2 = lfirst( ZM );
				VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
				H = A1;
				A1 = _0;
				while( H != _0 )
				{       Z = lfirst( H );
					H = lred( H );
					ZM = _0;
					while( Z != _0 )
					{ el = lfirst( Z );
					  Z = lred( Z );
					  VL = pvmix( VL1,VL,el,el2,&el,&el2);
					  ZM = lcomp( el,ZM );
					}
					ZM = linv( ZM );
					A1 = lcomp( ZM, A1 );
				}
				A1 = linv( A1 );
			       *B1 = list2( VL,A1 );
				H = A2;
				A2 = _0;
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
					A2 = lcomp( ZM, A2 );
				}
				A2 = linv( A2 );
				*B2 = list2( VL,A2 );
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
