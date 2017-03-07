/*M
.SH NAME
maicsum - matrix of integers column sum

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maicsum(M,a,i,b,j)
matrix M;
single i,j;
int    a,b;

.SH DESCRIPTION
maicsum() returns the matrix, that results by addition of the i-th column multiplied with a and the j-th column multiplied with b. The resulting sum is written into the i-th column.
.PP
.TP 4
.B M
must be a matrix of integers.
M*/
/*H
        Version 1       20.02.1998  Andreas Heiser
   DATE maicsum      : 
H*/
	
#include <_matr1.h>

matrix maicsum(M,a,i,b,j)
matrix 	M;
single	i,j;
int	a,b;
{	matrix	MM;
	single	k,n,m;
	int	h1,h2;	

	init(MM,k,n,m,h1,h2);
	bind(M,i,j,a,b);
	
	MM=M;n=llength(lfirst(MM));
	for(k=1;k<=n;k++)
	{	h1=maselel(MM,k,i);
		h1=iprod(h1,a);
		h2=maselel(MM,k,j);
		h2=iprod(h2,b);
		h1=isum(h1,h2);
		m=masetel(MM,k,i,h1);
	}
	return(MM);
}
