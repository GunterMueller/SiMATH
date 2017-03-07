/*C
			calc_eival( fkeller )

	"calculator eigenvalues".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	obj calc_eival( fkeller );  list fkeller;
	X = calc_eival( fkeller );

	fkeller besteht aus einer Matrix M mit zugehoeriger Kennung und
	der Polynomvariablen des charakteristischen Polynoms. Dabei
	muss M eine quadratische Matrix ueber Z, Q, Z/mZ oder einem 
	endlichen Koerper sein.
        An erg wird die Liste der Eigenwerte ueber Z, Q, Z/mZ oder dem 
	endlichen Koerper zurueckgegeben.
	calc_eival gibt das Produkt der irreduziblen Faktoren des char.
	Polynoms ueber Z, Q, Z/mZ oder dem endlichen Koerper mit 
	zugehoeriger Kennung zurueck.
	Laeuft calc_eival fehlerhaft ab, so ist  X  = -BASIS.
C*/
/*H
	Version  1      16.01.1990         C.Hollinger/U.Schneiders
	Version  2      11.09.1992         U.Schneiders ( mod und nf )
	Version  3	26.07.1993	   S.Schmitt ( gf )
H*/

#include <_calc.h>

obj calc_eival( fkeller )
list fkeller;

{
	single ken, m, n, t;
	obj p, erg, ev, M, var;
	list L, VP;
	list AVL;
	pol P;
	bind( fkeller );
	init( p, erg, ev, M, var, L, VP, AVL, P );

	if( fkeller == -BASIS ) return( -BASIS );
	if( llength( fkeller ) != 2 )
	{       mistake( 44 );
		return( -BASIS );
	}
	var = lfirst( fkeller );
	M = lsecond( fkeller );

	/*** Ueberpruefen der Parameter. ***/
	/*** var muss wie folgt aussehen: ( ( name )( 1 1 ), 2 ) ***/

	ken = lsecond( var );
	var = lfirst( var );
	if( ken != 2 )
	{       mistake( 79 );
		return( -BASIS );
	}
	VP = lfirst( var );
	var = lsecond( var );
	if( llength(VP) != 1 || llength(var) != 2 || lfirst(var) != 1 || lsecond(var) != 1 )
	{       mistake( 79 );
		return( -BASIS );
	}
	t = lsecond( M );
	M = lfirst( M );
	if( t < 5 || ( t > 6 && t != 19 && t != 33 ) )
	{       mistake( 47 );
		return( -BASIS );
	}
	if( t == 19 && !pzsch )
	{       mistake( 47 );
		return( -BASIS );
	}

	/*** Ist M eine quadratische Matrix? ***/
	/*** Man braucht p schon hier wegen der speziellen Bit-Darstellung
		von Matrizen ueber Z/2Z.				***/

	if( t == 19 ) 
	{	p = lfirst( varlist[modsch].varwert );
		if(p==2) M=mam2tomams(M);
	}

	m = manrrow( M );
	n = manrcol( M );
	if( n != m )
	{       mistake( 47 );
		return( -BASIS );
	}

	/*** Auswertung ***/

	if ( t == 33 ) p = lfirst( varlist[gfsch].varwert );

	switch( t )
	{       case 5: erg = maievifcp( M,&L );
			break;
		case 6: erg = marevifcp( M,&L );
			break;
		case 19:if( ssch ) erg = mamsevifcp( p,M,&L );
			else       erg = mamievifcp( p,M,&L );
			break;
		case 33:if(gfchar==2) erg=magf2evifcp(p,M,&L);
			else erg = magfsevifcp(gfchar,p,M,&L);
			break;
	}
	if(erg==ERROR)
	{	mistake(93);
		return(ERROR);
	}

	if(!assch)
	{  printf(" eigenvalues:\n");
	   if( ps )   fprintf(datei,"out: eigenvalues:\n    ");
	}
	if(avsch) AVL=_0;
	if( t < 7 )
	{   while( erg != _0 )
	    {   ev = lfirst( erg );
		m = lsecond( erg );
		erg = lred2( erg );
		for( ; m > 0; m-- )
			switch( t )
			{       case 5: if(avsch) AVL=lcomp(list2(ev,0),AVL);
					if(!assch)
					{  printf(" %i  ",ev );
					   if( ps )
					   fprintf(datei," %i  ",ev );
					}
					break;
				case 6: if( israt( ev ) )
					{  if(avsch) AVL=lcomp(list2(ev,0),AVL);
					   if(!assch)
					   {  printf(" %r  ",ev );
					      if( ps )
					      fprintf(datei," %r  ",ev );
					   }
					}
					else
					{  if(avsch) AVL=lcomp(list2(ev,1),AVL);
					   if(!assch)
					   {  printf(" %i  ",ev );
					      if( ps )
					      fprintf(datei," %i  ",ev );
					   }
					}
					break;
			}
	   }
	}
	else if( t == 19 )
	{  while( erg != _0 )
	   {	ev = lfirst( erg );
		erg = lred( erg );
		if(avsch) AVL=lcomp(list2(ev,17),AVL);
		if(!assch)
		{  printf(" MOD(%i)  ",ev );
		   if( ps ) fprintf(datei," MOD(%i)  ",ev );
		}
	   }
	}
	else
	{	while( erg != _0 )
		{	ev = lfirst( erg );
			erg = lred( erg );
			if(avsch) AVL=lcomp(list2(ev,31),AVL);
			if(!assch)
			{  if(gfchar==2) 
			   {	putgf2el(p,ev,VGF);
				if(ps) fputgf2el(p,ev,VGF,datei);
			   }
			   else
			   {	putgfsel(ev,VGF);
			   	if(ps)	fputgfsel(ev,VGF,datei);
			   }
			   printf("   ");
			   if( ps ) fprintf(datei,"   ");
			}
		}
	}

	if(!assch)
	{  printf("\n");
	   if( ps )    fprintf(datei,"\n");
	}

	if( L == _0 )
	{ 	if(avsch)
		{	AVL=linv(AVL);
			av_basad(AVL);
		}
		if( t < 7 )   return( list2( 1,0 ) );
		if( t == 19 ) return( list2( 1, 17 ) );
		ev = list2( 0,1 );
		if(gfchar==2) ev=udpm2tosb(ev);
		return( list2( ev, 31 ) );
	}

	if(!assch)
	{    printf(" irreducible factors of degree >= 2 of the characteristic polynomial:\n");
	     if( ps )
	         fprintf(datei,"out: irreducible factors of degree >= 2 of the characteristic polynomial:\n    ");
	}
	if( t!= 33 ) P = 1;
	else 
	{	P = list2( 0,1 );
		if(gfchar==2) P=udpm2tosb(P);
	}
	P = pvinsert( 0, P, 1 );
	if( t < 7 )
	{	while( L != _0 )
		{       ev = lfirst( L );
			m = lsecond( L );
			L = lred2( L );
			if(avsch)
			{	erg=list2(VP,ev);
				AVL=lcomp(list2(erg,2),AVL);
				AVL=lcomp(list2(m,0),AVL);
			}
			if(!assch)
			{  printf( " ( " );
			   if( ps ) fprintf(datei, " ( " );
			   putpi( 1, ev, VP );
			   if( ps ) fputpi( 1, ev, VP, datei );
			   printf( " )" );
			   if( ps ) fprintf(datei, " )" );
			   if( m > 1 )
			   {       printf( "^%i ", m );
				   if( ps ) fprintf(datei, "^%i ", m );
			   }
			   if( L != _0 )
			   {       printf( "* " );
				   if( ps ) fprintf(datei, "* " );
			   }
			}
			ev = piexp( 1, ev, m );
			P = piprod( 1, ev, P );
		}
	}
	else if( t == 19 )
	{	while( L != _0 )
		{       ev = lfirst( L ); 
			L = lred( L ); 
			if(avsch) 
			{	erg=list2(VP,ev);
				AVL=lcomp(list2(erg,18),AVL);
			}
			if(!assch)
			{  printf( " ( " );
			   if( ps ) fprintf(datei, " ( " );
			   putpm( 1, ev, VP );
			   if( ps ) fputpm( 1, ev, VP, datei );
			   printf( " )" );
			   if( ps ) fprintf(datei, " )" );
			   if( L != _0 )
			   {       printf( "* " );
				   if( ps ) fprintf(datei, "* " );
			   }
			}
			if( ssch ) P = pmsprod( 1, p, ev, P );
			else       P = pmiprod( 1, p, ev, P );
		}
	}
	else
	{	while( L != _0 )
		{	ev = lfirst( L );
			L = lred( L );
			if(avsch) 
			{	erg=list2(VP,ev);
				AVL=lcomp(list2(erg,32),AVL);
			}
			if(!assch)
			{  printf( " ( " );
			   if( ps ) fprintf(datei, " ( " );
			   if(gfchar==2)
		 	   {	putpgf2(1,p,ev,VP,VGF);
				if(ps) fputpgf2(1,p,ev,VP,VGF,datei);
			   }
			   else
			   {	putpgfs( 1, ev, VP, VGF );
			   	if(ps) fputpgfs(1,ev,VP,VGF,datei);
			   }
			   printf( " ) " );
			   if( ps ) fprintf(datei, " ) " );
			   if( L != _0 )
			   {	printf("* " );
			        if( ps ) fprintf(datei, "* " );
			   }
			}
			if(gfchar==2) P=pgf2prod(1,p,ev,P);
			else P=pgfsprod(1,gfchar,p,ev,P);
		}
	} 
	if(!assch)
	{  printf("\n\n");
	   if( ps )    fprintf(datei,"\n\n");
	}
	if(avsch)
	{	AVL=linv(AVL);
		av_basad(AVL);
	}

	P = list2( VP,P );
	if( t < 7 ) P = list2( P,2 );
	else if( t == 19 ) P = list2( P, 18 );
	else P = list2( P, 32 );
	return( P );
}
