/*M
.SH NAME
udpicontpp - univariate dense polynomial over integers content and primitive part

.SH SYNOPSIS
.nf
#include<_pol1.h>

int udpicontpp(P, pPP)  
pol P, *pPP;

.SH DESCRIPTION
.TP 4
.B P
is an univariate dense polynomial over the integer numbers.   
.TP 4
.B pPP
points on a pol.      
.PP
udpicontpp computes the content C and the primitive part PP (i.e. 1/C * P = PP) of the polynomial P.
.PP
If P = 0 then C = PP = 0.
.PP
udpicontpp returns C. The primitive part PP of P can be found at *pPP.
  
M*/

/*H
	 Version 1      10.08.1988      Pascale Serf
   DATE udpicontpp    : 890501
H*/


# include <_pol1.h>

int udpicontpp(P,pPP)
pol P,*pPP;
{
	int I,A;
	list L;
	pol P1;         /* primitiver Anteil von P */
	single r;       /* Grad von P */

	bind(P);
	init(I,A,L,P1);

	/***    1.Fall : P = 0    ***/
	if ( !P ) { I = 0; *pPP = 0; }

	/***    2.Fall : P != 0    ***/
	else {
	    r = lfirst(P);
	    L = lred(P);

	    /* Inhalt durch sukzessive ggT-Bildung berechnen */
	    I = lfirst(L); I = iabs(I);
	    L = lred(L);
	    while ( L!=_0 && I!=1 ) {
		A = lfirst(L); L = lred(L);
		if ( A ) I = igcd(I,A);
	    }

	    /* Inhalt evtl. rausdividieren */
	    if ( I == 1 ) *pPP = P;
	    else {
		P = lred(P);
		P1 = _0;
		while ( P != _0 ) {
		    A = lfirst(P); P = lred(P);
		    if ( A ) A = iquot(A,I);
		    P1 = lcomp(A,P1);
		}
		P1 = linv(P1);
		*pPP = lcomp(r,P1);
	    }
	}

	/***    Rueckgabe    ***/
	return(I);
}
