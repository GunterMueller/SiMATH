/*M
.SH NAME
upnffact - univariate polynomial over number field, factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upnffact(F, P)  
pol F, P;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree >=1. Let z be a root of F, then F generates a number field, say K, by adjunction of z to Q (Q(z) = Q[z] = K).  
.TP 4
.B P
is an univariate polynomial over K.
.PP
upnffact returns a list, say L, where
.PP
L = (c, P_1, e_1, ..., P_k, e_k), with
.TP 4
c
in K, the
.TP 4
e_i's
are natural numbers, and the
.TP 4
P_i's 
are monic and irreducible polynomials over K, such that
.IP
P = c * P1^e1 *...* Pk^ek.  
.PP
For that purpose, upnffact computes the factorization of the norm of P (a polynomial over Q). 

.SH SEE ALSO
Literature: H. Cohen, A Course in Computational Algebraic 
                      Number Theory, S.142 ff.

M*/

/*H
	Version 1	08.09.1994 		Wolfgang Schwarz
   DATE upnffact      : 941201
H*/

#include <_pol3.h>

list upnffact(F,P)
pol F,P;
{list fak,L,L1,Lf;
 int e;
 init(fak,L,L1,Lf,e);
 bind(F,P);
 if (P==0) return(0);
 fak=list1(plc(1,P));
 P=pnfmonic(1,F,P);
 if (lfirst(P)>0) 
  {
   L=upnfsfact(F,P); /* zerlege in quadratfreie Faktoren */
   while (L!=_0)
    {L1=lfirst(L);
     e=lfirst(L1);
     Lf=uspnffact(F,lsecond(L1)); /* Zerlegung der quadratfreien Faktoren */
     while (Lf!=_0) 
      {fak=lsuffix(fak,lfirst(Lf));
       fak=lsuffix(fak,e);
       Lf=lred(Lf);
      }
     L=lred(L);
    }
  }
 return(fak);
} 

