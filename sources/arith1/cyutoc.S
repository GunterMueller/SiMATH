/*M
.SH NAME
cyutoc - cyclotomic unit to complex number 

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cyutoc( A )
cyc A;

.SH DESCRIPTION
cyntoc() returns the complex value of the cyclotomic unit A.
M*/
/*H    
	Version 1       02.01.00      Marc Conrad
H*/
#include <_arith1.h>


complex cyutoc(A)
cyc A; 
{
    bind(A);
    return cyntoc(cyutocyn(A));
}
   



 
