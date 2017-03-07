/*M
.SH NAME
cdprfmsp1fcl - common denominator polynomial over rational functions over modular single prime, transcendence degree 1, from coefficient list

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol cdprfmsp1fcl(L, p) 
list L; 
single p;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS.
.TP 4
.B L:
Let  P = a_n * y^n + ... + a_0 * y^0 be a polynomial over the rational function field over Z/(pZ), P != 0, and let d be the common denominator of the coefficients of P. For b_i := d * a_i (0<=i<=n), the list 
 (d, b_n, .. b_0)
is called the 'coefficient list' of P.
.IP 
L is such a coefficient list of a polynomial, say P.
.PP
Let 0 <= e_1 < ... < e_m <= n be the numbers for which b_(e_i) != 0 hold.
cdprfmsp1fcl returns the list 
.IP
(d, e_m, b_(e_m), ... e_1, b_(e_1)),
.PP
representing P as a CD-polynomial.
   
M*/
               
/*H
	Version 1       15.10.89        J.Schmitt
   DATE cdprfmsp1fcl  : 901120
H*/

#include<_pol4.h>

pol cdprfmsp1fcl(L,p)
list L;                           
single p;
{
	pol P,P1,k,l,d;
	single n,e;
	init(P,P1,k,l,d);
	bind(L);

	k = lfirst(L);
	L = lred(L);
	while ( (lfirst(L) == 0) && (lred(L) != _0) ) { L = lred(L); }
	if ( lfirst(L) == 0 ) return(0);

	n = llength(L) - 1;
	P = lcomp(n,L);
	P = dptop(1,P);
	P1 = P;
	d  = k;
	while (P1!=_0) {
		P1= lred(P1);
		l = lfirst(P1);
		P1= lred(P1);
		k = upmsgcd(p,k,l);
	}
	while (P!=_0) { 
		e = lfirst(P);
		P = lred(P);
		l = lfirst(P);
		P = lred(P);
		l = pmsquot(1,p,l,k);
		P1= lcomp2(l,e,P1);
	}
	P1= linv(P1);    
	d = pmsquot(1,p,d,k);
	P = lcomp(d,P1);
	return(P);
}
