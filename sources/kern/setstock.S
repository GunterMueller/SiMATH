/*c
			setstock()

	"set STOCK"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	!!! wird nur vom System benutzt !!!
	Der STOCK wird um 125 Elemente erhoeht und eine Meldung ueber
	den neuen STOCK_SZ nach stderr abgesetzt.
	Bei Speicherueberlauf wird das Programm abgebrochen mit einer
	entsprechenden Meldung auf stdout.
c*/
/*H
	Version  1      09.2.87         R. Boeffgen
	Version  2      25.6.87         stdout mit stderr bei kontrol-
					lierter Ausgabe koordiniert.  RB
	Version  3      17.08.1987      gehoert ab jetzt zur srclib.kern.  MAR.
	Version  4      17.12.1987      Erhoehen um 125 statt 100 El.  PS
	Version  5	04.03.1994	STOCK und STOCK_SZ lokal deklariert, 
					da in _list.h ausgeblendet.  PS
   DATE setstock      : 890501.940315
H*/


# include <_list.h>
# undef printf
int *STOCK;     /* no longer declared or referenced (extern) in _list.h */
int STOCK_SZ;   /* no longer declared or referenced (extern) in _list.h */

setstock( )
{
	extern char *malloc(), *realloc();
	char *p;
    /***    STOCK vergroessern    ***/
	if ( ( p=malloc(125*sizeof(int)) )==NULL
	  || ( free(p), ( STOCK = (int*)realloc(STOCK,(STOCK_SZ+125)*sizeof(int)) )==NULL )  )
    /***    Abbruch bei Fehler    ***/
	{
		printf("\n*** Zu grosse Schachtelungstiefe. ***");
		printf("\n*** Abbruch wegen STOCK-Ueberlauf ***\n");
		lend();
		exit(1);
	}
    /***    neuen STOCK_SZ melden    ***/
	STOCK_SZ += 125;
	if ( inocmp( fileno(stdout), fileno(stderr) ) )
		fprintf( stderr, "\n*** STOCK_SZ = %d ***\n", STOCK_SZ );
	else    fprintf( stdout, "\n*** STOCK_SZ = %d ***\n", STOCK_SZ );
}
