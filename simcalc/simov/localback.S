/*C
			localback(zahl)

	"Ruecksetzung lokaler Variablenspeicher".
	localback(zahl); single zahl;
	Das Programm setzt den lokalen Variablenspeicher um
	zahl Argumente zurueck.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      19.05.1994      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

localback(zahl)
single zahl;

{       /*** Deklarationen und Vorbesetzungen ***/

	single l, i,g;

	if(!zahl) return(0);
	for(l=1;l<=zahl;l++)
	{    localvar[anzloc-l].typ=0;
	     localvar[anzloc-l].varwert = 0;
	     g=strlen(localvar[anzloc-l].varname);
	     for(i=0;i<g;i++) *(localvar[anzloc-l].varname+i) = '\0';
	}
	anzloc = anzloc-zahl;
	return(0);
}
