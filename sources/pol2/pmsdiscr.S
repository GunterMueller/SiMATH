/*M
.SH NAME 
pmsdiscr - polynomial over modular singles discriminant

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmsdiscr(r, p, P, n)  
single r, m, n; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.                                            
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                                                  
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/pZ.                                       
.TP 4                                                                           
.B n                                                                            
is an integer number, 1 <= n <= 3.                                              
.PP                           
pmsdiscr returns the discriminant, say P1, of P with regard to the main variable
, so P1 is a polynomial in r-1 variables.                                       
.PP                                                                             
The value of n determines the algorithm used by pmsdiscr as follows : In the cas
e n < 3, pmidiscr computes the resultant of P and its derivation, namely        
.IP                                                                             
 n = 1: computation of the determinant of the                                   
        Sylvester matrix (s. psylvester),                                       
 n = 2: Collins algorithm (s. pmsrescoll).                                      
.PP 
In the case n = 3, pmsdiscr uses the Hankel matrix for the computation
 of the discriminant (s. pmsdiscrhank).                                         
In case of doubt, you should try n = 3, especially if P is monic with regard to 
the main variable.                                                              
.PP                                                                             
For r = 1, pmsdiscr uses the Collins algorithm, in the case of p divides deg(P1)
, pmsdiscr always uses the Hankel matrix (even if r = 1).                       
                                                                                
.SH CAUTION                                                                     
In some cases, it could be possible that the Collins algorithm does not lead to 
a result, then pmsdiscr returns ERROR.                                          
                                                                                
.SH SEE ALSO                                                                    
 psylvester                                                                     
 pmsdiscrhank                                                                   
 psirescoll                                                                     
                                                               
M*/

/*H
	Version 1       17.09.1992     	U.Schneiders 
	Version 2	26.04.1993	Marc Conrad (n=3)
   DATE pmsdiscr      : 921130.930531
H*/


#include <_pol2.h>

pol pmsdiscr(r, m, P, n)
	single r;
	single m;
	pol P;
	single n;
{
	single e;
	pol P1, P2;

	bind(P);
	init(P1, P2);

/* Berechnung der Diskriminante */
	if (pdegree(r, P) == 0)
		return (0);
	if (mshom(m, pdegree(r, P)) == 0)
		n = 3;
	if (n == 3)
		P1 = pmidiscrhank(r, m, P);
	else {

		P1 = pmsderiv(r, m, P);
		if (r > 1) {
			if (n == 2)
				n = 3;
			P1 = pmsres(r, m, P, P1, n);
		} else
			P1 = pmsres(r, m, P, P1, 3);
		if (P1!=(ERROR-1)) {
			e = pdegree(r, P);
			P2 = plc(r, P);
			r--;
			P1 = pmsquot(r, m, P1, P2);
			if (e % 4 >= 2)
				P1 = pmsneg(r, m, P1);
		}
	}
	return (P1);
}
