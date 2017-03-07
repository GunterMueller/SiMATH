/*M
.SH NAME
upmicfact - univariate polynomial over modular integers complete factorization
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
list upmicfact(p, P)  
int p; 
pol P;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number.                                                              
.TP 4                                                                           
.B P                                                                            
is a monic, univariate polynomial over Z/pZ, with degree of P > 0.
.PP
upmicfact returns a list L consisting of all monic, irreducible factors of P.
                                                                 
M*/                                                                             
                               
/*H
	Version 1       24.07.91	J.Schmitt
   DATE upmicfact     : 910915
H*/

# include <_pol2.h>

list upmicfact(ip,P)
int ip;
pol P;
{
	list L,L2,L3,L4,M;
	single e,l;

	bind(ip,P);
	init(L,L2,L3,L4,M);

	if ( lfirst(P) == 1 ) { 
		L = list1(P);
		return(L);
	}
	M = _0;
	L = upmisfact(ip,P);
	while ( L != _0 ) {
		L2 = lfirst(L);
		L  = lred(L);
		e  = lfirst(L2);
		P  = lsecond(L2);
		L2 = _0;
		if ( lfirst(P) > 1 ) L3 = upmiddfact(ip,P);
		else L3 = list2(P,1);
		while ( L3 != _0 ) {
			P  = lfirst(L3);
			L3 = lred(L3);
			l  = lfirst(L3); 
			L3 = lred(L3);
			if ( l == 1 ) L4 = upmirfspec(ip,P);
			else L4 = upmibfact(ip,P,l);
			while ( L4 != _0 ) {
				if ( l != 1 ) L2 = lcomp(lfirst(L4),L2);
				else {
					P = lfirst(L4);
					if ( !P ) P = list2(1,1);
					else P = list4(1,1,0,mineg(ip,P));
					L2 = lcomp(P,L2);
                                }
				L4=lred(L4);
			}
		}
		while ( L2 != _0 ) {
			P = lfirst(L2);
			L2 = lred(L2);
			for ( l=1 ; l<=e ; l++ ) M = lcomp(P,M);
		}
	}
	return(M);
}
