/*M
.SH NAME
modielemtest - module over the integers element test

.SH SYNOPSIS
.nf
#include<_arith2.h>

single modielemtest(B, a)  
list B; 
pol a;
   
.SH DESCRIPTION
Let A be a seperable algebra over the rational numbers.
.TP 4
.B B
is a list of CD-polynomials over the rational numbers (for B = (p_1 ... p_l), deg(p_i) > deg(p_(i+1)) must hold), these polynomials represents elements of A, forming a Z-base of a Z-module (say M) in A.
.TP 4
.B a
is a CD-polynomial, representing an element in A.
.PP
modielemtest returns 1, if a is an element in M, and 0 else.
 
M*/
        
/*H
	Version 1       29.05.89        J.Schmitt
   DATE modielemtest  : 891101.9001__.9211__
H*/

#include<_arith2.h>

single modielemtest(B,a)
list B;
pol a;
{
	list Bl;
	int z1,k1,z3,k3,d,r,q;
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
		q = iprod(z3,k1);
		r = iprod(z1,k3);
		d = iqrem(q,r,&q,&r);
		if ( r != 0 ) return(0);
		q = ineg(q);
		r = lfirst(Bl);
		Bl = lred(Bl);
		Bl = piiprod(1,Bl,q);
		Bl = lcomp(r,Bl);
		a = cdprsum(a,Bl);
	} while ( a != 0 );
	return(1);
}
