/*M
.SH NAME
upprmsp1hli - univariate polynomial over polynomial ring over modular single prime, transcendence degree 1, Hensel lemma initialization

.SH SYNOPSIS
.nf
#include<_pol4.h>

list upprmsp1hli(p, F, P, L) 
single p; 
pol F, P; 
list L;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is an univariate and monic polynomial of degree > 1 over the polynomial ring in x over Z/(pZ).
.TP 4
.B P
is a monic and irreducible polynomial in Z/(pZ)[x].
.TP 4
.B L
= (f_1, ..., f_r) is a list of coprime univariate and monic polynomials over Z/(pZ)[x], such that
.IP
F = f_1 * ... * f_r mod (P)
.IP
holds.
.PP
upprmsp1hli returns a list of r univariate and coprime polynomials over Z/(pZ)[x], say A_1, ..., A_r. For 1 <= i <= r, deg(A_i) is smaller than deg(f_i). Let 
.IP
F_i := (f_1 * ... * f_r)/f_i,
.PP
then
.IP
( F_1 * A_1 ) + ... + ( F_r * A_r ) = 1 mod (P)
.PP
will hold.


M*/
          
/*H
	Version 1      	02.11.89        J.Schmitt                  
   DATE upprmsp1hli   : 901120
H*/

#include <_pol4.h>

list upprmsp1hli(p,F,P,L)
single p;
pol F,P;
list L;
{                           
	single t,n;
	pol Pred,P1,A1,A2;
	list H,La,L1,Li,AL;
	bind(F,P,L);
	init(Pred,P1,A1,A2,H,La,L1,Li,AL);

	if ( lred(L) == _0 ) {
		  A1 = list2(0,1);
		  A1 = list2(0,A1);
		  A1 = list1(A1);
		  return(A1);
	}                                 
                  
	n = lfirst(P);
	A1 = _0;
	while ( F != _0 ) {          
		t  = lfirst(F);
		F  = lred(F);
		A2 = lfirst(F);
		if ( lfirst(A2) > n ) A2 = pmsrem(1,p,lfirst(F),P);
		if (A2) A1=lcomp2(A2,t,A1);
		F  = lred(F);
	}
	F = linv(A1);

	AL = gfsalgen(p,n,P);
	La = L;
	H  = _0;
	while ( La != _0 ) {
		A1  = pgfsquot(1,p,AL,F,lfirst(La));
		La  = lred(La);
		H   = lcomp(A1,H);
	}
	La = linv(H);
/*      La = ( F_1 , ... , F_r ) - siehe Dokumentation. */

	Pred = lfirst(La);
	La = lred(La);
	A1 = list2(0,1);
	A1 = list2(0,A1);
	L1 = list1(A1);

	while  ( La != _0 ) {
		Pred = upgfsegcd(p,AL,Pred,lfirst(La),&A1,&A2);
		La   = lred(La);
		Li   = _0;
		H    = L;
		while ( L1 != _0 ) {
			P1  = pgfsprod(1,p,AL,lfirst(L1),A1);
			L1  = lred(L1);
			P1  = pgfsrem(1,p,AL,P1,lfirst(H));
			H   = lred(H);
			Li  = lcomp(P1,Li);
		}
		Li = lcomp(A2,Li);
		L1 = linv(Li);
	}
	return(L1);
}
