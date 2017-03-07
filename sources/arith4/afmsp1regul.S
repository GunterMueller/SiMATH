/*M
.SH NAME
afmsp1regul - algebraic function over modular single primes, transcendence degree 1, regulation

.SH SYNOPSIS
.nf
#include<_arith4.h>

rat afmsp1regul(p, F, P, Q, a0, mpa0, pa1, pa2)  
single p; 
pol F, P, Q, a0, mpa0, *pa1, *pa2;
                              
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, univariate and separable polynomial over the polynomial ring (Z/pZ) [x].
.TP 4
.B P
is a monic and irreducible polynomial in (Z/pZ) [x].
.TP 4
.B Q
is a power of P. The product of Q with an arbitrary element in the P-maximal over-order of the polynomial order of F lies in the
polynomial order.
.TP 4
.B a0
is a CD-polynomial, representing a P-primary integral element in A (s. cdprfmsp1fcl).
The minimal polyno-mial of a0 has the same degree as F.
.TP 4
.B mpa0 
is the (modulo P unique) irreducible factor of the minimal polynomial of a0 of degree smaller than the degree of F.
.PP
afmsp1regul computes a rational number v (say), and two CD-polynomials, pa1 and pa2, representing two elements a1 and a2 in A, such that
.IP
 a1 = mpa0(a0),
 v  = (v_P)*(a1), and for v =: w1/v1
 (v_P)* (a2) = 1/v1. 
.PP
afmsp1regul returns v and writes pa1 and pa2 to *pa1 and *pa2 respectively.

.SH SEE ALSO
.nf
iafmsp1psval
cdprfmsp1fcl

M*/
     
/*H
	Version 1       11.01.90	J.Schmitt
   DATE afmsp1regul   : 901120.9203__
H*/

#include<_arith4.h>

rat afmsp1regul(p,F,P,Q,a0,mpa0,pa1,pa2)
single p;
pol F,P,Q;
pol a0,mpa0;
pol *pa1,*pa2;
{
	single d,dp,j,vz,wz;
	rat v;
	pol a1,a2,z,M;
	init(v,a1,a2,z,M);
	bind(F,P,Q,a0,mpa0);

	a1 = upprmsp1afes(p,F,mpa0,a0);
	d  = 1;                         
	M  = P;
	for ( ; ; ) {
        	if (a1) {     
			do {
				d = d + d;
				M = pmsprod(1,p,M,M);
				z = cdprfmsp1mh(p,a1,M);
			} while ( !z );
		}
		else z = 0;
		a2 = afmsp1minpol(p,F,z);
 		v  = iafmsp1psval(p,P,a2);               

		vz = rden(v) * d;
		wz = rnum(v);
		if ( wz < vz ) { dp = rfloor(v) + 1; break; }
	}
	M  = pmsexp(1,p,P,dp);
	a2 = cdprfmsp1mh(p,a1,M);
	vz = rnum(v);
	wz = rden(v);
	if ( vz > 1 ) {
		j = segcd(vz,wz,&d,&dp);
		if ( d <= 0 ) {
			d  = d  + wz;
			dp = dp - vz;
		}
		if ( wz == 1 ) j = 2;
		M  = pmsexp(1,p,P,(j-dp));
		a2 = afmsp1expsp(p,F,a2,d,M);
		M  = pmsquot(1,p,M,P);
		if ( j == 2 ) M = pmsquot(1,p,M,P);
		a2 = cdprfmsp1upq(p,a2,M);
	}       
	*pa1 = a1;
	*pa2 = a2;
	return(v);
}
