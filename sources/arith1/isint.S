/*M
.SH NAME
isint - is integer ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single isint(A)
obj A;

.SH DESCRIPTION
isint() returns 1 if A is an integer, 0 otherwise.
M*/
/*H
	Version 1       05.01.1987              Pascale Serf
	Version 2       02.04.1987              komplette Neufassung
						  P.Serf
	Version 3       26.01.1988      B. Weis
			komplette Neufassung   
	Version 4	27.09.1990		Marc Conrad
                                   Fall  A = ( single ) erfasst.
   DATE isint         : 890501.901120
H*/


#include <_arith1.h>

single isint(A)
obj A;
{
    single s, vz=0;
    obj B;   

    if (issingle(A)) s = 1;
    else if (!islist(A)  ||  A == _0) s = 0;
    else {
	s = 1;
	B = lfirst(A);
	if (!issingle(B)) {A = _0; s = 0;}
	else {vz = ssign(B); A = lred(A);}   
	if ( A == _0 ) s = 0;
	else {
		while (A != _0) {
		    B = lfirst(A);
		    if (!issingle(B)) {s = 0; break;}
		    if (B  &&  vz  &&  vz != ssign(B)) {s = 0; break;}
		    if (!vz) vz = ssign(B);
		    A = lred(A);
	    	}
		if (s  &&  !B) s = 0;    
	}
    }

/* Ausgabe */

    return(s);
}
