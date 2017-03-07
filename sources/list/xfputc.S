/*c
			xfputc(c, pf)

	"file put character, internal version"
	Quellbibliothek: srclib.C_sm
	Include-Datei:	 _list.h
	!!  Dieses Programm wird nur vom System ueber die Macros
	    fputc() und putc() benutzt	!!
	!!  Es darf nur zusammen mit getocnt() und setocnt() auf einer
	    Datei uebersetzt werden !!
	single xfputc(c, pf)  char c; FILE *pf;
	t = xfputc(c, pf);
	Der Character c wird auf die Datei *pf ausgegeben.
	Bei Erfolg ist t=c, andernfalls t = EOF.
	Das Zeichen \ gilt als Entwertungszeichen, d.h. beim
	Wiedereinlesen wird dieses sowie das nachfolgende Zeichen
	ignoriert. Will man \ als signifikantes Zeichen ausgeben, so
	muss es zweifach ausgegeben werden: \\
c*/
/*H
	Version 1	23.02.1987	R. Boeffgen
	Version 2	25.03.1987	RB
	Version 3	26.03.1987	neu konzipiert.	 RB
	Version 4	31.03.1987	Bearbeitung linker Rand neu.
					Bearbeitung Spaltenzaehler neu.
					MAR.
	Version 5	01.04.1987	*pc > LN_SIZE statt *pc >= LN_SIZE
					MAR.
	Version 6	07.12.1989	einheitl. Version fuer MX2(+), SUN und
					Apollo. PS			      
	Version 7	31.06.1994	etwas systemunabhaengiger, 
					_list.h. wird nicht mehr benutzt, 
					sondern nur noch stdio.h. Ausgabe
					vereinfacht wg. Linux-Portierung
					 Marc Conrad
   DATE xfputc	      : 890501.900101.941201
H*/				

/* Ausgewaehlte Teile des Headers _list.h: */

# include <stdio.h>

# ifndef  __PARAM_HEADER__
# include <sys/param.h>		/***	Def. der Zeitaufloesung	 HZ    ***/
# endif
	   
# ifndef _NFILE
# define _NFILE NOFILE
# endif
#define single int	  

extern single  LN_SIZE, MARGIN;	       

				/*** Feld der Zeichenzaehler aller ***/
static single ocnt[ _NFILE ];	/***   Dateien fuer die jeweils	   ***/
				/***	 aktuelle Ausgabezeile	   ***/

single	xfputc ( c, pf )
char c;
FILE *pf;
{
	int  *pc = &ocnt[ fileno(pf) ];
	int d;
   /***	   linken Rand setzen		****/
	while ( (*pc)++ < MARGIN )  putc(' ',pf);
   /***	   falls c Zeilenvorschub, Zeichenzaehler zuruecksetzen	   ***/
	if ( c=='\n' )	*pc = 0;
   /***	   falls Zeile voll und c kein Zeilenvorschub	 ***/
	if ( *pc >= LN_SIZE )  {
   /***	   falls bei gepufferter Ausgabe voraufgegangenes Zeichen kein	 ***/
   /***	   Zwischenraum (space), durch Entwertungszeichen ersetzen	 ***/
   /*	  !! NEIN !! Ab Version 3.9 wird jetzt immer ein Entwertungszeichen*/
   /*		     gesetzt, andernfalls muss die interne Realisierung	   */
   /*		     (Definition) von putc benutzt werden, was Probleme	   */
   /*		     bei der Portierung verursachen kann (insb. Linux)	   */
		if ( !isatty( fileno(pf) ))  {
			putc('\\',pf);
		}
   /***	   fuer Apollo:		stets Zeilenvorschub			 ***/
   /***	   fuer MX2(+) und SUN: kein Zeilenvorschub am Bildschirmrand	 ***/
# ifdef ___APOLLO
		putc('\n',pf);
# else
		if ( LN_SIZE != 80  ||	!isatty( fileno(pf) ) )	 putc('\n',pf);
# endif
		*pc = 0;
   /***	   linken Rand setzen		****/
		while ( (*pc)++ < MARGIN )  putc(' ',pf);
	}
   /***	   bei Tabulator Zeichenzaehler aktualisieren	 ***/
	if ( c== '\t' )	 --*pc,	 *pc += 9 - *pc %8;
   /***	   Zeichen ausgeben    ***/
	if ( (d=putc(c,pf)) == EOF )  errmsgio( "xfputc", "EA101" );
	return( d );
}



single getocnt( pf )
FILE *pf;
{
	return( ocnt[ fileno(pf) ] );
}



single setocnt( pf, n )
FILE *pf;
single n;
{
	ocnt[ fileno(pf) ] = n;
	return( 0 );
}

