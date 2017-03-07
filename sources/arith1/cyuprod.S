/*M
.SH NAME
cyuprod - cyclotomic unit product

.SH SYNOPSIS
.nf
#include<_arith1.h>

cyc cyuprod(A, B)
cyc A, B;

.SH DESCRIPTION
cyuprod() returns A * B.
M*/

/*H
	Version 1 	02.01.00	Marc Conrad.
H*/

#include<_arith1.h>

cyc cyuprod( U, V)  
    cyc U, V; 
{ 
    bind(U,V); 
    return cynprod(U,V); 
    } 
    
