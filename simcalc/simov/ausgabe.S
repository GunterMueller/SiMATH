/*C
			ausgabe ( string, name, wert, sch )

	"Ausgabe".
	char *string, *name; list wert; single sch;
	ausgabe( string, name, wert, sch );

	ausgabe schreibt das Ergebnis "wert" einer Berechnung auf stdout
	und auf eine Protokolldatei, falls eine geoeffnet ist.
	"name" existiert dabei nur, falls eine Variablenzuweisung erfolgte.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1.1    12.05.1987      H.Stroeher/M.Mang
	Version  1.2    03.10.1988      C.Hollinger/U.Schneiders
	Version  1.3    24.01.1989      C.Hollinger/U.Schneiders
	Version  1.4    07.03.1990      U.Schneiders
	Version  1.5    02.11.1990      U.Schneiders  ( ell. Kurven )
	Version  1.6    14.01.1992      U.Schneiders  ( Reelle Zahlen )
	Version  1.7    30.04.1992      U.Schneiders  ( mod, nf )
	Version  1.8    30.03.1993      S.Schmitt/U.Schneiders
	Version  1.9    07.06.1993	S.Schmitt/U.Schneiders
	Version  2	03.02.1994	S.Schmitt/U.Schneiders
	Version  2.1	24.01.1995	S.Schmitt/U.Schneiders
	Version  2.2	10.07.1996	S.Schmitt (ecqnfsch neu)
H*/

#include <_calc.h>

ausgabe ( string, name, wert, sch )
char *string, *name;
list wert;
single sch;

{
     single ken, r, h1, h2, l;
     obj O, O1, O2 , O3,  w;
     bind( wert );
     init( O, O1, O2, O3,  w );

     ken = lsecond( wert );
     wert = lfirst( wert );

     if(assch<2){
     if ( !sch )
     {  printf( "%t %s = ",8, name );
	if ( ps )
	fprintf( datei, "out: %s = ", name );
     }
     else
     {  h1 = strlen( name ) + 5;
/*	if(!schleife) printf("\n"); */
	printf( "%t %s = ", 4, name );
	puts(string);
	printf( "\n%t = ", h1 );
	if ( ps )
	{
		fprintf ( datei, "out: %s = ", name );
		fputs( string, datei );
		fprintf( datei, "\n%t = ", h1+1 );
	}
     }
     }
	/*** Ausgabe auf stdout und Protokolldatei, falls angelegt,
	     mit eventueller Variablenzuweisung ***/

	switch( ken )
	{	case 0:
	        case 16:puti( wert );
			if( ps )    fputi( wert, datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 1: putr( wert );
			if ( ps ) fputr( wert, datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 2: w = lfirst( wert );
			r = llength( w );
			O = lsecond( wert );
			putpi( r, O, w );
			if ( ps ) fputpi( r, O, w , datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 3: w = lfirst( wert );
			r = llength( w );
			O = lsecond( wert );
			putpr( r, O, w ); 
			if ( ps ) fputpr( r, O, w, datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 4: w = lfirst( wert );
			r = llength( w );
			O = lsecond( wert );
			O1 = lfirst( O );
			h1 = ispmonom( r, O1 );
			O2 = lsecond( O );
			h2 = ispmonom( r, O2 );
			if( h1 )  putpi( r, O1, w );
			else
			{       printf( "( " );
				putpi( r, O1, w );
				printf( " )" );
			}
			printf(" / ");
			if( h2 )  putpi( r, O2, w );
			else
			{       printf( "( " );
				putpi( r, O2, w );
				printf( " )" );
			}
			if( ps )
			{        if( h1 )  fputpi( r, O1, w,datei );
				 else
				 {       fprintf( datei, "( " );
					 fputpi( r, O1, w, datei );
					 fprintf( datei, " )" );
				 }
				 fprintf( datei," / ");
				 if( h2 )  fputpi( r, O2, w,datei );
				 else
				 {       fprintf( datei, "( " );
					 fputpi( r, O2, w, datei );
					 fprintf( datei, " )" );
				 }
			}
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		case 19:
		case 20:
		case 26:
		case 27:
		case 33:
		case 34:l = strlen( name );
			if( sch )  l = l - 4;
			matraus( wert, ken, l );
			break;
		case 10:
		case 11:
		case 12:
		case 13:
		case 14:
		case 21:
		case 22:
		case 28:
		case 29: 
		case 35:
		case 36: vecaus( wert, ken );
			 break;
		case 15: if(!OUTPUTDIG) putfl( wert, -DIGITS );
/***** RAUS ****
			 else yputflfx(wert, 1, OUTPUTDIG );
*****************/
			 else putflfx(wert, 1, OUTPUTDIG );
			 if( ps )
			 {      if(!OUTPUTDIG) fputfl( wert, -DIGITS, datei );
				else fputflfx(wert, 1, OUTPUTDIG,datei);
			 }
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case 37: if(!OUTPUTDIG) putcomp( wert, -DIGITS );
			 else putcompfx(wert,1,OUTPUTDIG);
			 if( ps )
			 {	if(!OUTPUTDIG) fputcomp( wert, -DIGITS, datei );
				else fputcompfx(wert,1,OUTPUTDIG,datei);
			 }
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case 38:w = lfirst( wert );
			r = llength( w );
			O = lsecond( wert );
			putpfl( r, O, w );
			if ( ps ) fputpfl( r, O, w , datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 39:w = lfirst( wert );
			r = llength( w );
			O = lsecond( wert );
			putpc( r, O, w );
			if ( ps ) fputpc( r, O, w , datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
	        case 17:printf( "MOD(%i)", wert );
			if( ps )    fprintf( datei, "MOD(%i)", wert );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 18:w = lfirst( wert );
			r = llength( w );
			O = lsecond( wert );
			putpm( r, O, w ); 
			if ( ps ) fputpm( r, O, w , datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 23:wert = dptop( 1, wert );
			putpi( 1, wert, VNF ); 
			if ( ps ) fputpi( 1, wert, VNF , datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 24:O1 = lfirst( varlist[nfsch].varwert );
			putnfel( O1, wert, VNF ); 
			if( ps  ) fputnfel( O1, wert, VNF, datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 25:O1 = lfirst( varlist[nfsch].varwert );
			w = lfirst( wert );
			r = llength( w );
			wert = lsecond( wert );
			putpnf( r, O1, wert, w, VNF ); 
			if( ps  )fputpnf( r, O1, wert, w, VNF, datei );
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case 30: if(gfchar==2)
			 {	wert=sbtoudpm2(wert);	
				wert=dptop(1,wert);
			 }
			 else wert=lfirst(wert);
			 putpi(1,wert,VGF);
			 if(ps) fputpi(1,wert,VGF,datei);
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case 31: if(gfchar==2)
			 {	O1=lfirst(varlist[gfsch].varwert);
				putgf2el(O1,wert,VGF);
			 	if(ps)	fputgf2el(O1,wert,VGF,datei);
			 }
			 else
			 {	putgfsel(wert,VGF);
			 	if(ps)	fputgfsel(wert,VGF,datei);
			 }
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case 32: w=lfirst(wert);
			 r=llength(w);
			 wert=lsecond(wert);
			 if(gfchar==2)
			 {	O1=lfirst(varlist[gfsch].varwert);
				putpgf2(r,O1,wert,w,VGF);
				if(ps)	fputpgf2(r,O1,wert,w,VGF,datei);
			}
			else
			{	putpgfs(r,wert,w,VGF);
				if(ps)	fputpgfs(r,wert,w,VGF,datei);
			}
			if(assch<2){
			printf("\n");
			if(ps) fprintf(datei,"\n");
			}
			break;
		case -1:
		case -2: printf( "EC(" );
			 if( ps ) fprintf( datei, "EC(" );
			 wert=lfirst(wert);
			 wert=lfirst(wert);
			 if(ken == (-1))  wert = lred3(wert);		
			 while(wert != _0)
			 {	w=lfirst(wert);
				wert = lred(wert);
				putr(w);
				if(wert != _0) printf(", ");
				if(ps)
				{	fputr(w, datei);
					if(wert!=_0) fprintf(datei,", ");
				}
			 }
			 printf(")");
			 if(ps) fprintf( datei, ")");
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case -3: if(!lthird(wert))
			 {	printf("O");
				if(ps) fprintf(datei,"O");
				if(assch<2){
				printf("\n");
				if(ps) fprintf(datei,"\n");
				}
				break;
			 }
			 printf("PT(");
			 if(ps) fprintf(datei,"PT(");
			 O1=lfirst(wert);
			 O2=lsecond(wert);
			 O=lthird(wert);
			 wert=iprod(O,O);
			 O1=rcons(O1,wert);
			 wert=iprod(O,wert);
			 O2=rcons(O2,wert);
			 putr(O1);
			 printf(", ");
			 putr(O2);
			 printf(")");
			 if(ps)
			 {	fputr(O1,datei);
				fprintf(datei,", ");
	  			fputr(O2,datei);
				fprintf(datei,")");
			 }
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case -4: if( !lthird(wert) )
			 {      printf( "PT(0, 1, 0)" );
				if( ps ) fprintf( datei, "PT(0, 1, 0)" );
				if(assch<2){
				printf("\n");
				if(ps) fprintf(datei,"\n");
				}
				break;
			 }
			 printf( "PT(" );
			 if( ps ) fprintf( datei, "PT(" );
			 O1=lfirst(wert);
			 O2=lsecond(wert);
			 O=lthird(wert);
			 wert = iprod(O,O);
			 O1=rcons(O1,wert);	/** x/z^2 **/
			 wert=iprod(wert,O);
			 O2=rcons(O2,wert);	/** y/z^3 **/
			 wert = rden(O1);
			 O = rden(O2);
			 O = ilcm(wert,O);
			 O = itor(O);
			 O1 = rprod(O,O1);
			 O2 = rprod(O,O2);
			 O = rnum(O);
			 O1 = rnum(O1);
			 O2 = rnum(O2);
			 puti(O1);
			 printf(", ");
			 puti(O2);
			 printf(", ");
			 puti(O);
			 printf(")");
			 if(ps)
			 {	fputi(O1,datei);
				fprintf(datei,", ");
				fputi(O2,datei);
				fprintf(datei,", ");
				fputi(O,datei);
				fprintf(datei,")");
			 }
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case -5:
		case -6: printf( "EC(" );
			 if( ps ) fprintf( datei, "EC(" );
			 while( wert != _0 )
			 {      w = lfirst( wert );
				wert = lred( wert );
				printf( "MOD(%i)", w );
				if( wert != _0 ) printf( ", " );
				if( ps )
				{       fprintf( datei, "MOD(%i)", w );
					if( wert != _0 ) fprintf( datei, ", " );
				}
			 }
			 printf( ")" );
			 if( ps ) fprintf( datei, ")" );
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case -7:
		case -8: if( !wert )
			 {      printf( "MOD(O)" );
				if( ps ) fprintf( datei, "MOD(O)" );
				if(assch<2){
				printf("\n");
				if(ps) fprintf(datei,"\n");
				}
				break;
			 }
			 printf( "PT(" );
			 if( ps ) fprintf( datei, "PT(" );
			 while( wert != _0 )
			 {      w = lfirst( wert );
				wert = lred( wert );
				printf( "MOD(%i)", w );
				if( wert != _0 ) printf( ", " );
				if( ps )
				{       fprintf( datei, "MOD(%i)", w );
					if( wert != _0 ) fprintf( datei, ", " );
				}
			 }
			 printf( ")" );
			 if( ps ) fprintf( datei, ")" );
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case -9:
		case -10:O1 = lfirst( varlist[nfsch].varwert ); 
			 if(ecqnfsch!=_0)
			 { 	if(llength(ecqnfsch)!=1) wert=qnftonf(wert,ken);
				else
				{	wert = lfirst(wert);
					wert = lfirst(wert);
					if(ken == (-9)) wert = lred3(wert);
				}
			 }
			 printf( "EC(" );
			 if( ps ) fprintf( datei, "EC(" );
			 while( wert != _0 )
			 {      w = lfirst( wert );
				wert = lred( wert );
				w=kenntest(list2(w,24));
				O2 = lsecond(w);
				w=lfirst(w);
				if(O2==24) putnfel( O1,w, VNF );
			   	else if(O2==1) putr(w);
				else puti(w);
				if( wert != _0 ) printf( ", " );
				if( ps )
				{       if(O2==24) fputnfel( O1, w, VNF, datei );
				        else if(O2==1) fputr(w,datei);
					else fputi(w,datei);
					if( wert != _0 ) fprintf( datei, ", " );
				}
			 }
			 printf( ")" );
			 if( ps ) fprintf( datei, ")" );
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case -11:
		case -12:if( !wert )
			 {      printf( "NF(O)" );
				if( ps ) fprintf( datei, "NF(O)" );
				if(assch<2){
				printf("\n");
				if(ps) fprintf(datei,"\n");
				}
				break;
			 }
		         O1 = lfirst( varlist[nfsch].varwert );
			 printf( "PT(" );
			 if( ps ) fprintf( datei, "PT(" );
			 while( wert != _0 )
			 {      w = lfirst( wert );
				wert = lred( wert );
				w=kenntest(list2(w,24));
				O2=lsecond(w);
				w=lfirst(w);
				if(O2==24) putnfel( O1, w, VNF );
				else if(O2==1) putr(w);
				else puti(w);
				if( wert != _0 ) printf( ", " );
				if( ps )
				{       if(O2==24) fputnfel( O1, w, VNF, datei );
					else if(O2==1) fputr(w,datei);
					else fputi(w,datei);
					if( wert != _0 ) fprintf( datei, ", " );
				}
			 }
			 printf( ")" );
			 if( ps ) fprintf( datei, ")" );
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case -14:O1 = lfirst( varlist[gfsch].varwert ); 
			 printf( "EC(" );
			 if( ps ) fprintf( datei, "EC(" );
			 while( wert != _0 )
			 {      w = lfirst( wert );
				wert = lred( wert );
				putgf2el( O1,w, VGF );
				if( wert != _0 ) printf( ", " );
				if( ps )
				{       fputgf2el( O1, w, VGF, datei );
					if( wert != _0 ) fprintf( datei, ", " );
				}
			 }
			 printf( ")" );
			 if( ps ) fprintf( datei, ")" );
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
		case -15:
		case -16:if( !wert )
			 {      printf( "GF(O)" );
				if( ps ) fprintf( datei, "GF(O)" );
				if(assch<2){
				printf("\n");
				if(ps) fprintf(datei,"\n");
				}
				break;
			 }
		         O1 = lfirst( varlist[gfsch].varwert );
			 printf( "PT(" );
			 if( ps ) fprintf( datei, "PT(" );
			 while( wert != _0 )
			 {      w = lfirst( wert );
				wert = lred( wert );
				putgf2el( O1, w, VGF );
				if( wert != _0 ) printf( ", " );
				if( ps )
				{       fputgf2el( O1, w, VGF, datei );
					if( wert != _0 ) fprintf( datei, ", " );
				}
			 }
			 printf( ")" );
			 if( ps ) fprintf( datei, ")" );
			 if(assch<2){
			 printf("\n");
			 if(ps) fprintf(datei,"\n");
			 }
			 break;
	}
	if( ps && sch && ( ken < 5 || ken == 15 ) && assch<2 ) fprintf( datei, "\n" );
	if( sch && !schleife ) printf( "\n" );
}
