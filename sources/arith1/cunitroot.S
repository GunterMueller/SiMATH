/*M
.SH NAME
cunitroot - complex n-th root of unity 

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex cunitroot(n, a)
int n, a;

.SH DESCRIPTION
cunitroot() returns z^a where z = e^(2*pi*i/n) is a n-th root of 
unity. 
M*/
/*H
        Version 1       09.01.00      Marc Conrad 
H*/

#include <_arith1.h>

complex cunitroot(n,a)
int n, a; 
{ 
    complex z; 
    init(z); 
    bind(n,a); 
    z = itoc(a); 
    z = cexpsv(z,n);

    return (z); 
}

