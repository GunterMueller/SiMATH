/*C
			matrtyper( A1,A2,t1,t2,B1,B2)

	"matrixtyper".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	single matrtyper( A1,A2,t1,t2,B1,B2);  list A1,A2; single t1,t2;
					       list *B1,*B2;
	X = matrtyper( A1,A2,t1,t2,B1,B2);

	t1 bzw t2 ist die Kennung der Matrizen A1 bzw A2. matrtyper er-
	mittelt die minimal gemeinsame Kennung X. Dabei werden die Ma-
	trizen A1 und A2 entsprechend ihrer gemeinsamen Kennung angepasst
	und an B1 und B2 zurueckgegeben.
C*/
/*H
	Version  1      24.10.1988      C.Hollinger/U.Schneiders
	Version  1.1    24.05.1989      C.Hollinger     ( Korr. t3 )
	Version  2      17.07.1989      C.Hollinger     ( ra. Fu )
H*/
 
#include<_calc.h>

single matrtyper( A1, A2, t1, t2, B1, B2 )
list A1, A2;
single t1, t2;
list *B1, *B2;

{
	single n, r, rn, sch=0, t3;
	obj el, el1, el2, el3, H;
	list VL, VL1, VL2, Z, ZM;
	init( el, el1, el2, el3, H, VL, VL1, VL2, Z, ZM );
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

	if( ( t1 == 5 && t2 == 5 ) || ( t1 == 6 && t2 == 6 ) )
	{       t3 = t1;
		*B1 = A1;
		*B2 = A2;
	}

	/*** Anpassung an min. gemeinsame Kennung. ***/

	switch( t1 )
	{       case 5: switch( t2 )
			{       case 6: t3 = 6;
					*B2 = A2;
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{       el = lfirst( Z );
							Z = lred( Z );
							el = itor( el );
							ZM = lcomp( el,ZM );
						}
						ZM = linv( ZM );
						A1 = lcomp( ZM, A1 );
					}
					*B1 = linv( A1 );
					break;
				case 7: t3 = 7;
					*B2 = A2;
					VL = lfirst( A2 );
					r = llength( VL );
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{       el = lfirst( Z );
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
				case 8: t3 = 8;
					*B2 = A2;
					VL = lfirst( A2 );
					r = llength( VL );
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{       el = lfirst( Z );
							Z = lred( Z );
							el = itor( el );
							el = pvinsert( 0,el,r );
							ZM = lcomp( el,ZM );
						}
						ZM = linv( ZM );
						A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					*B1 = list2( VL,A1 );
					break;
				case 9: t3 = 9;
					VL = lfirst( A2 );
					*B2 = A2;
					r = llength( VL );
					H = A1;
					A1 = _0;
					el1 = pvinsert( 0,1,r );
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{       el = lfirst( Z );
							Z = lred( Z );
							if( el )
							{  el = pvinsert( 0,el,r );
							   el = list2( el,el1 );
							}
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
			{       case 7: t3 = 8;
					VL = lfirst( A2 );
					r = llength( VL );
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{       el = lfirst( Z );
							Z = lred( Z );
							el = pvinsert( 0,el,r );
							ZM = lcomp( el,ZM );
						}
						ZM = linv( ZM );
						A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					*B1 = list2( VL,A1 );
					H = lsecond( A2 );
					A2 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{       el = lfirst( Z );
							Z = lred( Z );
							el = pitopr( r,el );
							ZM = lcomp( el,ZM );
						}
						ZM = linv( ZM );
						A2 = lcomp( ZM, A2 );
					}
					A2 = linv( A2 );
					*B2 = list2( VL,A2 );
					break;
				case 8: t3 = 8;
					*B2 = A2;
					VL = lfirst( A2 );
					r = llength( VL );
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{       el = lfirst( Z );
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
				case 9: t3 = 9;
					*B2 = A2;
					VL = lfirst( A2 );
					r = llength( VL );
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{       el = lfirst( Z );
							Z = lred( Z );
							if( el )
							{  el1 = lsecond( el );
							   el1 = pvinsert( 0,el1,r );
							   el = lfirst( el );
							   el = pvinsert( 0,el,r );
							   el = list2( el,el1 );
							}
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
			{       case 7: t3 = 7;
					VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1,VL2 );
					if( n )
					{       *B1 = A1;
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
				case 8: t3 = 8;
					VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1, VL2 );
					r = llength( VL1 );
					A1 = lsecond( A1 );
					A2 = lsecond( A2 );
					if( !n )
					{       Z = lfirst( A1 );
						el = lfirst( Z );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
					}
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{ el = lfirst( Z );
						  Z = lred( Z );
						  el = pitopr( r,el);
						  if( !n ) VL = pvmix( VL1,VL,el,el2,&el,&el2);
						  ZM = lcomp( el,ZM );
						}
						ZM = linv( ZM );
						A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					if( !n )  *B1 = list2( VL,A1 );
					else      *B1 = list2( VL1, A1 );
					if( n )   *B2 = list2( VL2,A2 );
					else
					{  H = A2;
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
				case 9: t3 = 9;
					VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1, VL2 );
					r = llength( VL1 );
					A1 = lsecond( A1 );
					A2 = lsecond( A2 );
					if( !n )
					{       Z = lfirst( A1 );
						el = lfirst( Z );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						if( el2 ) el2 = lfirst( el2 );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
					}
					else    el1 = pvinsert( 0,1,r );
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{ el = lfirst( Z );
						  Z = lred( Z );
						  if( !n && el )
						  {  VL = pvmix( VL1,VL,el,el2,&el,&el2 );
						     rn = llength( VL );
						     el1 = pvinsert( 0,1,rn );
						  }
						  if(el ) el = list2( el,el1 );
						  ZM = lcomp( el,ZM );
						}
						ZM = linv( ZM );
						A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					if( !n )  *B1 = list2( VL,A1 );
					else      *B1 = list2( VL1, A1 );
					if( n )   *B2 = list2( VL2,A2 );
					else
					{  H = A2;
					   A2 = _0;
					   while( H != _0 )
					   {       Z = lfirst( H );
						   H = lred( H );
						   ZM = _0;
						   while( Z != _0 )
						   { el = lfirst( Z );
						     Z = lred( Z );
						     if( el )
						     {  el1 = lsecond( el );
						        el = lfirst( el );
						        VL = pvmix( VL2,VL,el,el2,&el,&el2);
						        VL = pvmix( VL2,VL,el1,el2,&el1,&el2);
						        el = list2( el,el1 );
						     }
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
			{       case 8: t3 = 8;
					VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1,VL2 );
					if( n )
					{       *B1 = A1;
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
				case 9: t3 = 9;
					VL1 = lfirst( A1 );
					VL2 = lfirst( A2 );
					n = oequal( VL1, VL2 );
					r = llength( VL1 );
					A1 = lsecond( A1 );
					A2 = lsecond( A2 );
					if( !n )
					{       Z = lfirst( A1 );
						el = lfirst( Z );
						el = prnumden( r,el,&el1 );
						ZM = lfirst( A2 );
						el2 = lfirst( ZM );
						if( el2 ) el2 = lfirst( el2 );
						VL = pvmix( VL1,VL2,el,el2,&el,&el2 );
					}
					H = A1;
					A1 = _0;
					while( H != _0 )
					{       Z = lfirst( H );
						H = lred( H );
						ZM = _0;
						while( Z != _0 )
						{ el = lfirst( Z );
						  Z = lred( Z );
						  el = prnumden( r,el,&el1 );
						  if( !n && el )
						  {  VL = pvmix( VL1,VL,el,el2,&el,&el2 );
						     rn = llength( VL );
						     el1 = pvinsert( 0,el1,rn );
						  }
						  else if( el ) el1 = pvinsert( 0,el1,r );
						  if( el ) el = list2( el,el1 );
						  ZM = lcomp( el,ZM );
						}
						ZM = linv( ZM );
						A1 = lcomp( ZM, A1 );
					}
					A1 = linv( A1 );
					if( !n )  *B1 = list2( VL,A1 );
					else      *B1 = list2( VL1, A1 );
					if( n )   *B2 = list2( VL2,A2 );
					else
					{  H = A2;
					   A2 = _0;
					   while( H != _0 )
					   {       Z = lfirst( H );
						   H = lred( H );
						   ZM = _0;
						   while( Z != _0 )
						   { el = lfirst( Z );
						     Z = lred( Z );
						     if( el )
						     {   el1 = lsecond( el );
						         el = lfirst( el );
						         VL = pvmix( VL2,VL,el,el2,&el,&el2);
						         VL = pvmix( VL2,VL,el1,el2,&el1,&el2);
						         el = list2( el,el1 );
						     }
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
		case 9: t3 = 9;
			VL1 = lfirst( A1 );
			VL2 = lfirst( A2 );
			n = oequal( VL1, VL2 );
			if( n )
			{       *B1 = A1;
				*B2 = A2;
			}
			else
			{       A1 = lsecond( A1 );
				A2 = lsecond( A2 );
				Z = lfirst( A1 );
				el = lfirst( Z );
				if( el ) el = lfirst( el );
				ZM = lfirst( A2 );
				el2 = lfirst( ZM );
				if( el2 ) el2 = lfirst( el2 );
				VL = pvmix( VL1,VL2,el,el2,&el3,&el2 );
				H = A1;
				A1 = _0;
				while( H != _0 )
				{       Z = lfirst( H );
					H = lred( H );
					ZM = _0;
					while( Z != _0 )
					{       el = lfirst( Z );
						Z = lred( Z );
						if( el )
						{   el1 = lsecond( el );
						    el = lfirst( el );
						    VL = pvmix( VL1,VL,el,el3,&el,&el3 );
						    VL = pvmix( VL1,VL,el1,el3,&el1,&el3 );
						    el = list2( el,el1 );
						}
						ZM = lcomp( el,ZM );
					}
					ZM = linv( ZM );
					A1 = lcomp( ZM, A1 );
				}
				A1 = linv( A1 );
				*B1 = list2( VL, A1 );
				H = A2;
				A2 = _0;
				while( H != _0 )
				{       Z = lfirst( H );
					H = lred( H );
					ZM = _0;
					while( Z != _0 )
					{       el = lfirst( Z );
						Z = lred( Z );
						if( el )
						{   el1 = lsecond( el );
						    el = lfirst( el );
						    VL = pvmix( VL2,VL,el,el2,&el,&el2);
						    VL = pvmix( VL2,VL,el1,el2,&el1,&el2);
						    el = list2( el,el1 );
						}
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
