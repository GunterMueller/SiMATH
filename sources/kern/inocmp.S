/*C
			inocmp( dk1, dk2 )

	"i-node comparison"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	single inocmp( dk1, dk2 )  single dk1, dk2;
	t = inocmp( dk1, dk2 );
	Die Indexnummern der Dateien mit Dateikennzahl dk1 und dk2
	werden verglichen. Bei Gleichheit ist t=0, andernfalls t=1.
	Laeuft der benutzte C-Systemaufruf fehlerhaft ab, so ist t=-1.
C*/
/*H
	Version  1      25.06.1987      R.Boeffgen
   DATE inocmp        : 890501
H*/


# include <_list.h>

single inocmp( dk1, dk2 )
single dk1, dk2;
{
	single t;
	static struct stat BUF1, BUF2;
    /***    Dateiinformationen ausgeben    ***/
	if ( fstat(dk1,&BUF1) || fstat(dk2,&BUF2) )  {
    /***    Fehler in fstat    ***/
		t = -1;
		errmsgio( "inocmp", "EA100" );
	}
    /***    Indexnummern vergleichen    ***/
	else  t = ( BUF1.st_ino != BUF2.st_ino );
	return( t );
}
