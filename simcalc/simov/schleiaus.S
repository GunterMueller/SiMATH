/*C
			schleiaus(aus)

	"Schleifenausgabe".
	schleiaus(aus); 
	Das Programm gibt alle in einer Schleife besetzten Variablen
	aus und setzt varlist.typ wieder auf 0 zurueck. 
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version  1      18.11.1993      S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>
/****jmp_buf tes3;

void schleistop()
{
	printf(" \n **********   Output is interrupted.   **********\n\n");
	if (ps) fprintf(datei,"\nout: **********   Output is interrupted.   **********\n\n");
	longjmp(tes3,0);
}****/



schleiaus (aus)
single aus;

{       /*** Deklarationen und Vorbesetzungen ***/

	single l,zahl, altz;
	list L,M;
	init(L,M);
	L=_0;
	M=_0;

	/** Schleifen **/

	if(assch<2){
	if(aus){
	printf("\n");
	if(ps) fprintf(datei,"\n");
	}
	if(funktion){
	zahl=0;
	for(l=0;l<funktion;l++)
	{	altz=zahl;
		zahl=localvar[anzloc-zahl-1].varwert + zahl + 1;
	}
	for(l=anzloc-zahl;l<anzloc-altz-1;l++)
	{	if(localvar[l].typ==(-1))
		{	if(aus) L=lcomp(l,L);
			localvar[l].typ=0;
		}
		else if(localvar[l].typ==(-3))
		{	if(aus) M=lcomp(l,M);
			localvar[l].typ=2;
		}
	}
	if(aus && L!=_0) sortausloc(L);
	if(aus && M!=_0) sortfuncloc(M);	
	L=_0; M=_0;
	}
	for(l=0;l<MX;l++)
	{	if(varlist[l].typ == (-1))
		{	if(aus)	L=lcomp(l,L);
			varlist[l].typ=0;
		}
		else if( varlist[l].typ == (-3) )
		{	if(aus) M=lcomp(l,M);
			varlist[l].typ=2;
		}
		if(!l) l=MXNUM-1;
	}
	if(aus) sortaus(L);
	if(aus && M!=_0) sortfunc(M,0);
	if(!schleife && assch<2 && !funktion)
	{	tdiff = settime(); tabs+=tdiff;
		if(statsch) statistic(tdiff);
	}
	}

	/** print **/

	else{
	if(funktion){
	zahl=0;
	for(l=0;l<funktion;l++)
	{	altz=zahl;
		zahl=localvar[anzloc-zahl-1].varwert + zahl + 1;
	}	
	for(l=anzloc-zahl;l<anzloc-altz-1;l++)
		if(localvar[l].typ==(-2)) break;
	if(l< anzloc-1)
	{	ausgabe("","",localvar[l].varwert,0);
		if(schleife==1) localvar[l].typ = (-1);
		else localvar[l].typ=0;
		return(0);
	}
	}
	l=0;
	while( l<MX && varlist[l].typ != (-2) )
	{	if(!l) l=MXNUM-1;
		l++;
	}
	if(l<MX)
	{	ausgabe("","",varlist[l].varwert,0);
		if(schleife==1) varlist[l].typ = (-1);
		else varlist[l].typ = 0;
	}
	}

	return(0);
}
