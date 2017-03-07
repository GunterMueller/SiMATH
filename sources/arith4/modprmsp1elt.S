/*M
.SH NAME
modprmsp1elt - module over polynomial ring over modular single primes, transcendence degree 1, element test

.SH SYNOPSIS
.nf
#include<_arith4.h>

single modprmsp1elt(B, p, a)  
list B; 
single p; 
pol a;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.   
.TP 4
.B B
is a list containing univariate CD-polynomials b1,...,bn over (Z/pZ)(x).
deg(b1) >...> deg(bn) must hold.
The polynomials represent elements in a seperable algebra, say A, over (Z/pZ)(x) (s.cdprfmsp1fcl). These elements again generate a module M over (Z/pZ)[x] in A.
.TP 4
.B a
is an element in A, represented by a CD-polynomial.
.PP
modprmsp1elt returns 1, if a is an element in M and 0 else.

.SH SEE ALSO
cdprfmsp1fcl

M*/
       
/*H
	Version 1       29.10.89        J.Schmitt
   DATE modprmsp1elt  : 901120.9211__
H*/

#include<_arith4.h>

single modprmsp1elt(B,p,a)
list B;                 
single p;
pol a;
{
	list Bl;
	pol z1,k1,z3,k3,d,r,q;
	single z2,k2;
	init(Bl,z1,k1,z3,k3,d,r,q);
	bind(B,a);

	if (a==0) return(1);

	do {
		z1 = lfirst(a);
		z2 = lsecond(a);
		z3 = lthird(a);
		do {
			Bl = lfirst(B);
			B = lred(B);
			k2 = lsecond(Bl);
		} while ( ( z2 != k2 ) && ( B != _0 ) );
                if ( z2 != k2 ) return(0);
		k1 = lfirst(Bl);
		k3 = lthird(Bl);
		q = pmsprod(1,p,z3,k1);
		r = pmsprod(1,p,z1,k3);
		q = pmsqrem(1,p,q,r,&d);
		if ( d != 0 ) return(0);
		d = upmsgcd(p,q,k1);
		q = pmsquot(1,p,q,d);
		k1 = pmsquot(1,p,k1,d);
		q = pmsneg(1,p,q);   
		z1 = _0;           
		Bl = lred(Bl);
		while ( Bl!=_0 ) {
			z2 = lfirst(Bl);
			Bl = lred(Bl);
			z3 = lfirst(Bl);
			Bl = lred(Bl);
		        z3 = pmsprod(1,p,z3,q);
          		z1 = lcomp2(z3,z2,z1);
		}
		Bl = lcomp(k1,linv(z1));
		a = cdprfmsp1sum(p,a,Bl);
	} while ( a != 0 );
	return(1);
}
