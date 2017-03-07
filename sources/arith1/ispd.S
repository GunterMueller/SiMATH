/*M
.SH NAME
ispd - integer small prime divisors search

.SH SYNOPSIS
.nf
#include<_arith1.h>

list ispd(N,pM)
int N,*pM;

.SH DESCRIPTION
For N >0
ispd() calculates *pM and returns an ascendingly sorted list
(q1,...,qh), h>=0, of prime numbers q1<=...<=qh, such that
N = *pM * q1 * ... * qh and *pM has no prime factor in LIST_SP
(i.e. *pM=1 or *pM> 10^6).
M*/
/*H
					
	Version 1       24.02.1987      Pascale Serf
	Version 2       05.03.1987      LIST_SP jetzt Array statt Liste.  PS
	Version 3       16.06.1992	schneller mit Arrays.  MC
   DATE ispd          : 890501.921130
H*/


# include <_arith1.h>
#ifndef LP64
# include <_Earith.h>
#endif

list ispd(N, pM)
	int N, *pM;
#ifdef LP64
{
        bind(N);
        return ispd_lo( N, pM );
}
#else
{
	LONG a[LAENGE], *pa, *paa;

	unsigned c, p, sgf, x, y, q, mm;
	single *L1;
	list F;


	bind(N);
	init(F);

	F = _0;
	L1 = LIST_SP;

	if ( itoEb(N, a, LAENGE) ) return( ispd_lo( N, pM ) );
	paa = a + a[0];   
	

	mm = 4294967295U;    /* = 2^32 - 1 */
	q = mm;
	do {
		p = (unsigned) *L1;
		if (a[0] == 1)
			q = a[1] / p;
		else c = ( mm % p ) + 1;     
		pa = paa;    
		x = *(pa--) % p;              	
		
		while (pa != a) {      
			x = ((x * c)  + (*(pa--) % p)) % p;
		}         

		if (x == 0) {
			F = lcomp((single) p, F);
			N = Etoi(a);
			N = isquot(N, p);
			itoE(N, a);
			paa = a + a[0];
		} else
			L1++;
	}
	while (q > p && *L1 != 0);
	N = Etoi(a);
	if (q <= p && N != 1) {
		F = lcomp(N, F);
		N = 1;
	}
	*pM = N;
	return (linv(F));
}                
#endif




