/*M
.SH NAME
nftrace - number field element trace

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
nftrace returns the trace of a with regard to K/Q.

.SH SEE ALSO
nfneg

M*/
                  
/*H
	Version 1	24.04.91	J.Schmitt
   DATE nftrace       : 910915
H*/

#include <_arith2.h>

rat nftrace( P, a )
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
	b = rinv(itor(b));

	if ( !lfirst(a) ) {
		M = lsecond(a);
		M = iprod(M,n);
		M = itor(M);
		M = rprod(M,b);
		return(M);
	}

	M = _0;
	for (i=0;i<n;i++) {
                if ( !a ) {
			for ( k=0,L=_0;k<n;k++,L=lcomp(0,L) );
		}
		else {
			j = lfirst(a) + 1;
			for (k=(n-j), L=lred(a); k > 0; k--, L=lcomp(0,L));
		}	
		M = lcomp(L,M);
		a = udpiprod(a,list3(1,1,0));
		if ( pdegree(1,a) >= n ) a = udpipsrem(a,P);
	}	                                     
	M = maitrace(M);
	M = itor(M);
	M = rprod(M,b);
	return(M);    
}
