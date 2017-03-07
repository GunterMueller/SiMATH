/*M
.SH NAME
ptdegree - polynomial total degree, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ptdegree(r, P, v)  
single r, v; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B v
is an integer number, 0 <= v < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
ptdegree returns the total degree of P without consideration of the last v variables.

.SH EXAMPLE
Let r=2, v=1, then ptdegree returns the total degree of P as a polynomial in the first variable.

M*/

/*H
	Version 1	17.03.95	Wolfgang Schwarz
   DATE ptdegree      : 951201
H*/

#include <_pol1.h>

single ptdegree(r,P,v)
single r,v;
pol P;
{  single d;
   bind(P);

   d=0;
   if (P) if (r>v)
    {	if (r==1) d=lfirst(P);
   	else {r--;
	      if (v) {v--;
  		      while (P!=_0)
		  	{d=smax(d,ptdegree(r,lsecond(P),v));
			 P=lred2(P);
		  	}
		     }
	      else   while (P!=_0)
		  	{d=smax(d,lfirst(P)+ptdegree(r,lsecond(P),0));
			 P=lred2(P);
		  	}
	     }
    }
   return(d);
}

