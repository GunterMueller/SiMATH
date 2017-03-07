/*M
.SH NAME
ouspibasisic - order of an univariate separable polynomial over the integers basis of the integral closure ( ORDMAX, Ordmax, ordmax, integral basis )

.SH SYNOPSIS
.nf
#include<_arith2.h>

list ouspibasisic(F, pL)  
pol F; 
list *pL;
  
.SH DESCRIPTION
.TP 4
.B F
is the defining polynomial of a separable algebra (say A) over the rational numbers, i.e. F is a monic, separable and univariate polynomial over the integer numbers, the degree of F has to be equal to or greater than 2.
.TP 4
.B pL
points on a list, say *pL.
.PP
ouspibasisic returns a list of univariate polynomials over the rational numbers, representing elements of A. These elements form a Z-basis of the integral closure of the polynomial order of F in A.
*pL is empty, iff the polynomial order of F is maximal, i.e. equal to the integral closure.
Otherwise, *pL has the form (p_1 e_1...p_r e_r), where
.PP
for 1 <= i <= r, 
 p_i is a prime number, 
 e_i is a positive integer number, so that
.PP
p_1^e_1 * ... * p_r^e_r is equal to the index of the polynomial order in the integral closure.
.SH NOTES
ouspibasisic uses the FORD / ZASSENHAUS algorithem ROUND 4

.SH SEE ALSO
R. Boeffgen, Diplomarbeit, Universitaet des Saarlandes, Germany.

M*/
                                       
/*H
	Version 1       19.09.89        J.Schmitt
	Version 2	30.12.89	J.Schmitt
					Sicherung von *pL
	Version 3	05.08.91	J.S. Nun auch quadratische nicht-
					single Teiler der Disk. zu verarb.
   DATE ouspibasisic  : 891101.900101.910915.9203__
H*/

#include<_arith2.h>

list ouspibasisic(F,pL)
pol F;
list *pL;
{
	list L,Lk,B,M,H;
	single n,i,k,e;
	int p,Q,rd,c;
	init(L,Lk,B,M,H,p,Q,rd,c);
	bind(F);

	rd = upireddiscc(F,&c);
	L  = rdiscupifact(rd,c,&Lk);
	B  = _0;
	while ( Lk != _0 ) {
		e = lsecond(Lk);
		if ( e != 1 ) {
			p = lfirst(Lk);      
			if ( oupidedekmt(p,F) ) {
				Q  = iexp(p,lsecond(L));
				B  = lcomp2(p,Q,B);
			}
		}
		L  = lred2(L); 
		Lk = lred2(Lk);
	}

	H = _0;
	n = lfirst(F);

	if ( B == _0 ) {
		for (i=0;i<n;i++) {
			M = list3(1,i,1);
			B = lcomp(M,B);
		}                 
	}
	else {
		L = B;
		M = cdmarid(n);
                do {
			p = lfirst(L);
			L = lred(L);
                        Q = lfirst(L);
                        L = lred(L);
			if ( issingle(p) ) B = ouspibaslmo(F,p,Q,&k);
			else B = ouspibaslmoi(F,p,Q,&k);
			H = lcomp2(k,p,H);
			M = lconc(B,M);
			M = cdmarhermred(M);
		} while ( L != _0 );         
		if ( H != _0 ) H = linv(H);
		B = cdprlfcdmar(M); 
	}
	M = _0;
	while ( B != _0 ) {
		L = lfirst(B);
		B = lred(B);
		L = uprfcdpr(L);
		M = lcomp(L,M);
	}	                     
	*pL = H;
	return(M);
}
