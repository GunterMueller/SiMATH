/*M
.SH NAME
fgetmi - file get modular integer

.SH SYNOPSIS
.nf
#include <_arith1.h>

int fgetmi(M,pf)
int M;
FILE *pf;

.SH DESCRIPTION
fgetmi() returns the integer read in from the file *pf reduced modulo M
for M >0
or ERROR in case an error occurs.
M*/

/*H
	Version 1       8.4.1987                Pascale Serf
   DATE fgetmi        : 890501
H*/


# include <_arith1.h>

int fgetmi(M,pf)
int M;
FILE *pf;
{
	int A;

	bind(M);
	init(A);

	A = fgeti(pf);
	if ( A == ERROR ) {
		errmsgio("fgetmi","EA006");
		return(A);
	}
	else return(mihom(M,A));
}
