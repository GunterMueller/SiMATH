/*M
.SH NAME
itoI(A, h) - (SIMATH) integer to (Heidelberg) Integer

.SH SYNOPSIS
.nf
#include<_HDarith.h>

single itoI(A, h)
int A;
Integer *h;

.SH DESCRIPTION
itoI() returns 0 and the value of A as the Heidelberg integer h.
.PP
.TP 4
.B A
is an integer in SIMATH list representation
.PP
.TP 4
.B h
is an integer according to the conventions of the Heidelberg arithmetic package
.SH SEE ALSO
Itoi
M*/
/*H
	Version  1      16.04.1993	Marc Conrad
	Version  2      16.08.1993	voellig neu.  MC
   DATE itoI          : 930531.931130
H*/


#include<_HDarith.h>

single itoI(A, aa)
	Integer *aa;
	int A;
{
	single s;

	if (issingle(A)) {
		Iasint(aa, A);
	} else {
		DigitType v=0, *pe;
		unsigned neededlength, z = 0;
		single u, built, lwidth=SIZEOF_LONG*8;

                bind( A );
		Iasint(aa, 0);

		u = llength(A);
		neededlength = ((u * FULL_WIDTH) / lwidth) + 1;
		if (neededlength > aa->maxlength) {
			DigitType *newv;
			int oldlength = aa->maxlength;

			aa->maxlength = neededlength;
			newv = newDigitVec(&(aa->maxlength));
			delDigitVec(aa->vec, oldlength);
			aa->vec = newv;
		}
		pe = aa->vec;

		if (isign(A) >= 0)
			aa->sign = PLUS;
		else
			aa->sign = MINUS;

		built=0;
		while (A != _0) {
			u = lfirst(A), A = lred(A);
			if (u<0)
			        u=-u;
			v |= ((unsigned long) u) << built;
			built += FULL_WIDTH;
			if( built >= lwidth ) {
				*pe = v;
				pe++, z++;
				built -= lwidth;
				v = (unsigned long) u >> (FULL_WIDTH - built);
			}
		}
		if( built && v ) {
		        *pe = v;
			pe++, z++;
		}
		aa->length = z;
	}
	return (0);
}
