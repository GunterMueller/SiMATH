/*M
.SH NAME
maihnf - matrix of integers Hermite normal form

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maihnf(M)
matrix M;

.SH DESCRIPTION
maihnf() returns the Hermite normal form of a matrix M.
.PP
.TP 4
.B M
must be a matrix of integers.
M*/
/*H
        Version 1       20.02.1998  Andreas Heiser
   DATE ismari      : 
H*/
	
#include <_matr1.h>

matrix maihnf(A)
matrix	A;
{	matrix		M,W;
	single		i,j,k,l,m,n,d,e,f,g,j0,i1,i2;
	int		b,h,q;
	floating	f1,f2;
	
	init(M,W,i,j,k,l,m,n,d,e,f,g,j0,i1,i2,b,h,q,f1,f2);
	bind(A);

	m=llength(A);n=llength(lfirst(A));
	W=maconszero(m,n);
	M=A;i=m;k=n;
	if(icomp(m,n)>0)
	{	l=idif(m,n);
		l++;
	}
	else
		l=1;

	e=1;
	while(e)
	{	f=1;j=1;
		/*printf("\n : ");putsi(i);*/

		while(icomp(j,k)<0 && f)
		{	h=maselel(M,i,j);
			if(icomp(h,0))
                               	f=0;
			j++;
		}
		if(!f)
		{	j=1;
			while(j)
			{	q=maselel(M,i,j);
				q=iabs(q);
				if(q)
				{	j0=j;
					j=0; 
				}
				else
					j++; 
			}
			for(j=1;j<=k;j++)
			{	h=maselel(M,i,j);
				h=iabs(h);
				/*printf("\n h: ");puti(h);*/
				if(icomp(h,q)<0 && h)
				{	q=h;
					j0=j;
				}
			}
			if(icomp(j0,k)<0)
				M=maicc(M,k,j0);
			/*printf("\n AB: ");putl(M);*/
			h=maselel(M,i,k);
			/*printf("\n hh: ");puti(h);*/
			if(icomp(h,0)<0)
				M=maicmult(M,k,-1);
			b=maselel(M,i,k);
			/*printf("\n b: ");puti(b);*/
			for(j=1;j<k;j++)
			{	q=maselel(M,i,j);
				f1=flquot(itofl(q),itofl(b));
				q=flfloor(f1);
				M=maicsum(M,1,j,-q,k);
			}
			/*printf("\n AC: ");putl(M);*/
		}
		else
		{	h=maselel(M,i,k);
                        if(icomp(h,0)<0)
                  		M=maicmult(M,k,-1);
                        b=maselel(M,i,k);
                        if(b)
                        {	for(j=n;j>k;j--)
				{	q=maselel(M,i,j);
					f1=flquot(itofl(q),itofl(b));
					q=flfloor(f1);
					M=maicsum(M,1,j,-q,k);
					/*printf("\n AD: ");putl(M);*/
				}
			}
                        else
                           	k++;
			if(!icomp(i,l))
			{	d=idif(n,k);d++;
				for(j=1;j<=d;j++)
				{	g=isum(j,k);g--;
					for(i1=1;i1<=n;i1++)
					{	h=maselel(M,i1,g);
						i2=masetel(W,i1,j,h);
					}
				}
				e=0;
			}
			else
			{	i--;
				k--;
			}
		}
	}
	/*printf("\n W: ");putmai(W);*/
	return(W);
}
