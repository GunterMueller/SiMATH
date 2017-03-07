/*C
			statistic( t )

	"statistic".
	statistic(t); single t;
	statistic( t );
	Die fuer eine Rechnung benoetigten Zellen und der Rechenzeitver-
	brauch, sowie die insgesamt bis zum Aufruf des Programms statistic
	benoetigten Zellen und benoetigte Rechenzeit werden
	auf Bildschirm und auf Protokolldatei geschrieben, falls geoeffnet.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      02.06.1987      H.Stroeher/M.Mang
        Version  1.1    15.09.1989      C.Hollinger/U.Schneiders ( %,/ )
        Version  1.2    10.06.1996      S.Schmitt ( Zellen weg )
H*/

 
#include <_calc.h>

statistic(t)
single t;

{
	/*** Deklarationen und Vorbesetzungen ***/

	/**** single cdiff; ***/

	/*** Berechnung der benoetigten Zellen und Rechenzeit ***/

/****	cdiff = cellc - cellabs;
	cellabs = cellc;
	printf("\n      **** %.2f s, %d cells,",t/100.,cdiff);
	printf(" total: %.2f s, %d cells. ****\n",tabs/100.,cellc);
	if ( ps ) {
	  fprintf(datei,"\n      **** %.2f s, %d cells,",t/100.,cdiff);
	  fprintf(datei," total: %.2f s, %d cells. ****\n",tabs/100.,cellc);
	} ****/
	printf("\n      **** %.2f s,",t/100.);
	printf(" total: %.2f s. ****\n",tabs/100.);
	if ( ps ) {
	  fprintf(datei,"\n      **** %.2f s,",t/100.);
	  fprintf(datei," total: %.2f s. ****\n",tabs/100.);
 	}
}
