/*M
.SH NAME
fgetms - file get modular single

.SH SYNOPSIS
.nf
#include <_arith1.h>

single fgetms(m,pf)
single m;
FILE *pf;

.SH DESCRIPTION
fgetms() returns the integer read in from the file *pf and reduced modulo m,
for m >0
or ERROR in case an error occurs.
M*/

/*H
	Version 1       8.4.1987                Pascale Serf
   DATE fgetms        : 890501
H*/


# include <_arith1.h>

single fgetms(m,pf)
single m;
FILE *pf;
{
	int A;

	init(A);

	A = fgeti(pf);
	if ( A == ERROR ) {
		errmsgio("fgetms","EA006");
		return(A);
	}
	else return(mshom(m,A));
}
