/*M
.SH NAME
itoI_sp - (SIMATH) integer to (Heidelberg) Integer special version

.SH SYNOPSIS
.nf
#include<_HDarith.h>

single itoI_sp(A, lA, h)
int A;
single lA;
Integer *h; 


.SH DESCRIPTION
itoI_sp() returns 0 and the value of A as the Heidelberg integer h,
provided lA = llength(A) in case A is not a single.
.PP
.TP 4
.B A
is an integer in SIMATH list representation
.PP
.TP 4
.B lA
is the length of the list A
.PP
.TP 4
.B h
is an integer according to the conventions of the Heidelberg arithmetic package
.SH SEE ALSO
Itoi
M*/

/*H
	Version  1      03.09.1993	Marc Conrad
   DATE itoI_sp       : 930531.931130
H*/

#include <_HDarith.h>

#define wortlen 32
int itoI_sp(A, l, a)
	Integer *a;
	int A;    
	single l; 
{

	if (issingle(A)) {
		Iasint(a, A);
	} else {
		DigitType x, y, *pq;

		single m, z, s, ml, u, sgn;
		unsigned neededlength;

		Integer b, c;

		bind(A);

		Iasint(a, 0);
		z = 1;

		neededlength = ((l * 30) / wortlen) + 1;
		if (neededlength > a->maxlength) {
			DigitType *newv;
			int oldlength = a->maxlength;

			a->maxlength = neededlength;
			newv = newDigitVec(&(a->maxlength));
			delDigitVec(a->vec, oldlength);
			a->vec = newv;
		}
		if (isign(A) >= 0)
			a->sign = PLUS;
		else
			a->sign = MINUS;

		pq = a->vec;
		x = 1;
		y = 0;

		m = lfirst(A);
		m = sabs(m);
		A = lred(A);
		l = 0;
		while ((A != _0) || m) {
			if (m & 1)
				y |= x;
			if (x < (1 << (wortlen - 1))) {
				x <<= 1;
			} else {
				*(pq++) = y;
				l++;
				y = 0;
				x = 1;
			}


			if (z == 30) {
				if (A != _0) {
					m = lfirst(A);
					m = sabs(m);
					A = lred(A);
					z = 1;
				} else
					break;
			} else {

				m >>= 1;
				z++;
			}
		}
		if (y) {
			*(pq++) = y;
			l++;
		}
		a->length = l;


	}
	return (0);

}



