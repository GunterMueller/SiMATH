/*M
.SH NAME
msfrl - modular single Fermat residue list

.SH SYNOPSIS
.nf
#include<_arith1.h>

list msfrl(m,a)
single m,a;

.SH DESCRIPTION
msfrl() returns the list of all different values b
in Z/mZ with the property that b*b-a is a square
in Z/mZ for m >0 and a in Z/mZ.
M*/
/*H
	Version 1       5.3.1987                Pascale Serf
   DATE msfrl         : 890501
H*/


# include <_arith1.h>

list msfrl(m,a)
single m,a;
{
	single m1,s,s1,i,i1,j;
	list S,S1,L;

	init3(S,S1,L);

	/***    Erstellung der Liste der Einheiten aus Z/mZ    ***/
	m1 = m/2;
	S = _0;
	for ( i=0 ; i<=m1 ; i++ ) {
		s = msprod(m,i,i);
		S = lcomp(s,S);
	}

	/***    Berechnung von L    ***/
	L = _0;
	S1 = lcopy(S);
	for ( i=m1 ; i>=0 ; i-- ) {
		s = lfirst(S1);
		S1 = lred(S1);
		s1 = msdif(m,s,a);
		j = lsrch(s1,S);
		if ( j!=0 ) {
			L = lcomp(i,L);
			i1 = msneg(m,i);
			if ( i1!=i ) L = lcomp(i1,L);
		}
	}
	return(L);
}
