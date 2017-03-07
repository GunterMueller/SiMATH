/*M
.SH NAME
dipmoad - distributive polynomial monomial advance

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dipmoad(r, P, pLBC, pLEV)  
single r; 
pol P; 
obj *pLBC; 
list *pLEV;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables over an arbitrary ring.
.PP
dipmoad writes the base coefficient of the leading monomial of P to pLBC, the exponent vector of the leading monomial of P to pLEV and returns the polynomial P1, which is the polynomial P without the leading monomial.
 
.SH CAUTION
If P is a monomial, P1 is the empty list.
 
M*/

/*H
	Version 1	01.06.1992	Th. Weis
   DATE dipmoad       : 930115
H*/

#include <_pol1.h>

pol dipmoad(r,P,pLBC,pLEV)
single r;
pol    P;
obj    *pLBC;
list   *pLEV;
{
  pol P1;

  P1    = P;
  *pLBC = lfirst(P1);
  P1    = lred(P1);
  *pLEV = lfirst(P1);
  P1    = lred(P1);

  return(P1);
}
