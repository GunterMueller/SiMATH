/*M
.SH NAME
isnfone - is number field element one

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isnfone(F,A)  
pol F; 
nfel A;
 
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a
is an element of K (for representation of number field elements s. nfneg).
.PP 
isnfone returns 1, if A = 1 and 0 else.

.SH SEE ALSO
nfneg

M*/
                
/*H
	Version 1	30.12.1992	Th. Weis
   DATE isnfone       : 930115
H*/

#include <_arith2.h>

single isnfone(F,A)
pol    F;
nfel   A;
{
  bind(A);

  if ( oequal(A,list3(1,0,1)) == 1 ) return(1);

  return(0);
}
