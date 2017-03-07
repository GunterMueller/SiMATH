/*C
			fputnfel( F, a, V, pf )

	"file put number field element"
	Quellbibliothek: srclib.simre
	Include-Datei:   _arith2.h
	single fputnfel( F, a, V, pf )  pol F; nfel a; list V; FILE *pf;
	t = fputnfel( F, a, V, pf);
	Dabei muss gelten:
	      - F ist ein irreduzibles Polynom in einer Variablen ueber Z
		in dense-Darstellung, das einen Zahlkoerper K erzeugt.
	      - a ist ein Element von K und hat folgende Form (falls
		a != 0):
			( HNa, r, ar, ..., a0 ).
		Dabei ist
		      - HNa positive ganze Zahl;
		      - A := ( r, ar, ..., a0 ) Polynom in einer Variablen 
			ueber Z in dense-Darstellung;
		      - ggT( HNa, ar, ..., a0 ) = 1;
		      - a = 1/HNa * A.
	      - V ist 1-elementige Variablenliste.
	a wird als Polynom ueber Q in der in V angegebenen Variablen auf 
	die Datei *pf ausgegeben.
	Bei korrektem Verlauf ist t = 0, ansonsten ERROR.

	HINWEIS: Eine andere Ausgabemoeglichkeit liefert -> fputonfel.
C*/
/*H
	Version 1       14.03.1989      Christine Hollinger
	Version 2       24.02.1989      0 Koeffizient.  CH
	Version 3       24.10.1990      a = 0: fprintf(pf,"0\n") ->
                                               fprintf(pf,"0 #");
					fprintf(pf,"\n") --> fprintf(pf," #") );
					Placebo F.  CH
	Version 4       31.01.1991      fputc(c,pf) durch while-Schleife
					ersetzt.  TW
        Version 5       22.09.1992      Abfragen z<0 bzw. >0 durch
					isign(z)<0 bzw. >0 ersetzt.  TW
	Version 6	22.01.1993	voellig neu.  PS
   DATE fputnfel      : 890601.900315.901120.910915.921130.930115
H*/
/*cS
	fputnfel ruft auf: dptop, fputpr, nfeltoudpr
Sc*/


# include <_arith2.h>

single fputnfel(F,a,V,pf)
pol F;
nfel a;
list V;
FILE *pf;
{
	/* Funktion statt Macro, da es in fputmanf   */
	/* und fputvecnf als Funktion benoetigt wird */
	
	xfputs("NF(",pf);
	fputpr(1,dptop(1,nfeltoudpr(a)),V,pf);
	xfputs(")",pf); 

	return( 0 );
}
