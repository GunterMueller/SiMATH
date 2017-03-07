/*M
.SH NAME
abnfrelcl - abelian number field relative class number

.SH SYNOPSIS
.nf
#include<_arith2.h>

int abnfrelcl(q, g)  
single q, g;
      
.SH DESCRIPTION
.TP 4
.B q
= p^n, for p a prime number, n an odd integer number.   
.TP 4
.B g 
is an integer number, g divides phi(q).
.PP
abnfrelcl returns the relative class number of the abelian number field with conductor q and degree g, i.e. of the subfield of degree g (say K) of the cyclotomic field of order q over Q (This subfield is unique, because (Z/qZ)* is cyclic. The conductor of an abelian number field is a power of p if and only if p is the only ramified prime.)
.PP
For K real, abnfrelcl returns 1.
.PP
In order to compute the relative class number, abnfrelcl composes the resultant of X^(d/2)+1 and some other polynomials (which corresponds to the product of some character sums). 
.PP
If q is not the power of a prime or g does not divide phi(q), abnfrelcl returns ERROR.

.SH SEE ALSO
abnfrelclmp

M*/
                                 
/*H
	Version 1	23.06.1993	Wolfgang Schwarz
   DATE abnfrelcl     : 931130
H*/

# include <_arith2.h>

int abnfrelcl(q,g)   /* Relativklassenzahl des abelschen Zahlkoerpers vom */
                     /* Grad g und Fuehrer q=unger. Primzahlpotenz        */
                     /*  O(g^2+q) Operationen mit ganzen Zahlen          */
single q,g; 
{pol F,G;
 list faktoren;
 int h,a;
 single w,r,phi,i,j,p,f,fN,r_g,r_i,x,last_C,C;
 init(F,G,h,a);
 if (q<=1) return(ERROR);
 faktoren=ifact(q);
 p=lfirst(faktoren);
 if (p==2) return(ERROR);
 while (faktoren!=_0)
  {if (lfirst(faktoren)!=p) return(ERROR);
   faktoren=lred(faktoren);
  } 
 phi=iphi(q);
 if (g<=0||phi%g!=0) return(ERROR);
 if ((phi/g)%2==0) return(1);  /* Koerper reell */
 i=g;
 if (i%(p-1)) w=2;
 else {w=2*p;while (i%p==0) {w=w*p;i=i/p;}}

 r=miproot(q);
 r_g=msexp(q,r,g);
 F=_0;G=_0;
 /* Berechne F(X)=f(X)*(X-1)+1, f(X)=C(1)+C(r)X+C(r^2)X^2+... */
 last_C=0;
 for (i=0,r_i=1;i<g/2;i++)
   {C=0;
    x=r_i;
    for (j=phi/g;j>0;j--) 
      {if (2*x<q) C++;
       x=(x*r_g)%q;
      }
    if (C!=last_C) {F=lcomp(last_C-C,F);F=lcomp(i,F);}
    r_i=(r_i*r)%q;
    last_C=C;
   }
 if (C!=phi/g) {F=lcomp(C-phi/g,F);F=lcomp(i,F);}
 G=list4(g/2,1,0,1);
 h=pirescoll(1,G,F,2);
 if ((g/2)%2==1) h=ineg(h);
 h=iprod(h,w/2);
 a=2;f=1;while (a!=1) {a=(2*a)%q;f++;}
 fN=g/igcd(phi/f,g);
 if (fN%2==0)
   {a=iexp(2,fN/2);a=isum(a,1);a=iexp(a,g/fN);}
 else
   {a=iexp(2,fN);a=isum(a,-1);a=iexp(a,g/2/fN);}
  return(iquot(h,a));
}
