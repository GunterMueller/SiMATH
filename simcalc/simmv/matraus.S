/*C
			matraus( M, ken, l )

	"matrix ausgabe".
	Quellbibliothek: srclib.mout
	Include- Datei: _calc.h
	matraus( M, ken, l );  list M; single ken, l;

	matraus schreibt die in M enthaltene Matrix auf stdout und
	auf eine Protokolldatei, falls eine geoeffnet ist. ken ist
	die zugehoerige Kennung der Matrix, und l gibt die Anzahl der
	Blanks an, um die die Ausgabe eingerueckt werden soll.
C*/
/*H
	Version  1      03.10.1988      C.Hollinger/U.Schneiders
	Version  2      27.06.1989      C.Hollinger
	Version  3      20.09.1988      C.Hollinger/U.Schneiders
					( zusaetzl. { } um Matrix )
	Version  4      15.05.1992      U.Schneiders ( M und NF )
	Version  4.1    07.06.1993      S.Schmitt
H*/

#include<_calc.h>

matraus( M, ken, l )
list M;
single ken, l;

{
	list w, Z, VL;
	obj el, O, O1;
	single h, h1, kenel, r;
	init( w, Z, el, O, O1, VL );
	bind( M );

	if( ( ken > 6 && ken < 10 ) || ken == 20 || ken == 27 || ken == 34 )
	{       VL = lfirst( M );
		M = lsecond( M );
	}
	else if(ken==19 && lfirst(varlist[modsch].varwert)==2) M=mam2tomams(M);

	printf("{ ");
	if( ps ) fprintf( datei, "{ " );
	l = l + 14;
	if( ken < 10 ) ken = ken - 5;
	else           ken = ken - 2;

	while( M != _0 )
	{       Z = lfirst( M );
		M = lred( M );
		printf("{ ");
		if( ps ) fprintf( datei, "{ " );
		while( Z != _0 )
		{       el = lfirst( Z );
			Z = lred( Z );
			if( ( ken > 1 && ken < 5 ) || ken == 18 || ken == 25 || ken == 32 )  el = list2( VL, el );
			el = list2( el, ken );
			el = kenntest( el );
			kenel = lsecond( el );
			el = lfirst( el );
			switch( kenel )
 			{	case 0: printf( "%i", el );
					if ( ps )
					fprintf( datei, "%i", el );
					break;
			        case 17:printf( "MOD(%i)", el );
					if ( ps )
					fprintf( datei, "MOD(%i)", el );
					break;
				case 1: putr( el );
					if ( ps )
					fputr( el, datei );
					break;
				case 2: w = lfirst( el );
					r = llength( w );
					O = lsecond( el );
					putpi( r, O, w );
					if ( ps )
					fputpi( r, O, w , datei );
					break;
				case 18:w = lfirst( el );
					r = llength( w );
					O = lsecond( el );
					putpm( r, O, w );
					if ( ps )
					fputpm( r, O, w , datei );
					break;
				case 3: w = lfirst( el );
					r = llength( w );
					O = lsecond( el );
					putpr( r, O, w );
					if ( ps )
					fputpr( r, O, w, datei );
					break;
				case 4: w = lfirst( el );
					r = llength( w );
					O = lsecond( el );
					O1 = lfirst( O );
					O = lsecond( O );
					h1 = ispmonom( r,O1 );
					h = ispmonom( r,O );
					if( h1 )   putpi( r,O1,w );
					else
					{       printf(" ( " );
						putpi( r,O1,w );
						printf(" )" );
					}
					printf(" / " );
					if( h )   putpi( r,O,w );
					else
					{       printf(" ( " );
						putpi( r,O,w );
						printf(" )" );
					}
					if( ps )
					{   if( h1 )   fputpi( r,O1,w,datei );
					    else
					    {   fprintf( datei," ( " );
						fputpi( r,O1,w,datei );
						fprintf( datei," )" );
					    }
					    fprintf( datei," / " );
					    if( h )    fputpi( r,O,w,datei );
					    else
					    {   fprintf( datei," ( " );
						fputpi( r,O,w,datei );
						fprintf( datei," )" );
					    }
					}
					break;
				case 24:O1 = lfirst( varlist[nfsch].varwert );
					putnfel( O1, el, VNF );
					if( ps  )
						fputnfel( O1, el, VNF, datei );
					break;
				case 25:O1 = lfirst( varlist[nfsch].varwert );
					w = lfirst( el );
					r = llength( w );
					el = lsecond( el );
					putpnf( r, O1, el, w, VNF );
					if( ps  )
						fputpnf( r, O1, el, w, VNF, datei );
					break;
				case 31:if(gfchar==2)
					{   O1=lfirst(varlist[gfsch].varwert);
					    putgf2el(O1,el,VGF);
			 		    if(ps)fputgf2el(O1,el,VGF,datei);
					}
					else
					{   putgfsel(el,VGF);
					    if(ps) fputgfsel(el,VGF,datei);
					}
					break;
				case 32:w=lfirst(el);
					r=llength(w);
					el=lsecond(el);
					if(gfchar==2)
					{   O1=lfirst(varlist[gfsch].varwert);
				            putpgf2(r,O1,el,w,VGF);
				            if(ps)fputpgf2(r,O1,el,w,VGF,datei);
					}
					else
					{   putpgfs(r,el,w,VGF);
					    if(ps) fputpgfs(r,el,w,VGF,datei);
					}
					break;
			}
			if( Z != _0 )
			{       printf("   ");
				if( ps ) fprintf( datei, "   " );
			}
		}
		if( M != _0 )
		{       printf(" }" );
			if( ps ) fprintf( datei, " }");
			if(!assch){
			printf("\n%t",l);
			if(ps) fprintf( datei,"\n%t",l-3);
			}
		}
		else 
		{       printf(" } }");
			if( ps ) fprintf( datei, " } }" );
			if(!assch){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
		}
	}
}
