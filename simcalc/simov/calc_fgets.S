/*S
			calc_fgets ( s, n, pf )

	"calculator file get string"
	Quellbibliothek: srclib.mout
	Include-Datei:   _list.h
	char *calc_fgets( s,n,pf )  char *s; single n; FILE *pf;
	str = calc_fgets( s,n,pf );
	calc_fgets() liest von der Datei *pf entweder n-1 Zeichen oder bis
	ausschliesslich zum naechsten Zeilenende oder bis Dateiende,
	falls dies vorher eintrifft. Die eingelesenen Zeichen traegt
	calc_fgets() in den Bereich ein, auf den s zeigt.
	calc_fgets() schliesst die eingelesene Zeichenreihe mit '\0' ab.

	Bei Auftreten des Entwertungszeichens \ wird dieses sowie das
	nachfolgende Zeichen ignoriert. Soll \ als signifikantes
	Zeichen interpretiert werden, so muss es doppelt eingegeben
	werden: \\

	str ist der Zeiger auf das erste eingelesene Zeichen.
	Bei Fehler oder Dateiende ist str der Nullzeiger. Dabei wird
	keine Fehlermeldung ausgegeben.
C*/
/*H
	Version 1       14.09.1990      U.Schneiders
	Version 1.1     15.05.1991      U.Schneiders  ( nicht mehr als
					1024 Zeichen lesen fuer AS- Version )
H*/
/*cS
	calc_fgets ruft auf: xfgetc
Sc*/

# include <_calc.h>

char *calc_fgets( s, n, pf )
char *s;
single n;
FILE *pf;
{
	single z=0;
	single c;
	char *str = s;
   /***    zeichenweise einlesen mit Calculator- internem xfgetc()    ***/
	while ( --n > 0  &&  (c = xfgetc(pf)) != EOF )
	{
		if ( (*str++ = c) == '\n' )  break;
		z++;
		if(z>(MAXL-1))
		{	ungetc(c,pf);
			break;
		}
	}

   /***    Stringende-Zeichen und Rueckmeldung    ***/
	if( c != EOF ) str--;
	else c = '\0';
	*str = '\0';
	return( (c==EOF && str==s) ? NULL : s );
}
