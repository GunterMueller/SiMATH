/*C
			listaus( L )

	"Listenausgabe".
	listaus(L); list L;
	listaus( L );

	Ist ein spezielles Listenausgabeprogramm, das nur bei der
	Faktorisierung benutzt wird. Die Liste der Primfaktoren
	wird in der Form faktor1^exp1*...*faktorn^expn ausgegeben.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      H.Stroeher/M.Mang
H*/
/*cS
	listaus ruft auf: icomp

		  Macros: fprintf, lfirst, lred, printf
Sc*/
#include <_calc.h>

listaus( L )
list L;

{       /*** Deklarationen und Vorbesetzungen ***/

	single i=1, j=1;
	int A;
	init( A );
	bind( L );

	   /*** L ist leere Liste ***/

	/**   if ( L == _0 ) 
	   {	printf(" ()");
		if( ps ) fprintf( datei, " ()" );
	   } **/

	   if(L==_0)
	   {	printf(" 1");
		if(ps) fprintf( datei, " 1");
	   }

	   /*** L ist ungleich der leeren Liste ***/

	   while( L != _0 ) {
		   if ( L != _0 ) {
			   A = lfirst( L );
			   L = lred( L );
			   i = 1;
		   }
		   while ( L != _0 && icomp( lfirst( L ) , A ) == 0 ) {
			   L = lred( L );
			   ++i;
		   }
		   if ( j == 1 ) {

			   /*** Ausgabe von kleinstem Primteiler und
				zugehoerigem Exponent, falls dieser
				groesser 1 ist ***/

			   if ( i == 1 ) {
				printf(" %i", A );
				if ( ps ) fprintf(datei," %i",A);
			   }
			   else {
				printf(" %i^%d", A, i );
				if ( ps ) fprintf(datei," %i^%d", A, i );
			   }
		   }

		   /*** Ausgabe weiterer Primteiler und zugehoeriger
			Exponenten, falls diese groesser 1 sind ***/

		   else {
			   if ( i == 1 ) {
				printf(" * %i", A );
				if ( ps ) fprintf(datei," * %i",A);
			   }
			   else {
				printf(" * %i^%d", A, i );
				if ( ps ) fprintf(datei," * %i^%d", A, i );
			   }
		   }
		   ++j;
	   }
	   printf("\n");
	   if( ps ) fprintf( datei, "\n" );
}
