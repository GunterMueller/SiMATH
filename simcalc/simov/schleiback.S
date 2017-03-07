/*C
			schleiback( )

	"Schleifenruecksetzung".
	schleiback(); 
	Das Programm setzt varlist.typ von den in einer Schleife 
	besetzten Variablen wieder auf 0 zurueck. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      19.11.1993      S.Schmitt/U.Schneiders
H*/
/*cS
	schleiback ruft auf: 
Sc*/
 
#include <_calc.h>

schleiback()

{       /*** Deklarationen und Vorbesetzungen ***/

	single l,zahl,altz;

	/*** Aufloesung des Eingabestrings und Information zu den
	     eingebenen Variablen ***/

	for(l=0;l<MX;l++)
	{    if ( varlist[l].typ == (-1) ) /** Schleifen **/
		varlist[l].typ = 0;
	     else if( varlist[l].typ == (-2) ) /** print **/
		varlist[l].typ = 0; 
        /**  {	if(schleife==1) varlist[l].typ = (-1); 
		else            varlist[l].typ = 0; 
	     } **/
	     else if( varlist[l].typ == (-3) )  /**decl in Schleifen**/
		varlist[l].typ = 2;
	     if(!l) l=MXNUM-1;
	}
	if(funktion){
	zahl=0;
	for(l=0;l<funktion;l++)
	{	altz=zahl;
		zahl=localvar[anzloc-zahl-1].varwert + zahl + 1;
	}	
	for(l=anzloc-zahl;l<anzloc-altz-1;l++)
	{	if(localvar[l].typ==(-1)) localvar[l].typ=0;
		else if(localvar[l].typ==(-2)) localvar[l].typ=0;
		else if(localvar[l].typ==(-3)) localvar[l].typ=0;
	}
	}
	return(0);
}
