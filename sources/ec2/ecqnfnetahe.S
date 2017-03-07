/*M
.SH NAME 
ecqnfnetahe - elliptic curve over quadratic number field Neron-Tate height

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnfnetahe(D, E, P)
int    D;
list   E, P;

.SH DESCRIPTION
ecqnfnetahe() returns the Neron-Tate height of a point P on an elliptic curve E over a quadratic number field K = Q(D^(1/2)) (see J.H. Silverman: Math. of Comp., 51, 1988, p. 339-358).

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B P
is a list representing a point on E(K). \  \  \  \  \  \  \  P = ( xp, yp, zp )\  nfel xp, yp, zp;   
M*/
/*H
        Version 1      02.01.1997	 Andreas Heiser
   DATE ecqnfnetahe  : 
H*/

#include<_ec2.h>

floating ecqnfnetahe(D, E, P)
int	D;
list	E,P;

{	pol		F;
	floating	ch,lh,f1,f2;
	int		n1,p;
	single		f,g,z,e1,e2;
	nfel		a1,a2,a3,a4,a6;
	nfel		h1,h2,A1,B1,pi,u;
	nfel		a1m,a2m,a3m,a4m,a6m,xp,yp,zp,xm,ym,xpm;
	list		AA,L1,L2,L3,L4,Pi,V;
	
	bind(D,E,P);
	
	init(F);
	init(ch,lh,f1,f2);
	init(n1,p);
	init(f,g,z,e1,e2);
	init(a1,a2,a3,a4,a6);
	init(h1,h2,A1,B1,pi,u);
	init(a1m,a2m,a3m,a4m,a6m,xp,yp,zp,xm,ym,xpm);
	init(AA,L1,L2,L3,L4,Pi,V);
	
	V=pmakevl("x");
	F=list4(2,1,0,-D);
	
	xp=lfirst(P);
	yp=lsecond(P);
	zp=lthird(P);
	
	if(!zp)
		return(0);
	else
	{	xp=qnfquot(D,xp,zp);
		yp=qnfquot(D,yp,zp);
	}
	
	L1=lfirst(E);
	L2=lfirst(L1);
	a1=lfirst(L2);
	a2=lsecond(L2);
	a3=lthird(L2);
	a4=lfourth(L2);	
	a6=lfifth(L2);

	/* Berechnung der archimedischen lokalen Hoehe(n) */

	ch=ecqnflhaav(D,E,P,50);

	h1=qnfexp(D,xp,2);h1=qnfiprod(D,h1,3);
	h2=qnfprod(D,a2,xp);h2=qnfiprod(D,h2,2);
	h1=qnfsum(D,h1,h2);h1=qnfsum(D,h1,a4);
	h2=qnfprod(D,a1,yp);
	A1=qnfdif(D,h1,h2);

	h1=qnfiprod(D,yp,2);h2=qnfprod(D,a1,xp);
	h1=qnfsum(D,h1,h2);
	B1=qnfsum(D,h1,a3);

	/* Anteil von E1(K) */	

	if(xp)
	{	L1=qnfpifact(D,xp);
	        n1=1;
	        if(llength(L1)!=1)
		{	while(L1!=_0) 
		        {       Pi=lfirst(L1);
			        f=lsecond(L1);
			        pi=lthird(L1);
				z=lfourth(L1);
				if(f<0)
				  {
				    if(A1)
				      e1=qnfpiord(D,Pi,pi,z,A1);
				    else
				      e1=1;
				    if(B1)
				      e2=qnfpiord(D,Pi,pi,z,B1);
				    else
				      e2=1;
				    if(e1<=0 && e2<=0)
				      {
					p=lfirst(Pi);p=iprod(p,lsecond(Pi));
					p=iquot(p,lfourth(Pi));
					if(!z)
					  p=iexp(p,2);
					p=iexp(p,ineg(f));
					n1=iprod(n1,p);
				      }
				  }
				L1=lred4(L1);
			} 
		}
		lh=fllog(itofl(n1));
		ch=flsum(ch,lh);
	}

	/* Anteile schlechter Reduktion */
	
	if(A1)
	  {
	    L1=qnfpifact(D,A1);
	    L2=_0;
	    while(llength(L1)>1)
	      {
		Pi=lfirst(L1);
		f=lsecond(L1);
		pi=lthird(L1);
		z=lfourth(L1);
		if(f>0)
		  {
		    if(B1)
		      g=qnfpiord(D,Pi,pi,z,B1);
		    else
		      g=1;
		    if(g>0)
		      L2=lcomp4(Pi,f,pi,z,L2);
		  }
		L1=lred4(L1);
	      }
	  }
	else
	  L2=qnfpifact(D,B1);
		
	while(llength(L2)>1)
	  {
	    Pi=lfirst(L2);
	    f=lsecond(L2);
	    pi=lthird(L2);
	    z=lfourth(L2);
	    p=lfirst(Pi);p=iprod(p,lsecond(Pi));
	    p=iquot(p,lfourth(Pi));
	    L3=list4(Pi,f,pi,z);
	    L4=ecqnfmineqnaav(D,E,P,L3);
	    a1m=lfirst(L4);a2m=lsecond(L4);
	    a3m=lthird(L4);a4m=lfourth(L4);
	    a6m=lfifth(L4);L4=lred5(L4);
	    AA=ecqnfinit(D,a1m,a2m,a3m,a4m,a6m);
	    lh=ecqnflhnaav(D,AA,L4,L3);
	    ch=flsum(ch,lh);
	    xpm=lfirst(L4);
	    if(xpm)
	      u=qnfquot(D,xp,xpm);
	    else
	      u=list3(1,0,1);
	    f1=itofl(qnfpiord(D,Pi,pi,z,u));
	    f2=fllog(itofl(p));
	    if(!z)
	      f2=flprod(f2,itofl(2));
	    f1=flprod(f1,f2);
	    ch=fldif(ch,f1);

	    L2=lred4(L2);
	  }
	ch=flquot(ch,itofl(2));

	return(ch);
}

matrix	imat(m)
single	m;
{	int	n;
	single	i,ii,j,jj,k,kk,mm,r,rr;
	matrix	M;
	init(n,i,ii,j,jj,k,kk,mm,r,rr,M);
	bind(m);
	mm=iphi(m);
	mm=iquot(mm,2);
	M=maconszero(mm,mm);
	mm=iquot(m,2);
	if(irem(m,2))	mm=isum(mm,1);	
	ii=0;
	for(i=1;i<mm;i++)
	{	if(igcd(i,m)==1)
		{	ii++;jj=0;
			for(j=1;j<mm;j++)
			{	if(igcd(j,m)==1)
				{	jj++;
					k=iprod(i,j);
					r=irem(k,m);
					rr=idif(m,r);
					k=imin(r,rr);
					kk=masetel(M,ii,jj,k);
				}
			}
		}
	}
	return(M);
}

int maigcd(M)
matrix	M;
{	list	ZM;
        int	gcd,i;
	bind(M);
        init(ZM,gcd,i);
	if(M!=_0)
	{	gcd=maselel(M,1,1);
		while(M!=_0) 
		{	ZM=lfirst(M);
			M=lred(M);
			while(ZM!=_0) 
			{	i=lfirst(ZM);
				gcd=igcd(gcd,i);
				ZM=lred(ZM);
			}
		}
        }
	else 
		gcd=1;
	return(gcd);
}

matrix martomai(M)
matrix	M;
{	list	ZM,ZL;
        int	i,j;
        rat	r;
        matrix	L=0;

        if(!M) return(L);

        bind(M,L);
        init(ZM,ZL,i,j,r);

        L=_0;

        while(M!=_0) 
	{	ZL=_0;
                ZM=lfirst(M);
                M=lred(M);
                while(ZM!=_0) 
		{	r=lfirst(ZM);
                        ZM=lred(ZM);
                        i=rnum(r);
			j=rden(r);
			i=iquot(i,j);
                        ZL=lcomp(i,ZL);
                }
                ZL=linv(ZL);
                L=lcomp(ZL,L);
        }
        L=linv(L);
	return(L);
}

int igcdinf(A,B)
int	A,B;
{	int	n1,n2;
	
	bind(A,B);
	init(n1,n2);
	
	n2=igcd(A,B);n1=1;
	while(idif(n1,n2)!=0)
	{	n1=n2;
		n2=iexp(n2,2);
		n2=igcd(A,n2);
	}
	return(n1);	
}

matrix maitomafl(M)
matrix	M;
{	list		ZM,ZL;
        int		i;
        floating	fl;
        matrix		L=0;

        if(!M) return(L);

        bind(M,L);
        init(ZM,ZL,i,fl);

        L=_0;

        while(M!=_0) 
	{	ZL=_0;
                ZM=lfirst(M);
                M=lred(M);
                while(ZM!=_0) 
		{	i=lfirst(ZM);
                        ZM=lred(ZM);
                        fl=itofl(i);
                        ZL=lcomp(fl,ZL);
                }
                ZL=linv(ZL);
                L=lcomp(ZL,L);
        }
        L=linv(L);
	return(L);
}