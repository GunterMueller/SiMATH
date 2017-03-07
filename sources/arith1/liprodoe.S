/*M
.SH NAME
liprodoe - list of integers product over all entries

.SH SYNOPSIS
.nf
#include <_arith1.h>

int  liprodoe (L)
list L;

.SH DESCRIPTION
liprodoe() returns the product of all entries
in L, provided they are integers.
The empty product is defined to be 1.
M*/

/*H
	Version 1       11.09.1992      Joachim Stein
	Version 2	01.07.1996	neue Doku, L=() erlaubt
					Georg Lay
   DATE liprodoe      : 921130.961201
H*/

#include <_arith1.h>

int liprodoe (L)
list L;                     
                                                                         
{
        int   P;
	init (P);

        for (P = 1; L != _0; L = lred (L))
           P = iprod (P, lfirst (L));

        return (P);
}



