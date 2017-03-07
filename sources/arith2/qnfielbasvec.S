/*M
.SH NAME 
qnfielbasvec - quadratic number field integer element basis vector

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfielbasvec(D, a)
int      D;
nfel     a;

.SH DESCRIPTION
qnfielbasvec returns a list L = ( x, y ), where x and y are integers with a = x + y * w and { 1, w } is basis of the ring of integers O_K of K = Q(D^(1/2)). 

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B a
is an element in the ring of integers O_K of K. 
M*/
/*H
        Version 1      02.01.1997	 Andreas Heiser
   DATE qnfielbasvec  : 
H*/

#include<_arith2.h>

list qnfielbasvec(D,a)
int	D;
nfel	a;
{	list	L;
	int	x,y,n;
	single	g;

	init(L,g,x,y,n);
	bind(D,a);

	n=lfirst(a);
	if(lsecond(a))
	{	x=lfourth(a);
		y=lthird(a);
	}
	else
	{	x=lthird(a);
		y=0;
	}
	
	g=m4hom(D);
	if(g==1)
	{	x=idif(x,y);
		x=iquot(x,n);
		y=iprod(y,2);
		y=iquot(y,n);
	}
	L=list2(x,y);
	
	return(L);
}