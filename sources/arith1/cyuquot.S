/*M
.SH NAME
cyuquot - cyclotomic unit quotient 

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cyuquot(A, B)
cyc A, B;

.SH DESCRIPTION
cyuquot() returns A / B.
M*/

/*H
	Version 1 	29.12.1999	Marc Conrad.
H*/

#include<_arith1.h>

cyc cyuquot( U, V)  
cyc U, V; 
{ 
    bind(U, V); 
    return (cyuprod(U,cyuexp(V,-1)));
}
