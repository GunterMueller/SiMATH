/*M
.SH NAME
cyuexp - cyclotomic unit exponentiation 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cyuexp(A, n)
cyc A;
single n;

.SH DESCRIPTION
cyuexp() returns A^n.
M*/

/*H
	Version 1 	02.01.00	Marc Conrad.
H*/

#include<_arith1.h>

cyc cyuexp( U, n)  
cyc U; 
single n;
{ 
    bind(U); 
    return cynexp(U,n); 
    } 
