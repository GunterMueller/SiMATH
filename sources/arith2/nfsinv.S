/*M
.SH NAME
nfsinv - number field, sparse representation, inverse

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfsinv(F,a)  
pol F; 
nfel a;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Q of degree r (say), with r >= 1. F generates the number field K (say).
.TP 4
.B a
is an element of K, represented as univariate sparse polynomial over Q of degree < r, a != 0.
.PP
nfsinv returns the multiplicative inverse of a, which is represented in the same way as a. 

M*/
                             
/*H
	Version 1       16.06.1988      Pascale Serf
	Version 2       22.07.1988      nf durch nfs ersetzt.  PS
   DATE nfsinv        : 890501
H*/


# include <_arith2.h>

nfel nfsinv(F,a)
pol F;
nfel a;
{
	pol a1,a2,q,r,v,v1,v2;
	rat c;

	bind(F,a);
	init(a1,a2,q,r,v,v1,v2,c);

	/***    Initialisierungen    ***/
	a1 = F; a2 = a;
	v = 0; v1 = itor(1); v1 = list2(0,v1);

	/***    euklidischer Algorithmus fuer F und a    ***/
	while ( lfirst(a2) ) {
	    q = prqrem(1,a1,a2,&r);
	    a1 = a2; a2 = r;
	    v2 = prdif(1,v,prprod(1,q,v1)); v = v1; v1 = v2;
	}
	v = prrquot(1,v1,lsecond(a2));

	return(v);
}
