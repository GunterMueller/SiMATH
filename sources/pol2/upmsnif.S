/*M
.SH NAME
upmsnif - univariate polynomial over modular singles, number of irreducible factors 
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
single upmsnif(p, P) 
single p; 
pol P;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                                                  
.TP 4                                                                           
.B P                                                                            
is an univariate, monic and square-free polynomial over Z/pZ.
.PP
upmsnif returns the number of irreducible factors of P.
                                                                            
M*/                                                                             

/*H
	Version 1           10.03.88                 J.Schmitt
   DATE upmsnif       : 890501
H*/


#include <_pol2.h>

single upmsnif(m,P)
single m;
pol P;
{
	single n,a,i,j;
	list Q,Q1,P1,B1,L;

	bind(P);
	init(Q,Q1,P1,B1,L);

/*    Spezialfall : Grad(P) == 1    */
	if ( lfirst(P) == 1 ) return(1);

/*    allgemeiner Fall : Grad(P) >= 2    */

	/*    Bildung der Matrix Q - I, zunaechst als Liste    */
	n = lfirst(P);
	Q = upmsbqp(m,P);
	Q = macup(n,Q);
	Q1 = Q;
	for ( i=0 ; i<=n-1 ; i++ ) {
		P1= lfirst(Q1);
		for ( j=1 ; j<=i ; j++ ) P1= lred(P1);
		a = lfirst(P1);
		a = msdif(m,a,1);
		lsfirst(P1,a);
		Q1 = lred(Q1);
	}

	/*    Berechnung einer Nullraumbasis von Vektoren fuer Q */
	Q  = matransp(Q);
	B1 = mamsnsb(m,Q);

	return(llength(B1));
}
