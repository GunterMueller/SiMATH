/*M
.SH NAME
lcyubas - list of cyclotomic units which perform a basis

.SH SYNOPSIS
.nf
#include<_arith1.h>

list lcyubas(n)
single n

.SH DESCRIPTION
For a positive single number n lcyubas() returns a basis of the 
group of the n-th cyclotomic units. 

.SH SEE ALSO
cyubasrep, cynbasrep
M*/

/*H
	Version 1 	09.01.00	Marc Conrad.
H*/

#include<_arith1.h>

#define METH_B 0

list lcyubas(n)  
    single n; 
{ 
    list L, C; 
    single i; 

    init(L, C);
    L = _0; 
    for( i = 1; i < n; i++ ) { 
        C = cyucons(n,i); 
        if( cyugdevmet(lfirst(C)) == METH_B ) { 
               L = lcomp(C,L); 
               } 
        }      
   return L; 
   } 
    
