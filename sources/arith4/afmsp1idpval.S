/*M
.SH NAME
afmsp1idpval - algebraic function over modular single primes, transcendence degree 1, increasing the denominator of the P-star value

.SH SYNOPSIS
.nf
#include<_arith4.h>

pol afmsp1idpval(p, F, P, a0, a2, wa, b2, wb, py, pwy)
single p, wa, wb, *pwy;
pol F, P, a0, a2, b2, *py;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is the defining polynomial of a separable algebra, say A, over (Z/pZ) (x), the rational function field over Z/pZ, i.e. F is a monic, separable and univariate
polynomial over the polynomial ring (Z/pZ) [x].
.TP 4
.B P
is a monic and irreducible polynomial in (Z/pZ) [x].     
.TP 4
.B a0, a2 and b2
are integer elements in A, represented by CD-polynomials (s. cdprfmsp1fcl). a0 is P-primary. a2 arises trough a0 by the method used in afmsp1regul, notations
there: a0 and *pa2.
.TP 4
.B wa and wb
are positive singles, such that
.IP
 wb does not divide wb,
 (v_P)* (a2) = 1 / wa, and
 (v_P)* (b2) = 1 / wb.
.PP
afmsp1idpval computes a single, say wy and two P-primary integer elements in A, say a and y, both represented by CD-polynomials, such that
.IP
.nf
wy = lcd(wa,wb),
(v_P)*(y) = 1 / wy and
(v_P)*(m(a) = 1/ wy, 
.PP
where m(a) is the (modulo P unique) irreducible factor of 
the minimal polynomial of a.
afmsp1idpval returns a and writes wy, y to *pwy and *py 
respectively.                                                 
.SH SEE ALSO
.nf
cdprfmsp1fcl
iafmsp1psval
afmsp1regul

M*/                     

/*H
	Version 1       15.01.90        J.Schmitt
   DATE afmsp1idpval  : 901120.9203__
H*/

#include<_arith4.h>

pol afmsp1idpval(p,F,P,a0,a2,wa,b2,wb,py,pwy)
single p;
pol F,P,a0,a2,b2;
single wa,wb;
pol *py;
single *pwy;
{
	pol a,pp,y;
	single k,l;
	bind(F,P,a0,a2,b2);
	init(a,pp,y);

	segcd(wa,wb,&k,&l);
	if ( k < 0 ) k = k + wb;
	else	     l = l + wa;
	pp = pmsprod(1,p,P,P);
	a = afmsp1expsp(p,F,b2,k,pp);
	y = afmsp1expsp(p,F,a2,l,pp);
	y = afmsp1prodsp(p,F,a,y,pp);
	y = cdprfmsp1upq(p,y,P);
	a = cdprfmsp1sum(p,a0,y);
	*pwy = ilcm(wa,wb);
	*py  = y;
	return(a);
}
