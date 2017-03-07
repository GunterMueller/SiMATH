/*M
.SH NAME 
pcnfpiord - pure cubic number field element prime ideal order

.SH SYNOPSIS
.nf
#include<_arith2.h>

single pcnfpiord(D, Pi, e, f, a)
int      D;
list     Pi;
single   e,f; 
nfel     a;

.SH DESCRIPTION
pcnfpiord() computes the normalized Pi-adic valuation of a pure cubic number field element a at a prime ideal Pi, i.e. the order of the prime ideal in the prime ideal decomposition of the principal ideal (a), where a is an element in K = Q(D^(1/3)). 
.TP 3 
It returns:
ERROR, if a = 0, \   \    \    \    \   \  \   \   \   \   \  \  \  ord_Pi( a ), 
if a is an element of K = Q(D^(1/3))\\{0}. 

.PP
.TP 4
.B D
is a cubefree integer not equal to 0 or 1.
.TP 4
.B Pi
is a prime ideal in the ring of integers O_K of K.
.TP 4
.B e
is the ramification index of Pi over the according prime number.
.TP 4
.B f
is the degree of the residue class field.
.TP 4
.B a
is an element of the pure cubic number field K = Q(D^(1/3)). 
M*/
/*H
        Version 1       20.02.1998      Andreas Heiser
   DATE pcnfpiord      : 
H*/

	
#include <_arith2.h>

single pcnfpiord(D,Pi,e,f,a)
int	D;
list	Pi;
single	e,f;
nfel	a;
{	int	n;
	nfel	b;
	single	w,w1,w2;
	pol	F;

	init(n,b,w,w1,w2,F);
	bind(D,Pi,e,f,a);
	
	if(!a)
                return( ERROR );
        else
	{       F=list5(3,1,0,0,-D);  
		n=lfirst(a);
                b=nfeliprod(F,a,n);
                w1=pcnfielpiord(D,Pi,e,f,b);
                b=itonf(n);
                w2=pcnfielpiord(D,Pi,e,f,b);
                w=idif(w1,w2);
        }
        return(w);
}
