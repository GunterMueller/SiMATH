/*c
			xfputs ( s , pf )

	"file put string, internal version"
	Quellbibliothek: srclib.C_sm
	Include-Datei:   _list.h
	!!! wird nur vom System ueber die Makros fputs und puts benutzt !!!
	single xfputs(s,pf)  char *s; FILE *pf;
	t = xfputs( s,pf );
	Der string s wird auf die Datei *pf ausgegeben.
	t = 0 bei Erfolg, EOF sonst.
c*/
/*H
	Version 1       23.02.1987      R.Boeffgen
   DATE xfputs        : 890501.9107__
H*/


# include <_list.h>

single xfputs ( s, pf )
char *s;
FILE *pf;
{
	char c;
	single i=0;
   /***    zeichenweise Ausgabe    ***/
	while ( (c= *s++) != '\0' && (i=fputc(c,pf)) != EOF );
   /***    Rueckmeldung    ***/
	if ( i == EOF ) errmsgio("fputs","EA104");
	else i=0;
	return( i );
}
