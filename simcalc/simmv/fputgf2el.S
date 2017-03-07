/*C
			fputgf2el( G, a, V, pf )

	"file put Galois-field with characteristic 2 element"
	Quellbibliothek: srclib.simmv
	Include-Datei:   _calc.h
	fputgf2el(G,a,V,pf)  obj G; gf2el a; list V; FILE *pf;
	Voraussetzungen:
	     -  G ist ein irreduzibles, normiertes Polynom in einer 
		Variablen ueber Z/2Z vom Grad n >= 1 in der speziellen
		Bit-Darstellung (vgl. udpm2tosb). 
		G kann als ein erzeugendes Polynom fuer Gf(2^n) 
		interpretiert werden.
	     -  a ist ein Element aus GF(2^n), das als Polynom in einer 
		Variablen ueber Z/2Z vom Grad < n in spezieller Bit-
		Notation dargestellt wird.
	     -	V ist eine 1-elementige Variablenliste.
	a wird in Polynomdarstellung (sparse) konvertiert und auf die 
	Datei *pf ausgegeben.
C*/
/*H
	Version 1       07.06.1993	S.Schmitt/U.Schneiders
H*/
/*cS
        fputgf2el ruft auf: dptop, fprintf, fputpi, gf2eltoudpm2
Sc*/


# include <_calc.h>

fputgf2el(G,a,V,pf)
obj G;
gf2el a;
list V;
FILE *pf;
{
	bind(G,a,V);
	
	a = gf2eltoudpm2(G,a);
	a = dptop(1,a);
	fprintf(pf, "GF(");
	fputpi(1,a,V,pf);
	fprintf(pf, ")");
}
