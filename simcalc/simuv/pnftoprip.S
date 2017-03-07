/*C
			pnftoprip(r,P,ps)

	"polynomial over number field to polynomial over rationals, if
	possible".
	pol pnftoprip(r,P,ps) single r; pol P; single *ps;
	P1 = pnftoprip(r,P,ps);

	P ist ein Polynom in r (0<=r<BASIS) Variablen ueber einem
	algebraischen Zahlkoerper.
	P1 = P, und zwar als Polynom ueber den rationalen Zahlen Q,
		falls die Basis-Koeffizienten von P schon in Q
		liegen; in diesem Fall ist *ps gleich 1;
		sonst ist P1 Polynom ueber dem Zahlkoerper
		und *ps gleich 0.
	Die include-Datei <_arith3.h> wird benoetigt.
C*/
/*H
	Version  1      31.08.1993      U.Schneiders
H*/
/*cS
	pnftoprip ruft auf: diptop, linv, ptodip, rcons
		 Macros: lcomp2, lfirst, lred, lred2, lsecond, lthird
Sc*/

#include<_arith3.h>

pol pnftoprip(r,P,ps)
single r;
pol P;
single *ps;
{
	int N;
	nfel A;
	list E;
	pol P1, PS;
	bind(P);
	init(N,A,E,P1,PS);

	*ps = 1;
	if ( P == 0 ) P1 = P;
	else if (!r) 
	{	if (!lsecond(P) ) 
		{	N = lfirst( P );
			P = lthird( P );
			P1 = rcons(P,N);
		}
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
				N = lfirst( A );
				A = lthird( A );
				A = rcons( A, N );
				P1 = lcomp2(E,A,P1);
			}
			P1 = linv(P1);
			P1 = diptop(r,P1);
		}
		else P1 = P;
	}

	return(P1);
}
