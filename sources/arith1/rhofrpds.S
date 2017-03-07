/*M
.SH NAME
rhofrpds - rho- method ( fast reduction ) by Pollard divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h>

int rhofrpds(N,b,z)
int N;
single b,z;

.SH DESCRIPTION
rhofrpds() returns a factor of P of N,
worst case P=1 or P=N.
.TP 4
.B N
>1 should not be prime
.TP 4
.B b
<N should be as random as possible and not to large (i.e. |b| < 1000)
.TP 4
.B z
is the maximum number of iterations using the polynomial x^2+|b|

rhofrpds uses a special reduction modulo N
which yields faster results than rhopds
in case N > 2^60.

.SH SEE ALSO
N. Koblitz, "A course of Number Theory and cryptography",
Springer 1987, chapter 5.
.SH SEE ALSO
rhopds		
M*/

/*H 
	Version 1	23.09.1991	Marc Conrad
   DATE rhofrpds      : 911215.9203__.9211__
H*/

#include <_arith1.h>

int rhofrpds(N,b,z)
int N;
single b,z;
{       

	int x, vglx, dummy, k;
	floating Nf, f;
	single i, v, rette_eps;  

	bind(N);
	init( x, vglx, Nf, f, k );

	rette_eps = FL_EPS;
	FL_EPS = (1 + ilog2( N )) / 30 + 2;
	Nf = flquot( itofl( -1 ), itofl( N ) );

	vglx = -1967;                    /* 1967 : arbitrary value */
	z += 2;
	if ( b > 0 ) b = -b;
	iqrem(isum(b,isquare(vglx)),N,&dummy,&x);
	for (i=2,v=2; (igcd(isum(x,vglx),N) == 1) && (i < z); i++ ) {
		if (i==v) {
			vglx = ineg( x );
			v <<= 1;
		}
		x = isum(isquare(x), b);
		f = itofl( x );
		FL_EPS <<= 1;
		k = flround( flprod( f, Nf ) ); /* [x * ( -1/N )] */
		FL_EPS >>= 1;
		k = iprod( k, N );
		x = isum( x, k );
	}
	FL_EPS = rette_eps;
	return(igcd(isum(vglx,x),N));

}
