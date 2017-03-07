/*M
.SH NAME
pnffact - polynomial over number field factorization
(recursive)

.SH SYNOPSIS
.nf
#include<_pol3.h>

list pnffact(r, F, D, P) i
single r;  
int D; 
pol F, P;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is a monic polynomial in dense representation.
.PP
Let t denote a zero of F, then t generates a number field, say K.
.TP 4
.B D
is a natural number, such that the ring of integers of K is in 1/D * Z[t] (s. ouspidenic).
.TP 4
.B P
is a polynomial in r variables over K.
.PP
pnffact returns a list (c,P_1, e_1,...,P_k, e_k), where for 1 <= i <=k, 
.TP 4
c
is in K,
.TP 4
e_i
is a natural number, and
.TP 4
P_i
is a monic and irreducible polynomial over K, such that
.PP
P = c * P_1^e_1 + ... + P_k^e_k holds.
                                                                        
.SH SEE ALSO
ouspidenic

M*/
                
/*H
	Version 1	08.05.1995	Wolfgang Schwarz
   DATE pnffact       : 951201
H*/

#include <_pol3.h>

list pnffact(r,F,D,P)
single r;
pol F,P;
int D;
{list fak,L,L1,Lf;
 pol Pp, Pc;
 single e;
 nfel c;
 init(fak,L,L1,Lf,Pp,Pc);
 bind(F,D,P);

 if (!P) fak = 0;
 else if (!r) fak = list1(P);
 else if (r == 1) fak = upnffact(F,P);
 else
   {
    c = plbc(r,P);
    P = pnfmonic(r,F,P);
    Pc = pnfcontpp(r,F,D,P,&Pp);

/* Inhalt zerlegen */

    L = pnffact(r-1,F,D,Pc);    
    L = lred(L);
    fak = _0;
    while (L != _0)     
	{P = lfirst(L);
	 P = list2(0,P);
	 e = lsecond(L);
	 fak = lcomp2(P,e,fak);
	 L = lred2(L);
	}

/* primitiven Anteil zerlegen */

    if (pdegree(r,Pp))
     	{
      	 L = pnfsfact(r,F,D,Pp); 
      	 while (L!=_0)
		{L1 = lfirst(L);
     	 	 e = lfirst(L1);
     	 	 Lf = spnffact(r,F,D,lsecond(L1)); 
	 	 while (Lf!=_0) 
      	  		{fak = lcomp2(lfirst(Lf),e,fak);
           		 Lf = lred(Lf);
      	  		}
     	 	 L = lred(L);
    		}
	}
    fak = lcomp(c,fak);
   }
 return(fak);
} 

