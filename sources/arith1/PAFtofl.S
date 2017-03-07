/*M
.SH NAME
PAFtofl - Papanikolaou floating point to (SIMATH) floating point

.SH SYNOPSIS
.nf
#include<_PAFarith1.h>

int PAFtofl(x)
Float *x;

.SH DESCRIPTION
PAFtofl() returns the value of x as a SIMATH floating in list representation.
.PP
.TP 4
.B *x
is a floating point number according to the conventions of the Papanikolaou floating point package.

.SH SEE ALSO
fltoPAF
M*/

/*H
	Version  1      16.08.1993	Marc Conrad
   DATE PAFtofl       : 931130
H*/
#include<_PAFarith.h>

floating PAFtofl(y)
	Float *y;
{
	single e, lA, q, r;
	int A;

	init(A);

	A = Itoi(&(y->m));    

	e = y->e - Flength(y);

	q = e / 30 - 1; 
	r = e % 30 + 30; 

	A = ip2prod(A, r) ;

	if (issingle(A))
		lA = 1;
	else
		lA = llength(A);

	return (flcons(A, q, lA));  




}


