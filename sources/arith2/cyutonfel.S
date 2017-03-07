/*M
.SH NAME
cyutonfel - cyclotomic unit to number field element 

.SH SYNOPSIS
.nf
#include<_arith2.h>

complex cyutonfel( n, F, A )
cyc A;

.SH DESCRIPTION
.TP 4
.B n
is an integer > 2
.TP 4
.B A 
is a cyclotomic unit 
.TP 4
F 
is the n-th cyclotomic polynomial. If F==0 F will be computed by n.
.PP
cyutonfel() returns the value of the cyclotomic unit A in the n-th 
cyclotomic number field.
.SH SEE ALSO 
cyntonfel, cyutoc
.SH NOTE 
M*/
/*H    
	Version 1       29.12.1999      Marc Conrad
H*/
#include <_arith2.h>

nfel cyutonfel(n, F, A)
single n; 
cyc A; 
pol F; 
{
    bind(A, F);
    return cyntonfel(n,F,cyutocyn(A)); 
    } 



 
