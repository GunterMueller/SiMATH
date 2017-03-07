/*M
.SH NAME
dipevl - distributive polynomial exponent vector of the leading monomial

.SH SYNOPSIS
.nf
#include<_pol1.h>

list dipevl(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables over an arbitrary ring.
.PP
dipevl returns the exponent vector EV of the leading monomial of the polynomial P, so EV has length r.

M*/

/*H
	Version 1	19.05.1992	Th. Weis
   DATE dipevl        : 930115
H*/

#include <_pol1.h>

list dipevl(r,P)
single r;
pol    P;
{
  list EL;

  bind(P);
  init(EL);

  EL = _0;                               /* P == 0 */

  if ( P != 0 )  EL = lsecond(P);        /* P != 0 */

  return(EL);
}
