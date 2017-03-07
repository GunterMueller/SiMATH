/*C

			protkopf( )

	"Protokollkopf".
	protkopf();
	protkopf( );
	Produziert den Meldungsblock am Anfang einer Protokolldatei.
	Der include-file <_calc.h> wird benoetigt.

C*/
/*H

	Version  1      02.06.1987      H.Stroeher/M.Mang
	Version  2      10.01.1990      U.Schneiders
					( gctime - ctime )
H*/
 
#include <_calc.h>

protkopf()

{
	int clock;
	char *ctime();
	init( clock );

	clock = time( 0 );
	fprintf( datei, "                  log file of  ");
	fprintf( datei, "%s", ctime(&clock) );
	fprintf( datei, "                  ");
	fprintf( datei,"=====================================\n\n\n");
}
