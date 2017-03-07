/*M
.SH NAME
cdprfmsp1inv - common denominator polynomial over rational functions over
modular single prime, transcendence degree 1, inverse

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol cdprfmsp1inv(p,F,A) 
single p; 
pol F, A;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, 1 < p < BASIS. 
.TP 4
.B F 
is a monic and univariate polynomial over Z/(pZ)(x) of positive degree.
.TP 4
.B A
is a univariate CD-polynomial over Z/(pZ)(x) (s. cdprfmsp1fcl), A != 0.
.PP
cdprfmsp1inv returns a CD-polynomial, say B, over Z/(pZ)(x) with deg(B) < deg(F), such that
.IP
B = (A)^(-1) mod F
.PP
holds.
 
.SH SEE ALSO
cdprfmsp1fcl 

M*/

/*H
	Version 1     	13.12.89      	J.Schmitt
   DATE cdprfmsp1inv  : 901120
H*/

#include<_pol4.h>

pol cdprfmsp1inv(p,F,A)
single p;
pol F,A;
{
	pol a1, a2, b, b1, q, r;
	init(a1,a2,b,b1,q,r);
	bind(F,A);

	a1 = F;
	a2 = uprfmsp1fcdp(p,A);
	b  = list2(0,1);
	b1 = list2(b,b);
	b1 = list2(0,b1);
	b  = 0;

	while ( pdegree(1,a2) ) {
		q = prfmsp1qrem(1,p,a1,a2,&r);
		a1 = a2;
		a2 = r;
		r = prfmsp1prod(1,p,q,b1);
		r = prfmsp1dif(1,p,b,r);
		b = b1;
		b1 = r;
	}
 	if (a2) {
		r = rfmsp1inv(p,lsecond(a2));
		b = prfmsp1rfprd(1,p,b1,r);
	}
	b = cdprfmsp1fup(p,b);
	return(b);
}
