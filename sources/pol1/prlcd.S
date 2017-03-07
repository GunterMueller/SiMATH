/*M
.SH NAME
prlcd - polynomial over rationals, least common denominator, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

int prlcd(r, P)  
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
prlcd returns the least common denominator of the coefficients of P.
                                                          
M*/

/*H
			09.09.1994		Wolfgang Schwarz
   DATE prlcd	      : 941201
H*/

#include <_pol1.h>

int prlcd(r,P)   /* polynomial over rationals least common denominator */
                 /* rekursiv */
single r;pol P;
{int den;
 bind(P);init(den);
 if (P==0) return(1);
 den=1;
 if (r>1) 
   while (P!=_0)
    {den=ilcm(den,prlcd(r-1,lsecond(P)));
     P=lred2(P);
    }
 else if (r==1)
   while (P!=_0)
    {den=ilcm(den,lsecond(lsecond(P)));
     P=lred2(P);
    }
 else den=lsecond(P);
 return(den);
}

