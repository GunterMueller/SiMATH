/*M
.SH NAME
mamihomsol - matrix of modular integers homogeneous solution

.SH SYNOPSIS
.nf
#include<_matr1.h>

list mamihomsol(M,p)
matrix	M;
int	p;
	
.SH DESCRIPTION
mamihomsol() returns a solution of the equation M * x = 0, L = (x1, ... , xn), modulo p.
.PP
.TP 4
.B M
must be a matrix of integers.
M*/
/*H
        Version 1       20.02.1998  Andreas Heiser
   DATE mamihomsol      : 
H*/
	
#include <_matr1.h>
	
list mamihomsol(M,p)
matrix	M;
int	p;
{	list	L,H;
	single	d,m,n,i,j,k,ii,jj;
	matrix	A;
	int	h,h1,h2;
	
	init(L,H,d,m,n,i,j,k,ii,jj,A,h,h1,h2);
	bind(M,p);

	A=M;L=_0;
	m=llength(M);n=llength(lfirst(M));
	
	for(i=1;i<=m;i++)
	{	d=0;ii=i;
		while(!d && ii<m)
		{	h=maselel(A,ii,i);
			if(h)
			{	d=1;
				A=maicr(A,ii,i);
			}
			ii++;			
		}
		if(d)
		{	h1=maselel(A,i,i);
			jj=i;jj++;
			for(ii=jj;ii<=m;ii++)
			{	h2=maselel(A,ii,i);
				h2=ineg(h2);
				A=mairsum(A,h1,ii,h2,i);
			}
		}
	}
	if(d)
		for(i=1;i<=n;i++)
			L=lcomp(0,L);
	else
	{	A=maitomami(p,A);
		j=m;jj=idif(n,m);
		for(i=n;i>jj;i--)
		{	h1=maselel(A,j,i);
			if(!h1)
				L=lcomp(1,L);
			else
			{	H=L;ii=i;ii++;h=0;
				for(k=ii;k<=n;k++)
				{	h1=lfirst(H);
					h2=maselel(A,i,k);
					h1=iprod(h1,h2);
					h=isum(h,h1);
					H=lred(H);
				}
				h=ineg(h);h=mihom(p,h);
				h1=maselel(A,i,i);
				h=miquot(p,h,h1);
				L=lcomp(h,L);
			}
			j--;
		}
		

	}	
	return(L);
}