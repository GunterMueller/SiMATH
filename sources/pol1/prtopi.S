/*M
.SH NAME
prtopi - polynomial over rationals to polynomial over integers, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol prtopi(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the rational numbers.
.PP
prtopi returns the polynomial P1 in r variables over the integer numbers.
The coefficients of P1 are the numerators of the coefficients of P. (To find the least common denominator of the polynomial P, s. 'prlcd'.)

.SH SEE ALSO
prlcd

M*/

/*H
			09.09.1994		Wolfgang Schwarz
   DATE	prtopi	      : 941201
H*/

#include <_pol1.h>

pol prtopi(r,P)  /* polynomial over rationals to polynomial over integers */
                 /* rekursiv */ /* Nenner werden weggelassen */
single r;pol P;
{pol Q;
 bind(P);init(Q);
 if (P==0) return(0);
 Q=_0;
 if (r>1)
   while (P!=_0)
    {Q=lsuffix(Q,lfirst(P));
     Q=lsuffix(Q,prtopi(r-1,lsecond(P)));
     P=lred2(P);
    }
 else if (r==1)
   while (P!=_0) 
    {Q=lsuffix(Q,lfirst(P));
     Q=lsuffix(Q,lfirst(lsecond(P)));
     P=lred2(P);
    }
 else Q=lsuffix(Q,lsecond(P));
 return(Q); 
}

