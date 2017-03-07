/*M
.SH NAME
cyutocyn - cyclotomic unit to cyclotomic number 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cyutocyn(U)
cyc U;

.SH DESCRIPTION
cyutocyn() returns the cyclotomic unit U as a cyclotomic number.
M*/

/*H
	Version 1 	29.12.1999	Marc Conrad.
H*/

#include<_arith1.h>
cyc cyutocyn(U)
cyc U; 
{ 
    cyc V, W; 
    list C; 
    single e; 
    single a; 
    single n, p; 
    bind(U); 
    init(W, V, C); 
    
    V = _0; 
    W = U; 
    while( U != _0 ) { 
        C = lfirst(U); 
        e = lsecond(U); 
        U = lred2(U); 

        n = lfirst(C); 
        a = lsecond(C); 

        if( isspprime(n,&p) ) { 
             C = list2(n,1); 
             C = list2(C,-e);  
             V = cynprod(V,C); 
             }
        } 
   W = cynprod(W,V); 
   return W; 
   } 

         
         


   

