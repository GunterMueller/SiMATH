/*M
.SH NAME
miproot - modular integer primitive root

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miproot(Q)
int Q;

.SH DESCRIPTION
miproot() returns a primitive root (mod Q), in
case Q >0 and there is a primitive root (mod Q).

.SH CAUTION
If there is no primitive root (mod Q), the function
will loop forever.
M*/
/*H
	Version 1	23.06.1993	Wolfgang Schwarz
   DATE miproot       : 931130
H*/

# include <_arith1.h>

int miproot(q)
int q;
{int w,l,e,phi;
 list faktoren, fak;
 single is_primroot;
 init(w,l,e,faktoren,fak,phi);
 bind(q);
 phi=iphi(q);
 faktoren=ifact(phi);
 w=1;
 do
  {do w++; while (igcd(w,q)!=1);
   is_primroot=1;
   fak=faktoren;
   while (fak!=_0)
    {e=iquot(phi,lfirst(fak));
     if (miexp(q,w,e)==1) {is_primroot=0;break;}
     fak=lred(fak);
    }
   } while (is_primroot==0);
 return(w);
}

