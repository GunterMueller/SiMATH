/*M
.SH NAME
cynexp - cyclotomic number exponentiation 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cynexp(A, n)
cyc A;
single n;

.SH DESCRIPTION
cynexp() returns A^n.
M*/

/*H
	Version 1 	29.12.1999	Marc Conrad.
H*/

#include<_arith1.h>

cyc cynexp( U, n)  
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
        e *= n; 
        P = lcomp2(e,C,P);
        } 
   P = linv(P); 
   return ( P ); 
   }

