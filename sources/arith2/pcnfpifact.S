/*M
.SH NAME 
pcnfpifact - pure cubic number field element prime ideal factorization

.SH SYNOPSIS
.nf
#include<_arith2.h>

list pcnfpifact(D, a)
int    D;
nfel   a;

.SH DESCRIPTION
pcnfpifact() computes the factorization of the principal ideal (a) into prime ideals, where a is an element of the pure cubic number field K = Q(D^(1/3)). 
.TP 3 
pcnfpifact() returns:
ERROR, if a = 0, \   \    \    \    \   \  \   \   \   \   \  \  \  ( 1 ), if a is a unit in the ring of integers O_K of K,
( P_1  e_1  f_1  w_1  ...  P_k  e_k  f_k  w_k )  \   \    list  P_i;  single  e_i, f_i, w_i;\   \    \    \   \    \  with prime ideals P_i = ( p, pi ), p a prime number of Q, pi a prime element of K, e_i the ramification index, f_i th residue class degree of P_i over p and the corresponding exponents w_i in the prime ideal decomposition of (a). 
.PP
.TP 4
.B D
is a non negative cubefree integer not equal to 0 or 1.
.TP 4
.B a
is an element of the pure cubic number field K = Q(D^(1/3)). 
M*/
/*H
        Version 1        20.02.98      Andreas Heiser 
   DATE pcnfpifact     : 
H*/
	
#include <_arith2.h>

list pcnfpifact(D,aa)
int	D;
nfel	aa;
{	list		L,L1,L2,L3,Pi;
	pol		F,G;	
	int		a,b,c,d,n,p,u,v,x,y;
	rat		r;
	nfel		h,pi,th,om;
	single		e;
	floating	f;

	init(L,L1,L2,L3,Pi,F,G,a,b,c,d,n,p,r,h,pi,th,om,u,v,e,f,x,y);
	bind(D,aa);

	if(!aa)
		return( ERROR );

	L=_0;F=list5(3,1,0,0,-D);
	n=lfirst(aa);
	h=nfeliprod(F,aa,n);
	n=iexp(n,3);
	r=nfnorm(F,h);
	
	n=ilcm(n,rnum(r));
	
	if(n!=1)
	{	L1=ifact(n);
		L1=ifel(L1);
	}
	else
		L1=_0;
	if(llength(L1)==0)
		return(list1(1));
	L2=ifact(D);L2=ifel(L2);
	a=1;b=1;
	while(L2!=_0)
	{	c=iexp(lfirst(L2),lsecond(L2));
		if(mihom(2,lsecond(L2)))
			a=iprod(a,c);
		else
			b=iprod(b,c);
		L2=lred2(L2);
	}
	b=isqrt(b);
	c=iprod(a,b);
	th=list4(1,1,1,0);

	while(L1!=_0)
	{	p=lfirst(L1);
		
		if(mihom(p,c) && p!=3)
		{	G=dptop(1,F);
			G=pitopmi(1,G,p);
			L2=upmicfact(p,G);L2=linv(L2);
			if(mihom(3,p)==2)
			{	while(L2!=_0)
				{	G=lfirst(L2);
					f=lfirst(G);
					G=ptodp(1,G);
					G=udpitoudpr(G);
					pi=udprtonfel(G);
					Pi=list2(p,pi);
					e=pcnfpiord(D,Pi,1,f,aa);
					if(e)
						L=lcomp4(Pi,1,f,e,L);
					L2=lred(L2);
				}
			}
			else
			{	u=idif(p,1);u=iquot(u,3);
				u=iexp(D,u);
				
				if(mihom(p,u)==1)
				{	while(L2!=_0)
					{	G=lfirst(L2);
						G=ptodp(1,G);
						G=udpitoudpr(G);
						pi=udprtonfel(G);
						Pi=list2(p,pi);
						e=pcnfpiord(D,Pi,1,1,aa);
						if(e)
							L=lcomp4(Pi,1,1,e,L);
						L2=lred(L2);
					}
				}
				else
				{	Pi=list1(p);
					e=pcnfpiord(D,Pi,1,3,aa);
					if(e)
						L=lcomp4(Pi,1,3,e,L);
				}
			}
		}
		else
			if(!mihom(p,c))
			{	if(!mihom(p,a))
					Pi=list2(p,th);		
				else
				{	L2=pcnfintbas(D);
					Pi=list2(p,lthird(L2));
				}
				e=pcnfpiord(D,Pi,3,1,aa);
				if(e)
					L=lcomp4(Pi,3,1,e,L);
			}
			else	
			{	u=iexp(a,2);v=iexp(b,2);
				u=idif(u,v);
				if(mihom(9,u))
				{	pi=nfdif(F,th,itonf(a));
					Pi=list2(p,pi);
					e=pcnfpiord(D,Pi,3,1,aa);
					if(e)
						L=lcomp4(Pi,3,1,e,L);
				}
				else
				{	L2=pcnfintbas(D);
					om=lthird(L2);
					x=iexp(a,2);x=isum(x,2);
					x=iprod(x,b);
					h=nfquot(F,itonf(x),itonf(3));
					pi=nfdif(F,om,h);
					Pi=list2(3,pi);
					e=pcnfpiord(D,Pi,1,1,aa);
					if(e)
						L=lcomp4(Pi,1,1,e,L);
					x=iexp(a,2);x=idif(x,1);
					x=iprod(x,b);
					h=nfquot(F,itonf(x),itonf(3));
					pi=nfdif(F,om,h);
					x=iexp(D,2);
					if(mihom(27,x)==1)
					{	pi=nfsum(F,pi,th);
						pi=nfdif(F,pi,itonf(a));
					}
					Pi=list2(3,pi);
					e=pcnfpiord(D,Pi,2,1,aa);
					if(e)
						L=lcomp4(Pi,2,1,e,L);
				}
			}
		L1=lred2(L1);
	}
	return(L);
}		















