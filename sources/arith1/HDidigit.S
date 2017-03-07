/* DOC_SKIP */

/*M
.SH NAME
HDidigit - Heidelberg arithmetic package: digit functions

.SH SYNOPSIS
(Internal)

.SH DESCRIPTION
This file contains some internal functions of the so-called Heidelberg arithmetic package. Please mind the compatibility notice and the original copyright in the file HDiadd.S!
M*/

/*H
	Version  1      17.08.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE HDidigit      : 931130
H*/

#include<_HDarith.h>
                         
/* Integer Version 2.1, RD, 13.7.93	idigit.c	*/
/* Changed definition of DigitMult, added DigitMultAdd, RD, 13.7.93	*/
/* Integer Version 2.0, RD, 18.1.93	idigit.c	*/
/* DigitMultAdd and DigitMultSub removed, RD, 11.2.93 */



DigitType DigitAdd (sum, a, b, carry)
	DigitType *sum, a, b, carry;
        /* *sum=LOW-DIGIT(a+b+carry);
	   return HIGH-DIGIT(a+b+carry); 
	*/
{	a += carry;
	carry = (a < carry);
	a += b;
	carry += (a < b);
	*sum = a;
	return carry;
}

DigitType  DigitSub (diff, a, b, carry)
	DigitType *diff, a, b, carry;
        /* *diff=RESULT;
	   return CARRY;
	   where RESULT, CARRY are defined by: 
	   2^BitsPerDigit > 
		CARRY*2^BitsPerDigit + a - b - carry == RESULT >= 0
	*/
{       DigitType tmp;
        tmp = a-carry;
	carry = (tmp > a);
	a = tmp - b;
	carry += (a > tmp);
        *diff = a;
	return carry;
}

#define DDH (BitsPerDigit/2)

DigitType  DigitMult (prod, a, b)
	DigitType *prod, a, b;
        /* *prod=LOW-DIGIT(a*b);
	   return HIGH-DIGIT(a*b); 
	*/
{	DigitType	al, ah, bl, bh, low1, low2, carry, tmp2, tmp3;

	ah = a>>DDH;	al = (a<<DDH) >> DDH;
	bh = b>>DDH;	bl = (b<<DDH) >> DDH;

	low2 = bl * al;

	tmp2 = bl * ah;
	low1 = low2 + (tmp2 << DDH);
	carry = (low1 < low2) + (tmp2 >> DDH);

	tmp3 = bh * al;
	low2 = low1 + (tmp3 << DDH);
	carry += (low2 < low1) + (tmp3 >> DDH);

	*prod = low2;
	carry += bh * ah;
	return carry;
}

DigitType  DigitMultAdd (prod, a, b, carry)
	DigitType *prod, a, b, carry;
        /* *prod=LOW-DIGIT(a*b+carry);
	   return HIGH-DIGIT(a*b+carry); 
	*/
{	DigitType	al, ah, bl, bh, low1, low2, tmp1, tmp2, tmp3;

	ah = a>>DDH;	al = (a<<DDH) >> DDH;
	bh = b>>DDH;	bl = (b<<DDH) >> DDH;

	tmp1 = bl * al;
	low2 = carry + tmp1;
	carry = (low2 < carry);

	tmp2 = bl * ah;
	low1 = low2 + (tmp2 << DDH);
	carry += (low1 < low2) + (tmp2 >> DDH);

	tmp3 = bh * al;
	low2 = low1 + (tmp3 << DDH);
	carry += (low2 < low1) + (tmp3 >> DDH);

	*prod = low2;
	carry += bh * ah;
	return carry;
}


#define BPDM1 (BitsPerDigit - 1)

DigitType  DigitDiv (quot, h, l, d)
	DigitType *quot, h, l, d;
	/* Suppose:	d>0 and h<d
	   *quot=QUOT;
	   return REM;
	   where QUOT, REM are defined by: 
	   h*2^BitsPerDigit + l == d*QUOT + REM,
	   2^BitsPerDigit > REM >= 0
	*/
{       register DigitType qd = 0, carry;
	register int i;
	for (i=0; i<BitsPerDigit; i++) {
		carry=h>>BPDM1;
		h = (h<<1) | (l>>BPDM1);
		l = l<<1;
		qd<<=1;
		if (carry || h>=d) {
			qd+=1;
			h-=d;
	}	}
	*quot = qd;
	return h;
}


