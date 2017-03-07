/*M
.SH NAME
dipevlcm - distributive polynomial exponent vector least common multiple

.SH SYNOPSIS
.nf
#include<_pol1.h>

list dipevlcm(r, EV1, EV2)  
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
dipevlcm returns the vector EV, where 
.IP
EV = lcm ( EV1, EV2 )

M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipevlcm      : 930115
H*/

#include <_pol1.h>

list dipevlcm(r,EL1,EL2)
single r;
list    EL1,EL2;
{
  list    EL;

  bind(EL1,EL2);
  init(EL);

  EL = _0;
  while ( EL1 != _0 ) {
        if ( lfirst(EL1) > lfirst(EL2) )  EL = lcomp(lfirst(EL1),EL);
        else  EL = lcomp(lfirst(EL2),EL);
        EL1 = lred(EL1);
        EL2 = lred(EL2);
  }
  return(linv(EL));
}
