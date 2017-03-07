/*M
.SH NAME
isrone - is rational number one ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isrone(A)
rat A;

.SH DESCRIPTION
isrone() returns 1 incase A equals 1, and 0 otherwise.
M*/
/*H
	Version 1	30.12.1992	Th. Weis
   DATE isrone        : 930115
H*/

#include <_arith1.h>

single isrone(A)
rat    A;
{
  if ( !A )  return(0);
  if ( lfirst(A) == 1 && lsecond(A) == 1 )  return(1);
  return(0);
}
