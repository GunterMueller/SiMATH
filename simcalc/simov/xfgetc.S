/*C

			xfgetc ( pf )

	"file get character, internal version"
	!!! wird nur vom System ueber getc() und fgetc() benutzt !!!
	single xfgetc(pf)  FILE *pf;
	c = xfgetc( pf );
	Von der Datei *pf wird das naechste Zeichen nach c eingelesen.
	Bei Auftreten des Entwertungszeichens '\' wird dieses sowie das
	nachfolgende Zeichen ignoriert.
	Bei Fehler oder Dateiende ist c = EOF.
	Include-file <stdio.h>.

C*/
/*H

	Version 1       17.03.1987      R. Boeffgen
	Version 2       02.06.1987      Fehlermeldung eliminiert HS

H*/
/*cS
	Macros: getc
Sc*/


# include <stdio.h>
# define single int

single xfgetc ( pf )
FILE *pf;
{
	int d;
	int c = getc(pf);
	if ( c == '\\' )  
	{	d=getc(pf);  
		if(d!='"') c = getc(pf);
		else ungetc(d,pf);
	}
	return( c );
}
