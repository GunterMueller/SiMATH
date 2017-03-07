/* DOC_SKIP */

/*M
.SH NAME
HDidigitvec - Heidelberg arithmetic package: digitvec functions

.SH SYNOPSIS
(Internal)

.SH DESCRIPTION
This file contains some internal functions of the so-called Heidelberg arithmetic package. Please mind the compatibility notice and the original copyright in the file HDiadd.S!
M*/

/*H
	Version  1      17.03.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2      28.08.1993      Version 2 (Marc Conrad)
   DATE HDidigitvec        : 930531.931130
H*/
#include<_HDarith.h>


/* DigitVecAddCarry and DigitVecSubCarry removed, RD, 14.7.93 */
/* Test: VecMultAdd C-Version with gcc's unsigned long long, RD, 12.7.93 */
/* Integer Version 2.1, DigitVecMultSub changed, RD, 30.4.93	*/
/* Integer Version 2.0, RD, 18.1.93	idigitvec.c	*/
/* DigitVecSri, DigitVecCsubto avoid memory access delay, RD, 15.2.93 */

/*******************************
	First the standard DigitVec operations 
*********************************/

DigitType  DigitVecAdd (sum, a, b, l)
	DigitType *sum, *a, *b;
	int l;
     /*	sum[0..l-1] = a[0..l-1] + b[0..l-1]; return CARRY;   */
     /* This notation means:
	Add the integers represented by the vectors a and b,
	write the lowest l digits of the result into the vector sum
	and return the carry of this operation.
     */
{	DigitType accu, carry, tmp;
	carry=0;
	for ( ; l>0; l-- ) {
		accu = *a++ + carry;
		carry = (accu < carry);
		tmp = *b++;
		accu += tmp;
		carry += (accu < tmp);
		*sum++ = accu;
	}
	return carry;
}		/* DigitVecAdd */

DigitType  DigitVecSub (diff, a, b, l)
	DigitType *diff, *a, *b;
	int l;
     /*	diff[0..l-1] = a[0..l-1] - b[0..l-1]; return CARRY;   */
{	DigitType accu, carry, tmp;
	carry=0;
	for ( ; l>0; l-- ) {
		tmp = *a++;
		accu = tmp - carry;
		carry = (accu > tmp);
		tmp = accu - *b++;
		carry += (tmp > accu);
		*diff++ = tmp;
	}
	return carry;
}		/* DigitVecSub */

#define DDH (BitsPerDigit/2)

DigitType  DigitVecMult (res, a, m, l)
	DigitType *res, *a, m;
	int l;
     /*	res[0..l-1] = a[0..l-1]*m; return CARRY;   */
{       DigitType carry;
        DigitType aa, low1, low2, tmp1, tmp2, tmp3;
        DigitType ml, mh, al, ah;

        ml = (m << DDH) >> DDH;
        mh = m >> DDH;
	carry=0;

        for ( ; l>0; l--) {
            aa = *a++;
            al = (aa << DDH) >> DDH;
            ah = aa >> DDH;

            tmp1 = ml * al;
            low2 = carry + tmp1;
            carry = (low2 < carry);

            tmp2 = ml * ah;
            low1 = low2 + (tmp2 << DDH);
            carry += (low1 < low2) + (tmp2 >> DDH);

            tmp3 = mh * al;
            low2 = low1 + (tmp3 << DDH);
            carry += (low2 < low1) + (tmp3 >> DDH);

            *res++ = low2;
            carry += mh * ah;
        }
        return carry;
}               /* DigitVecMult */

#if !defined(__GNUC__) || defined(LP64)

DigitType  DigitVecMultAdd (res, a, m, l)
	DigitType *res, *a, m;
	int l;
     /*	res[0..l-1] += a[0..l-1]*m; return CARRY;   */
     /* Special function for multiple digit multiplication */
{       DigitType carry;
        DigitType aa, low1, low2, tmp1, tmp2, tmp3;
        DigitType ml, mh, al, ah;

        ml = (m << DDH) >> DDH;
        mh = m >> DDH;
	carry=0;

        for ( ; l>0; l--) {
            aa = *a++;
            al = (aa << DDH) >> DDH;
            ah = aa >> DDH;

            low1  = carry + *res;
            carry = (low1 < carry);

            tmp1 = ml * al;
            low2 = low1 + tmp1;
            carry += (low2 < low1);

            tmp2 = ml * ah;
            low1 = low2 + (tmp2 << DDH);
            carry += (low1 < low2) + (tmp2 >> DDH);

            tmp3 = mh * al;
            low2 = low1 + (tmp3 << DDH);
            carry += (low2 < low1) + (tmp3 >> DDH);

            *res++ = low2;
            carry += mh * ah;
        }
        return carry;
}               /* DigitVecMultAdd */

#else

/* Verwendung von unsigned long long bei GCC
	-- leider nicht portabel, und es erfordert,
		dass DigitType hoechstens halb so viele bits
		wie unsigned long long besitzt.
*/

typedef unsigned long long 	DoubleDigitType;

DigitType  DigitVecMultAdd (res, a, m, l)
	DigitType *res, *a, m;
	int l;
     /*	res[0..l-1] += a[0..l-1]*m; return CARRY;   */
     /* Special function for multiple digit multiplication */
{       DoubleDigitType accu=0;
        DoubleDigitType prod;
	DigitType aa;
        for ( ; l>0; l--) {
                accu+= *res;
                aa= *a++;
                prod = (DoubleDigitType)aa * (DoubleDigitType)m;
                accu+=prod;
                *res++ = accu;
                accu >>= BitsPerDigit;
        }
        return accu;
}               /* DigitVecMultAdd */


#endif

DigitType  DigitVecMultSub (res, a, m, l)
	DigitType *res, *a, m;
	int l;
     /*	res[0..l-1] -= a[0..l-1]*m; return CARRY;   */
     /* Special function for multiple digit division */
{       DigitType carry;
        DigitType aa, low1, low2, tmp1, tmp2, tmp3;
        DigitType ml, mh, al, ah;

        ml = (m << DDH) >> DDH;
        mh = m >> DDH;
	carry=0;

        for ( ; l>0; l--) {
            aa = *a++;
            al = (aa << DDH) >> DDH;
            ah = aa >> DDH;

            tmp1 = ml * al;
            low2 = carry + tmp1;
            carry = (low2 < carry);

            tmp2 = ml * ah;
            low1 = low2 + (tmp2 << DDH);
            carry += (low1 < low2) + (tmp2 >> DDH);

            tmp3 = mh * al;
            low2 = low1 + (tmp3 << DDH);
            carry += (low2 < low1) + (tmp3 >> DDH);

	    tmp1 = *res;
	    low1 = tmp1 - low2;
	    carry += (low1 > tmp1);

            *res++ = low1;
            carry += mh * ah;
        }
        return carry;
}               /* DigitVecMultSub */

DigitType  DigitVecDiv (quot, a, d, l)
	DigitType *quot, *a, d;
	int l;
     /*	quot[0..l-1] = a[0..l-1]/m; 
	return a[0..l-1]%m;
     */
{       DigitType carry=0;
        for (quot+=l, a+=l; l>0; l--)
		carry=DigitDiv(--quot, carry, *--a, d);
        return carry;
}		/* DigitVecDiv */


/*******************************
	Now some special DigitVec operations 
*********************************/

void DigitVecCsubto (a, b, l)
	DigitType *a, *b;
	int l;
        /* a[]-=b[l]; */
{	DigitType carry, x, y, z;
	if (l==0)
		return;
	x = *a;
	l--;
	z = *b++;
	carry = 0;
        for ( ; l>0; l--) {
		y = x - carry;
		carry = (y > x);
		x = y - z;
		*a++ = x;
		z = *b++;
		carry += (x > y);
		x = *a;
	}
	y = x - carry;
	carry = (y > x);
	x = y - z;
	*a++ = x;
	carry += (x > y);
        while (carry) {
		x = *a;
		y = x - carry;
		carry = (y > x);
		*a++ = y;
	}
}		/* DigitVecCsubto */


int DigitVecCadd (sum, a, b, la, lb)
	DigitType *sum, *a, *b;
	int la, lb;
	/* sum[]=a[la]+b[lb]; return sum->length */
{       DigitType carry=0, accu, tmp;
	int countmax;
	if (la>lb) {
		countmax=la;
		la-=lb;
	        for ( ; lb>0; lb--) {
			accu = *a++ + carry;
			carry = (accu < carry);
			tmp = *b++;
			accu += tmp;
			carry += (accu < tmp);
			*sum++ = accu;
		}
	        for ( ; la>0; la--) {
			accu = *a++ + carry;
			carry = (accu < carry);
			*sum++ = accu;
		}
	} else {
		countmax=lb;
		lb-=la;
	        for ( ; la>0; la--) {
			accu = *a++ + carry;
			carry = (accu < carry);
			tmp = *b++;
			accu += tmp;
			carry += (accu < tmp);
			*sum++ = accu;
		}
	        for ( ; lb>0; lb--) {
			accu = *b++ + carry;
			carry = (accu < carry);
			*sum++ = accu;
    	}	}
	*sum = carry;
	if (carry)
		return countmax+1;
	else
		return countmax;
}	/* DigitVecCadd */

int DigitVecCsub (diff, a, b, la, lb)
	DigitType *diff, *a, *b;
	int la, lb;
	/* diff[]=a[la]-b[lb]; return diff->length */
{       DigitType carry=0, x, y;
	int l=la-lb;
	for ( ; lb>0; lb--) {
		x = *a++;
		y = x - carry;
		carry = (y > x);
		x = y - *b++;
		carry += (x > y);
		*diff++ = x;
	}
	while (carry) {
		x = *a++;
		y = x - carry;
		carry = (y > x);
		*diff++ = y;
		l--;
	}
	for ( ; l>0; l--) {
		*diff++= *a++;
	}
	diff--;
	while ((la>0)&&(! *diff)) {
		diff--;
		la--;
	}
	return la;
}	/* DigitVecCsub */

BOOLEAN DigitVecSr1 (u, l) 
	DigitType *u;
	int l;
	/* b=u[l]%2; u[l]/=2; return b; */
{	DigitType b, bold, c;
	u=u + l;
	bold=0;
	while(l) {
		b= *--u;
		c=b>>1;
		c|=(bold<<(BitsPerDigit-1));
		bold=b;
		*u=c;
		l--;
	}
	b&=1;
	return (BOOLEAN) b;
}		/* DigitVecSr1 */


void DigitVecSri (u, l, i)
	DigitType *u;
	int l, i;
	/* b=u[l]%2^i; u[l]/=2^i; 	0<i<BitsPerDigit  */
{	DigitType b, bold, c;
	if (!l)
		return;
	u = u + l - 1;
	b = *u;
	bold=0;
	l--;
	while(l) {
		c=b>>i;
		c|=(bold<<(BitsPerDigit-i));
		*u=c;
		bold=b;
		b= *--u;
		l--;
	}
	c=b>>i;
	c|=(bold<<(BitsPerDigit-i));
	bold=b;
	*u=c;
}		/* DigitVecSri */

/*******************************
	Now some general non-critical DigitVec operations 
*********************************/

BOOLEAN DigitVecEq (a, b, l)
	DigitType *a, *b;
	int l;
        /* return a[l]==b[l]; */
{       for ( ; l>0; l--)
                if (*a++ != *b++)
                        return FALSE;
        return TRUE;
}

BOOLEAN DigitVecGt (a, b, l)
	DigitType *a, *b;
	int l;
        /* return a[l]>b[l] lexikographisch */
{       for (a+=l, b+=l; l>0; l--) {
		DigitType aa, bb;
		aa= *--a;
		bb= *--b;
                if (aa > bb)
                        return TRUE;
                else if (aa < bb)
                        return FALSE;
	}
        return FALSE;
}



