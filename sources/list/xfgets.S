/*c
			xfgets ( s, n, pf )

	"file get string, internal version"
	Quellbibliothek: srclib.C_sm
	Include-Datei:   _list.h
	!!! wird nur vom System ueber fgets() benutzt !!!
	char *xfgets( s,n,pf )  char *s; single n; FILE *pf;
	str = xfgets( s,n,pf );
	xfgets() liest von der Datei *pf entweder n-1 Zeichen oder bis
	einschliesslich zum naechsten Zeilenende oder bis Dateiende,
	falls dies vorher eintrifft. Die eingelesenen Zeichen traegt
	xfgets() in den Bereich ein, auf den s zeigt.
	xfgets() schliesst die eingelesene Zeichenreihe mit '\0' ab.

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
   DATE xfgets        : 890501
H*/


# include <_list.h>

char *xfgets( s, n, pf )
char *s;
single n;
FILE *pf;
{
	int c;
	char *str = s;
   /***    zeichenweise einlesen mit neuem getc()    ***/
	while ( --n > 0  &&  (c = getc(pf)) != EOF )
		if ( (*str++ = c) == '\n' )  break;
   /***    Stringende-Zeichen und Rueckmeldung    ***/
	*str = '\0';
	return( (c==EOF && str==s) ? NULL : s );
}
