/*M
.SH NAME
isqnffund - is discriminant of complex quadratic number field fundamental?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnffund(D) 
int D;

.SH DESCRIPTION
.TP 4
.B D
is an integer number.
.PP
isqnffund returns
.TP 4
1,
if D is a fundamental discriminant of a complex quadratic number field, and
.TP 4
0,
else.
 
M*/
              
/*H

        Version 1       01.01.1997      S.Kessler
H*/

#include <_arith2.h>

double fltoCfl();

single Squarefree(x)
	int x;
{
	int srt,t;
	init(srt,t);
	bind(x);
	if (isign(x)==-1) x=ineg(x);
	srt=isqrt(x);
	for (t=2; icomp(srt,t)==1; t=isum(t,1))
		if ( mihom(iprod(t,t),x)==0 ) return 0;
	return 1;
};

single isqnffund(D)
	int D;
{
	int qD4;
	init(qD4);
	bind(D);

	if ( (D!=1) && (mihom(4,D)==1) && Squarefree(D) ) return 1;
	qD4=iquot(D,4);
	if ( (D!=1) && (mihom(4,D)==0) && (Squarefree(qD4)) && ((mihom(4,(qD4))==2) || (mihom(4,(qD4))==3))) return 1;
	return 0;
};

















































































































