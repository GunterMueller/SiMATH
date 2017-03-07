/*M
.SH NAME
lflbsort - of floating point numbers bubble sort

.SH SYNOPSIS
.nf
#include<_arith1.h>

single lflbsort(L)
list L;

.SH DESCRIPTION
lflbsort() sorts L ascendingly in place
using bubble-sort and returns 0.
M*/

/*H
	Version  1	27.12.1994	Th. Weis
   DATE lflbsort      : 951201
H*/

#include <_arith1.h>

single lflbsort(L)
list L;
{
  floating a1, a2;
  list     L1, L2, M, M1;

  bind(L);

  init(a1, a2);
  init(L1, L2, M, M1);

  if(L == _0) return(0);

  M = _0;
  do {
    L1 = L;
    a1 = lfirst(L1);
    M1 = _0;
    while((L2 = lred(L1)) != M) {
      a2 = lfirst(L2);
      if(flcomp(a1, a2) == 1) {
        lsfirst(L1, a2);
        lsfirst(L2, a1);
        M1 = L2;
      }
      else a1 = a2;
      L1 = L2;
    }
  } while((M = M1) != _0);

  return(0);
}

