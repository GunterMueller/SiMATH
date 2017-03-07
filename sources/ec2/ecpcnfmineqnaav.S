/*M
.SH NAME 
ecpcnfmineqnaav - elliptic curve over pure cubic number field minimal equation at non archimedean absolute value

.SH SYNOPSIS
.nf
#include<_ec2.h>

list  ecpcnfmineqnaav(D, a1, a2, a3, a4, a6, P, L)
int    D;
nfel   a1, a2, a3, a4, a6; 
list   P, L;

.SH DESCRIPTION
ecpcnfmineqnaav() returns the minimal equation of an elliptic curve E over a pure cubic number field K = Q(D^(1/2)) with respect to a non archimedean absolute value and the transformed point to a given point P.
.TP 3 
ecpcnfmineqnaav() returns:
L = ( a1m, a2m, a3m, a4m, a6m, Pm ), where a1m, a2m, a3m, a4m and a6m are the minimal Weierstrass coefficients with respect to the given non archimedean absolute value, and Pm = ( xm, ym, zp) is the transformed point to the given Point P.
.PP
.TP 4
.B D
is a non negative cubefree integer not equal to 0 or 1.
.TP 4
.B a_i
are the Weierstrass coefficients of E, where E is an elliptic curve in Weierstrass equation.
.TP 4
.B P
is a list representing a point on E(K). \  \  \  \  \  \  \  P = ( xp, yp, zp ) \ nfel xp, yp, zp;   
.TP 4
.B L
is a list representing a prime ideal in the ring of integers O_K.\ \   \   \   \   \   \   \   \   \   \  \   \   \   \   L = ( Pi, e, f )  list Pi;  single e, f; \   \   \   \   \Pi is a prime ideal, e is the ramification index of Pi over the according prime number, f is the degree of the residue class field. 
M*/
/*H
        Version 1         20.02.1998      Andreas Heiser
   DATE ecpcnfmineqnaav :  
H*/

#include<_ec2.h>

list  ecpcnfmineqnaav(D,a1,a2,a3,a4,a6,P,L)
int     D;
nfel    a1,a2,a3,a4,a6;
list    P,L;
{       nfel    xp,yp;
        nfel    a1m,a2m,a3m,a4m,a6m,xpm,ypm,h1,dis,c4,c6,pi,u;
        nfel    aa1,aa2,aa3,aa4,aa6,xx,yy;
        single  e,f,fi,gi,zi,n;
        list    L1,L2,Pi;
        int     p;
	pol     F;

        init(a1m,a2m,a3m,a4m,a6m,xpm,ypm,h1,dis,c4,c6,fi,gi,pi,zi,Pi,u,n);
        init(aa1,aa2,aa3,aa4,aa6,xx,yy,p,xp,yp,L1,L2,e,f,F);

        bind(D,a1,a2,a3,a4,a6,P,L);

	F=list5(3,1,0,0,-D);

        xp=lfirst(P);yp=lsecond(P);
        dis=ecnfdisc(F,a1,a2,a3,a4,a6);
        Pi=lfirst(L);
	e=lsecond(L);
	f=lthird(L);
        fi=pcnfpiord(D,Pi,e,f,dis);
        fi=iquot(fi,12);
        L1=ecnftavc6(F,a1,a2,a3,a4,a6);
        c4=lfirst(L1);c6=lsecond(L1);

        if(c4)
        {       gi=pcnfpiord(D,Pi,e,f,c4);
                gi=iquot(gi,4);
                fi=smin(fi,gi);
                if(c6)
                {       gi=pcnfpiord(D,Pi,e,f,c6);
                        gi=iquot(gi,6);
                        fi=smin(fi,gi);
                }
        }
        else
        {       gi=pcnfpiord(D,Pi,e,f,c6);
                gi=iquot(gi,6);
                fi=smin(fi,gi);
        }
	if(llength(Pi)>1)
	  pi=lsecond(Pi);
	else
	  pi=itonf(lfirst(Pi));
	
        if(fi)
        {
	  u=nfexp(F,pi,fi);n=1;
	  a1m=nfquot(F,a1,u);
                if(a1m)
                {       gi=pcnfpiord(D,Pi,e,f,a1m);
                        if(gi<0)
                                n=0;
                }
                if(n)
                {       h1=nfexp(F,u,2);a2m=nfquot(F,a2,h1);
                        xpm=nfquot(F,xp,h1);
                        if(a2m)
                        {       gi=pcnfpiord(D,Pi,e,f,a2m);
                                if(gi<0)
                                        n=0;
                        }
                }
                if(n)
                {       h1=nfexp(F,u,3);a3m=nfquot(F,a3,h1);
                        ypm=nfquot(F,yp,h1);
                        if(a3m)
                        {       gi=pcnfpiord(D,Pi,e,f,a3m);
                                if(gi<0)
                                        n=0;
                        }
                }
                if(n)
                {       h1=nfexp(F,u,4);a4m=nfquot(F,a4,h1);
                        if(a4m)
                        {       gi=pcnfpiord(D,Pi,e,f,a4m);
                                if(gi<0)
                                        n=0;
                        }
                }
                if(n)
                {       h1=nfexp(F,u,6);a6m=nfquot(F,a6,h1);
                        if(a6m)
                        {       gi=pcnfpiord(D,Pi,e,f,a6m);
                                if(gi<0)
                                        n=0;
                        }
                }
                if(n)
                {       a1=a1m;a2=a2m;a3=a3m;a4=a4m;a6=a6m;
                        xp=xpm;yp=ypm;
                }
        }
        L1=list2(xp,yp);
	
        L1=lcomp5(a1,a2,a3,a4,a6,L1);

        return(L1);
}

