/*C
			mamodtyper( A1,A2,t1,t2,B1,B2,esch)

	"matrix over Z/mZ typer".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	single mamodtyper( A1,A2,t1,t2,B1,B2,esch);  list A1,A2; 
					single t1,t2,esch; list *B1,*B2;
	X = mamodtyper( A1,A2,t1,t2,B1,B2,esch);

	t1 bzw t2 ist die Kennung der Matrizen A1 bzw A2. mamodtyper er-
	mittelt die minimal gemeinsame Kennung X. Dabei werden die Ma-
	trizen A1 und A2 entsprechend ihrer gemeinsamen Kennung angepasst
	und an B1 und B2 zurueckgegeben.
C*/
/*H
	Version  1      06.07.1992      U.Schneiders
H*/
 
#include<_calc.h>

single mamodtyper( A1, A2, t1, t2, B1, B2, esch )
list A1, A2;
single t1, t2, esch;
list *B1, *B2;

{
	single n, r, sch=0, t3;
	int M;
	obj el, el2, H;
	list VL, VL1, VL2, Z, ZM;
	init( M, el, el2, H, VL, VL1, VL2, Z, ZM );
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

	if( t1 == 19 && t2 == 19 )
	{	*B1 = A1;
		*B2 = A2;
		return( 19 );
	}
	M = lfirst( varlist[modsch].varwert );

	/*** Anpassung an min. gemeinsame Kennung. ***/

	switch( t1 )
	{       case 5: switch( t2 )
			{       case 19:t3 = 19;
					*B2 = A2;
					if( ssch ) *B1 = maitomams( M, A1 );
		        		else       *B1 = maitomami( M, A1 );
					if(M==2) *B1=mamstomam2(*B1);
					break;
				case 20:t3 = 20;
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
						if( ssch ) el = mshom( M, el );
						else el = mihom( M, el );
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
	        case 6: A1 = martomami( M, A1 );
			if( A1 == ERROR )
			{       if(esch) mistake1( 243, M );
			    	return( ERROR );
			}
			switch( t2 )
			{       case 19:t3 = 19;
					*B2 = A2;
					*B1 = A1;
					if(M==2) *B1=mamstomam2(*B1);
					break;
				case 20:t3 = 20;
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
			}
			break;
		case 7: switch( t2 )
			{	case 19:t3 = 20;
					VL = lfirst( A1 );
					r = llength( VL );
					A1 = lsecond( A1 );
					if( ssch ) A1 = mapitomapms( r, A1, M );
					else A1 = mapitomapmi( r, A1, M );
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
			        case 20:t3 = 20;
					VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*B2 = A2;
					        r = llength( VL1 );
						A1 = lsecond( A1 );
						if(ssch) A1 = mapitomapms( r, A1, M );
						else A1 = mapitomapmi( r, A1, M );
						*B1 = list2( VL1,A1 );
					}
					else
					{       A1 = lsecond( A1 );
						A2 = lsecond( A2 );
						Z = lfirst( A1 );
						el = lfirst( Z );
						r = llength( VL1 );
						if(ssch) el = pitopms( r, el, M );
						else el = pitopmi( r, el, M );
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
							  if(ssch) el = pitopms( r, el, M );
							  else el = pitopmi( r, el, M );
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
		case 8: VL = lfirst( A1 );
			A1 = lsecond( A1 );
			r = llength( VL );
			A1 = maprtomapmi( r, A1, M );
			if( A1 == ERROR )
			{       if(esch) mistake1( 243, M );
				return( ERROR );
			}
			switch( t2 )
			{	case 19:t3 = 20;
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
			        case 20:t3 = 20;
					VL2 = lfirst( A2 );
					n = oequal( VL,VL2 );
					if( n )
				        {	*B2 = A2;
						*B1 = list2( VL,A1 );
					}
					else
					{	A2 = lsecond( A2 );
						Z = lfirst( A1 );
						el = lfirst( Z );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						VL1 = pvmix( VL,VL2,el,el2,&el,&el2 );
						H = A1;
						A1 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  VL1 = pvmix( VL,VL1,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A1 = lcomp( ZM, A1 );
						}
						A1 = linv( A1 );
					       *B1 = list2( VL1,A1 );
						H = A2;
						A2 = _0;
						while( H != _0 )
						{       Z = lfirst( H );
							H = lred( H );
							ZM = _0;
							while( Z != _0 )
							{ el = lfirst( Z );
							  Z = lred( Z );
							  VL1 = pvmix( VL2,VL1,el,el2,&el,&el2);
							  ZM = lcomp( el,ZM );
							}
							ZM = linv( ZM );
							A2 = lcomp( ZM, A2 );
						}
						A2 = linv( A2 );
						*B2 = list2( VL1,A2 );
					}
					break;
			}
			break;
		case 19:t3 = 20;
			*B2 = A2;
			VL = lfirst( A2 );
			r = llength( VL );
			H = A1;
			A1 = _0;
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
			    A1 = lcomp( ZM, A1 );
			}
			A1 = linv( A1 );
			*B1 = list2( VL,A1 );
			break;
		case 20:t3 = 20;
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
