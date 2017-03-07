/*C
			pctopflip(r,P,ps)

	"polynomial over the complex numbers to polynomial over floating
	 points, if possible".
	pol pctopflip(r,P,ps) single r; pol P; single *ps;
	P1 = pctopflip(r,P,ps);

	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber den 
	komplexen Zahlen.
	P1 = P, und zwar als Polynom ueber floating points, falls die 
		Basis-Koeffizienten von P schon in R liegen; in diesem 
		Fall ist *ps gleich 1;
		sonst ist P1 Polynom ueber den komplexen Zahlen
		und *ps gleich 0.
	Die include-Datei <_arith3.h> wird benoetigt.
C*/
/*H
	Version  1      01.02.1995      S.Schmitt
H*/

#include<_arith3.h>

pol pctopflip(r,P,ps)
single r;
pol P;
single *ps;
{
	complex A;
	list E;
	pol P1, PS;
	bind(P);
	init(A,E,P1,PS);

	*ps = 1;
	if ( P == 0 ) P1 = P;
	else if (!r) 
	{	if (!lsecond(P) ) P1 = lfirst( P );
		else {P1 = P; *ps = 0;}
	}
	else 
	{	PS = ptodip(r,P);
		P1 = PS;
		while (P1 != _0) 
		{	A = lfirst(P1);
			P1 = lred2(P1);
			if (lsecond(A)) {*ps = 0; break;}
		}
		if (*ps) 
		{	P1 = _0;
			while (PS != _0) 
			{	A = lfirst(PS);
				PS = lred(PS);
				E = lfirst(PS);
				PS = lred(PS);
				A = lfirst( A );
				P1 = lcomp2(E,A,P1);
			}
			P1 = linv(P1);
			P1 = diptop(r,P1);
		}
		else P1 = P;
	}

	return(P1);
}
