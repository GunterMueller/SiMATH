/*M
.SH NAME
imspds - integer medium single prime divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h>

single imspds(N,a,b)
int N;
single a,b;

.SH DESCRIPTION
imspds() returns a factor p of N.
Let 2 <= a <= b <= N.
If N has a prime factor >= 13 in [a,b] and no factor in [13,a[
then p equals the smallest prime factor of N in [a,b].
If N has no prime factor in [13,b] then p equals 1.
In any other case p is assigned some factor of N.
M*/

/*H
	Version 1       25.06.1992	Marc Conrad
   DATE imspds        : 921130
H*/


#include <_arith1.h>
#ifndef LP64
#include <_Earith.h>


static unsigned xumsprod();  
#endif


int imspds(N, a, b)
	int N;
	single a, b;
#ifdef LP64
{
	bind(N);
	return (impds(N, a, b, &DUM, &DUM));
}
#else
{
	single *L1;
	unsigned c, r, r1, ua, ub, p, mm;
	LONG n[LAENGE], *pn, *pan;
	bind(N);
	/* Bestimmung des ersten moeglichen Teilers    */
	if (itoEb(N, n, LAENGE)) {
		return (impds(N, a, b, &DUM, &DUM));
	}
	pan = n + n[0];

	ua = (unsigned) a;
	ub = (unsigned) b;
	mm = 0xFFFFFFFFU;	/* = 2^32 - 1 */
	r = ua % 2310;
	L1 = DIFF + 271;
	r1 = 1;
	while (r1 < r) {
		r1 = r1 + (unsigned) *L1;
		L1++;
		if (*L1 == 0)
			L1 = DIFF;
	}
	p = (ua + r1) - r;

	/* wiederholte probeweise Division    */
	while (p < ub) {
		c = (mm % p) + 1;
		pn = pan;
		r = *(pn--) % p;
		while (pn != n) {
			r = (xumsprod( p, r, c) + (*(pn--) % p)) % p;
		}

		if (r == 0) {
			return (p);
		}
		p += (unsigned) *(L1++);
		if (*L1 == 0)
			L1 = DIFF;
	}

	/* kein Teiler gefunden    */
	return (1);
}


/* 
"xumsprod":   wie msprod, aber alles unsigned 
m, a, b sind nichtsdestotrotz < BASIS 
*/


static unsigned xumsprod( m, a, b  )
	unsigned m, a, b;
{

	if (m < 65536)
		return ( (a * b) % m );
	else {
		unsigned c, d;
		unsigned a0, b0, c2;
/* Multiplikation */
		a0 = a % BSMALL;
		a = a >> 15;
		b0 = b % BSMALL;
		b = b >> 15;
		c = a0 * b0;
		c2 = a * b;
		d = (a0 + a) * (b0 + b) - (c + c2);
		a0 = d % BSMALL;
		a = d >> 15;

		d = ((a0 << 15) + c);
		c = (c2 + a);
/* Reduktion */
		if (m < 1664717) {
			return ( (c * (BASIS % m) + (d % m)) % m);   

		} else {
			d = d % m;
			b0 = 30;
			while (b0--) {
				c <<= 1, d <<= 1;
				if (d >= BASIS) {
					d -= BASIS;
					c++;
				}
				if (c >= m)
					c -= m;
			}
			return ( c );
		}

	}
}
#endif
