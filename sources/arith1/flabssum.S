/*M
.SH NAME
flabssum - floating point numbers absolute value sum

.SH SYNOPSIS
.nf
#include<_arith1.h>

floating flabssum(f, g)
floating f, g;

.SH DESCRIPTION
flabssum() returns the sum |f| + |g| of the absolute values
of f and g.
M*/

/*H
	Version 1	27.12.1994	Th. Weis
   DATE flabssum      : 951201
H*/

#include <_arith1.h>

floating flabssum(f, g)
floating f, g;
{
  floating temp, temp2;

  bind(f, g);

  init(temp, temp2);

  temp = flabs(f);
  temp2 = flabs(g);
  temp = flsum(temp, temp2);
 
  return(temp);
}
