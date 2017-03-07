/*M
.SH NAME
ippnfeidpval - integral p-primary number field element, increasing the denominator of the p-star value 

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol ippnfeidpval(F, p, a0, a2, wa, b2, wb, py, pwy)  
pol F, a0, a2, b2, *py;
single p, wa, wb, *pwy; 
 
.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic,  separable and univariate polynomial over the integer numbers.
.TP 4
.B p
is a single prime number. 
.TP 4
.B a0, a2 and b2 
are p-primary integral elements in A, represented by CD-polynomials (s.cdprfcl). a2 arises from a0 as described in ippnferegul (notation there for a2 : *pa2).
.TP 4
.B wa, wb
are positive singles, wb does not divide wb and
.IP
(v_p)* (a2) = 1 / wa and (v_p)* (b2) = 1 / wb
.PP
hold.
.TP 4
.B *pwy 
is equal to the least common multiple of wa and wb.
.TP 4
.B *py 
is a p-primary integral element in A, with (v_p)* value equal to 1/*pwy, *py is represented by a CD-Polynomial.
.PP
ippnfeidpval returns a p-primary integral element, say a, in A, such that
.IP
(v_p)* ( m(a) ) = 1 / *pwy 
.PP
holds, whereat m is the unique (modulo p) irreducible factor of the minimal polynomial of a.
.PP
a is given by a CD-polynomial.

.SH SEE ALSO
 cdprfcl
 ippnfelregul

M*/
                           
/*H
	Version 1       05.06.89        J.Schmitt
	Version 2	30.12.89	J.Schmitt
					Sicherung von *py und *pwy.
	Version 3       04.07.1991      ueberfl. Variable j beseitigt.  PS
   DATE ippnfeidpval  : 891101.900101.910715.9203__
H*/

#include<_arith2.h>

pol ippnfeidpval(F,p,a0,a2,wa,b2,wb,py,pwy)
pol F;
single p;
pol a0,a2,b2;
single wa,wb;
pol *py;
single *pwy;
{
	int pp;
	single k, l;
	pol a, h;
	bind(F,a0,a2,b2);
	init(a,h,pp);

	segcd(wa,wb,&k,&l);
	if ( k < 0 ) k = k + wb;
	else	     l = l + wa;
	pp = iprod(p,p);                                                       
	a = nfeexpspec(F,b2,k,pp);
	h = nfeexpspec(F,a2,l,pp);
	h = nfeprodspec(F,a,h,pp);
	h = cdpriquot(h,p);
	k = ilcm(wa,wb);
	a = cdprsum(a0,h);
	*pwy = k;
	*py  = h;
	return(a);
}
