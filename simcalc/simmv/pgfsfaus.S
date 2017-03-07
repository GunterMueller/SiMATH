/*C

			pgfsfaus( VL, P, L )

	"Polynomfaktorisierungsausgabe".
	Quellbibliothek: srclib.calc
	Include- Datei: _calc.h
	pgfsfaus( VL, P, L ); list VL; obj P; list L; 
	X = pgfsfaus( VL, P, L );

	Ist ein spezielles Polynomfaktorisierungsausgabeprogramm, das
	nur bei der Faktorisierung des Polynoms P mit Variablenliste VL
	aufgerufen wird. Die Liste L hat folgende Form:
	( c, P1, P2, ..., Pk ), wobei c = cont( P ) und Pi die einzelnen 
	Primfaktoren von P sind.

C*/
/*H

	Version  1      28.07.1993      S.Schmitt

H*/

#include<_calc.h>

pgfsfaus( VL, P, L )
list VL;
obj P;
list L;
{
	single r, exp, sch, s;
	obj c, M;
	list AVL;	
	init( c, M, AVL );
	bind( VL, P, L );

	sch = 0;
	r = llength( VL );

	if(!assch){
	printf( " factorization of " );
	if( ps ) fprintf(datei, "out: factorization of " );
	putpgfs(r,P,VL,VGF);
	if(ps) fputpgfs(r,P,VL,VGF,datei);
	printf(":\n");
	if(ps) fprintf(datei, ":\n");
	}

	c = lfirst( L );
	L = lred( L );
	if( avsch )	AVL = list1( list2(c,31) );

	if(!assch){
	printf(" ");
	if(ps) fprintf(datei, "out: ");
	M=list2(0,1);
	if( !oequal( c, M ) )
	{	 putgfsel(c,VGF);
		 if(ps)	fputgfsel(c,VGF,datei);
		 printf(" * ");
		 if( ps ) fprintf(datei, " * " );
	}
	else sch++;
	}

	s = 0;
	while( L != _0 )
	{       P = lfirst( L );
		if( !s && oequal( L, P ) ) sch++;
		L = lred( L );
		s = 1;
		exp = 1;
		if( L != _0 ) M = lfirst( L );
		while( L != _0 && oequal( M,P) )
		{	exp++;
			L = lred( L );
			if( L != _0 ) M = lfirst( L );
		}
		if(!assch)
		{
		if( llength( P ) > 2 && sch != 2 )
		{       printf( "( " );
			if( ps ) fprintf(datei, "( " );
		}
		putpgfs( r, P, VL, VGF );
		if( ps ) fputpgfs( r, P, VL, VGF, datei );
		if( llength( P ) > 2 && sch != 2 )
		{       printf( " )" );
			if( ps ) fprintf(datei, " )" );
		}
		if( exp > 1 )
		{       printf( "^%i", exp );
			if( ps ) fprintf(datei, "^%i", exp );
		}
		if( L != _0 )
		{       printf( " * " );
			if( ps ) fprintf(datei, " * " );
		}
		}
		if( avsch )
		{	c = list2( VL, P );
			AVL = lcomp( list2(c,32), AVL );
			AVL = lcomp( list2(exp,0), AVL );
		}
	}
	if(!assch){
	printf( "\n" );
	if( ps ) fprintf(datei, "\n" );
	}
	if( avsch )
	{	AVL = linv( AVL );
		av_basad(AVL);
	}
	return(P);
}

