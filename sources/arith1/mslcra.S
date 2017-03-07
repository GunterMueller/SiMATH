/*M
.SH NAME
mslcra - modular single list Chinese remainder algorithm

.SH SYNOPSIS
.nf
#include<_arith1.h>

list mslcra(m1,m2,L1,L2)
single m1,m2;
list L1,L2;

.SH DESCRIPTION
Let m1 >0, m2 >0, gcd(m1,m2) = 1, m = m1*m2 < BASIS;
L1=(a(1),...,a(m)) is a list of elements in Z/m1*Z,
L2=(b(1),...,b(n)) is a list of elements in  Z/m2*Z.

mslcra() returns a list L = (c(1,1), ..., c(1,n), ..., c(m,1), ..., c(m,n)),
where c(k,l) is the uniquely determined element in Z/mZ
which is congruent a(k) modulo m1 and congruent b(l) modulo m2.
M*/
/*H
	Version 1       19.2.1987               Pascale Serf
   DATE mslcra        : 890501
H*/


# include <_arith1.h>

list mslcra(m1,m2,L1,L2)
single m1,m2;
list L1,L2;
{
	single n1,a1,a2,a;
	list L,M2;

	bind2(L1,L2);
	init2(L,M2);

	n1 = msinv(m2,mshom(m2,m1));
	L = _0;
	while ( L1 != _0 ) {
		a1 = lfirst(L1);
		L1 = lred(L1);
		M2 = linv(lcinv(L2));   /*  Kopie von L2  */
		while ( L2 != _0 ) {
			a2 = lfirst(L2);
			L2 = lred(L2);
			a = mscra(m1,m2,n1,a1,a2);
			L = lcomp(a,L);
		}
		L2 = M2;    /*  urspruengliches L2  */
	}
	L = linv(L);
	return(L);
}
