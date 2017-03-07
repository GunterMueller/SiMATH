/*M
.SH NAME
uprfcdpr - univariate polynomial over the rationals from common denominator polynomial over the rationals

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol uprfcdpr(PC) 
pol PC;

.SH DESCRIPTION
.TP 4
.B PC
is a polynomial over the rational numbers in CD representation (s. cdprfcl).
.PP
uprfcdpr returns the polynomial PC as an univariate polynomial over the rational numbers in sparse representation.

.SH SEE ALSO
cdprfcl

M*/

/*H
	Version 1       15.05.89        J.Schmitt
   DATE uprfcdpr      : 891101
H*/

#include<_pol2.h>

pol uprfcdpr(PC)
pol PC;
{
	int Al;
	init(Al);
	bind(PC);

	if (PC == 0) return(PC);
	Al = lfirst(PC);
	Al = list2(1,Al);
	PC = lred(PC);
	PC = pitopr(1,PC);
	PC = prrprod(1,PC,Al);
	return(PC);
}
