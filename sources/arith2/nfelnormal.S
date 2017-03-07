/*M
.SH NAME
nfelnormal - number field element normalized representation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfelnormal(L)  
list L;
 
.SH DESCRIPTION
.TP 4
.B L
is a list in one of the following forms:
 1) (A 0),
 2) (A r l_r ... l_0), where
.IP
A is an integer number, not equal to zero,
.IP
(r l_r ... l_0) is the dense-representation of a polynomial, say P, over the integer numbers.
.PP
nfelnormal returns the representation of a number field element, say a, belonging to L. The returned representation has fractions only in their lowest terms, so
.TP 4
in case 1) a = 0,
.TP 4
in case 2) a = (HNa r a_r ... a_0), where
.IP
HNa is a positive integer number,
.IP
(r a_r ... a_0) is the dense representation of an univariate polynomial, say P1, over the integer numbers, so that
.IP
 gcd(HNa, gcd(a_r, ..., a_0)) = 1 and  
 1/A * P = 1/HNa * P1 hold. 

M*/
              
/*H
	Version 1       16.08.1988      Pascale Serf
   DATE nfelnormal    : 890601
H*/




# include <_arith2.h>

nfel nfelnormal(L)
list L;
{
	single r;
	int HN;
	nfel a = 0;

	bind(L,a);
	init(HN);

	if ( llength(L) > 2 ) {

	    HN = lfirst(L);
	    r = lsecond(L);
	    a = lred2(L);
	    a = lcomp2(r+1,HN,a);

	    udpicontpp(a,&a);
	    if ( icomp(lsecond(a),0) < 0 ) a = udpineg(a);

	    HN = lsecond(a);
	    a = lred2(a);
	    a = lcomp2(HN,r,a);

	}

	/***    Rueckgabe    ***/
	return(a);

}
