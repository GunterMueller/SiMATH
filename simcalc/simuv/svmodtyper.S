/*C
			svmodtyper( a1, a2, t1, t2, b1, b2, esch );

	"scalar vector over Z/mZ typer".
	Quellbibliothek: srclib.simuv
	Include- Datei: _calc.h
	single svmodtyper( a1, a2, t1, t2, b1, b2, esch ); obj a1,a1; 
					single t1,t2,esch; obj b1,b2 ;
	X = svmodtyper( a1, a2, t1, t2, b1, b2, esch );
	t1 bzw t2 ist die Kennung des Objekts a1 bzw a2. svmodtyper er-
	mittelt die minimale Kennung X fuer den Vektor. Dabei werden
	die Objekte a1 und a2 der Kennung X entsprechend angepasst
	und in b1 das Skalar, b2 der Vektor zurueckgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      13.07.1992      U.Schneiders
H*/
/*cS
	svmodtyper ruft auf: fputr, lcomp, linv, llength,
			     mihom, miinv, miprod, mistake, mshom,
                             msprod, oequal, pitopmi, pitopms, 
			     pmimiprod, pmsmsprod, prnumden, pvinsert,
                             pvmix, vecitovecmi, vecitovecms,
			     vecpitovpmi, vecpitovpms, vecprtovpmi,
			     vecrtovecmi
		     Macros: lfirst, list2, lred, lsecond, putr
Sc*/

#include <_calc.h>

single svmodtyper( a1, a2, t1, t2, b1, b2, esch )
obj a1, a2;
single t1, t2, esch;
obj *b1, *b2;

{       obj el, H;
	list M, VL, VL1, VL2;
	int N;
	single n, r, t3;
	init( el, H, M, VL, VL1, VL2, N );
	bind( a1, a2 );
	*b1 = _0; *b2 = _0;

	if( t1 == 4 || t2 == 4 || t1 == 14 || t2 == 14 || t1 > 22 || t2 > 22 )
	{       if(esch) mistake( 71 );
		return( -BASIS );
	}

	if( t2 < 4 || t2 == 17 || t2 == 18 ) 
	{       H = t1;
		t1 = t2;
		t2 = H;
		H = a1;
		a1 = a2;
		a2 = H;
	}
	M = lfirst( varlist[modsch].varwert );

	/***    Typangleichung  ***/

	switch( t2 )
	{       case 10: switch( t1 )
			{       case 17:*b1 = a1;
					if( ssch ) *b2 = vecitovecms( M, a2 );
		        		else       *b2 = vecitovecmi( M, a2 );
					t3 = 21;
					break;
				case 18:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    if( ssch ) el = mshom( M, el );
					    else el = mihom( M, el );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 22;
					break;
			}
			break;
	        case 11: a2 = vecrtovecmi( M, a2 );
			if( a2 == ERROR )
			{       if(esch) mistake1( 244, M );
			    	return( ERROR );
			}
			switch( t1 )
			{       case 17:*b1 = a1;
					*b2 = a2;
					t3 = 21;
					break;
				case 18:t3 = 22;
					*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					break;
			}
			break;
		case 12: switch( t1 )
			{       case 17:VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL,a1 );
					a2 = lsecond( a2 );
					if( ssch ) a2 = vecpitovpms( r, a2, M );
					else a2 = vecpitovpmi( r, a2, M );
					*b2 = list2( VL,a2 );
					t3 = 22;
					break;
			        case 18:t3 = 22;
					VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b1 = a1;
					        r = llength( VL2 );
						a2 = lsecond( a2 );
						if(ssch) a2 = vecpitovpms( r, a2, M );
						else a2 = vecpitovpmi( r, a2, M );
						*b2 = list2( VL2,a2 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						el = lfirst( a2 );
						r = llength( VL2 );
						if(ssch) el = pitopms( r, el, M );
						else el = pitopmi( r, el, M );
						VL = pvmix( VL2,VL1,el,a1,&el,&a1 );
					       *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
						        if(ssch) el = pitopms( r, el, M );
						        else el = pitopmi( r, el, M );
							VL = pvmix( VL2,VL,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					break;
			}
			break;
		case 13: VL = lfirst( a2 );
			a2 = lsecond( a2 );
			r = llength( VL );
			a2 = vecprtovpmi( r, a2, M );
			if( a2 == ERROR )
			{       if(esch) mistake1( 244, M );
				return( ERROR );
			}
			switch( t1 )
			{	case 17:t3 = 22;
					*b2 = list2( VL,a2 );
					a1 = pvinsert( 0,a1,r );
					*b1 = list2( VL,a1 );
					break;
			        case 18:t3 = 22;
					VL1 = lfirst( a1 );
					n = oequal( VL,VL1 );
					if( n )
				        {	*b1 = a1;
						*b2 = list2( VL,a2 );
					}
					else
					{	a1 = lsecond( a1 );
						el = lfirst( a2 );
						VL2 = pvmix( VL,VL1,el,a1,&el,&a1 );
					        *b1 = list2( VL2,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL2 = pvmix( VL,VL2,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL2,a2 );
					}
					break;
			}
			break;
		case 21:switch( t1 )
			{	case 0: *b2 = a2;
			                if( ssch ) *b1 = mshom( M, a1 );
					else       *b1 = mihom( M, a1 );
					t3 = 21;
					break;
				case 1: N = lsecond( a1 );
	                                if ( igcd( N, M ) != 1 )
			                {   if(esch) mistake2( 233, a1, M );
		        	            return( ERROR );
			                }
	 	                        N = miinv( M, N );
                                        a1 = lfirst( a1 );
			                if( ssch )
			                {   a1 = mshom( M, a1 );
                                            a1 = msprod( M, a1, N );
                                        }         
			                else    
			                {   a1 = mihom( M, a1 );
				            a1 = miprod( M, a1, N );
                       	                }
					*b1 = a1;
					*b2 = a2;
					t3 = 21;
					break;
				case 2: VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
			                if( ssch ) a1 = pitopms( r, a1, M );
					else a1 = pitopmi( r, a1, M );
					*b1 = list2( VL, a1 );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL, a2 );
					t3 = 22;
					break;
				case 3: VL = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL );
					H = prnumden( r, a1, &N );
					if( igcd( M, N ) != 1 )
					{       if(esch) mistake1( 242, M );
						return( ERROR );
					}
					N = miinv( M, N );
					if( ssch )
					{	a1 = pitopms( r, H, M );
						a1 = pmsmsprod( r, M, a1, N );
                        		}
					else      
					{	a1 = pitopmi( r, H, M );
						a1 = pmimiprod( r, M, a1, N );
                        		}
			                *b1 = list2( VL, a1 );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL, a2 );
					t3 = 22;
					break;
				case 17:*b1 = a1;
					*b2 = a2;
					t3 = 21;
					break;
				case 18:*b1 = a1;
					VL = lfirst( a1 );
					r = llength( VL );
					H = a2;
					a2 = _0;
					while( H != _0 )
					{   el = lfirst( H );
				            H = lred( H );
					    el = pvinsert( 0,el,r );
					    a2 = lcomp( el, a2 );
					}
					a2 = linv( a2 );
					*b2 = list2( VL,a2 );
					t3 = 22;
					break;
			}
			break;
		case 22:switch( t1 )
			{	case 0: *b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
			                if( ssch ) a1 = mshom( M, a1 );
					else       a1 = mihom( M, a1 );
				        a1 = pvinsert( 0, a1, r );	
					*b1 = list2( VL, a1 );
					t3 = 22;
					break;
				case 1: N = lsecond( a1 );
	                                if ( igcd( N, M ) != 1 )
			                {   if(esch) mistake2( 233, a1, M );
		        	            return( ERROR );
			                }
	 	                        N = miinv( M, N );
                                        a1 = lfirst( a1 );
			                if( ssch )
			                {   a1 = mshom( M, a1 );
                                            a1 = msprod( M, a1, N );
                                        }         
			                else    
			                {   a1 = mihom( M, a1 );
				            a1 = miprod( M, a1, N );
                       	                }
					VL = lfirst( a2 );
					r = llength( VL );
				        a1 = pvinsert( 0, a1, r );	
					*b1 = list2( VL, a1 );
					*b2 = a2;
					t3 = 22;
					break;
				case 2: VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
					        r = llength( VL1 );
						a1 = lsecond( a1 );
						if(ssch) a1 = pitopms( r, a1, M );
						else a1 = pitopmi( r, a1, M );
						*b1 = list2( VL1,a1 );
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						r = llength( VL1 );
						if(ssch) a1 = pitopms( r, a1, M );
						else a1 = pitopmi( r, a1, M );
						el = lfirst( a2 );
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
					        *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL2,VL,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 22;
					break;
				case 3: VL1 = lfirst( a1 );
					a1 = lsecond( a1 );
					r = llength( VL1 );
					H = prnumden( r, a1, &N );
					if( igcd( M, N ) != 1 )
					{       if(esch) mistake1( 242, M );
						return( ERROR );
					}
					N = miinv( M, N );
					if( ssch )
					{	a1 = pitopms( r, H, M );
						a1 = pmsmsprod( r, M, a1, N );
                        		}
					else      
					{	a1 = pitopmi( r, H, M );
						a1 = pmimiprod( r, M, a1, N );
                        		}
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						*b1 = list2( VL1,a1 );
					}
					else
					{       a2 = lsecond( a2 );
						el = lfirst( a2 );
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
					        *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL2,VL,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 22;
					break;
				case 17:*b2 = a2;
					VL = lfirst( a2 );
					r = llength( VL );
					a1 = pvinsert( 0, a1, r );
					*b1 = list2( VL, a1 );
					t3 = 22;
					break;
				case 18:VL1 = lfirst( a1 );
					VL2 = lfirst( a2 );
					n = oequal( VL1,VL2 );
					if( n )
				        {	*b2 = a2;
						*b1 = a1;
					}
					else
					{       a1 = lsecond( a1 );
						a2 = lsecond( a2 );
						el = lfirst( a2 );
						VL = pvmix( VL1,VL2,a1,el,&a1,&el );
					        *b1 = list2( VL,a1 );
						H = a2;
						a2 = _0;
						while( H != _0 )
						{       el = lfirst( H );
							H = lred( H );
							VL = pvmix( VL2,VL,el,a1,&el,&a1);
							a2 = lcomp( el, a2 );
						}
						a2 = linv( a2 );
						*b2 = list2( VL,a2 );
					}
					t3 = 22;
					break;
			}
			break;
	}

	return( t3 );
}
