/*M
.SH NAME
fputmi - file put modular integer

.SH SYNOPSIS
.nf
#include<_arith1.h>

sing|e fputmi(M,A,pf)
int M,A;
FILE *pf;

.SH DESCRIPTION
fputmi()  writes the modular integer A from Z/MZ for M > 0
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.returns 

.PP
.TP 4
.B M
M > 0, the module
.TP 4
.B A
the modular integer from Z/M*Z
M*/
/*H
	Version 1       8.4.1987                Pascale Serf
   DATE fputmi        : 890501
H*/


# include <_arith1.h>

single fputmi(M,A,pf)
int M,A;
FILE *pf;
{
	single t;

	bind2(M,A);

	t = fputi(A,pf);
	if ( t == ERROR) errmsgio("fputmi","EA107");
	return(t);
}
