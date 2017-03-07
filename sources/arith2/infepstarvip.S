/*M
.SH NAME
infepstarvip - integral number field element p-star valuation with respect to integer primes

.SH SYNOPSIS
.nf
#include<_arith2.h>

rat infepstarvip(P, A)  
int P; 
pol A;
  
.SH DESCRIPTION
.TP 4
.B P
is a prime number.
.TP 4
.B A
is not equal to the zero polynomial and the minimal polynomial of an integral algebraic number, say I, over the rational numbers, i.e. A is a monic and univariate polynomial over Z.
.PP
infepstarval returns the P-star valuation of the element I.

.SH SEE ALSO
For the definition of the P-star valuation see
 R. Boeffgen, Diplomarbeit p. 8-9, Universitaet des
 Saarlandes, Germany, or
 D.J. Ford, Dissertation, p. 38-39.
                                                  
M*/
                                           
/*H
	Version 1       06.08.91	J.Schmitt
   DATE infepstarvip  : 910915
H*/

#include<_arith2.h>

rat infepstarvip(p,A)
int p;
pol A;
{
	single i,e,n;
	rat v,w,i1,e1;
	int a,v1,w1;
	init(v,w,i1,e1,a,v1,w1);
	bind(p,A);

	n = lfirst(A);
	v = list2(0,0);
	A = lred2(A);
	if ( A == _0 ) return(0);
	do {
		e = lfirst(A);
		A = lred(A);
		a = lfirst(A);
		A = lred(A);
		i = iavalint(p,a);
		if ( i ) {
			i1 = itor(i);
			e  = n-e;
			e1 = itor(e);
			w  = rquot(i1,e1);
			v1 = iprod(lfirst(v),lsecond(w));
			w1 = iprod(lsecond(v),lfirst(w));
			if (icomp(v1,w1) >= 0) v = w;
		}
		else return(0);
	} while ( A != _0 );
	return(v);
}
