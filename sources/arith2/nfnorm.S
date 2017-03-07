/*M
.SH NAME
nfnorm - number field element norm

.SH SYNOPSIS
.nf
#include<_arith2.h>

rat nfnorm( F, a )  
pol F; 
nfel a;
  
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, monic and univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a
is an element of K (for representation of number field elements s. nfneg).
.PP 
nfnorm returns the norm of a with regard to K/Q.

.SH SEE ALSO
nfneg

M*/
                                 
/*H
	Version 1	24.04.91	J.Schmitt
   DATE nfnorm        : 910915
H*/

#include <_arith2.h>

rat nfnorm( P, a )
pol P;
nfel a;
{
	single i,n,j,k;
	matrix M;
	list L;
	int b;
	bind(P,a);
	init(M,L,b);

	if (!a) return(0);
        b = lfirst(a);
	a = lred(a);

	n = pdegree(1,P);
	b = iexp(b,n);
	b = rinv(itor(b));
        
	if ( !lfirst(a) ) { 
		M = lsecond(a);
		M = iexp(M,n);
		M = itor(M);
		M = rprod(M,b);
		return(M);
	}

	M = _0;
	for (i=0;i<n;i++) {
		if ( !a ) return(0);
		j = lfirst(a) + 1;
		for (k = (n - j), L = lred(a); k > 0; k--, L = lcomp(0,L));
		M = lcomp(L,M);
		a = udpiprod(a,list3(1,1,0));
		if ( pdegree(1,a) >= n ) a = udpipsrem(a,P);
	}	                                     
	M = maidet(M);
	M = itor(M);
	M = rprod(M,b);
	return(M);    
}
