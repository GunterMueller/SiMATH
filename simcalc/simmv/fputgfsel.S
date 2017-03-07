/*C
			fputgfsel( a, V, pf )

	"file put Galois-field with single characteristic element"
	Quellbibliothek: srclib.simmv
	Include-Datei:   _calc.h
	fputgfsel(a,V,pf)  list V; gfel a; FILE *pf;
	Es muss gelten : 
	  a ist aus GF(p^n).
	  V ist eine 1-elementige Variablenliste.
	a wird auf die Datei *pf ausgegeben.
C*/
/*H
	Version 1       07.06.1993              S.Schmitt/U.Schneiders 
H*/
/*cS
        fputgfsel ruft auf: fprintf, fputpi
Sc*/


# include <_calc.h>

fputgfsel(a,V,pf)
list V;
gfel a;
FILE *pf;
{
	bind(a,V);

	fprintf(pf, "GF(");
	fputpi(1,a,V,pf);
	fprintf(pf, ")");
}
