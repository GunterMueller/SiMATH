/*M
.SH NAME
upminif - univariate polynomial over modular integers, number of irreducible factors
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
single upminif(p, P)  
int p; 
pol P;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B P                                                                            
is an univariate, monic and square-free polynomial over Z/pZ.
.PP
upminif returns the number of irreducible factors of P.
                                                                            
M*/                                                                             
                                                                                
/*H
	Version 1 	16.08.91	J.Schmitt
   DATE upminif       : 910915
H*/

#include <_pol2.h>

single upminif(m,P)
int m;
pol P;
{
	single n,i,j;
	int a;
	list Q,Q1,P1,B1,L;

	bind(m,P);
	init(a,Q,Q1,P1,B1,L);

	if ( lfirst(P) == 1 ) return(1);

	n = lfirst(P);
	Q = upmibqp(m,P);
	Q = macup(n,Q);
	Q1 = Q;
	for ( i=0 ; i<=n-1 ; i++ ) {
		P1= lfirst(Q1);
		for ( j=1 ; j<=i ; j++ ) P1= lred(P1);
		a = lfirst(P1);
		a = midif(m,a,1);
		lsfirst(P1,a);
		Q1 = lred(Q1);
	}

	Q  = matransp(Q);
	B1 = maminsb(m,Q);

	return(llength(B1));
}
