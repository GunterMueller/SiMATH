/*M
.SH NAME
mscran - modular single Chinese remainder algorithm, n arguments

.SH SYNOPSIS
.nf
#include<_arith1.h>

single mscran(n,Lm,La)
single n;
list Lm,La;

.SH DESCRIPTION
mscran() returns the uniquely determined element a
in Z/mZ which is congruent ai modulo mi for all i=1,...,n
where
.nf
- n is positive,
- Lm = (m1,...,mn) is a list of n co-prime integers,
- La = (a1,...,an) is a list of n elements ai in Z/mi*Z
  for all i.
M*/
/*H
	Version 1       14.7.1987               Pascale Serf
   DATE mscran        : 890501
H*/


# include <_arith1.h>

single mscran(n,Lm,La)
single n;
list Lm,La;
{
	single m1,m2,a1,a2,n1;
	list Mm,Ma,M;

	bind2(Lm,La);
	init3(Mm,Ma,M);

	/*    Spezialfall : n = 1    */
	if ( n == 1 ) return(lfirst(La));

	/*    Spezialfall : n = 2    */
	if ( n == 2 ) {
		m1 = lfirst(Lm);
		m2 = lsecond(Lm);
		a1 = lfirst(La);
		a2 = lsecond(La);
		n1 = msinv(m2,mshom(m2,m1));
		return(mscra(m1,m2,n1,a1,a2));
	}

	/*    allgemeiner Fall : n >= 3    */
	else {
		m1 = lfirst(Lm);
		Mm = lred(Lm);
		a1 = lfirst(La);
		Ma = lred(La);
		m2 = 1;
		M = Mm;
		while ( M != _0 ) {
			m2 = m2 * lfirst(M);
			M = lred(M);
		}
		a2 = mscran(n-1,Mm,Ma);
		n1 = msinv(m2,mshom(m2,m1));
		return(mscra(m1,m2,n1,a1,a2));
	}

}
