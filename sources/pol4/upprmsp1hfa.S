/*M
.SH NAME
upprmsp1hfa - univariate polynomial over polynomial ring over modular single prime, transcendence degree 1, Hensel factorization approximation

.SH SYNOPSIS
.nf
#include<_pol4.h>

list upprmsp1hfa(p, F, P, L, k) 
single p, k; 
pol F, P; 
list L; 

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is a univariate polynomial of positive degree over the polynomial ring in x over Z/(pZ).
.TP 4
.B P
is a monic and irreducible polynomial in Z/(pZ)[x], P must not divide the leading coefficient of F.
.TP 4
.B L
= (f_1, ..., f_r) is a list of coprime univariate polynomials over Z/(pZ)[x], such that
.IP
F = f_1 * ... * f_r mod (P) 
.IP
holds. The coefficients of f_i are polynomials in Z/pZ[x] of degree < deg(P). For i > 1, f_i is monic.
.TP 4
.B k
is a natural number, k > 1, such that the product of deg(P) and the smallest power of 2, which is greater or equal to k, is a single.
.PP
upprmsp1hfa returns a list of r univariate polynomials of positive degree over Z/(pZ)[x], say F_1, ..., F_r, such that
.IP
 f_i = F_i mod (P), for 1 <= i <= r, and
 F = F_1 * ... * F_r mod (P)^k.
.PP
The factorization still holds for (P)^t, where t is the smallest power of 2 greater of equal to k. The coeffi-cients of the F_i are of degree < t * deg(P).
    
M*/
               
/*H
	Version 1       11.11.89        J.Schmitt
   DATE upprmsp1hfa   : 901120
H*/


#include <_pol4.h>

list upprmsp1hfa(p,F,P,L,k)
single p,k;
pol F,P;
list L;
{
	pol F1,P_k,A1,A2,A3,lk,li;
	single e,t,n;
	list L1,L2,L3,T;
	bind(F,P,L);
	init(F1,P_k,A1,A2,A3,lk,li,L1,L2,L3,T);

	F1  = F;
	t   = 1;
	P_k = P;
	while ( t <= k ) { t=2*t; P_k=pmsprod(1,p,P_k,P_k); }
	
	if ( lred(L) == _0 ) {
		A1 = _0;
		while ( F1 != _0 ) {
			e   = lfirst(F1);
			F1  = lred(F1);
		        A2  = lfirst(F1);
			A2  = pmsrem(1,p,A2,P_k);
			F1  = lred(F1);
			if (A2) A1=lcomp2(A2,e,A1);
		}
		F1 = linv(A1);
		L2 = list1(F1);
		return(L2);
	}
		
	lk = lsecond(F1);
	if ( !oequal(lk,list2(0,1)) ) {
		A1 = upmshegcd(p,P_k,lk,&li);
		A1 = _0;   
		L1 = _0;
		n  = lfirst(P_k);
		while ( F1 != _0 ) {
			e   = lfirst(F1);
			F1  = lred(F1);
			A2  = pmsprod(1,p,li,lfirst(F1));
			F1  = lred(F1);
			if (A2) {
			  if ( lfirst(A2) > n ) A2 = pmsrem(1,p,A2,P_k);
			  if (A2) {
				A1 = lcomp2(A2,e,A1);
				A2 = pmsrem(1,p,A2,P);
				if (A2) L1 = lcomp2(A2,e,L1);
			  }
			}
		}
		F1 = linv(A1);
		L1 = linv(L1);
		L3 = lcopy(L);
		A1 = _0;
		A3 = lfirst(L3);
		while ( A3 != _0 ) {
			e   = lfirst(A3);
			A3  = lred(A3);
			A2  = pmsprod(1,p,li,lfirst(A3));
			A3  = lred(A3);
			if (A2) {
		          	A2 = pmsrem(1,p,A2,P);
				if (A2) A1 = lcomp2(A2,e,A1);
			}
		}
		A3 = linv(A1);
		lsfirst(L3,A3);
	}
	else {
		L3 = L;
		A1 = _0;
		A3 = _0;
		while ( F1 != _0 ) {
			e   = lfirst(F1);
			F1  = lred(F1);
		        A2  = lfirst(F1);
			A2  = pmsrem(1,p,A2,P_k);
			F1  = lred(F1);
			if (A2) {
				A1 = lcomp2(A2,e,A1);
				A2 = pmsrem(1,p,A2,P);
				if (A2) A3 = lcomp2(A2,e,A3);
			}
		}
		F1 = linv(A1);
		L1 = linv(A3);
	}

	L2 = upprmsp1hli(p,L1,P,L3);

	L1 = L3;
	A1 = list2(0,1);
	A1 = list2(0,A1);
	while ( L1 != _0 ) {
		A1  = pmsprod(2,p,A1,lfirst(L1));
		L1  = lred(L1);
	}
	T  = list5(P,1,0,P,list2(0,1));
	L2 = list3(L3,L2,A1);

	t  = 1;
	while ( t < k ) {
		L2 = upprmsp1hqs(p,F1,T,lfirst(L2),lsecond(L2),lthird(L2));
   		t  = 2*t;
		A2 = pmsprod(1,p,lfourth(T),lfourth(T));
		T  = list5(P,t,0,A2,list2(0,1));
	}

	L2 = lfirst(L2);

	if ( !oequal(lk,list2(0,1)) ) {
		A3 = lfirst(L2);
		A1 = _0;
		while ( A3 != _0 ) {
			e   = lfirst(A3);
			A3  = lred(A3);
			A2  = pmsprod(1,p,lk,lfirst(A3));
			A3  = lred(A3);
			if (A2) {
			  if ( lfirst(A2) > n ) A2 = pmsrem(1,p,A2,P_k);
			  if (A2) A1 = lcomp2(A2,e,A1);
			}
		}
		if ( A1 != _0 ) A3 = linv(A1);
		else A3 = 0;
		lsfirst(L2,A3);
 	}

	return(L2);
}
