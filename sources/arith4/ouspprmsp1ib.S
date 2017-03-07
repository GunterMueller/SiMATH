/*M
.SH NAME
ouspprmsp1ib - order of an univariate separable polynomial over the polynomial ring over modular single prime, tran-scendence degree 1, integral basis

.SH SYNOPSIS
.nf
#include<_arith4.h>

list ouspprmsp1ib(p, F, pL) 
single p; 
pol F; 
list *pL;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, separable and univariate polynomial over the polynomial ring (Z/pZ) [x].
.PP
Let C be the integral closure of the polynomial order of F in A.
ouspprmsp1ib returns 
a list, containing univariate poloynomials over (Z/pZ)(x) of degree smaller than the degree of F. These polynomials represent elements in A, which form a (Z/pZ)[x]-basis of C.
ouspprmsp1ib writes the empty list to *pL, if the polynomial order of F is maximal, i.e. equal to C. Otherwise, ouspprmsp1ib writes a list L to *pL, where 
.IP
L = ( P_1, e_1, ..., P_r, e_r ), with
.IP
 P_i a prime polynomial in (Z/pZ)[x],
 e_i a positive integral number, such that
.IP
(P_1)^(e_1) * ... * (P_r)^(e_r) is equal to the index of the polynomial order in C.

.SH NOTES
ouspprmsp1ib uses the  FORD / ZASSENHAUS-algorithm ROUND 4.
 
M*/
      
/*H
	Version 1    	28.02.90        J.Schmitt
   DATE ouspprmsp1ib  : 901120
H*/

#include<_arith4.h>

list ouspprmsp1ib(p,F,pL)
single p;
pol F;
list *pL;
{
	list L,Lk,B,M;
	single n,i,k,e;
	pol P,Q,rd,c;
	init(L,Lk,B,M,P,Q,rd,c);
	bind(F);
          
	c  = upprmsp1disc(p,F);
	rd = upprmsp1redd(p,F);                 
	rd = pmsmonic(1,p,rd);
	if ( pdegree(1,rd) ) M  = upmscfacts(p,rd);   
	else M = _0;
	L  = _0;
	while ( M != _0 ) {
		B = lfirst(M);
		M = lred(M);
		n = lfirst(M);
		M = lred(M);
		if ( n != 1 ) L = lcomp2(B,n,L);
	        else {
			Q = pmsquot(1,p,c,B);
                        if ( !pmsrem(1,p,Q,B) ) L = lcomp2(B,n,L);
		}     
	}
	while ( L != _0 ) {
		P = lfirst(L);
		L = lred(L); 
		e = lfirst(L);
		L = lred(L); 
		if ( ouspprmsp1dm(p,P,F) ) {
			Q = pmsexp(1,p,P,e);
			M = lcomp2(P,Q,M);
		}
	}                  

	Lk = _0;
	n  = lfirst(F);
	c  = list2(0,1);
	if ( M == _0 ) {
		for (i=0;i<n;i++) {
			B = list2(c,c);
			B = list2(i,B);
			M = lcomp(B,M);
		}                 
	}
	else {
		B = cdmarfmsp1id(n);
                do {
			P  = lfirst(M);
			M  = lred(M);
                        Q  = lfirst(M);
                        M  = lred(M);
                        L  = ouspprmsp1bl(p,F,P,Q,&k);
			Lk = lcomp2(k,P,Lk);
			B  = lconc(L,B);
			B  = cdmarfmsp1hr(p,B);
		} while ( M != _0 );         
		if ( Lk != _0 ) Lk = linv(Lk);
		B = cdprfmsp1lfm(B,p); 
		while ( B != _0 ) {  
			P = uprfmsp1fcdp(p,lfirst(B));
			B = lred(B);
			M = lcomp(P,M);
		}
	}
	L = linv(M);
	*pL = Lk;
	return(L);
}
