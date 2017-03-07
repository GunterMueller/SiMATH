/*M
.SH NAME
afmsp1prodsp - algebraic function over modular single prime, transcendence degree 1, product special

.SH SYNOPSIS
.nf
#include<_arith4.h>

pol afmsp1prodsp(p, F, a, b, M) 
single p; 
pol F, a, b, M;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, separable and univariate polynomial over the polynomial ring (Z/pZ) [x].
The algebra A arises by the adjunction of a zero of F, say u.  
.TP 4
.B a and b
are elements in A, represented by CD-polynomials (s. cdprfmsp1fcl).
.TP 4
.B M
is a polynomial in x over (Z/pZ). 
.PP
afmsp1prodsp returns a CD-polynomial, which represents a*b in A. If the polynomial M is not the zero polynomial, c will be reduced modulo ( M * (Z/pZ)[x] ) [u]. 
.SH SEE ALSO
cdprfmsp1fcl

M*/
          
/*H
	Version 1       16.01.90        J.Schmitt
   DATE afmsp1prodsp  : 901120
H*/

#include<_arith4.h>

pol afmsp1prodsp(p,F,a,b,M)
single p;
pol F,a,b,M;
{
	single i;
	pol ap,bp,cp,N,c;
	init(ap,bp,cp,N,c);
	bind(F,a,b,M);

	if ((a==0)||(b==0)) return(0);

	ap = lfirst(a);
	a  = lred(a);
	bp = lfirst(b);
	b  = lred(b);
        cp = pmsprod(1,p,ap,bp);
		
        if (M) N = pmsprod(1,p,cp,M);
	else   N = 0;
	c = pmsprod(2,p,a,b);
	if (N) {
		bp = _0;
		while (c!=_0) {
			i  = lfirst(c);
			c  = lred(c);
                        ap = lfirst(c);
			c  = lred(c);
			ap = pmsrem(1,p,ap,N);
			if (ap) bp = lcomp2(ap,i,bp);
		}
		if (bp!=_0) c = linv(bp);
		else c = 0;	
	}        
 	c = pmsrem(2,p,c,F);
	if (N && c) {
		bp = _0;
		while (c!=_0) {
			i  = lfirst(c);
			c  = lred(c);
                        ap = lfirst(c);
			c  = lred(c);
			ap = pmsrem(1,p,ap,N);
			if (ap) bp = lcomp2(ap,i,bp);
		}
		if (bp!=_0) c = linv(bp);
		else c = 0;	
	}                             
	if (c) {
		c = lcomp(list2(0,1),c);
		c = cdprfmsp1upq(p,c,cp);
	}
	return(c);
}
