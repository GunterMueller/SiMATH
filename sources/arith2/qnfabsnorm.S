/*M
.SH NAME 
qnfabsnorm - quadratic number field absolut norm

.SH SYNOPSIS
.nf
#include<_arith2.h>

rat qnfabsnorm(D, L)
int    D;
list   L;

.SH DESCRIPTION
qnfabsnorm() computes the absolut norm of a divisor of the quadratic number field K = Q(D^(1/2)). 

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B L
is a list representinig a divisor in K. \  \  \  \  \  \  \  
L = ( P_1  f_1  pi_1  z_1  ...  P_k  f_k  pi_k  z_k )  \   \    list  P_i;  single  f_i, z_i;  nfel  pi_i;\   \   with prime ideals P_i (see 'qnfidprod'), the corresponding exponents f_i in the prime ideal decomposition of (a), prime elements pi_i, and z_i = 0, 1 or 2, if the prime ideal P_i divides an inert, ramified or split prime number in Q. 
M*/
/*H
        Version 1       03.01.1997      Andreas Heiser 
   DATE qnfabsnorm    : 970103
H*/

#include <_arith2.h>

int  qnfabsnorm(D,L)
int 	D;
list	L;
{	int	p;
	rat	N,r;
	single  fi;
	list	Pi,R;
	init(N,p,Pi,R,fi,r);
	bind(D,L);
	N=list2(1,1);
	
	if(llength(L)!=1)
	{	while(L!=_0)
		{	Pi=lfirst(L);
			p=lfirst(Pi);p=iprod(p,lsecond(Pi));
			p=iquot(p,lfourth(Pi));
			fi=lsecond(L);
			if(!lfourth(L))
				fi=iprod(fi,2);
			r=itor(p);
			if(fi<0)
			{	r=rexp(r,-fi);
				r=rinv(r);
			}
			else
				r=rexp(r,fi);
			N=rprod(N,r);
			L=lred4(L);
		}
	}
	return(N);	
}