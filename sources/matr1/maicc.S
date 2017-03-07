/*M
.SH NAME
maicc - matrix of integers change column

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maicc(M, i, j)
matrix M;
single i,j;

.SH DESCRIPTION
maicc() returns the matrix that results by changing the i-th column with the j-th column of the matrix M.

.PP
.TP 4
.B M
must be a matrix of integers.
M*/
/*H
        Version 1       20.02.1998  Andreas Heiser
   DATE maicc        : 
H*/

#include <_matr1.h>

matrix maicc(M,i,j)
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
		{	h1=maselel(MM,k,i);
			h2=maselel(MM,k,j);
			a=masetel(MM,k,i,h2);
			a=masetel(MM,k,j,h1);
		}
		return(MM);
	}
}