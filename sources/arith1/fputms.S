/*M
.SH NAME
fputms - file put modular single

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputms(m,a,pf)
single m,a;
FILE *pf;

.SH DESCRIPTION
fputms()  writes the modular integer a from Z/mZ for m > 0
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.

.PP
.TP 4
.B m
m > 0, the module
.TP 4
.B a
the modular integer from Z/m*Z
M*/

/*H
	Version 1       8.4.1987                Pascale Serf
   DATE fputms        : 890501
H*/


# include <_arith1.h>

single fputms(m,a,pf)
single m,a;
FILE *pf;
{
	single t;

	t = fputsi(a,pf);
	if ( t != 0 ) errmsgio("fputms","EA111");
	return(t);
}
