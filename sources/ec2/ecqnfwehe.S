/*M
.SH NAME 
ecqnfwehe - elliptic curve over quadratic number field Weil height

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnfwehe(D, E, P)
int    D;
list   E, P;

.SH DESCRIPTION
ecqnfwehe() returns the Weil height of a point P on an elliptic curve E over a quadratic number field K = Q(D^(1/2)).

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B P
is a list representing a point on E(K)\\{O}. \  \  \  \  \  P = ( xp, yp )\  nfel xp, yp;   
M*/
/*H
        Version 1      07.01.1997	 Andreas Heiser
   DATE ecqnfwehe    :
H*/

#include<_ec2.h>

floating  ecqnfwehe(D,E,P)
int	D;
list	E,P;

{	list		L1,L2,Pi;
	nfel		h1,pi,xp,yp;	
	single		f,z;
	rat		r1,r2,n;
	floating	wh,ah;
	int		n1,n2,p;

	init(L1,L2,Pi,pi,f,z,n,wh,ah,p,xp,yp);
	bind(D,E,P);

	xp=lfirst(P);yp=lsecond(P);

	/* contribution of E1(K) */
	
	if(xp)
	{	n1=lfirst(xp);
		h1=qnfiprod(D,xp,n1);
		r2=qnfnorm(D,h1);
		n2=rnum(r2);
		n2=igcdinf(n1,n2);
		n1=iquot(n1,n2);
		n1=iexp(n1,2);
		L1=qnfpifact(D,itoqnf(D,n2));
		L2=_0;
		if(llength(L1)!=1)
		{	while(L1!=_0)
			{	Pi=lfirst(L1);
				pi=lthird(L1);
				z=lfourth(L1);
				f=qnfpiord(D,Pi,pi,z,xp);
				if(f<0)
					L2=lcomp4(Pi,-f,pi,z,L2);
				L1=lred4(L1);
			}
			r1=qnfabsnorm(D,L2);
			n2=rnum(r1);
			n1=iprod(n1,n2);
		}
		wh=itofl(n1);
		wh=fllog(wh);
	}

	/* archimedean absolute values */
	
	if(D<0)
	{	n=qnfnorm(D,xp);ah=rtofl(n);
		if(flcomp(ah,itofl(1))>0)
		{	ah=fllog(ah);	
			wh=flsum(wh,ah);
		}
	}
	else
	{	ah=qnftofl(D,xp);ah=flabs(ah);
		if(flcomp(ah,itofl(1))>0)
		{	ah=fllog(ah);	
			wh=flsum(wh,ah);
		}
		xp=qnfconj(D,xp);
		ah=qnftofl(D,xp);ah=flabs(ah);
		if(flcomp(ah,itofl(1))>0)
		{	ah=fllog(ah);	
			wh=flsum(wh,ah);
		}	
	}
	wh=flquot(wh,itofl(2));
	
	return(wh);
}