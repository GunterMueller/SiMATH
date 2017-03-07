/*M
.SH NAME
iqrem_3 - integer quotient and remainder special version 3

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iqrem_3(A,B,pQ,pR)
int A,B,*pQ,*pR;

.SH DESCRIPTION
iqrem_3()
calculates the integers *pQ = A / B and *pR = A - (*pQ) * B
for B!=0 and returns 0.
In some certain cases iqrem_3() uses the Heidelberg Arithmetic Package
to perform the division.
.PP
.TP 4
.B A,B
are not allowed to be singles, i.e. it must hold that
|A|, |B| >= BASIS
M*/
/*H
	Version 1       03.09.1993      Marc Conrad
	Version 2       06.12.1993      Fehler beseitigt.  MC
	Version 3       03.05.1999      iqrem_lo() auskommentiert. 
   DATE iqrem_3       : 931130
H*/

#include<_HDarith.h>

int iqrem_3(A, B, pQ, pR)
     int A, B, *pQ, *pR;
{
	Integer q, r, a, b;

	bind(A, B);

	if (llength(A) < llength(B)) {
		*pQ = 0;
		*pR = A;
		return (0);
	}

	cI(&a);
	cI(&b);

	itoI(A, &a);
	itoI(B, &b);

	cI(&q);
	cI(&r);

	Idiv(&q, &r, &a, &b);

	if (!Ieq0(&r)) {
		if (a.sign == MINUS) {
			if (b.sign == MINUS) {
				IplasI(&r, &b);
				Idec(&q);
			} else {
				ImiasI(&r, &b);
				Iinc(&q);
			}
		}
	}
	dI(&a);
	dI(&b);

	A = Itoi(&q);
	B = Itoi(&r);

	*pQ = A;
	*pR = B;

	dI(&q);
	dI(&r);

	return (0);
}
