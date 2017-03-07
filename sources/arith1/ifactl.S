/*M
.SH NAME
ifactl - integer factorial

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ifactl(a)
single a;

.SH DESCRIPTION
For a >0 ifactl() returns the factorial of a.
M*/
/*H
	Version  1      11.09.1986      R.Boeffgen  
	Version  2      24.11.1991      vieles geaendert.  MC
	Version  3	31.08.1993	Fehler beseitigt.  MC
   DATE ifactl        : 890501.911215.9203__.931130
H*/



#include<_arith1.h>

#define GRENZE 200
#define FAC12  479001600
/*                          
FAC12 = 12!.
GRENZE ist eine heuristische Konstante, und haengt von 
den jeweiligen Multiplikationsalgorithmen ab, die implementiert
sind. 
Die Verbesserung fuer Zahlen > GRENZE geht davon aus, 
dass ungefaehr gleichgrosse Zahlen schneller multipliziert werden
als verschieden grosse.
*/

ifactl(m)
	single m;
{
	if (m < 12) {
		single i, a = 1;

		for (i = 1; i <= m; i++)
			a *= i;
		return (a);
	} else if (m < GRENZE) {
		single a = 1, i = 12;
		int B = FAC12;

		while (++i <= m)
			if (i <= BASIS / a)
				a *= i;
			else
				B = isprod(B, a), a = i;
		B = isprod(B, a);
		return (B);
	} else {
		list L, M;
		single u, i;
		int A;

		init(L, M, A);

		if (sodd(m)) {
			M = list1(m);
			m--;
		} else
			M = _0;
		u = m >> 1;
		u += 6;
		M = lcomp(FAC12, M);
		if (m < 65524)
			for (i = 13; i <= u; i++, m--) {
				M = lcomp(m * i, M);
			}
		else
			for (i = 13; i <= u; i++, m--) {
				M = lcomp(iprod(m, i), M);
			}
		while (lred(M) != _0) {
			L = M;
			M = _0;
			for (;;) {
				A = lfirst(L);
				L = lred(L);
				if (L == _0) {
					M = lcomp(A, M);
					break;
				}
				M = lcomp(iprod(A, lfirst( L )), M);
				L = lred(L);
				if (L == _0)
					break;
			}
		}
		return (lfirst(M));
	}

}
