/*M
.SH NAME
number field element special minimal polynomial, Collins algorithm, version2

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol nfespecmpc2(F, g) 
pol F, g; 

.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra over the rational numbers, i.e. F is a monic, separable and univariate polynomial over the integer numbers.   
.TP 4
.B g
is an element of this algebra. g is represented by a CD- polynomial (s. cdprfcl)
.
.PP
nfespecmpc2 calls pirescspec, if pirescspec returns the resultant, nfespecmpc2 returns the minimal polynomial of g over the integer numbers, else nfespecmpc2 returns 0.
nfespecmpc2 uses a computation method of Collins.

.SH SEE ALSO
 pirescspec
 cdprfcl
 Diplomarbeit R.Boeffgen p. 19-20.         
 
M*/
              
/*H
	Version 1       05.09.89        J.Schmitt
	Version 2	30.12.89	J.Schmitt
					Namen geaendert.
   DATE nfespecmpc2   : 891101.900101
H*/

#include<_pol2.h>

pol nfespecmpc2(F,a)
pol F,a;
{
	pol M, H, P1, P2;
	single e;
	int k,l;
	init(M,H,P1,P2,k,l);
	bind(F,a);

	if ( a==0 ) {
		M = list2(1,1);
		return(M);
	}
	if ( lsecond(a) == 0) {
		l = lfirst(a);
		k = ineg(lthird(a));
		M = list4(1,l,0,k);
		return(M);
	}

	l = lfirst(a);
	P2 = lred(a);
	H = _0;
	l = ineg(l);
	while ( P2 != _0 ) {
		e = lfirst(P2);
		P2 = lred(P2);
		if ( e != 0) k = list2(0,lfirst(P2));
		else k = list4(1,l,0,lfirst(P2));
		P2 = lred(P2);
		H = lcomp2(k,e,H);
	}
	if ( e != 0 ) {
		k = list2(1,l);
		H = lcomp2(k,0,H);
	}
	H = linv(H);

	P1 = _0;
	while (F != _0) {
		e = lfirst(F);
		F = lred(F);
		k = list2(0,lfirst(F));
		F = lred(F);
		P1 = lcomp2(k,e,P1);
	}
	F = linv(P1);

	P1 = pirescspec(2,H,F,2);
	if ( P1 != 0 ) {
		P1 = picontpp(1,P1,&P2);
		P1 = pideriv(1,P2);
		F = pigcdcf(1,P1,P2,&H,&M);
		return(M);
	}
	else	return(0);
}
