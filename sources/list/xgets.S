/*c
			xgets ( s )

	"get string, internal version"
	Quellbibliothek: srclib.C_sm
	Include-Datei:   _list.h
	!!! wird nur vom System ueber gets() benutzt !!!
	char *xgets( s )  char *s;
	str = xgets( s );
	xgets() liest von der Standardeingabe Zeichen bis zum Zeilen-
	ende und speichert die gelesene Zeichenreihe in s. Das Zeilen-
	ende wird ersetzt durch das Nullbyte '\0'.

	Bei Auftreten des Entwertungszeichens \ wird dieses sowie das
	nachfolgende Zeichen ignoriert. Soll \ als signifikantes
	Zeichen interpretiert werden, so muss es doppelt eingegeben
	werden: \\
	Falls die Eingabe nicht vom Bildschirm erfolgt, wird der
	linke Rand (MARGIN) ueberlesen.

	str ist der Zeiger auf das erste eingelesene Zeichen.
	Bei Fehler oder Dateiende ist str der Nullzeiger. Dabei wird
	keine Fehlermeldung ausgegeben.
c*/
/*H
	Version 1       07.09.87        R. Boeffgen
	Version 2       08.10.1987      Programm korrigiert. MAR.
   DATE xgets         : 890501
H*/


# include <_list.h>

char *xgets( s )
char *s;
{
	int c;
	char *str = s;
   /***    zeichenweise einlesen mit neuem getc()    ***/
	while ( (c = getc(stdin)) != EOF )
		if ( (*str = c) == '\n' )  break;
		else  str++;
   /***    Stringende-Zeichen und Rueckmeldung    ***/
	*str = '\0';
	return( (c==EOF && str==s) ? NULL : s );
}
