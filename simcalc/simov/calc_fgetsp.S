/*S
			calc_fgetsp ( s, n, pf )

	"calculator file get string, pipeline"
	Quellbibliothek: srclib.simov
	Include-Datei:   _calc.h
	char *calc_fgetsp( s,n,pf )  char *s; single n; FILE *pf;
	str = calc_fgetsp( s,n,pf );
	calc_fgetsp() liest von der Datei *pf entweder n-1 Zeichen oder bis
	ausschliesslich zum naechsten Zeilenende oder bis Dateiende,
	falls dies vorher eintrifft. Die eingelesenen Zeichen traegt
	calc_fgetsp() in den Bereich ein, auf den s zeigt.
	calc_fgetsp() schliesst die eingelesene Zeichenreihe mit '\0' ab.
	Bei Auftreten des Entwertungszeichens \ wird dieses sowie das
	nachfolgende Zeichen ignoriert. Soll \ als signifikantes
	Zeichen interpretiert werden, so muss es doppelt eingegeben
	werden: \\

	str ist der Zeiger auf das erste eingelesene Zeichen.
	Bei Fehler oder Dateiende ist str der Nullzeiger. Dabei wird
	keine Fehlermeldung ausgegeben.
	Im Gegensatz zu calc_fgets wird bei Fehler NULL zurueckgegeben.
C*/
/*H
	Version 1       25.11.1994      U.Schneiders
H*/

# include <_calc.h>

char *calc_fgetsp( s, n, pf )
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
	*str = '\0';
	return( (c==EOF && str==s) ? NULL : s );
}
