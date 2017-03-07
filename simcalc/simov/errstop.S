/*C
			errstop()

	"error stop".
	single errstop(); 
	s = errstop();

	errstop wird in Schleifen aufgerufen, nachdem ein Fehler in einer
	Rechnung aufgetreten ist. Es wird abgefragt,ob der Benutzer
	trotzdem mit dem naechsten Schleifendurchlauf fortfahren moechte. 
	In diesem Fall wird 0 zurueckgegeben. Soll die Schleife abgebrochen 
	werden, wird 1 zurueckgegeben. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      10.08.1994      S.Schmitt
H*/

# include <_calc.h>

single errstop()
{
	char *ant, c, *getline();

	ant = malloc(MAXLV);
	*ant = '\0';
	if(assch || !isatty(fileno(stdin))) return(1);
	printf(" Do you want to continue the loop? (y/n) ");
	if(ps) fprintf( datei,"out: Do you want to continue the loop? (y/n)\n");
	setocnt(stdout,0);
	ant=getline("",-1);
	c=(*ant);
	setocnt(stdout,0);

	if(ps) fprintf(datei,"in : %c",c);
	if(c=='y') return(0);
	else return(1);
}
