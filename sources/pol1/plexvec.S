/*M
.SH NAME
plexvec - polynomial leading exponent vector

.SH SYNOPSIS
.nf
#include<_pol1.h>

list plexvec(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS
.TP 4
.B P
is a polynomial in the r variables X1, ..., Xr.
.PP 
plexvec returns the exponent vector of the leading term of P,
.PP
for P = 0, plexvec returns 0. 

M*/

/*H
        Version 1       04.05.1995	Wolfgang Schwarz 
   DATE plexvec       : 951201
H*/

#include <_pol1.h>

list plexvec(r,P)
single r;
pol P;
{single i;
 list L;
 bind(P);
 init(L);
 
 if (P)
  {L = _0;
   while (r>0)
    {
	L = lcomp(lfirst(P),L);
	P = lsecond(P);
	r--;
    }
   L = linv(L);
  }
 else L=0;
 return(L);
}	
 
