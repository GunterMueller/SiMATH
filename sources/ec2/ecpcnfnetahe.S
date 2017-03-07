/*M
.SH NAME 
ecpcnfnetahe - elliptic curve over pure cubic number field Neron-Tate height

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecpcnfnetahe(D, a1, a2, a3, a4, a6, P)
int    D;
nfel   a1, a2, a3, a4, a6; 
list   P;

.SH DESCRIPTION
ecpcnfnetahe() returns the Neron-Tate height of a point P on an elliptic curve E over a pure cubic number field K = Q(D^(1/3)) (see J.H. Silverman: Math. of Comp.
, 51, 1988, p. 339-358).

.PP
.TP 4
.B D
is a non negative cubefree integer not equal to 0 or 1.
.TP 4
.B a_i
are the Weierstrass coefficients of E, where E is an elliptic curve in Weierstrass equation.
.TP 4
.B P
is a list representing a point on E(K). \  \  \  \  \  \  \  P = ( xp, yp, zp )\
  nfel xp, yp, zp;   
M*/
/*H
        Version 1      20.02.1998        Andreas Heiser
   DATE ecpcnfnetahe : 
H*/

#include<_ec2.h>
	
floating ecpcnfnetahe(D,a1,a2,a3,a4,a6,P)
int	D;
nfel	a1,a2,a3,a4,a6;
list	P;
{	floating	ch,lh,h;
	nfel		disc,h1,h2,A1,B1,xp,yp,zp;
	nfel            a1m,a2m,a3m,a4m,a6m,xpm,u;
	pol		F;
	list		L,L1,L2,L3,L4,Pi;
	int		p,n1;
	rat		r,s; 
	single		e,f,w,e1,e2,g,f1,f2;
	
	init(ch,lh,h,disc,F,L,L1,L2,Pi,e,f,g,w,e1,e2,p,r,s,h1,h2,A1,B1,xp,yp);
	init(a1m,a2m,a3m,a4m,a6m,L3,L4,xpm,u,f1,f2,zp);
	bind(D,a1,a2,a3,a4,a6,P);

	xp=lfirst(P);
        yp=lsecond(P);
        zp=lthird(P);
	
        if(!zp)
                return(0);
        else
        {       xp=nfquot(F,xp,zp);
                yp=nfquot(F,yp,zp);
        }

	/* Berechnung der lokalen archimedischen Hoehe */

	ch=ecpcnflhaav(D,a1,a2,a3,a4,a6,P);
	ch=flprod(ch,itofl(3)); 
	
	/* Anteil von E1(K) */

	h1=nfexp(F,xp,2);h1=nfeliprod(F,h1,3);
        h2=nfprod(F,a2,xp);h2=nfeliprod(F,h2,2);
        h1=nfsum(F,h1,h2);h1=nfsum(F,h1,a4);
        h2=nfprod(F,a1,yp);
        A1=nfdif(F,h1,h2);

        h1=nfeliprod(F,yp,2);h2=nfprod(F,a1,xp);
        h1=nfsum(F,h1,h2);
        B1=nfsum(F,h1,a3);

	/* Anteil von E1(K) */
		
	if(xp)
	{	
		L=pcnfpifact(D,lfirst(P));
		n1=1;
		if(llength(L)>1)
                {       while(L!=_0) 
                        {       Pi=lfirst(L);
                                e=lsecond(L);
                                f=lthird(L);
                                w=lfourth(L);
                                if(w<0)
                                  {
                                    if(A1)
                                      e1=pcnfpiord(D,Pi,e,f,A1);
                                    else
                                      e1=1;
                                    if(B1)
                                      e2=pcnfpiord(D,Pi,e,f,B1);
                                    else
                                      e2=1;
                                    if(e1<=0 && e2<=0)
                                      {
                                        p=lfirst(Pi);
                                        if(f!=1)
                                          p=iexp(p,f);
                                        p=iexp(p,ineg(w));
                                        n1=iprod(n1,p);
                                      }
                                  }
                                L=lred4(L);
                        } 
                }
                lh=fllog(itofl(n1));
                ch=flsum(ch,lh);
        }

	/* Anteile schlechter Reduktion */
	
	L2=_0;
	if(A1)
          {
            L1=pcnfpifact(D,A1);
            while(llength(L1)>1)
              {
                Pi=lfirst(L1);
                e=lsecond(L1);
                f=lthird(L1);
                w=lfourth(L1);
                if(w>0)
                  {
                    if(B1)
                      g=pcnfpiord(D,Pi,e,f,B1);
                    else
                      g=1;
                    if(g>0)
                      L2=lcomp4(Pi,e,f,g,L2);
                  }
                L1=lred4(L1);
              }
          }
        else
	  if(B1)
	    L2=pcnfpifact(D,B1);

        while(llength(L2)>1)
          {
            Pi=lfirst(L2);
            e=lsecond(L2);
            f=lthird(L2);
            w=lfourth(L2);
            p=lfirst(Pi);
            L3=list4(Pi,e,f,w);
            L4=ecpcnfmineqnaav(D,a1,a2,a3,a4,a6,P,L3); 
            a1m=lfirst(L4);a2m=lsecond(L4);
            a3m=lthird(L4);a4m=lfourth(L4);
            a6m=lfifth(L4);L4=lred5(L4);
            lh=ecpcnflhnaav(D,a1m,a2m,a3m,a4m,a6m,L4,L3);
            ch=flsum(ch,lh);
            xpm=lfirst(L4);
            if(xpm)
              u=nfquot(F,xp,xpm);
            else
              u=list3(1,0,1);
            f1=itofl(pcnfpiord(D,Pi,e,f,u));
            f2=fllog(itofl(p));
            f2=flprod(f2,itofl(2));
	    f2=flquot(f2,itofl(e));
	    f1=flprod(f1,f2);
            ch=fldif(ch,f1);

            L2=lred4(L2);
          }
	ch=flquot(ch,itofl(3)); 
	return(ch);
}


