/*M
.SH NAME
maicr - matrix of integers change row

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maicr(M, i, j)
matrix M;
single i,j;

.SH DESCRIPTION
maicr() returns the matrix that results by changing the i-th row with the j-th row of the matrix M.

.PP
.TP 4
.B M
must be a matrix of integers.
M*/
/*H
        Version 1       20.02.1998  Andreas Heiser
   DATE maicr        : 
H*/

#include <_matr1.h>

matrix maicr(M,i,j)
matrix 	M;
single	i,j;
{	matrix	MM;
	single	k,n,a;
	int	h1,h2;	

	init(MM,k,n,a,h1,h2);
	bind(M,i,j);
	
	MM=M;
	if(icomp(i,j)==0)
		return(MM);
	else
	{	n=llength(lfirst(MM));
		for(k=1;k<=n;k++)
		{	h1=maselel(MM,i,k);
			h2=maselel(MM,j,k);
			a=masetel(MM,i,k,h2);
			a=masetel(MM,j,k,h1);
		}
		return(MM);
	}
}