/*M
.SH NAME
upprmsp1hqs - univariate polynomial over polynomial ring over modular single prime, transcendence degree 1, Hensel quadratic step

.SH SYNOPSIS
.nf
#include<_pol4.h>

list upprmsp1hqs(p, F, T, L1, L2, A) 
single p; 
pol F, A; 
list T, L1, L2;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is an univariate and monic polynomial of positive degree over the polynomial ring in x over Z/(pZ). 
.TP 4
.B T
= (P, k, l, Pk, Pl).
.TP 8
.B P
is a monic and irreducible polynomial in Z/(pZ)[x].
.TP 8
.B k,l 
are two integral number, such that l >= 0 and k > 2*l hold.
.TP 8
.B Pk
= (P)^k.
.TP 8
.B Pl
= (P)^l.
.TP 4
.B L1
= (f_1, ..., f_r) is a list of univariate and monic polynomials over Z/(pZ)[x], such that
.IP
F = f_1 * ... * f_r mod (Pk)
.IP
holds.
The coefficients of the f_i are of degree < k * deg(P).
.TP 4
.B A
= f_1 * ... * f_r.
.TP 4
.B L2
= ( A1, A2, ... , Ar )is a list of univariate polynomials over Z/(pZ)[x]. For 1 <= i <= r, deg(A_i) is smaller than deg(f_i). Let
.IP
F_i := A/f_i,
.PP
then
.IP
( F_1 * A_1 ) + ... + ( F_r * A_r ) = (Pl) mod (Pk)
must hold.
.PP
upprmsp1hqs returns a list L = (L3, L4, A2), where
L3 and L4 are lists fulfilling the conditons of the lists L1 and L2 respectively for 2 * (k-l). A2 is the product of the polynomials in L3.

M*/
                   
/*H
	Version 1       02.11.89       J.Schmitt
   DATE upprmsp1hqs   : 901120
H*/

#include <_pol4.h>

list upprmsp1hqs(p,F,T,L1,L2,A)
single p;
pol F,A;
list T,L1,L2;
{                       
	single t;
	pol P_t,P_2t,A0,A1,A2,A3,G;
	list L1a,L2a,L3,L4;
	bind(F,T,L1,L2,A);
	init(P_t,P_2t,A0,A1,A2,A3,G,L1a,L2a,L3,L4);

	P_t  = pmsquot(1,p,lfourth(T),lfifth(T));
	P_2t = pmsprod(1,p,P_t,P_t);
	if ( lred(L1) == _0 ) {
		A2 = _0;
  		while ( F != _0 ) {
			t  = lfirst(F);
			F  = lred(F);
			A3 = pmsrem(1,p,lfirst(F),P_2t);
			F  = lred(F);
			if (A3) A2 = lcomp2(A3,t,A2);
		}
		A2  = linv(A2);
		L1a = list1(A2);
		L2a = list3(L1a,L2,A2);
		return(L2a);
	}
	A1 = pmsdif(2,p,F,A);
	A2 = list2(0,lfourth(T));
	G  = pmsquot(2,p,A1,A2);
/*      G  = ( F - (f_1*...*f_r) ) / (P)^k                       */

	L3 = _0;
	L1a= L1;
	L2a= L2;
	while( L2a != _0 ) {
		A1  = pmsprod(2,p,G,lfirst(L2a));
		L2a = lred(L2a);
		A1  = pmsrem(2,p,A1,lfirst(L1a));
		A2  = list2(0,P_t);
		A1  = pmsprod(2,p,A1,A2);
		A1  = pmssum(2,p,A1,lfirst(L1a));
		L1a = lred(L1a);
		A2  = _0;
		while( (A1) && (A1!=_0) ) {
			A0 = pmsrem(1,p,lsecond(A1),P_2t);
			if (A0) A2 = lcomp(lfirst(A1),A2);
			A1 = lred(A1);
			if (A0) A2 = lcomp(A0,A2);
			A1 = lred(A1);
		}
		if ( A2 != _0 ) A2 = linv(A2); 
		else A2  = 0;
		L3 = lcomp(A2,L3);
	}
	L3 = linv(L3);
/*      L3 = ( g_1, ... , g_r )                                 */
/*	g_i= ( G * A_i ) * P_t + f_i mod ( f_i , P_2t )         */

	L1a = L1;
	L2a = L2;
	A0  = 0;
	while( L1a != _0 ) {
		A1  = pmsquot(2,p,A,lfirst(L1a));
		L1a = lred(L1a);
		A1  = pmsprod(2,p,A1,lfirst(L2a));
		L2a = lred(L2a);
		A0  = pmssum(2,p,A1,A0);
	}
	A2 = lfifth(T); A2 = list2(0,A2);   /* MX2+ compiliert A2=list2(0,lfifth(T)) nicht */
	A0 = pmsdif(2,p,A0,A2);
	A2 = list2(0,lfourth(T));
	A0 = pmsquot(2,p,A0,A2);
/*      A0 = ( (F_1*A_1 + ... + F_r*A_r) - (P)^l ) / (P)^k      */

	L1a = L3;
	A2  = lfirst(L1a);
	L1a = lred(L1a);
	while( L1a != _0 ) {
		A2  = pmsprod(2,p,A2,lfirst(L1a));
		L1a = lred(L1a);
	}
	G   = 0;
	L1a = L1;
	L2a = L2;
	L4  = L3;
	while ( L4 != _0 ) {
		A1  = pmsquot(2,p,A2,lfirst(L4));
		L4  = lred(L4);
		A3  = pmsquot(2,p,A,lfirst(L1a));
		L1a = lred(L1a);
		A1  = pmsdif(2,p,A1,A3);
		A1  = pmsprod(2,p,A1,lfirst(L2a));
		L2a = lred(L2a);
		G   = pmssum(2,p,G,A1);
	}
	A1 = list2(0,lfourth(T));
	G  = pmsquot(2,p,G,A1);
	G  = pmssum(2,p,G,A0);
	G  = pmsneg(2,p,G);
/*      G  = -( ( (G_1 - F_1)*A_1 + ... + (G_r - F_r)*A_r )/(P)^k + A0 ) */
/*	falls L3 = (g_1, ..., g_r) und G_i = (g_1 * ... * g_r) / g_i     */

	L1a = L1;
	L2a = L2;
	L4  = _0;
	while( L2a != _0 ) {
		A1  = pmsprod(2,p,G,lfirst(L2a));
		A1  = pmsrem(2,p,A1,lfirst(L1a));
		L1a = lred(L1a);
		A0  = list2(0,P_t);
		A1  = pmsprod(2,p,A1,A0);
		A1  = pmssum(2,p,A1,lfirst(L2a));
		L2a = lred(L2a);
		A0  = _0;
		while( (A1) && (A1 != _0) ) {
			A3 = pmsrem(1,p,lsecond(A1),P_2t);
			if (A3) A0 = lcomp(lfirst(A1),A0);
			A1 = lred(A1);
			if (A3) A0 = lcomp(A3,A0);
			A1 = lred(A1);
		}
		if ( A0 != _0 ) A0 = linv(A0);
		else A0 = 0;
		L4 = lcomp(A0,L4);
	}
	L4  = linv(L4);
/*      L4  = (B_1, ..., B_r)                                */
/*	B_i = ( A_i * G ) * P_t + A_i mod ( f_i, P_2t )      */
  
	A0  = list3(L3,L4,A2);
	return(A0);
}
