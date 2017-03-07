/*c
			xfgetc (pf)

	"file get character, internal version"	 (rekursiv)
	Quellbibliothek: srclib.C_sm
	Include-Datei:	 _list.h
	!!! wird nur vom System ueber getc() und fgetc() benutzt !!!
	single xfgetc(pf)  FILE *pf;
	c = xfgetc(pf);
	Von der Datei *pf wird das naechste Zeichen nach c eingelesen.
	Bei Auftreten des Entwertungszeichens \ wird dieses sowie das
	nachfolgende Zeichen ignoriert. Soll \ als signifikantes
	Zeichen interpretiert werden, so muss es doppelt eingegeben
	werden: \\
	Falls die Eingabe nicht vom Bildschirm erfolgt, wird der
	linke Rand (MARGIN) ueberlesen.
	Bei Fehler oder Dateiende ist c = EOF. Dabei wird keine
	Fehlermeldung ausgegeben.
c*/
/*H
	Version 1	17.03.87	R. Boeffgen
	Version 2	25.03.87	Sonderfaelle.  RB
	Version 3	31.05.1994	Es wird nicht mehr _list.h 
					eingebunden. Marc Conrad
   DATE xfgetc	      : 890501.941201
H*/

# include <stdio.h>
					
/* Signifikane Teile aus _list.h:  */

# ifndef _NFILE
# define _NFILE NOFILE
# endif
#define single int	  

extern single  LN_SIZE, MARGIN;	       

single xfgetc ( pf )
FILE *pf;
{
	single c, i;
   /***	   Vorbesetzung fuer ersten Aufruf von xfgetc()	   ***/
	static single clast = '\n';
   /***	   falls keine Geraetedatei, ggf. linken Rand ueberlesen    ***/
	if ( clast == '\n'  &&	!isatty( fileno(pf) ) )
		for ( i=MARGIN ; i-- ; getc(pf) );
   /***	   Zeichen einlesen    ***/
	clast = c = getc(pf);
   /***	   Einlesen wiederholen, falls Zeichen nicht signifikant    ***/
	if ( c == '\\'	&&  ( clast = getc(pf) ) != '\\' )  c = xfgetc(pf);
   /***	   Ergebnis    ***/
	return( c );
}
