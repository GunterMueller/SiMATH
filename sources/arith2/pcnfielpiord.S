/*M
.SH NAME 
pcnfielpiord - pure cubic number field integer element prime ideal order

.SH SYNOPSIS
.nf
#include<_arith2.h>

single pcnfielpiord(D, Pi, e, f, a)
int      D;
list     Pi;
single   e,f; 
nfel     a;

.SH DESCRIPTION
pcnfielpiord() computes the normalized Pi-adic valuation of an element a in the ring of integers O_K of a pure cubic number field K = Q(D^(1/3)) at a prime ideal Pi, i.e. the order of the prime ideal in the prime ideal decomposition of the principal ideal (a). 
.TP 3 
It returns:
ERROR, if a = 0, \   \    \    \    \   \  \   \   \   \   \  \  \  ord_P( a ), 
if a is an element in the ring of integers O_K of K = Q(D^(1/3))\\{0}. 

.PP
.TP 4
.B D
is a cubefree integer not equal to 0 or 1.
.TP 4
.B Pi
is a prime ideal in the ring of integers O_K of K.
.TP 4
.B e
is the ramification index of Pi over the according prime number.
.TP 4
.B f
is the degree of the residue class field.
.TP 4
.B a
is an element in the ring of integers O_K of K. 
M*/
/*H
        Version 1      20.02.1998        Andreas Heiser
   DATE pcnfielpiord : 
H*/

#include<_arith2.h>

single pcnfielpiord(D,Pi,e,f,a)
int	D;
list	Pi;
single	e,f;
nfel	a;
{	single	c,w,i,j,k,jj,kk;
	rat	r,s;
	int	d,d1,d2,p,h,x,y,n,ci,di,ei,mi;			
	pol	F;
	list	L,H,HH,W,I;
	matrix	A,N,M,M1,M2;
	nfel	w1,w2,w3,th,h1,h2,pi,om,bb;

	init(c,w,i,j,jj,r,d,d1,p,h,F,N,M,M1,M2,L,H,HH,w1,w2,w3,th,h1,h2,pi);
	init(x,y,n,ci,di,ei,om,bb,A,kk,s,k,W,d2,I);
	bind(D,Pi,e,f,a);
	
	F=list5(3,1,0,0,-D);
	c=iprod(e,f);
	p=lfirst(Pi);
	if(llength(Pi)>1)
		pi=lsecond(Pi);
	
	w=0;
	th=list4(1,1,1,0);
	if(c==3)
	{	r=nfnorm(F,a);
		w=iavalint(p,rnum(r));
		if(f==3)
			w=iquot(w,3);
		return(w);
	}
	else
	{	L=pcnfintbas(D);
		H=L;HH=_0;
		while(H!=_0)
		{	h1=lfirst(H);
			h1=nfprod(F,a,h1);
			HH=lcomp(h1,HH);
			H=lred(H);
		}
		HH=linv(HH);
		HH=pcnfherm(D,HH);
		M=lfirst(HH);d1=lsecond(HH);
		
		L=pcnfherm(D,L);
		N=lfirst(L);d=lsecond(L);
	
		L=_0;
		for(i=1;i<=3;i++)
		{	h=maselel(N,1,i);
			h1=itonf(h);
			for(j=2;j<=3;j++)	
			{	h=maselel(N,j,i);
				jj=j;jj--;
				h2=nfexp(F,th,jj);
				h2=nfprod(F,h2,itonf(h));
				h1=nfsum(F,h1,h2);
			}
			h1=nfquot(F,h1,itonf(d));
			L=lcomp(h1,L);
		}
		W=linv(L);L=W;
		/* W Ganzheitsbasis */
	
		M1=maicons1(3);M1=maismul(M1,p);
		M2=maconszero(3,3);
		pi=lsecond(Pi);
		om=lthird(L);H=L;
		n=lfirst(om);x=lfourth(om);y=lfifth(om);
		for(i=1;i<=3;i++)
		{	h1=lfirst(H);
			h1=nfprod(F,h1,pi);
			mi=lfirst(h1);
			if(lsecond(h1)==0)
			{	ci=0;di=0;ei=lthird(h1);
			}
			else
				if(lsecond(h1)==1)
				{	ci=0;di=lthird(h1);
					ei=lfourth(h1);
				}
				else
				{	ci=lthird(h1);
					di=lfourth(h1);
					ei=lfifth(h1);
				}
			h=iprod(ci,n);h=iquot(h,mi);
			j=masetel(M2,i,3,h);
			h=iprod(ci,x);h=idif(di,h);
			h=iquot(h,mi);
			j=masetel(M2,i,2,h);
			h=iprod(ci,y);h=idif(ei,h);
			h=iquot(h,mi);
			j=masetel(M2,i,1,h);
			H=lred(H);
		}
		M2=matransp(M2);
		
		M2=maitomami(p,M2);
	
		H=maminsb(p,M2);
		H=lfirst(H);
		
		bb=0;HH=L;
		for(i=1;i<=3;i++)
		{	h1=lfirst(HH);
			h=lfirst(H);
			h1=nfeliprod(F,h1,h);
			bb=nfsum(F,bb,h1);
			H=lred(H);
			HH=lred(HH);
		}
		/* Berechnung von beta */
	
		A=maitomar(N);A=marinv(A);
	
		M=maitomar(M);
		
		A=marprod(A,M);
		r=rcons(d,d1);
		A=marsmul(A,r);

		h=1;
		for(i=1;i<=llength(A);i++)
		{	r=maselel(A,i,i);
			h=iprod(h,rnum(r));
		}
		
		if(mihom(p,h))
			return(0);
		else
		{	w=0; 
			r=rcons(iexp(d,3),maidet(N));
			while(1)
			{	L=_0;
				for(i=1;i<=3;i++)
				{	h1=0;HH=W;
					for(k=1;k<=3;k++)
					{	h2=lfirst(HH);
						h=rnum(maselel(A,k,i));
						h2=nfprod(F,h2,itonf(h));
						h1=nfsum(F,h1,h2);
						HH=lred(HH);
					}
					h1=nfprod(F,h1,bb);
					h=lfirst(h1);
					d2=ilcm(d2,h);
					
					L=lcomp(h1,L);
				}
				L=linv(L);H=L;
				A=_0; 
				while(H!=_0)
				{	h1=lfirst(H);
					HH=pcnfintbasvec(D,h1,W);
					A=lcomp(HH,A);
					H=lred(H);
				}
				A=linv(A);
				A=matransp(A);
				s=rcons(1,p);
				A=maitomar(A);
				A=marsmul(A,s);
				if(ismari(A)) 
					w++;
				else
					return(w); 
			}
			return(w);
		}
	}	
}

list pcnfherm(D,L)
int	D;
list	L;
{	matrix	M;
	nfel	a;	
	int	d,k;
	single	i,j,l,m;
	list	H;

	init(M,a,d,i,j,k,l,m);
	bind(D,L);
	
	d=1;H=L;
	while(H!=_0)
	{	a=lfirst(H);
		k=lfirst(a);
		d=ilcm(d,k);
		H=lred(H);
	}
	H=L;j=1;
	M=maconszero(3,3);
	while(H!=_0)
	{	a=lfirst(H);
		k=lfirst(a);
		k=iquot(d,k);
		i=lsecond(a);i++;
		a=lred2(a);
		while(a!=_0)
		{	l=lfirst(a);
			l=iprod(l,k);
			m=masetel(M,i,j,l);
			i--;
			a=lred(a);
		}
		j++;
		H=lred(H);
	}
	M=maihnf(M);
	H=list2(M,d);
	return(H);
}

/*  a = x*1 + y*th + z*om , {1,th,om} Ganzheitsbasis  */
/*  Ausgabe:  L = (x,y,z)			      */

list pcnfintbasvec(D,a,I)
int	D;
nfel 	a;
list	I;
{	list	L;
	int	x,y,z;	
	rat	r,s;
	nfel	om,b;
	pol	F;

	init(L,x,y,z,r,s,om,b,F);
	bind(D,a,I);

	F=list5(3,1,0,0,-D);

	if(lsecond(a)==2)
	{	r=rcons(lthird(a),lfirst(a));
		om=lthird(I);
		s=rcons(lthird(om),lfirst(om));
		z=rnum(rquot(r,s));
		b=nfeliprod(F,om,z);
		b=nfdif(F,a,b);
	}
	else
	{	z=0;
		b=a;
	}
	if(b)
		if(lsecond(b)==1)
		{	x=lfourth(b);
			y=lthird(b);
		}
		else
		{	x=lthird(b);
			y=0;
		}
	else
	{	x=0;y=0; 
	}	
	L=list3(x,y,z);
	return(L);
}	