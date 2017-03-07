/*M
.SH NAME
flrand - floating randomise

.SH SYNOPSIS
.nf
#include <_arith1.h>

floating flrand ();

.SH DESCRIPTION
flrand() returns a random value x with 0 <= x < 1.
The behaviour of flrand() depends on SEMIRAND. For
a description of SEMIRAND, see irand(). A sequence
of values produced by flrand() is uniformly distributed.

.SH SEE ALSO
irand
M*/
/*H
	Version 1	21.01.1996	Georg Lay
   DATE flrand        : 960501
H*/

#include <_arith1.h>

floating flrand()
 {
 floating x,X;
 init    (x,X);

 X = iexp  (2,BLOG2*FL_EPS);
 x = irand (X);
 X = itofl (X);
 x = itofl (x);

 return (flquot (x,X));
 }
