/*C
			factmsg( Z, L, k, m )

	"factorization message".
	factmsg(Z,L,k,m); int Z; list L; single k,m;
	factmsg( Z, L, k, m );

	Produziert die entsprechende Ausgabe bei der Faktorisierung
	von ganzen oder rationalen Zahlen.
	Z ist die zu faktorisierende Zahl, L die Liste der Primfaktoren,
	k ein Schalter zur Unterscheidung der verschiedenen Typen und
	m ein Schalter fuer positives oder negatives Vorzeichen der Zahl.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      28.04.1987      M.Mang
H*/
/*cS
	factmsg ruft auf: listaus

		  Macros: fprintf, printf
Sc*/

#include <_calc.h>

factmsg(Z,L,k,m)
int Z;
single k,m;
list L;
{
	bind( Z, L );

	switch(k){
	case 0 :  break;

	/*** Meldung bei Faktorisierung ganzer Zahlen ***/

	case 1 :  printf( " factorization of %i: ", Z );
		  if ( m == -1 ) printf("-");
		  if ( ps ) {
		    fprintf( datei, "out: factorization of %i: ", Z );
		    if ( m == -1 ) fprintf( datei, "-" );
		  }
		  break;

	/*** Meldung bei Faktorisierung von Elementen aus Q\Z ***/

	case 2 :  printf(" factorization of %r:\n",Z);
		  printf(" numerator: ");
		  if ( m ==  -1 ) printf("-");
		  if ( ps ) {
		    fprintf( datei, "out: factorization of %r:\n", Z );
		    fprintf( datei, "out: numerator: ");
		    if ( m == -1 ) fprintf( datei, "-" );
		  }
		  break;
	case 3 :  printf(" denominator: ");
		  if ( ps ) fprintf( datei, "out: denominator: ");
		  break;
	}
	listaus(L);
}
