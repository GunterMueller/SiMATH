/*M
.SH NAME
isma_ - is matrix of ____ ?

.SH SYNOPSIS
.nf
#include<_matr1.h>

single isma_(M, isfunc, numargs, arg1, arg2)
obj M, (*isfunc)();
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
isma_() returns 1, if M is a matrix of elements accepted by isfunc
and 0 otherwise.

.PP
.TP 4
.B M
is the object to be tested.
.TP 4
.B isfunc
is a function that checks, whether an object belongs to
a certain ring R. The function is given M and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by isfunc.
.TP 4
.B arg1, arg2
are at most 2 optional arguments for isfunc.
M*/
/*H
	Version 1       22.11.1988      Klaus Petry
	Version 2       01.06.1989      U.Schneiders, Th.Weis ( p2, p3 vorbesetzt )
	Version 3	15.10.1990	Th. Weis ( Variable c entfernt )
	Version 4	24.07.1991	single arg1,arg2;
					 --> obj arg1,arg2;  Th. W.
   DATE isma_         : 890501.890801.901120.910915
H*/

#include <_matr1.h>

single isma_(M,is,anzahlargs,arg1,arg2)
obj M, (*is)();
single anzahlargs;
obj    arg1, arg2;
{
    single erg=1, i;
    list Z;
    obj O, *p1, *p2, *p3;
    bind(M);
    bind(arg1,arg2);

    switch (anzahlargs) {
	case 0: p1 = &O;        /** Z, Q **/
		p2 = p3 = &O;	/** damit die Apollo nicht abstuerzt **/
		break;
	case 1: p1 = &arg1;     /** ms, Pi, Pr, nf(s) **/
		p2 = &O;
		p3 = &O;        /** damit die Apollo nicht abstuert **/
		break;
	case 2: p1 = &arg1;     /** Pms, gfs **/
		p2 = &arg2;
		p3 = &O;
		break;
	}

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
				O = lfirst(Z);
				Z = lred(Z);
				if (!(*is)(*p1,*p2,*p3)) {erg = 0; break;}
				}
			    if (!erg) break;
			    }
			}
		    }
		}
	    else erg = 0;
	    }
	else erg = 0;
	}
    return(erg);
}
