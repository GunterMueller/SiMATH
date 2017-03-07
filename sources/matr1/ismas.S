/*M
.SH NAME
ismas - is matrix of singles ?

.SH SYNOPSIS
.nf
#include<_matr1.h>

single ismas(M)
obj M;

.SH DESCRIPTION
ismas() returns 1, if M is a matrix of singles
and 0 otherwise.
M*/
/*H
	Version 1       04.05.1988      Klaus Petry
   DATE ismas         : 890501
H*/


#include <_matr1.h>

single ismas(M)
obj M;

{
    single erg=1, i, MIs0 = 1;
    list Z;
    single S;
    bind(M);

    if (M) {
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
			else {
			    while (Z != _0) {
				S = lfirst(Z);
				Z = lred(Z);
				if (!issingle(S)) {erg = 0; break;}
				if (MIs0) if (S) MIs0 = 0;
				}
			    if (!erg) break;
			    }
			}
		    }
		}
	    else erg = 0;
	    }
	else erg = 0;
	if (MIs0) erg = 0;
	}

/* Ausgabe */

    return(erg);
}
