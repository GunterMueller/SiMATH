/*M
.SH NAME
pmieval - polynomial over modular integers evaluation, main variable                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmieval(r, M, P, A)  
single r; 
int M, A; 
pol P;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B M                                                                            
is an integer number, M > 0.                                                    
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/(M*Z).           
.TP 4
.B A
is element of Z/(M*Z).
.PP
pmieval returns P(A) (the evaluation of P at A) with regard to the main variable.

M*/                                                                             

/*H
	Version 1	26.07.91	J.Schmitt
   DATE pmieval       : 910915
H*/

#include <_pol1.h>

pol pmieval(r,M,P,A)
single r;
int M;
pol P;
int A;
{
	single e, e1;
	pol P1, k;
	bind(M,P,A);
	init(P1,k);

	if (P == 0) P1 = 0;
	else {
		r--;
		e = lfirst(P);
		P = lred(P);
		P1 = lfirst(P);
		P = lred(P);
		while (P != _0) {
			e1 = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			for (e -= e1; e; e--) {
				if (r) P1 = pmimiprod(r,M,P1,A);
				else P1 = miprod(M,P1,A);
			}
			if (r) P1 = pmisum(r,M,P1,k);
			else P1 = misum(M,P1,k);
			e = e1;
		}
		for (; e; e--) {
			if (r) P1 = pmimiprod(r,M,P1,A);
			else P1 = miprod(M,P1,A);
		}
	}
	return(P1);
}
