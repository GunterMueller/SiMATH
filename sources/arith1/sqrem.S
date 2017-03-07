/*M
.SH NAME
sqrem - single-precision quotient and remainder

.SH SYNOPSIS
.nf
#include<_arith1.h>

single sqrem(a,b,d,pq,pr)
single a,b,d,*pq,*pr;

.SH DESCRIPTION
Let A := (a * BASIS + b) for  a*b >=0 and |a|<|d|.
Then sqrem() calculates *pq and *pr such that
*pq equals the integer part of A/d and *pr = A - (*pq) * d
and returns 0.

M*/
/*H
	Version  1      23.06.1986      R. Boeffgen
	Version  2      11.11.1987      |a|<|d| im Kommentar hinzugefuegt. RB
	Version  3      18.08.1988      Assembler-Version fuer MX-2. BW
	Version  4      08.05.1989      wegen divs/mods: fuer Apollo in 
					if ( a==0 ) 3.Zeile weg. CH/US
	Version  5      07.12.1989      einheitl. Version fuer MX2(+), SUN
					und Apollo. PS
	Version  6      14.02.1990      "ifndef ___apollo" --> "ifdef ___mx". PS
	Version	 7	15.11.1991	Division fuer d < 2^15 verbessert. MC
	Version  8	03.11.1994	MX-Version entfernt. MP
   DATE sqrem         : 890501.890601.891001.900101.900315.911215.941201
H*/

# include <_arith1.h>

single sqrem(a, b, d, pq, pr)
	single a, b, d, *pq, *pr;
{
	/***    a Null    ***/
	if (a == 0) {
		*pq = b / d;
		*pr = b % d;
	}
	/***    a nicht Null    ***/
	else {
		single s = 0, t = 0;
#ifdef LP64
		long q, r, num;
#else /* default is ILP32 */
		single q = 0;
#endif

		if (a < 0)
			a = -a, b = -b, s = 1;
		if (d < 0)
			d = -d, t = 1;

#ifdef LP64
		num = (((long) a) << FULL_WIDTH) | b;
		q = num / d;
		r = num % d;
		if (s ^ t)
			*pq = -(single)q;
		else
			*pq = (single)q;
		if (s)
			*pr = -(single)r;
		else
			*pr = (single)r;
#else /* default is ILP32 */
		if (d >= BSMALL) {

			register i = BLOG2;

			/***    Shift und Subtraktion    ***/
			while (i--) {
			        a <<= 1, b <<= 1, q <<= 1;
				if (b >= BASIS)
					b -= BASIS, a++;
				if (a >= d)
					a -= d, q++;
			}
		}
		else {
		        single u, w;

			u = ((a << HALF_WIDTH) | (b >> HALF_WIDTH));
			w = (((u % d) << HALF_WIDTH) | (b & HALF_MASK));

			q = ((u / d) << HALF_WIDTH) | (w / d);
			a = w % d;
		}
		if (s ^ t)
			*pq = -q;
		else
			*pq = q;
		if (s)
			*pr = -a;
		else
			*pr = a;
#endif
	}

	return (0);
}
