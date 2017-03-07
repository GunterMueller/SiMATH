/*M
.SH NAME
upprmsp1redd - univariate polynomial over polynomial ring over modular single prime, transcendence degree 1, reduced discriminant

.SH SYNOPSIS
.nf
#include<_pol4.h>

pol upprmsp1redd(p, F) 
single p; 
pol F;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is an univariate polynomial the polynomial ring in x over Z/(pZ).
.PP
upprmsp1redd returns the reduced discriminant of F.
   
M*/
          
/*H
	Version 1	30.11.89		J.Schmitt
   DATE upprmsp1redd  : 901120
H*/

#include <_pol4.h>

pol upprmsp1redd(p,F)
single p;
pol F;                      
{
	single e;
	pol P2,A1,A2,B1,B2,L,Q,Q2,R,H,E;
	bind(F);
	init(P2,A1,A2,B1,B2,L,Q,Q2,R,H,E);
                                     

	if ( !F ) return(0);
	                                       
	P2 = pmsderiv(2,p,F);
	if ( !P2 ) return(0);     

	E  = list2(0,1);                       
	A1 = list2(0,E);
	A2 = 0;
	B1 = 0;
	B2 = A1;

	H  = _0;
	while ( F != _0 ) {
		e = lfirst(F);
		F = lred(F);
		L = lfirst(F);
		F = lred(F);		
		L = list2(L,E);
		H = lcomp2(L,e,H);
	}
	F = linv(H);

	H  = _0;
	while ( P2 != _0 ) {
		e  = lfirst(P2);
		P2 = lred(P2);
		L  = lfirst(P2);
		P2 = lred(P2);		
		L  = list2(L,E);
		H  = lcomp2(L,e,H);
	}
	P2 = linv(H);
              
	while ( pdegree(1,P2) ) {
		
                Q = prfmsp1qrem(1,p,F,P2,&R);
                                             
		L = list2(0,1);
		H = Q;  
		while ( H != _0 ) {
			H  = lred(H);
                        Q2 = lfirst(H);
			H  = lred(H);
			Q2 = lsecond(Q2);
			F  = pmsprod(1,p,Q2,L);
			L  = pmsquot(1,p,F,upmsgcd(p,Q2,L));
                }
		H = R;
		while ( H != _0 ) {
			H  = lred(H);
                        Q2 = lfirst(H);
			H  = lred(H);
			Q2 = lsecond(Q2);
			F  = pmsprod(1,p,Q2,L);
			L  = pmsquot(1,p,F,upmsgcd(p,Q2,L));
                }

		L = list2(L,E);
                Q = prfmsp1rfprd(1,p,Q,L);
                R = prfmsp1rfprd(1,p,R,L);

		Q2 = Q;
		while ( Q2 != _0 ) {
			e  = lfirst(Q2);
			Q2 = lred(Q2);
			F  = lfirst(Q2);
			Q2 = lred(Q2);
			F  = lfirst(F);
			H  = lcomp2(F,e,H);
		}
                Q2 = linv(H);

		L  = lfirst(L);
		H  = pmsupmsprod(2,p,A1,L);
		F  = pmsprod(2,p,A2,Q2);
		A1 = A2;
		A2 = pmsdif(2,p,H,F);
		H  = pmsupmsprod(2,p,B1,L);
		F  = pmsprod(2,p,B2,Q2);
		B1 = B2;
		B2 = pmsdif(2,p,H,F);

                F  = P2;
		P2 = R;
	}

	P2 = lsecond(P2);
	P2 = lfirst(P2);		
	R  = P2;

	while ( (A2) && (A2 != _0) ) {
		A2 = lred(A2);
		Q2 = lfirst(A2);
		A2 = lred(A2);
		P2 = upmsgcd(p,P2,Q2);
	}
	while ( (B2) && (B2 != _0) ) {	
		B2 = lred(B2);
		Q2 = lfirst(B2);
		B2 = lred(B2);
		P2 = upmsgcd(p,P2,Q2);
	}	                  

	R = pmsquot(1,p,R,P2);
	return(R);
}
