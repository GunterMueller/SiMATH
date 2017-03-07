/*M
.SH NAME 
udp3rf - univariate dense polynomial degree 3 root finding

.SH SYNOPSIS
.nf
#include<_pol1.h>
#include<_PAFarith.h>

list udp3rf( P )
pol    P;

.SH DESCRIPTION
udp3rf() computes all real and complex roots of a polynomial of degree 3, P(x) = a * x^3 + b * x^2 + c * x +d , where a, b, c, d are real numbers.
.TP 4 
udp3rf() returns a list L = ( L1, L2 ) of two lists, where L1 is the list of real roots and L2 is the list of complex roots of P.
.PP
.TP 4
.B P
is an univariate dense polynomial of degree 3.
M*/
/*H
        Version 1       24.04.1997      Andreas Heiser
   DATE udp3rf   :  
H*/

#include<_pol1.h>
#include<_PAFarith.h>

list udp3rf(P)
pol	P;
{	list	 	L,L1,L2,H;
	floating	p,q,r,s,t,D,h1,h2,rho,phi,y1,y2,y3;
	complex		u,v,e1,e2,c1,c2,x1,x2,x3;
	single		i;
	
	init(L,L1,L2,H,p,q,r,s,t,D,h1,h2,i,u,v,e1,e2,c1,c2,x1,x2,x3);
	init(rho,phi,y1,y2,y3);
	bind(P);
	
	L=_0;L1=_0;L2=_0;

	h1=lsecond(P);
	r=lthird(P);
	s=lfourth(P);
	t=lfifth(P);

	r=flquot(r,h1);s=flquot(s,h1);t=flquot(t,h1);

	/* Berechnung von p und q */

	h1=flprod(s,itofl(3));h2=flprod(r,r);
	h1=fldif(h1,h2);p=flquot(h1,itofl(3));
	h1=flprod(r,r);h1=flprod(h1,r);
	h1=flprod(h1,itofl(2));h1=flquot(h1,itofl(27));
	h2=flprod(r,s);h2=flquot(h2,itofl(3));
	h1=fldif(h1,h2);q=flsum(h1,t);
	
	/* Berechnung von D */

	h1=flprod(p,p);h1=flprod(h1,p);
	h1=flquot(h1,itofl(27));
	h2=flprod(q,q);h2=flquot(h2,itofl(4));
	D=flsum(h1,h2);
	h1=flsexp(itofl(10),-10);
	h2=flabs(D);
	if(flcomp(h2,h1)<=0)
		D=0;
	
	if(flcomp(D,0)>=0)
	{	if(p==0)
		{	u=fltoc(flneg(q));
			L=cnroot(u,3);
			h1=flsexp(itofl(10),-10);
			while(L!=_0)
			{	x1=lfirst(L);
				h2=cimag(x1);h2=flabs(h2);
				if(flcomp(h2,h1)<=0)
					L1=lcomp(creal(x1),L1);
				else
					L2=lcomp(x1,L2);
				L=lred(L);
			}
		}
		else
		{	
			h1=flquot(q,itofl(-2));
			h2=flsqrt(D);h1=flsum(h1,h2);
			h2=flquot(itofl(1),itofl(3));
			if(flsign(h1)<0)
			{	h1=flpow(flneg(h1),h2);
				h1=flneg(h1);
			}
			else
				h1=flpow(h1,h2);
			u=fltoc(h1);

			h1=flsexp(itofl(10),-10);
			h2=flabs(u);
			if(flcomp(h2,h1)>0)	/** u!=0 **/
			{
				v=cquot(fltoc(p),itoc(-3));
				v=cquot(v,u);
			}
			else 			/** u=0 **/
			{	h1=flquot(q,itofl(-2));
				h2=flsqrt(D);h1=fldif(h1,h2);
				h2=flquot(itofl(1),itofl(3));
				if(flsign(h1)<0)
				{	h1=flpow(flneg(h1),h2);
					h1=flneg(h1);
				}
				else
					h1=flpow(h1,h2);
				v=fltoc(h1);
			}
		
			e1=ccri(itofl(-1),flsqrt(itofl(3)));
			e1=cquot(e1,itoc(2));
			e2=cconjug(e1);
	
			h1=flquot(r,itofl(-3));
			x1=csum(u,v);
			x1=csum(x1,fltoc(h1));
			y1=creal(x1);
			L1=list1(y1);
			
			c1=cprod(e1,u);c2=cprod(e2,v);
			x2=csum(c1,c2);x2=csum(x2,fltoc(h1));
			c1=cprod(e2,u);c2=cprod(e1,v);
			x3=csum(c1,c2);x3=csum(x3,fltoc(h1));
			
			h1=fldif(creal(u),creal(v));
			h1=flabs(h1);
			h2=flsexp(itofl(10),-10);
			if(flcomp(h1,h2)<=0)
			{	y2=creal(x2);
				y3=creal(x3);
				L1=lcomp2(y3,y2,L1);
				L1=linv(L1);
			}
			else
				L2=list2(x2,x3);
		}
	}
	else
	{	h1=flprod(p,p);h1=flprod(h1,p);
		h1=flsquot(h1,-27);rho=flsqrt(h1);
		h1=flquot(q,itofl(-2));h1=flquot(h1,rho);
		phi=flPAFfu(Facos,1,h1);
		h1=flquot(itofl(1),itofl(3));
		rho=flpow(rho,h1);rho=flprod(rho,itofl(2));
		h1=flquot(phi,itofl(3));h1=flcos(h1);
		y1=flprod(rho,h1);
		h1=flprod(itofl(2),flPi());h1=flsum(phi,h1);
		h1=flquot(h1,itofl(3));h1=flcos(h1);
		y2=flprod(rho,h1);
		h1=flprod(itofl(4),flPi());h1=flsum(phi,h1);
		h1=flquot(h1,itofl(3));h1=flcos(h1);
		y3=flprod(rho,h1);

		h1=flquot(r,itofl(-3));
		
		y1=flsum(y1,h1);
		y2=flsum(y2,h1);
		y3=flsum(y3,h1);
	
		L1=list3(y1,y2,y3); lflbsort(L1);
	}
	L=list2(L1,L2);
	return(L);
}



