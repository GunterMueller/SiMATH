/*C
			vlist( V, ken )

	"vector list".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list vlist( V, ken );  list V;single ken;
	X = vlist( V, ken );

	vlist passt den in V angegebenen Vektor elementweise der ma-
	ximalen Kennung an. Dabei baut sie gleichzeitig das Ergeb-
	nis in X auf.
C*/
/*H
	Version  1      24.01.1989      C.Hollinger/U.Schneiders
	Version  2      17.07.1989      C.Hollinger     ( rat. Fu )
	Version  3      31.03.1992      U.Schneiders ( mod. Arith. ) 
	Version  3.1    21.05.1992      U.Schneiders ( NF ) 
	Version  3.2	08.07.1993	S.Schmitt ( GF )
H*/
/*cS
	vlist ruft auf: calc_gf, calc_m, calc_nf, itor, lcomp, lcomp2, 
			linv, llength, pitopr, prnumden, pvinsert, pvmerge
		Macros: lfirst, list2, lred, lred2, lsecond
Sc*/

#include<_calc.h>

list vlist( V,ken )
list V;
single ken;

{
	list H, LP, LV, NP, VL;
	obj el, el1;
	single kenel, r;
	init( H, LP, LV, NP, VL, el, el1 );
	bind( V );

	/*** Anpassung an gemeinsame Kennung ken. ***/

	switch( ken )
	{       case 10:H = V;
			V = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				el = lfirst( el );
				V = lcomp( el, V );
			}
			V = linv( V );
			V = list2( V,10 );
			break;
		case 11:H = V;
			V = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				kenel = lsecond( el );
				el = lfirst( el );
				if( !kenel )    el = itor( el );
				V = lcomp( el, V );
			}
			V = linv( V );
			V = list2( V,11 );
			break;
		case 12:H = V;
			LV = _0;
			LP = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				kenel = lsecond( el );
				el = lfirst( el );
				if( !kenel )    VL = _0;
				else
				{       VL = lfirst( el );
					el = lsecond( el );
				}
				LV = lcomp( VL, LV );
				LP = lcomp( el, LP );
			}
			VL = pvmerge( LV, LP, &NP );
			V = _0;
			while( NP != _0 )
			{       el = lfirst( NP );
				NP = lred( NP );
				V = lcomp( el, V );
			}
			V = list2( VL, V );
			V = list2( V,12 );
			break;
		case 13:H = V;
			LV = _0;
			LP = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				kenel = lsecond( el );
				el = lfirst( el );
				switch( kenel )
				{       case 0: VL = _0;
						el = itor( el );
						break;
					case 1: VL = _0;
						break;
					case 2: VL = lfirst( el );
						el = lsecond( el );
						r = llength( VL );
						el = pitopr( r,el );
						break;
					case 3: VL = lfirst( el );
						el = lsecond( el );
						break;
				}
				LV = lcomp( VL, LV );
				LP = lcomp( el, LP );
			}
			VL = pvmerge( LV, LP, &NP );
			V = _0;
			while( NP != _0 )
			{       el = lfirst( NP );
				NP = lred( NP );
				V = lcomp( el, V );
			}
			V = list2( VL, V );
			V = list2( V,13 );
			break;
		case 14:H = V;
			LV = _0;
			LP = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				kenel = lsecond( el );
				el = lfirst( el );
				switch( kenel )
				{       case 0: VL = _0;
						el1 = 1;
						break;
					case 1: VL = _0;
						el1 = lsecond( el );
						el = lfirst( el );
						break;
					case 2: VL = lfirst( el );
						el = lsecond( el );
						r = llength( VL );
						el1 = pvinsert( 0,1,r );
						break;
					case 3: VL = lfirst( el );
						el = lsecond( el );
						r = llength( VL );
						el = prnumden( r,el,&el1 );
						el1 = pvinsert( 0,el1,r );
						break;
					case 4: VL = lfirst( el );
						el = lsecond( el );
						el1 = lsecond( el );
						el = lfirst( el );
						break;
				}
				LV = lcomp2( VL, VL, LV );
				LP = lcomp2( el, el1, LP );
			}
			VL = pvmerge( LV, LP, &NP );
			V = _0;
			while( NP != _0 )
			{       el = lfirst( NP );
				el1 = lsecond( NP );
				NP = lred2( NP );
				if(el) el = list2( el,el1 );
				V = lcomp( el,V );
			}
			V = list2( VL, V );
			V = list2( V,14 );
			break;
	        case 21:H = V;
			V = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				if( lsecond( el ) != 17 )
				{	el = calc_m( el );
					if( el == ERROR ) return( ERROR );
				} 
				el = lfirst( el );
				V = lcomp( el, V );
			}
			V = linv( V );
			V = list2( V, 21 );
			break;
		case 22:H = V;
			LV = _0;
			LP = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				if( lsecond( el ) < 17 )
				{	el = calc_m( el );
					if( el == ERROR ) return( ERROR );
				} 
				kenel = lsecond( el );
				el = lfirst( el );
				if( kenel == 17 )    VL = _0;
				else
				{       VL = lfirst( el );
					el = lsecond( el );
				}
				LV = lcomp( VL, LV );
				LP = lcomp( el, LP );
			}
			VL = pvmerge( LV, LP, &NP );
			V = _0;
			while( NP != _0 )
			{       el = lfirst( NP );
				NP = lred( NP );
				V = lcomp( el, V );
			}
			V = list2( VL, V );
			V = list2( V, 22 );
			break;
	        case 28:H = V;
			V = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				if( lsecond( el ) != 24 )
				{	el = calc_nf( el );
					if( el == ERROR ) return( ERROR );
				} 
				el = lfirst( el );
				V = lcomp( el, V );
			}
			V = linv( V );
			V = list2( V, 28 );
			break;
		case 29:H = V;
			LV = _0;
			LP = _0;
			while( H != _0 )
			{       el = lfirst( H );
				H = lred( H );
				if( lsecond( el ) < 24 )
				{	el = calc_nf( el );
					if( el == ERROR ) return( ERROR );
				} 
				kenel = lsecond( el );
				el = lfirst( el );
				if( kenel == 24 )    VL = _0;
				else
				{       VL = lfirst( el );
					el = lsecond( el );
				}
				LV = lcomp( VL, LV );
				LP = lcomp( el, LP );
			}
			VL = pvmerge( LV, LP, &NP );
			V = _0;
			while( NP != _0 )
			{       el = lfirst( NP );
				NP = lred( NP );
				V = lcomp( el, V );
			}
			if( VL != _0 )
			{	V = list2( VL, V );
				V = list2( V, 29 );
			}
			else    V = list2( V, 28 );
			break;
		case 35:H = V;
			V = _0;
			while(H!=_0)
			{	el = lfirst(H);
				H = lred(H);
				if(lsecond(el) != 31)
				{	el = calc_gf(el);
					if(el == ERROR) return(ERROR);
				}
				el = lfirst(el);
				V = lcomp(el,V);
			}
			V = linv(V);
			V = list2(V,35);
			break;
		case 36:H = V;
			LV = _0;
			LP = _0;
			while(H!=_0)
			{	el = lfirst(H);
				H = lred(H);
				if(lsecond(el)<31)
				{	el = calc_gf(el);
					if(el == ERROR) return(ERROR);
				}
				kenel = lsecond(el);
				el = lfirst(el);
				if(kenel == 31)  VL = _0;
				else
				{	VL = lfirst(el);
					el = lsecond(el);
				}
				LV = lcomp(VL,LV);
				LP = lcomp(el,LP);
			}
			VL = pvmerge(LV,LP,&NP);
			V = _0;
			while(NP !=_0)
			{	el = lfirst(NP);
				NP = lred(NP);
				V = lcomp(el,V);
			}
			if( VL != _0 )
			{	V = list2(VL,V);
				V = list2(V,36);
			}
			else    V = list2(V,35);
			break;
	}
	return( V );
}
