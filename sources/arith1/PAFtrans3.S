/*C
			PAFtrans3( )

	"Papanikolaou floating point package: transcendental functions 3"
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fasin
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasin needs a real argument!
* side effects    : none
* algorithm       : y = asin(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Facos
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasin needs a real argument!
* side effects    : none
* algorithm       : y = acos(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fatan
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasin needs a real argument!
* side effects    : none
* algorithm       : y = atan(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fatan2
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *z, *y, *x
* return value    : void
* extern          :
* error messages  : Fatan2 needs real arguments!
* side effects    : none
* algorithm       : z = atan2(y, x) in time O(sqrt(t) t^log3) where t
*                   the precision. (A four quadrant arctan function
*                   returns arctan of y/x in range from pi to -pi)
*
*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Facot
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasin needs a real argument!
* side effects    : none
* algorithm       : y = acot(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fasinh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasinh needs a real argument!
* side effects    : none
* algorithm       : y = asinh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Facosh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Facosh needs a real argument!
* side effects    : none
* algorithm       : y = acosh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fatanh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fatanh needs a real argument!
* side effects    : none
* algorithm       : y = atanh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Facoth
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Facoth needs a real argument!
* side effects    : none
* algorithm       : y = acoth(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
C*/
/*H
	Version  1      02.09.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFtrans3     : 931130
H*/                                                             

#include<_PAFarith.h>      
/*

*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fasin
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasin needs a real argument!
* side effects    : none
* algorithm       : y = asin(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*                   We use the identity:
*
*                   asin(x) = atan(x / sqrt(1 - x^2)) 
*
*****************************************************************/

void
Fasin(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           p1, p2;

	cFasF(&p1, x);
	cFasdbl(&p2, 1.0);
	if (FeqF(&p1, &p2)) {
		Fpi(y);
		y->e--;
		return;
	}
	p2.m.sign = !p2.m.sign;
	if (FeqF(&p1, &p2)) {
		Fpi(y);
		y->e--;
		y->m.sign = !y->m.sign;
		return;
	}
	FasFmuF(&p2, x, &p1);
	Fdec(&p2);
	p2.m.sign = !p2.m.sign;
	Fsqrt(&p2, &p2);
	FasFdiF(&p1, x, &p2);
	Fatan(y, &p1);
	dF(&p1);
	dF(&p2);
}

/*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Facos
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasin needs a real argument!
* side effects    : none
* algorithm       : y = acos(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*                   We use the identity:
*
*                   acos(x) =  pi/2 - atan(x / sqrt(1 - x^2))
*
*****************************************************************/

void
Facos(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           p1, p2, p3;

	cFasF(&p1, x);
	cFasdbl(&p2, 1.0);
	if (FeqF(&p1, &p2)) {
		Fasdbl(y, 0.0);
		return;
	}
	p2.m.sign = !p2.m.sign;
	if (FeqF(&p1, &p2)) {
		Fpi(y);
		return;
	}
	cF(&p3);
	FasFmuF(&p2, x, &p1);
	Fdec(&p2);
	p2.m.sign = !p2.m.sign;
	Fsqrt(&p2, &p2);
	FasFdiF(&p1, x, &p2);
	Fatan(&p3, &p1);
	Fpi(&p2);
	p2.e--;
	FasFmiF(y, &p2, &p3);
	dF(&p1);
	dF(&p2);
	dF(&p3);
}

/*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fatan
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasin needs a real argument!
* side effects    : none
* algorithm       : y = atan(x) in time O(t^(1 + log3)) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*                   We use the identity:
*
*                   atan(x) = 2 * atan(x / (x + sqrt(x^2 + 1)))
*                   
*                   to reduce x and the sum the series we the
*                   Horner rule, using increasing precision at
*                   each step. This algotihm can be improved to a
*                   O(t^(1/2 + log3)) one, if one reduces relatively
*                   to the precision (i.e subsityte -10 with -c,
*                   c = -sqrt(machine_dependent_constant * t)) 
*
*****************************************************************/

void
Fatan(y, x)
	register pFloat y;
	register
	const Float    *x;
{
	Float           a, e, tmp;
	long            i, j, ex, t = BinPrec;
	long            m, u, f;

	if (Fis0(x)) {
		Fasdbl(y, 0.0);
		return;
	}
	ex = x->e;
	if (ex > BinPrec)
		BinPrec = ex + BitsPerDigit - ex % BitsPerDigit;
	cFasdbl(&a, 1.0);
	cFasF(&tmp, x);
	m = 0;
	if (tmp.m.sign) {
		m = 1;
		tmp.m.sign = PLUS;
	}
	if (FeqF(&tmp, &a)) {
		Fpi(y);
		y->e -= 2;
		if (m)
			y->m.sign = !y->m.sign;
		dF(&a);
		dF(&tmp);
		return;
	}
	Fnormalize(&tmp);
	ex = tmp.e;
	u = 0;
	if (ex > 0) {
		FasintdiF(&tmp, 1, &tmp);
		u = 1;
	}
	ex = tmp.e;
	f = 0;
	cFasF(&e, &tmp);
	if (ex > -10)
		while (tmp.e > -10) {
			FmuasF(&e, &tmp);
			FasFplF(&e, &e, &a);
			Fsqrt(&e, &e);
			FasFplF(&e, &e, &a);
			FdiasF(&tmp, &e);
			FasF(&e, &tmp);
			f++;
		}
	FasF(&a, &tmp);
	FmuasF(&a, &tmp);

	ex = abs(tmp.e) << 1;
	j = BinPrec / ex;
	if (j & 1)
		j++;
	Fasintdiint(y, 1, 2 * j + 1);
	BinPrec = 4 * ex;

	for (i = j; i >= 1; i--) {
		FmuasF(y, &a);
		Fasintdiint(&e, 1, 2 * i - 1);
		BinPrec += 2 * ex;
		if (BinPrec > t)
			BinPrec = t;
		y->m.sign = !y->m.sign;
		FasFplF(y, y, &e);
	}
	BinPrec = t;
	FmuasF(y, &tmp);
	y->e += f;

	if (u) {
		Fpi(&a);
		a.e--;
		FmiasF(y, &a);
		y->m.sign = !y->m.sign;
	}
	if (m)
		y->m.sign = !y->m.sign;

	dF(&a);
	dF(&e);
	dF(&tmp);
}

/*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fatan2
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *z, *y, *x
* return value    : void
* extern          :
* error messages  : Fatan2 needs real arguments!
* side effects    : none
* algorithm       : z = atan2(y, x) in time O(sqrt(t) t^log3) where t
*                   the precision. (A four quadrant arctan function
*                   returns arctan of y/x in range from pi to -pi)
*
*****************************************************************/

void
Fatan2(z, y, x)
	register pFloat          z;
	register const Float    *y, *x;
{
	Float           tmpy, tmpx;
	int             xs, ys;

	if (!x->m.length && !y->m.length) {
		Fasint(z, 0);
		z->e = -BinPrec;
		return;
	} else {
		cFasF(&tmpy, y);
		cFasF(&tmpx, x);

		if (tmpx.m.sign) {
			xs = 1;
			tmpx.m.sign = !tmpx.m.sign;
		} else
			xs = 0;
		if (tmpy.m.sign) {
			ys = 1;
			tmpy.m.sign = !tmpy.m.sign;
		} else
			ys = 0;

		if (FgtF(x, y)) {
			FasFdiF(z, &tmpy, &tmpx);
			Fatan(z, z);
		} else {
			FdiasF(&tmpx, &tmpy);
			Fatan(&tmpx, &tmpx);
			tmpx.m.sign = !tmpx.m.sign;
			Fpi(&tmpy);
			tmpy.e--;
			FasFplF(z, &tmpy, &tmpx);
		}
		if (xs) {
			Fpi(&tmpy);
			z->m.sign = !z->m.sign;
			FasFplF(z, z, &tmpy);
		}
		if (ys)
			z->m.sign = !z->m.sign;

		dF(&tmpy);
		dF(&tmpx);
	}
}


/*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Facot
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasin needs a real argument!
* side effects    : none
* algorithm       : y = acot(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*                   We use the identity:
*
*                   acot(x) =  pi/2 - atan(x)
*
*
*****************************************************************/

void
Facot(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           p1, p2;

	cF(&p1);
	cF(&p2);
	Fatan(&p1, x);
	Fpi(&p2);
	p2.e--;
	FasFmiF(y, &p2, &p1);
	dF(&p1);
	dF(&p2);
}

/*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fasinh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fasinh needs a real argument!
* side effects    : none
* algorithm       : y = asinh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*                   We use the identity:
*
*                   asinh(x) = log(x + sqrt(x^2 + 1))
*
*****************************************************************/

void
Fasinh(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           p1;

	cFasF(&p1, x);
	FmuasF(&p1, x);
	Fplasint(&p1, 1);
	Fsqrt(&p1, &p1);
	FasFplF(y, x, &p1);
	Flog(y, y);
	dF(&p1);
}

/*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Facosh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Facosh needs a real argument!
* side effects    : none
* algorithm       : y = acosh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*                   We use the identity:
*
*                   acosh(x) = log(x + sqrt(x^2 - 1))
*
*
*****************************************************************/

void
Facosh(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           p1;

	cFasF(&p1, x);
	FmuasF(&p1, x);
	Fplasint(&p1, -1);
	Fsqrt(&p1, &p1);
	FasFplF(y, x, &p1);
	Flog(y, y);
	dF(&p1);
}

/*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fatanh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fatanh needs a real argument!
* side effects    : none
* algorithm       : y = atanh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*                   We use the identity:
*
*                   atanh(x) = 1/2 * log((1 + x) / (1 - x))
*                            = 1/2 * log(2/(1 - x) - 1)
*
*
*****************************************************************/

void
Fatanh(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           p1;

	cFasF(&p1, x);
	p1.m.sign = !p1.m.sign;
	Fplasint(&p1, 1);
	FasintdiF(y, 2, &p1);
	Fplasint(y, -1);
	Flog(y, y);
	y->e--;
	dF(&p1);
}

/*****************************************************************
*
* filename        : trans3.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Facoth
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Facoth needs a real argument!
* side effects    : none
* algorithm       : y = acoth(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*                   We use the identity:
*
*                   acoth(x) = 1/2 * log((x + 1) / (x - 1))
*                            = 1/2 * log(2/(x - 1) + 1)
*
*****************************************************************/

void
Facoth(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           p1;

	cFasF(&p1, x);
	Fplasint(&p1, -1);
	FasintdiF(y, 2, &p1);
	Fplasint(y, 1);
	Flog(y, y);
	y->e--;
	dF(&p1);
}
