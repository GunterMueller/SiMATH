/*M
.SH NAME 
qnfpiord - quadratic number field element prime ideal order

.SH SYNOPSIS
.nf
#include<_arith2.h>

single qnfpiord(D, P, pi, z, a)
int      D;
list     P;
nfel     pi, a;
single   z;

.SH DESCRIPTION
qnfpiord() computes the normalized P-adic valuation of a quadratic number field 
element a at a prime ideal P, i.e. the order of the prime ideal in the prime ide
al decomposition of the principal ideal (a), where a is an element in K = Q(D^(1
/2)). 
.TP 3 
It returns:
ERROR, if a = 0, \   \    \    \    \   \  \   \   \   \   \  \  \  ord_P( a ), 
if a is an element of K = Q(D^(1/2))\\{0}. 

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod').
.TP 4
.B pi
is a prime element of the prime ideal P.
.TP 4
.B z
is 0, 1 or 2, if the prime ideal P divides an inert, ramified or split prime num
ber in Q.
.TP 4
.B a
is an element of the quadratic number field K = Q(D^(1/2)). 
M*/
/*H
        Version 1       11.01.1997      Andreas Heiser
   DATE qnfpiord      : 
H*/

#include <_arith2.h>

single qnfpiord(D,P,pi,z,a)
int     D;
list    P;
nfel    pi,a;
single  z;

{       single  f,g;
        int     n;
        nfel    b;

        init(b,f,g,n);
        bind(D,P,pi,z,a);

        if(!a)
                return( ERROR );
        else
        {       if(isqnfiel(D,a))
                        f=qnfielpiord(D,P,pi,z,a);
                else
                {       n=lfirst(a);
                        b=qnfiprod(D,a,n);
                        f=qnfielpiord(D,P,pi,z,b);
                        b=itoqnf(D,n);
                        g=qnfielpiord(D,P,pi,z,b);
                        f=idif(f,g);
                }
                return(f);
        }
}


	