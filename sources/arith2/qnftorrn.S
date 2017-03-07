/*M
.SH NAME
qnftorrn -  quadratic number field element to two rational numbers and
one integer

.SH SYNOPSIS
.nf
#include<_arith2.h>

single qnftorrn(A,a1,a2,n)
nfel A;
rat *a1,*a2;
int *n;

.SH DESCRIPTION
A= a1+sqrt(d)*a2 =(b1+sqrt(b2))/n with rationals a1 and a2 and integers 
b1,b2 and n is an element of a quadratic number field. qnftorrn()
returns the a1 and a2, and the n.
M*/
/*H
        Version  1      19.08.1998      S.Schmitt
   DATE qnftorrn         : 980819
H*/



# include <_arith2.h>


single qnftorrn(A,a1,a2,n) 
nfel A;
rat *a1,*a2;
int *n;
{
	int b;

	init(b);
	bind(A,*a1,*a2,*n);

	if(A) 
	{	
		*n = lfirst(A);
		b = lthird(A);
		if(!lsecond(A))
		{	
			*a1 = rcons(b,(*n));
			*a2 = itor(0);
			return(0);
		}
		*a2 = rcons(b,(*n));
		b = lfourth(A);
		*a1 = rcons(b,(*n));	
		return(0);
	}
	*a1 = itor(0);
	*a2 = itor(0);
	*n = 1;
	return(0);
}	
	
/*****************************************************************************/


