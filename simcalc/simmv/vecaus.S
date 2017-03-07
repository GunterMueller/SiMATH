/*C
			vecaus( V, ken )

	"vector ausgabe".
	Quellbibliothek: srclib.mout
	Include- Datei: _calc.h
	vecaus( V, ken );  list V; single ken;

	vecaus schreibt den in V enthaltenen Vektor auf stdout und
	auf eine Protokolldatei, falls eine geoeffnet ist. ken ist
	die zugehoerige Kennung des Vektors.
C*/
/*H
	Version  1      24.01.1989      C.Hollinger/U.Schneiders
	Version  2      27.06.1989      C.Hollinger
	Version  3      15.05.1992      U.Schneiders ( M und NF )
	Version  3.1    07.06.1993      S.Schmitt
H*/
/*cS
	vecaus ruft auf: fputgfsel, fputnfel, fputpgfs, fputpi, fputpm, 
			 fputpnf, fputpr, fputr, ispmonom, kenntest, 
			 llength, putgfsel, putnfel, putpgfs, putpi, 
			 putpm, putpnf, putpr, putr
         	  Macros: fprintf, lfirst, lred, lsecond, printf
Sc*/

#include<_calc.h>

vecaus( V, ken )
list V;
single ken;

{
	list w, VL;
	obj el, O, O1;
	single h, h1, kenel, r;
	init( el, O, O1, w, VL );
	bind( V );

	/*** Vektorausgebe erfolgt gemaes dem { el1  el2 ... } ***/

	if( ( ken > 11 && ken < 15 ) || ken == 22 || ken == 29 || ken == 36 )
	{       VL = lfirst( V );
		V = lsecond( V );
	}
	printf("{ ");
	if( ps )        fprintf( datei, "{ " );
	if( ken < 15 ) ken = ken - 10;
	else           ken = ken - 4;

	while( V != _0 )
	{       el = lfirst( V );
		V = lred( V );
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
				{       if( h1 )   fputpi( r,O1,w,datei );
					else
					{       fprintf( datei," ( " );
						fputpi( r,O1,w,datei );
						fprintf( datei," )" );
					}
					fprintf( datei," / " );
					if( h )    fputpi( r,O,w,datei );
					else
					{       fprintf( datei," ( " );
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
				{   	O1=lfirst(varlist[gfsch].varwert);
				    	putgf2el(O1,el,VGF);
			 	    	if(ps)fputgf2el(O1,el,VGF,datei);
				}
				else
				{   	putgfsel(el,VGF);
				    	if(ps) fputgfsel(el,VGF,datei);
				}
				break;
			case 32:w=lfirst(el);
				r=llength(w);
				el=lsecond(el);
				if(gfchar==2)
				{   	O1=lfirst(varlist[gfsch].varwert);
				    	putpgf2(r,O1,el,w,VGF);
				    	if(ps)fputpgf2(r,O1,el,w,VGF,datei);
				}
				else
				{   	putpgfs(r,el,w,VGF);
				    	if(ps) fputpgfs(r,el,w,VGF,datei);
				}
				break;
		}
		if( V != _0 )
		{       printf("   ");
			if( ps ) fprintf( datei, "   " );
		}
	}
	printf(" }");
	if( ps ) fprintf( datei, " }" );
	if(!assch){
	printf("\n");
	if(ps) fprintf( datei,"\n");
	}
}
