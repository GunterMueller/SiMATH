/*M
.SH NAME
isma - is matrix ?

.SH SYNOPSIS
.nf
#include<_matr1.h>

single isma(M)
obj M;

.SH DESCRIPTION
isma() returns 1, if M is a matrix
and 0 otherwise.
M*/
/*H
	Version 1       19.05.1988      Klaus Petry
	Version 1       22.11.1988      Klaus Petry     Null entfaellt
   DATE isma          : 890501
H*/


#include <_matr1.h>

single isma(M)
obj M;
{
    single erg=1, i, Z;
    obj O;
    bind(M);

    if (islist(M)) {
	    i = llength(M);
	    if (i >= 1) {
		    i = 0;
		    while (M != _0) {
			    Z = lfirst(M);
			    M = lred(M);
			    if (!islist(Z)) {erg = 0; break;}
			    else {
				    if (!i) {
					    i = llength(Z);
					    if (!i) {erg = 0; break;}
					    }
				    if (i != llength(Z)) {erg = 0; break;}
				    }
			    }
		    }
	    else erg = 0;
	    }
    else erg = 0;

    return(erg);
}
