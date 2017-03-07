/*C
			setstack( anz )

	"set STACK"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	setstack( anz )  single anz;
	Falls der STACK weniger als anz Elemente hat, so wird er auf
	anz Elemente erhoeht; andernfalls zeigt setstack( anz ) keine
	Wirkung. Eine Meldung ueber den neuen ST_SIZE wird nach stderr
	abgesetzt. Bei Speicherueberlauf wird das Programm abgebrochen
	mit einer entsprechenden Meldung auf stdout.
C*/
/*H
	Version  1      09.02.1987      R. Boeffgen
	Version  2      25.06.1987      stdout mit stderr bei kontrol-
					lierter Ausgabe koordiniert.  RB
	Version  3      17.08.1987      gehoert ab jetzt zur srclib.kern.  MAR
	Version  4      11.11.1987      Parameter n eingefuehrt.  RB
	Version  5	21.12.1992	englische Meldungen.  PS
   DATE setstack      : 890501.930115.961201
H*/


# include <_list.h>
# undef printf

setstack( n )
single n;
{
	extern char *malloc(), *realloc();
	char *p;

	if ( ST_SIZE < n )  {
    /***    STACK vergroessern    ***/
	    if ( ( p=malloc( (n-ST_SIZE)*sizeof(int*) ) )==NULL
	      || ( free(p), ( STACK = (int**)realloc(STACK,n*sizeof(int*)) )==NULL )  )
    /***    Abbruch bei Fehler    ***/
	    {
		    printf("\n*** not enough memory ***");
		    printf("\n*** STACK overflow ***\n");
		    lend();
		    exit(1);
	    }
    /***    neuen ST_SIZE melden    ***/
	    ST_SIZE = n;
	    if(!SS_MESS)
	    {	if ( inocmp( fileno(stdout), fileno(stderr) ) )
		        fprintf( stderr, "\n*** ST_SIZE = %d ***\n", ST_SIZE );
	    	else    fprintf( stdout, "\n*** ST_SIZE = %d ***\n", ST_SIZE );
	    }
	}
}
