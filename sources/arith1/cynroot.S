/*M
.SH NAME
cynprod - cyclotomic number root 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cynroot(A, n)
cyc A;
single n;

.SH DESCRIPTION
cynroot() returns the n-th root of A if possible. Otherwise the 
program will be terminated with an Error message. 
M*/

/*H
	Version 1 	29.12.1999	Marc Conrad.
H*/

#include<_arith1.h>

cyc cynroot( U, n)  
cyc U; 
single n;
{ 
    cyc P; 
    list C; 
    single e; 
    bind(U); 
    init(P, C); 

    if( U == _0 || n == 1 ) { return U; }
    if( n == 0 ) { return _0; }

    P = _0; 
    while( U != _0 ) { 
        C = lfirst(U); U = lred(U);
        e = lfirst(U); U = lred(U);
        if( (e % n) != 0 ) { 
          printf("ERR: Cyclotomic numbers: n-th root of a non n-th power!\n");
          exit(1); 
          } 
        e = e / n; 
        P = lcomp2(e,C,P);
        } 
   P = linv(P); 
   return ( P ); 
   }

