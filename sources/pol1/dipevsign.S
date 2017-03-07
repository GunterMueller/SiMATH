/*M
.SH NAME
dipevsign - distributive polynomial exponent vector signum

.SH SYNOPSIS
.nf
#include<_pol1.h>

single dipevsign(r, EV)  
single r; 
list EV;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B EV
is the exponent vector of a distributive polynomial in r variables over an arbitrary ring, so EV has length r.
.PP
dipevsign returns 
.TP 4
 1,
if at least one component of EV is greater than 0 and all others are greater or equal 0,
.TP 4
 0, 
if all components of EV are equal 0,
.TP 4
-1,
if at least one component of EV is smaller than 0. 

M*/

/*H
	Version 1	16.11.1992	Th. Weis
   DATE dipevsign     : 930115
H*/

#include <_pol1.h>

single dipevsign(r,EV)
single r;
list    EV;
{
  single s;

  s = 0;
  while ( EV != _0 ) {
        if ( lfirst(EV) < 0 ) {
           s = (-1);
           break;
        }
        if ( lfirst(EV) > 0 ) {
           s = 1;
        }
        EV = lred(EV);
  }
  return(s);
}
