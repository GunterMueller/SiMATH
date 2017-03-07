/*M
.SH NAME
upihlqsip - univariate polynomial over integers, Hensel lemma quadratic step with respect to integer prime

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upihlqsip(p, p_k, p_l, P, L1, L2, A)  
int p, p_k, p_l; 
pol P, A;              
list L1, L2;
    
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4                                                                           
.B pk                                                                           
= p^k,                                                                          
.TP 4                                                                           
.B pl                                                                           
= p^l,                                                                          
with non-negative exponents k, l, so that 2*l < k.     
.TP 4                                                                           
.B P                                                                            
is an univariate and monic polynomial over the integer numbers of degree > 1.
.TP 4
.B L1                                                                           
= ( P1, ..., Pr )                                                               
is a list, consisting of univariate and monic polynomials over the integer numbers with coefficients in [0, p^k-1], so that
.IP                                                                             
P = P1 * ... * Pr mod p^k.                 
.TP 4                                                                           
.B L2                                                                           
= ( A1, ..., Ar ) is a list, consisting of univariate polynomials over the integer numbers, so that        for 1 <= i <= r 
.IP                                                                             
deg(Ai) < deg(Pi), and for Fi := P / Pi                                         
.IP                                                                             
A1 * F1 + ... + Ar * Fr = p^l mod p^k,                                          
.IP                                                                             
holds.                                         
.TP 4                                                                           
.B A                                                                            
= P1 * ... * Pr.                                                                
.PP                                            
upihlqsip returns a list L = ( L3, L4, A2 ), where                                
.TP 4                                                                           
L3                                                                              
= (g1, ..., gr) is a list, consisting of univariate and monic polynomials over the integer numbers with coefficients in [0, p^t-1], so that   
.IP                                                                             
P = g1 * ... * gr mod p^( 2*(k-l) ).     
.TP 4                                                                           
L4                                                                              
= ( B1, ..., Br ) is a list, consisting of univariate polynomials over the integer numbers, so that         for 1 <= i <= r
.IP                                                                             
deg(Bi) < deg(gi), and for Gi := P / gi,                                        
.IP                                                                             
B1 * G1 + ... + Br * Gr = p^l mod p^t,                                          
.IP
holds.                                                                          
.TP 4                                                                           
A2                                                                              
= g1 * ... * gr.                                                                
                                                       
M*/

/*H
	Version 1        05.08.91	J.Schmitt
   DATE upihlqsip      : 910915
H*/

# include <_pol2.h>

list upihlqsip(p,p_k,p_l,P,L1,L2,A)
int p,p_k,p_l;
pol P,A;
list L1,L2;
{
	pol A0,A1,A2,A3,G;
	list L1a,L2a,L3,L4;
	int p_t,p_2t;
	single i;
	bind(p_k,p_l,P,L1,L2,A);
	init(p_t,p_2t,A0,A1,A2,A3,G,L1a,L2a,L3,L4);

	p_t  = iquot(p_k,p_l);
	p_2t = iprod(p_t,p_t);

	A1 = pidif(1,P,A);
	G  = piiquot(1,A1,p_k);
/* G = ( P - ( f_1*...*f_r ) ) / p^k  */


	L3  = _0;
	L1a = L1;
	L2a = L2;
	while ( L2a != _0 ) {
		A1  = piprod(1,G,lfirst(L2a));
		L2a = lred(L2a);
		A1  = pirem(1,A1,lfirst(L1a));
		A1  = piiprod(1,A1,p_t);
		A1  = pisum(1,A1,lfirst(L1a));
		L1a = lred(L1a);
		A1  = pitopmi(1,A1,p_2t);
		L3  = lcomp(A1,L3);
	}
/* g_i = (G * A_i) * p^t + f_i  mod ( f_i * Z[x] + p^2t * Z[x] ) */
/* L3  = (g_1, ... ,g_r)                                         */


	L3 = linv(L3);
	L1a = L1;
	L2a = L2;
	A0  = 0;
	while ( L1a != _0 ) {
		A1  = piquot(1,A,lfirst(L1a));
		L1a = lred(L1a);
		A1  = piprod(1,A1,lfirst(L2a));
		L2a = lred(L2a);
		A0  = pisum(1,A0,A1);
	}
	A1 = list2(0,p_l);
	A0 = pidif(1,A0,A1);
	A0 = piiquot(1,A0,p_k);
/* A0 = ( (F_1*A_1 + ... + F_r*A_r) - p^l ) / p^k  */


	L1a = L3;
	A2  = list2(0,1);
	while ( L1a != _0 ) {
		A2  = piprod(1,A2,lfirst(L1a));
		L1a = lred(L1a);
	}
	G   = 0;
	L1a = L1;
	L2a = L2;
	L4  = L3;
	while ( L4 != _0 ) {
		A1  = piquot(1,A2,lfirst(L4));
		L4  = lred(L4);
		A3  = piquot(1,A,lfirst(L1a));
		L1a = lred(L1a);
		A1  = pidif(1,A1,A3);
		A1  = piprod(1,A1,lfirst(L2a));
		L2a = lred(L2a);
		G   = pisum(1,G,A1);
	}
	G = piiquot(1,G,p_k);
	G = pisum(1,G,A0);
	G = pineg(1,G);
/* G = -( ( (G_1 - F_1)*A_1 + ... + (G_r - F_r)*A_r ) / p^k  + A0 )   */


	L1a = L1;
	L2a = L2;
	L4  = _0;
	while ( L2a != _0 ) {
		A1  = piprod(1,lfirst(L2a),G);
		A1  = pirem(1,A1,lfirst(L1a));
		L1a = lred(L1a);
		A1  = piiprod(1,A1,p_t);
		A1  = pisum(1,A1,lfirst(L2a));
		L2a = lred(L2a);
		A1  = pitopmi(1,A1,p_2t);
		L4  = lcomp(A1,L4);
	}
/* B_i = ( A_i * G ) p^t + A_i  mod ( f_i * Z[x] + p^2t * Z[x] ) */
/* L4  = (B_1, ... ,B_r)                                         */


	L4 = linv(L4);
	A1 = list3(L3,L4,A2);
	return(A1);
}
