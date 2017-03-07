/*C
			mlist( M, ken )

	"matrix list".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	list mlist( M, ken );  list M;single ken;
	X = mlist( M, ken );

	mlist passt die in M angegebene Matrix elementweise der ma-
	ximalen Kennung an. Dabei baut sie gleichzeitig das Ergeb-
	nis in X auf.
C*/
/*H
	Version  1      19.10.1988      C.Hollinger/U.Schneiders
	Version  2      28.06.1989      C.Hollinger     ( rat.Fu )
	Version  3      31.03.1992      U.Schneiders ( mod. Arith. ) 
	Version  3.1    21.05.1992      U.Schneiders ( NF ) 
	Version  3.2	08.07.1993	S.Schmitt ( GF )
H*/

#include<_calc.h>

list mlist( M,ken )
list M;
single ken;

{       list H, LP, LV, NP, VL, Z, ZM;
	obj el, el1, n;
	single i, kenel, l, r;
	init( H, LP, LV, NP, VL, Z, ZM, el, el1, n );
	bind( M );

	/*** Anpassung der Matrixelemente an max. Kennung. ***/

	switch( ken )
	{       case 5: H = M;
			M = _0;
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				ZM = _0;
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
					el = lfirst( el );
					ZM = lcomp( el,ZM );
				}
				ZM = linv( ZM );
				M = lcomp( ZM, M );
			}
			M = linv( M );
			M = list2( M,5 );
			break;
		case 6: H = M;
			M = _0;
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				ZM = _0;
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
					kenel = lsecond( el );
					el = lfirst( el );
					if( !kenel )    el = itor( el );
					ZM = lcomp( el,ZM );
				}
				ZM = linv( ZM );
				M = lcomp( ZM, M );
			}
			M = linv( M );
			M = list2( M,6 );
			break;
		case 7: H = M;
			LV = _0;
			LP = _0;
			Z = lfirst( H );
			l = llength( Z );
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
					kenel = lsecond( el );
					el = lfirst( el );
					if( !kenel )    VL = _0;
					else
					{       VL = lfirst( el );
						el = lsecond( el );
					}
					LV = lcomp( VL,LV );
					LP = lcomp( el,LP );
				}
			}
			VL = pvmerge( LV, LP, &NP );
			M = _0;
			while( NP != _0 )
			{       i = 0;
				Z = _0;
				while( i < l )
				{       el = lfirst( NP );
					NP = lred( NP );
					Z = lcomp( el,Z );
					i++;
				}
				M = lcomp( Z,M );
			}
			M = list2( VL,M );
			M = list2( M,7 );
			break;
		case 8: H = M;
			LV = _0;
			LP = _0;
			Z = lfirst( H );
			l = llength( Z );
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
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
					LV = lcomp( VL,LV );
					LP = lcomp( el,LP );
				}
			}
			VL = pvmerge( LV, LP, &NP );
			M = _0;
			while( NP != _0 )
			{       i = 0;
				Z = _0;
				while( i < l )
				{       el = lfirst( NP );
					NP = lred( NP );
					Z = lcomp( el,Z );
					i++;
				}
				M = lcomp( Z,M );
			}
			M = list2( VL,M );
			M = list2( M,8 );
			break;
		case 9: H = M;
			LV = _0;
			LP = _0;
			Z = lfirst( H );
			l = llength( Z );
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
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
			}
			VL = pvmerge( LV, LP, &NP );
			M = _0;
			while( NP != _0 )
			{       i = 0;
				Z = _0;
				while( i < l )
				{       el = lfirst( NP );
					el1 = lsecond( NP );
					if( el ) el = list2( el,el1 );
					NP = lred2( NP );
					Z = lcomp( el,Z );
					i++;
				}
				M = lcomp( Z,M );
			}
			M = list2( VL,M );
			M = list2( M,9 );
			break;

	        case 19:H = M;
			M = _0;
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				ZM = _0;
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
					if( lsecond( el ) != 17 )
					{	el = calc_m( el );
						if( el == ERROR ) return( ERROR );
					}
					el = lfirst( el );
					ZM = lcomp( el,ZM );
				}
				ZM = linv( ZM );
				M = lcomp( ZM, M );
			}
			M = linv( M );
			if(lfirst(varlist[modsch].varwert)==2) M=mamstomam2(M);
			M = list2( M, 19 );
			break;
		case 20:H = M;
			LV = _0;
			LP = _0;
			Z = lfirst( H );
			l = llength( Z );
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
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
					LV = lcomp( VL,LV );
					LP = lcomp( el,LP );
				}
			}
			VL = pvmerge( LV, LP, &NP );
			M = _0;
			while( NP != _0 )
			{       i = 0;
				Z = _0;
				while( i < l )
				{       el = lfirst( NP );
					NP = lred( NP );
					Z = lcomp( el,Z );
					i++;
				}
				M = lcomp( Z,M );
			}
			M = list2( VL,M );
			M = list2( M, 20 );
			break;
	        case 26:H = M;
			M = _0;
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				ZM = _0;
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
					if( lsecond( el ) != 24 )
					{	el = calc_nf( el );
						if( el == ERROR ) return( ERROR );
					}
					el = lfirst( el );
					ZM = lcomp( el,ZM );
				}
				ZM = linv( ZM );
				M = lcomp( ZM, M );
			}
			M = linv( M );
			M = list2( M, 26 );
			break;
		case 27:H = M;
			LV = _0;
			LP = _0;
			Z = lfirst( H );
			l = llength( Z );
			while( H != _0 )
			{       Z = lfirst( H );
				H = lred( H );
				while( Z != _0 )
				{       el = lfirst( Z );
					Z = lred( Z );
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
					LV = lcomp( VL,LV );
					LP = lcomp( el,LP );
				}
			}
			VL = pvmerge( LV, LP, &NP );
			M = _0;
			while( NP != _0 )
			{       i = 0;
				Z = _0;
				while( i < l )
				{       el = lfirst( NP );
					NP = lred( NP );
					Z = lcomp( el,Z );
					i++;
				}
				M = lcomp( Z,M );
			}
			if( VL != _0 ) 
			{	M = list2( VL,M );
				M = list2( M, 27 );
			}
			else   M = list2( M, 26 );
			break;
		case 33:H = M;
			M = _0;
			while(H!=_0)
			{	Z = lfirst(H);
				H = lred(H);
				ZM = _0;
				while(Z != _0)
				{	el = lfirst(Z);	
					Z = lred(Z);
					if(lsecond(el) != 31 )
					{	el = calc_gf(el);
						if(el == ERROR) return(ERROR);
					}
					el = lfirst(el);
					ZM = lcomp(el,ZM);
				}
				ZM = linv(ZM);
				M = lcomp(ZM,M);
			}
			M = linv(M);
			M = list2(M,33);
			break;
		case 34:H = M;
			LV = _0;
			LP = _0;
			Z = lfirst(H);	
			l = llength(Z);
			while(H!=_0)
			{	Z = lfirst(H);
				H = lred(H);
				while(Z!=_0)
				{	el = lfirst(Z);
					Z = lred(Z);
					if(lsecond(el) < 31)
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
			}
			VL = pvmerge(LV,LP,&NP);
			M = _0;
			while(NP != _0)
			{	i = 0;
				Z = _0;
				while(i < l)
				{	el = lfirst(NP);
					NP = lred(NP);
					Z = lcomp(el,Z);
					i++;
				}
				M = lcomp(Z,M);
			}
			if( VL != _0 )
			{	M = list2(VL,M);
				M = list2(M,34);
			}
			else    M = list2(M,33);
			break;
	}
	return( M );
}
