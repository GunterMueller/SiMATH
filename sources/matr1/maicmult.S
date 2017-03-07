/*M
.SH NAME
maicmult - matrix of integers column multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maicsum(M,i,q)
matrix M;
single i;
int    q;

.SH DESCRIPTION
maicmult() returns the matrix, that results by multiplication of the i-th column with q.
.PP
.TP 4
.B M
must be a matrix of integers.
M*/
/*H
        Version 1       20.02.1998  Andreas Heiser
   DATE maicmult      : 
H*/
	
#include <_matr1.h>
	
matrix maicmult(M,i,q)
matrix 	M;
single	i;
int	q;
{	matrix	MM;
	single	k,n,a;
	int	h;	

	init(MM,k,n,a,h);
	bind(M,i,q);
	
	MM=M;n=llength(lfirst(MM));
	for(k=1;k<=n;k++)
	{	h=maselel(MM,k,i);
		h=iprod(h,q);
		a=masetel(MM,k,i,h);
	}
	return(MM);
}