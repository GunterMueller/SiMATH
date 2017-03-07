/*M
.SH NAME
isgfsone - is Galois-field with single characteristic element one ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

ingle isgfsone(p,AL,a)  
single p; 
list AL; 
gfel a;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G, AL1) is an arithmetic list for GF(p^n) (s. gfsalgen), where n = llength(AL1) + 1.
.TP 4
.B a
is an element of GF(p^n), represented as an univariate polynomial over Z/pZ of degree < n.
.PP
isgfsone returns 1 if a = 1 and 0 else.

.SH SEE ALSO
gfsalgen

M*/
                   
/*H
	Version 1	30.12.1992	Th. Weis
   DATE isgfsone      : 930115
H*/

#include <_pol3.h>

single isgfsone(p,AL,a)
single p;
list   AL;
gfel   a;
{
  bind(a);

  if ( oequal(a,list2(0,1)) == 1 ) return(1);

  return(0);
}
