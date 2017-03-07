/*M
.SH NAME
cynquot - cyclotomic number quotient 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cynquot(A, B)
cyc A, B;

.SH DESCRIPTION
cynquot() returns A / B.
M*/

/*H
	Version 1 	29.12.1999	Marc Conrad.
H*/

#include<_arith1.h>

cyc cynquot( U, V)  
cyc U, V; 
{ 
    bind(U, V); 
    return (cynprod(U,cynexp(V,-1)));
}
