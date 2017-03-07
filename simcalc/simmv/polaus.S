/*C
			polaus( VL, L, P, ken, p )

	"Polynomlistenausgabe".
	polaus(VL,L,P,ken,p); list VL,L; pol P; single ken,p;

	Ist ein spezielles Polynomlistenausgabeprogramm, das nur bei
	der Faktorisierung benutzt wird. Die Liste der Primfaktoren
	wird in der Form c * faktor1^exp1*...*faktorn^expn ausgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      11.05.1988      C.Hollinger/U.Schneiders
	Version  2      04.12.1989      U.Schneiders
	Version  3      03.02.1991      U.Schneiders
	Version  4      11.03.1993      S.Schmitt/U.Schneiders
H*/

#include<_calc.h>

polaus( VL, L, P, ken, p )
list VL, L;
pol P;
single ken, p;

{       single exp, m, r, sch, test;
	int c;
	pol Q, R;
	list AVL;
	bind( VL, L, P );
	init( c, Q, R, AVL );

	r = llength( VL );
	
	if(!assch){
	printf( " factorization of " );
	if( ps ) fprintf(datei, "out: factorization of " );
	if( ken == 2 )
	{       putpi( r, P, VL );
		printf(" modulo ");
		printf("%i",p);
		printf( ":\n" );
		printf("      ");
		if( ps )
		{       fputpi( r, P, VL, datei );
			fprintf(datei," modulo ");
			fprintf(datei,"%i",p);
			fprintf(datei, ":\n" );
			fprintf(datei,"      ");
		}
	}
	else if( ken==3 )
	{       putpr( r, P, VL );
		printf(" modulo ");
		printf("%i",p);
		printf( ":\n" );
		printf("      ");
		if( ps )
		{       fputpr( r, P, VL, datei );
			fprintf(datei," modulo ");
			fprintf(datei,"%i",p);
			fprintf(datei, ":\n" );
			fprintf(datei,"      ");
		}
	}
        else        
        {  	putpm(r,P,VL);
		printf( ":\n" );
		printf("      ");
		if(ps)
		{	fputpm(r,P,VL,datei);
			fprintf(datei, ":\n" );
			fprintf(datei,"      ");
		}
	}
	}

	/*** L wurde mit upmicfact berechnet, wobei an L der  ***/
	/*** der fuehrende Koeffizient vorne angehaengt wurde ***/

	c = lfirst( L );
	L = lred( L );
	if( avsch )
	{	if( ken==2 || ken==3 ) AVL = list1( list2(c,0) );
		else	AVL = list1( list2(c,17) );
	}
	if( icomp( c, 1 ) && !assch )
	{       if(ken!=18)
                { 	printf( " %i", c );
			if( ps ) fprintf(datei, "out: %i", c );
		}
		else
		{	printf(" MOD(%i)",c);
			if(ps)  fprintf(datei," out: MOD(%i)",c);
		}
		if( L != _0 )
		{       printf( " * " );
			if( ps )  fprintf( datei, " * " );
		}
		else
		{       printf( "\n" );
			if( ps ) fprintf( datei, "\n" );
			L=list2(c,0);
			if( avsch ) av_basad( AVL );
			return( L );
		}
	}
	else if( L != _0 && !assch )   /*  c == 1 */
	{       printf( " " );
		if( ps ) fprintf(datei, "out: " );
	}
	else if( L == _0 )                /*  c == 1 */
	{       if(!assch){
		printf( " 1\n" );
		if( ps )  fprintf( datei, "out: 1\n" );
		}
		L=list2(c,0);
		if( avsch ) av_basad( AVL );
		return( L );
	}

	P = lfirst( L );
	L = lred( L );
	exp = 1;
	sch = 0;
	while( L != _0 )
	{       Q = lfirst( L );
		L = lred( L );
		test = oequal( P, Q );
		while( test )
		{       exp++;
			if( L != _0 )
			{       Q = lfirst( L );
				L = lred( L );
				test = oequal( P, Q );
			}
			else break;
		}
		if( test ) break;
		else if(!assch)
		{       m = ispmonom( r, P );
			if( !m )
			{       printf( "( " );
				if( ps ) fprintf(datei, "( " );
			}
                        if(ken!=18)
			{	putpi( r, P, VL );
				if( ps ) fputpi( r, P, VL, datei );
			}
			else
 			{	putpm(r,P,VL);
				if(ps) fputpm(r,P,VL,datei);
			}
			if( !m )
			{       printf( " )" );
				if( ps ) fprintf(datei, " )" );
			}
			if( exp > 1 )
			{       printf( "^%i", exp );
				if( ps ) fprintf(datei, "^%i", exp );
			}
			printf( " * " );
			if( ps ) fprintf(datei, " * " );
		}
		if( avsch )
		{	R = list2( VL, P );
			if( ken==2 || ken==3 ) AVL = lcomp( list2(R,2), AVL );
			else AVL = lcomp( list2( R,18), AVL );
			AVL = lcomp( list2( exp,0), AVL );
		}
		P = Q;
		exp = 1;
		sch = 1;
	}

	if(!assch){
	if( icomp( c, 1 ) || exp > 1 || sch )
	{       m = ispmonom( r, P );
		if( !m )
		{       printf( "( " );
			if( ps ) fprintf(datei, "( " );
		}
	}
	if(ken!=18)
	{ 	putpi( r, P, VL );
		if( ps ) fputpi( r, P, VL, datei );
	}
	else
	{	putpm(r,P,VL);
		if(ps) fputpm(r,P,VL,datei);
	}
	if( icomp( c, 1 ) || exp > 1 || sch )
	{       if( !m )
		{       printf( " )" );
			if( ps ) fprintf(datei, " )" );
		}
	}
	if( exp > 1 )
	{       printf( "^%i", exp );
		if( ps ) fprintf(datei, "^%i", exp );
	}
	printf("\n");
	if( ps ) fprintf(datei, "\n" );
	}
	if( avsch )
	{	R = list2( VL, P );
		if( ken==2 || ken==3 ) AVL = lcomp( list2(R,2), AVL );
		else AVL = lcomp( list2( R,18), AVL );
		AVL = lcomp( list2( exp,0), AVL );

		AVL = linv( AVL );
		av_basad(AVL);
	}	
	return( P );
}
