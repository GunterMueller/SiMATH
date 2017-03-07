/*M
.SH NAME      
uprfact - univariate polynomial over rationals factorization
                                                                  
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
list uprfact(P)  
pol P;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B P                                                                            
is an univariate polynomial over the rational numbers.
P != 0.
.PP
Let N be the lowest common denominator of the coefficients of P, so
Q = N * P is a polynomial over the integer numbers.
.PP
uprfact returns a list L = (c, P1, e1, ..., Pk, ek ),      k >= 0, where
.IP
 k = 0, if deg(P) = 0,
 c = sign(P) * cont(P) / N,                                                     
 Pi are coprime, irreducible, univariate                                        
 polynomials,                                                                   
 ei are integer numbers, ei > 0, with                                           
.IP                                                                             
P = c * P1^e1 * ... * Pk^ek.                                                    
.PP
uprfact returns ERROR in case of an error occurs.                               
                                                     
M*/                                                                             

/*H
	Version 1       16.06.1988      Pascale Serf
   DATE uprfact       : 890501
H*/


# include <_pol2.h>

list uprfact(P)
pol P;
{
	rat a,c;
	int N;
	pol P1;
	list L;

	bind(P);
	init(a,c,N,P1,L);

	/***    Hauptnenner der Koeffizienten aus P herausziehen,    ***/
	P1 = prnumden(1,P,&N);

	/***    P1 faktorisieren                                 ***/
	/***    im Fehlerfall ERROR als Funktionswert liefern    ***/
	L = upifact(P1);
	if ( L == ERROR ) return(ERROR);

	/***    Faktorisierung fuer P bestimmen    ***/
	c = lfirst(L); L = lred(L);
	c = rcons(c,N);
	L = lcomp(c,L);

	return(L);

}
