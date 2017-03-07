/*M
.SH NAME
upmsrelpfact univariate polynomial over modular singles relative prime factorization

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmsrelpfact(p, P, Fac, pA2)                                                
int p;                                                                          
pol P, Fac, *pA2;                                                               
                                                                                
.SH DESCRIPTION                                                                 
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B P                                                                            
is an univariate polynomial over Z/pZ.                                          
.TP 4                                                                           
.B Fac                                                                          
is an univariate polynomial over Z/pZ, Fac divides P.      
.PP
upmsrelfact computes the univariate polynomials A1, A2 over Z/pZ, so that      
.IP                                                                             
 A1 * A2 = P,                                                                   
 gcd (A1, Fac) = 1 and                                                          
 A2 | Fac^deg(P)                                                                
.PP                                                                             
holds.                                                                          
.PP                                                       
upmsrelfact returns A1 and writes A2 to pA2. 

M*/

/*H
	Version 1       15.05.89        J.Schmitt
	Version 2	30.12.89	J.Schmitt
					Sicherung von *pA2;
   DATE upmsrelpfact  : 891101.900101
H*/

#include<_pol2.h>

pol upmsrelpfact(p,P,Fak,pA2)
single p;
pol P,Fak;
pol *pA2;
{
	pol A1, A2;
	init(A1,A2);
	bind(P,Fak);

	A1 = P;
	A2 = list2(0,1);

	do {
		A2 = pmsprod(1,p,Fak,A2);
		A1 = pmsquot(1,p,A1,Fak);
		Fak = upmsgcd(p,A1,A2);
	}
	while ( lfirst(Fak) > 0);  
	*pA2 = A2;
	return(A1);
}
