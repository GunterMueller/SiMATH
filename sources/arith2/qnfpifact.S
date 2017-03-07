/*M
.SH NAME 
qnfpifact - quadratic number field element prime ideal factorization

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfpifact(D, a)
int    D;
nfel   a;

.SH DESCRIPTION
qnfpifact() computes the factorization of the principal ideal (a) into prime ideals, where a is an element of the quadratic number field K = Q(D^(1/2)). 
.TP 3 
qnfpifact() returns:
ERROR, if a = 0, \   \    \    \    \   \  \   \   \   \   \  \  \  ( 1 ), if a is a unit in the ring of integers O_K of K,
( P_1  f_1  pi_1  z_1  ...  P_k  f_k  pi_k  z_k )  \   \    list  P_i;  single  f_i, z_i;  nfel  pi_i;\   \    \    \    with prime ideals P_i (see 'qnfidprod'), the corresponding exponents f_i in the prime ideal decomposition of (a), prime elements pi_i, and z_i = 0, 1 or 2, if the prime ideal P_i divides an inert, ramified or split prime number in Q.

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B a
is an element of the quadratic number field K = Q(D^(1/2)). 
M*/
/*H
        Version 1       03.01.1997      Andreas Heiser 
   DATE qnfpifact     : 970103
H*/

#include <_arith2.h>

list qnfpifact(D,a)
int	D;
nfel	a;

{	list	L,L1,L2,L3,Pi,Pi1,Pi2;
	rat	r;
	nfel	pi,b,pi1,pi2;
	int	c,d,n,p,D0,x,y,p2;
	single	e,f;

	init(L,L1,L2,L3,Pi,Pi1,Pi2);
	init(r);
	init(pi,b,pi1,pi2);
	init(c,d,n,p,D0,x,y,p2);
	init(e,f);

	bind(D,a);

	if(!a)
		return( ERROR );

	else
	{	if(m4hom(D)==1)
			f=1;
		else
			f=0;
	
		L=_0;
		n=lfirst(a);
		b=qnfiprod(D,a,n);
		r=qnfnorm(D,b);
		n=ilcm(n,rnum(r));
	
		if(n!=1)
		{ 	L1=ifact(n);
			L1=ifel(L1);
		}
		else
			L1=_0;

		while(L1!=_0)
		{	p=lfirst(L1);
			L2=qnframind(D,p);
			if(llength(L2)==1)
			{	r=qnfnorm(D,a);
				e=ravalint(p,r);
				if(lfirst(L2)==1)

				/*   p traege in K        		*/
                		/*   pi  = p              		*/
                		/*   (p) = (p)*[1,(1+D^(1/2))/2],     	*/
				/*                falls D = 1 mod 4   	*/
                		/*         Darstellung: (p,2,1,2)       */
                		/*   (p) = (p)*[1,D^(1/2)], 		*/
				/*		  falls D = 2,3 mod 4   */   
				/*         Darstellung: (p,1,0,1)       */

				{	pi=list3(1,0,p);
					e=iquot(e,2);
					if(e)
					L=lcomp4(list4(p,f+1,f,f+1),e,pi,0,L);
				}
				else
			
				/*   p verzweigt in K			*/
				
				{	if(p==2 && m4hom(D)==3)

					/*   pi = 1+D^(1/2)        	*/
					/*   (2) = [2,1+D^(1/2)]	*/
					/*   Darstellung: (p,1,0,1)	*/

					{	pi=list4(1,1,1,1);
						Pi=list4(1,2,1,1);
					}
					else

					/*   pi = D^(1/2)		*/
					/*   (p) = [p,D^(1/2)]		*/
					/*   Darstellung: (1,p,0,f+1)	*/

					{   pi=list4(1,1,1,0);
					    if(f)
						Pi=list4(1,isprod(p,2),p,2);
					    else
						Pi=list4(1,p,0,1);
					}
					if(e)
					L=lcomp4(Pi,e,pi,1,L);
				}
			}
			else

			/*   	p zerlegt in K				*/
	
			{	if(p==2)
				{	if(mshom(16,D)==1)
					
					/*   pi1 = 1+(1+D^(1/2))/2	*/
					/*       = (3+D^(1/2))/2	*/
					/*   P1 = [p,(3+D^(1/2))/2]	*/
					/*   Darstellung: (1,4,3,2)	*/
					/*   pi2 = 2-(1+D^(1/2))/2	*/
					/*       = (3-D^(1/2))/2	*/
					/*   P2 = [p,(1+D^(1/2))/2]	*/
					/*   Darstellung: (1,4,1,2)	*/

					{	pi1=list4(2,1,1,3);
						pi2=list4(2,1,-1,3);
						Pi1=list4(1,4,3,2);
						Pi2=list4(1,4,1,2);
					}
					else

					/*   pi1 = (1+D^(1/2))/2	*/
					/*   P1 = [p,(1+D^(1/2))/2]	*/
					/*   Darstellung: (1,4,1,2)	*/
					/*   pi2 = 1-(1+D^(1/2))/2	*/
					/*       = (1-D^(1/2))/2	*/
					/*   P2 = [p,(3+D^(1/2))/2]	*/
					/*   Darstellung: (1,4,3,2)	*/

					{	pi1=list4(2,1,1,1);
						pi2=list4(2,1,-1,1);
						Pi1=list4(1,4,1,2);
						Pi2=list4(1,4,3,2);
					}
				}
				else
				{	n=mihom(p,D);
					L3=list2(p,1);
					L3=misqrtas(L3,n);
					n=libsort(L3);
					if(m4hom(D)==1)
					{	n=1;
						while(L3!=_0 && n)
						{	D0=lfirst(L3);
							if(irem(D0,2))
							{	x=iexp(D0,2);
								x=idif(x,D);
								y=iexp(p,2);
								if(irem(x,y))
									n=0;
							}
							else
							{	x=iexp(D0,2);
								x=idif(x,D);
								y=iexp(p,2);
								if(!irem(x,y))
									n=0;
							}
							L3=lred(L3);
						}
						c=idif(D0,1);d=isum(D0,1);
						if(!irem(D0,2))
						{	c=isum(c,p);
							d=isum(d,p);
						}
						c=iquot(c,2);d=iquot(d,2);
					}	
					else
					{	c=lfirst(L3);	
						x=iexp(c,2);
						x=idif(x,D);
						y=iexp(p,2);
						if(!irem(x,y))
							c=isum(c,p);
						d=c;
					}	

					/*   {1,omega} Ganzheitsbasis	*/
					/*   pi1 = c + omega		*/
					/*   pi2 = d - omega		*/

					L3=qnfintbas(D);
					pi1=lsecond(L3);pi2=pi1;
					pi1=qnfisum(D,pi1,c);
					pi2=qnfdif(D,itoqnf(D,d),pi2);
				
					if(m4hom(D)==1)

					{	n=lfourth(pi1);
						p2=isprod(p,2);
						n=mihom(p2,n);
						if(ieven(n))
							n=isum(n,p);
						Pi1=list4(1,p2,n,2);
						n=ineg(lfourth(pi2));
						n=mihom(p2,n);
						if(ieven(n))
							n=isum(n,p);
						Pi2=list4(1,p2,n,2);
					}
					else
					{	n=lfourth(pi1);
						n=mihom(p,n);

						Pi1=list4(1,p,n,1);
						n=ineg(lfourth(pi2));
						n=mihom(p,n);
						Pi2=list4(1,p,n,1);
					}
				}
				e=qnfpiord(D,Pi1,pi1,2,a);
				if(e)
					L=lcomp4(Pi1,e,pi1,2,L);
				e=qnfpiord(D,Pi2,pi2,2,a);
				if(e)
					L=lcomp4(Pi2,e,pi2,2,L);
			}
			L1=lred2(L1);
		}
		if(!llength(L))
			L=list1(1);
		return(L);
	}
}



