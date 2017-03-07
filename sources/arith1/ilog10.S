/*M
.SH NAME
ilog10 - integer logarithm, base 10

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ilog10(n)
int n;

.SH DESCRIPTION
ilog10() the integer part log10(|n|) incremented by 1
or 0 if n equals 0.
M*/
/*H
	Version 1	01.07.1993	Georg Lay
   DATE ilog10        : 931130
H*/

#include <_arith1.h>

ilog10 (n)
int n;
 {
 single log10;
 bind (n);

 for (log10 = 0; n != 0; n = iquot (n,10), log10++);

 return (log10);
 }

