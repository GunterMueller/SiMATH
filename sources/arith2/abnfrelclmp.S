/*M
.SH NAME
abnfrelclmp - abelian number field relative class number modulo prime

.SH SYNOPSIS
.nf
#include<_arith2.h>

int abnfrelclmp(m, q, g)  
int m; 
single q, g;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, gcd(m,q) = 1.
.TP 4
.B q
= p^n, for p a prime number, n an odd integer number.
.TP 4
.B g
is an integer number, g divides phi(q).
.PP                                   
abnfrelclmp returns the relative class number mod m of the abelian number field with conductor q and degree g, i.e. of the subfield of degree g (say K) of the cyclotomic field of order q (This subfield is unique, because (Z/qZ)* is cyclic).
.PP
For K real, abnfrelclmp returns 1.
.PP
In order to compute the relative class number, abnfrelcl composes the resultant of X^(d/2)+1 and some other polynomials (which corresponds to the product of some character sums).   
.PP
If q is not the power of a prime or g does not divide phi(q), abnfrelcl returns ERROR.    

.SH SEE ALSO
abnfrelcl  

M*/
                       
/*H
	Version 1	23.06.1993	Wolfgang Schwarz
   DATE abnfrelclmp   : 931130
H*/



# include <_arith2.h>

int abnfrelclmp(m,q,g) /* Relativklassenzahl mod m des abelschen Zahlkp. vom*/
                   /* Grad g und Fuehrer q=p^n, p ungerade Primzahl     */
                   /*  O(g^2+q) Operationen mit ganzen Zahlen   <=m     */
single q,g;
int m;
{pol F,G;
 list faktoren;
 int h,a;
 single w,r,phi,i,j,p,f,fN,r_g,r_i,x,last_R,R;
 bind(m);
 init(F,G,h,a);
 if (q<=1) return(ERROR);
 faktoren=ifact(q);
 p=lfirst(faktoren);
 if (p==2) return(ERROR);
 while (faktoren!=_0)
  {if (lfirst(faktoren)!=p) return(ERROR);
   faktoren=lred(faktoren);
  } 
 if (m%p==0) return(ERROR);
 phi=iphi(q);
 if (g==0||phi%g!=0) return(ERROR);
 if ((phi/g)%2==0) return(1);  /* Koerper reell */
 i=g;
 if (i%(p-1)) w=2;
 else {w=2*p;while (i%p==0) {w=w*p;i=i/p;}}

 r=miproot(q);
 r_g=msexp(q,r,g);
 F=_0;G=_0;
 /* Berechne F(X)=f(X)*(X-1)+1, f(X)=R(1)+R(r)X+R(r^2)X^2+... */
 last_R=0;
 for (i=0,r_i=1;i<g/2;i++)
   {R=0;
    x=r_i;
    for (j=phi/g;j>0;j--) 
      {R=isum(R,x);
       x=(x*r_g)%q;
      }
    R=irem(R,m);
    a=midif(m,last_R,R);
    if (a!=0) {F=lcomp(a,F);F=lcomp(i,F);}
    r_i=(r_i*r)%q;
    last_R=R;
   }
 a=miprod(m,phi/g,q%m);
 a=midif(m,last_R,a);
 if (a!=0) {F=lcomp(a,F);F=lcomp(i,F);}
 G=list4(g/2,1,0,1);
 if (F==_0) return(0); else h=pmires(1,m,G,F,3);
 if (h==ERROR) return(ERROR);
 h=miprod(m,h,w/2);
 a=miexp(m,q,g/2);
 h=miquot(m,h,a);
 return(h);
}
