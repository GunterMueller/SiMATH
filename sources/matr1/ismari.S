/*M
.SH NAME
ismari - is matrix of rationals matrix of integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

single ismari(M)
matrix M;

.SH DESCRIPTION
ismari() returns 1, if the matrix M is a matrix of integers, else 0.
.PP
.TP 4
.B M
must be a matrix of rationals.
M*/
/*H
        Version 1       20.02.1998  Andreas Heiser
   DATE ismari      : 
H*/

#include <_matr1.h>
	
single ismari(M)
matrix	M;
{	single	i;
	list	Z;
	 
	init(i,Z);
	bind(M);

	i=1; 
	while(M!=_0 && i)
	{	Z=lfirst(M);
		while(Z!=_0 && i) 
		{	if(rden(lfirst(Z))!=1)
				i=0;
			Z=lred(Z);
		}
		M=lred(M); 
	}
	return(i);
}	 