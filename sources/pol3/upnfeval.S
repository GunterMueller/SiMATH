/*M
.SH NAME
upnfeval - univariate polynomial over a number field evaluation

.SH SYNOPSIS
.nf
#include<_pol3.h>

nfel upnfeval(F, P, A)  
pol F, P; 
nfel A;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree >=1. Let z be a root of F, then F generates a number field, say K, by adjunction of z to Q (Q(z) = Q[z] = K).
.TP 4
.B P
is an univariate polynomial over K in sparse representation.
.TP 4
.B A 
is an element of K (for the representation of number field elements s. nfneg).
.PP                                                                      
upnfeval returns the evaluation of P at A (as a number field element).
  
.SH SEE ALSO
nfneg

M*/

/*H
	Version 1       15.05.89        J.Schmitt
	Version 2       29.10.1990      C.H.    NFSUM( F, ... )
   DATE upnfeval      : 891101.9001__.901120.9107__
H*/

#include<_pol3.h>

nfel upnfeval(F,P,A)
pol F, P;
nfel A;
{
	single e1, e2, i;
	list Ap;
	nfel B, A2;
	init(B,A2,Ap);
	bind(F,P,A);

	if (P==0) return(0);

	e1 = lfirst(P);
	Ap = lred(P);
	B = lfirst(Ap);
	Ap = lred(Ap);

	while ( Ap != _0 ) {
		e2 = lfirst(Ap);
		Ap = lred(Ap);
		A2 = lfirst(Ap);
		Ap = lred(Ap);
		for (i=(e1-e2);i>0;i--) B = nfprod(F,A,B);
		B = nfsum(F,A2,B);
		e1 = e2;
	}
	for (i=0;i<e1;i++) B = nfprod(F,A,B);
	return(B);
}
