/*M
.SH NAME
pmievalsv - polynomial over modular integers evaluation, specified variable, (recursive)
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmievalsv(r, M, P, n, A)  
single r ,n; 
int M, A; 
pol P;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.                                           
.TP 4                                                                           
.B M                                                                            
is an integer number, M > 0.                                                    
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/(M*Z).              
.TP 4
.B n
is an integer number, 1 <= n <= r.
.TP 4
.B A
is element of Z/(M*Z).
.PP
pmievalsv returns P(A) (the evaluation of P at A) with regard to the n-th variable.

M*/                                                                             
                              
/*H
	Version 1 	13.08.91	J.Schmitt
   DATE pmievalsv     : 910915
H*/

#include <_pol1.h>

pol pmievalsv(r,m,P,n,a)
single r;
int m;
pol P;
single n;
int a;
{
	single e;
	pol P1, k;
	bind(m,P,a);
	init(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* i gleich r */

	else if (n == r) P1 = pmieval(r,m,P,a);

/* allgemeiner Fall: P ungleich 0, n ungleich r */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = pmievalsv(r,m,k,n,a);
			if (k) P1 = lcomp2(k,e,P1);
		} while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
	}

/* Ausgabe */

	return(P1);
}
