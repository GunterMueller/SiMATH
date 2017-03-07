/*M
.SH NAME
dipevdif - distributive polynomial exponent vector difference

.SH SYNOPSIS
.nf
#include<_pol1.h>

list dipevdif(r,EV1,EV2)  
single r; 
list EV1, EV2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B EV1, EV2
are the exponent vectors of distibutive polynomials in r variables over an arbitrary ring, so EV1 and EV2 have length r.
.PP
dipevdif returns the exponent vector EV, where 
.IP
EV = EV1 - EV2.

M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipevdif      : 930115
H*/

#include <_pol1.h>

list dipevdif(r,EV1,EV2)
single r;
list    EV1,EV2;
{
  list    EV;

  bind(EV1,EV2);
  init(EV);

  EV = _0;
  while ( EV1 != _0 ) {
        EV  = lcomp(lfirst(EV1)-lfirst(EV2),EV);
        EV1 = lred(EV1);
        EV2 = lred(EV2);
  }
  return(linv(EV));
}
