/*M
.SH NAME
isqnfphsqu - is quadratic number field element modulo prime ideal square

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfphsqu(d,a,P,pi,z)
int d;
nfel a;
list P;
nfel pi;
single z;

.SH DESCRIPTION
isqnfphsqu() tests, if the number number field element a is a square 
modulo the prime ideal P. It returns 0, if P divides a, 
if a is a square modulo P, isqnfelsqu() returns 1 and if a is no square 
modulo P, -1.

.PP                                                                             
.TP 4                                                                           
.B d                                                                            
is a squarefree integer not equal to 0 and 1.
.TP 4
.B a
is an integral element of K=Q(sqrt(d)).
.TP 4
.B P
is a prime ideal of K with prime element pi and decomposition z 
(see `qnfpifact'). The prime above P must be > 2.
M*/
/*H
        Version 1       31.07.1998      Susanne Schmitt
   DATE isqnfphsqu     : 980731
H*/

#include <_arith2.h>

single isqnfphsqu( d, a, P, pi, z )
int d;
nfel a;
list P;
nfel pi;
single z;
{
    int p;

    bind( d,a, P,pi );
    init(p);

    a = qnfpihom(d,P,pi,z,a);
    if(!a) return(0);
    p = qnfidprime(P,pi,z);

    if(z)	/* nicht traege */
    {
	a = lthird(a);
        return(ipjacsym(a,p));
    }
    p = iprod(p,p);
    p = idif(p,1);
    p = iquot(p,2);
    a = qnfexp(d,a,p);
    a = qnfidif(d,a,1);
    a = qnfpihom(d,P,pi,z,a);
    if(!a) return(1);
    return(-1);

}
