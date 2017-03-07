/*C
			PAFtrans1 ( )

	"Papanikolaou floating point package: transcendental functions 1"    

*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsqrt
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fsqrt needs real arguments!
*                   Fsqrt needs arguments >= 0!
* side effects    : none
* algorithm       : y = sqrt(x) in time O(log(t)) where t the
*                   precision using the Newton method for
*                   f(z) = z^2 - x (= 0)
*
*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fexp
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fexp needs a real argument
* side effects    : none
* algorithm       : y = exp(x) in time O(sqrt(t) t^log3) where t
*                   the precision using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Flog
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Flog needs a real argument!
*                   Flog needs an argument > 0!
* side effects    : none
* algorithm       : y = log(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsqr
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *z, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : z = x ^ 2 in time O(t^log3) where t
*                   the precision, using the trivial method.
*
*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FsqrF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *z
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : z = z ^ 2 in time O(t^log3) where t
*                   the precision, using the trivial method.
*
*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFpowF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *z, *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : z = x ^ y in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFpowint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x, *a, int n
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = a ^ n in time O(log(n) t^log3) where t
*                   the precision,  using the binary method.
*
C*/
/*H
	Version  1      02.09.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFtrans1     : 931130
H*/                                                             

#include<_PAFarith.h>      

/*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsqrt
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fsqrt needs real arguments!
*                   Fsqrt needs arguments >= 0!
* side effects    : none
* algorithm       : y = sqrt(x) in time O(log(t)) where t the
*                   precision using the Newton method for
*                   f(z) = 1/z^2 - x (= 0)
*
*****************************************************************/

void
Fsqrt(y, x)
	register pFloat y;
	register const Float *x;

{
	long            l, l1, l0, l2, eps, n, i, ex, t = BinPrec;
	DigitType       x0;
	double          beta;
	Float           p1, p2, p3, copy;
	
	if  (x->m.sign)
		Ferror("Fsqrt needs an argument > 0!");
	if (!x->m.length) {
		y->m.length = 0;
		y->m.sign = PLUS;
		y->e = -t;
	} else {
		l = Prec;
		cFasF(&p1, x);
		cFmaxlength(&p2, l + 1);
		cFmaxlength(&p3, l + 1);

		copy.m.sign = p1.m.sign;
		
		ex = x->e;
		eps = ex % 2;
		ex /= 2;
		
		if (eps < 0) {
			eps++;
			eps++;
			ex--;
		}
		
		i = Flead0s(p1.m.vec[p1.m.length -1]);
		Islasint(&p1.m, i);
		p1.e = eps;
		x0 = p1.m.vec[p1.m.length - 1];
		beta = sqrt((eps+1) * (double) (x0) / BigDigit);
		Fasdbl(&p2, beta);

		n = 1 + log((double) (l - 2)) / LOG2;
		l1 = 1;
		l2 = 3;
		l -= 2;
		for (i = 1; i <= n; i++) {
			l0 = l1 << 1;
			if (l0 <= l) {
				l2 += l1;
				BinPrec = l2 << 5;
				l1 = l0;
			} else {
				l2 += -l1 + l + 1;
				BinPrec = l2 << 5;
				l1 = l + 1;
			}
			eps = p1.m.length - l2;
			if (eps > 0) {
				copy.m.vec = p1.m.vec + eps;
				copy.m.length = p1.m.length - eps;
				copy.m.maxlength =  p1.m.maxlength;
				copy.e = p1.e; 
				FasFdiF(&p3, &copy, &p2);
			} else
				FasFdiF(&p3, &p1, &p2);
			FasFplF(&p2, &p2, &p3);
			p2.e--;
		}
		BinPrec = t;
		FasF(y, &p2);
		y->e += ex;
		Fnormalize(y);
		
		dF(&p1);
		dF(&p2);
		dF(&p3);
	}
}

/*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fexp
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fexp needs a real argument
* side effects    : none
* algorithm       : y = exp(x) in time O(sqrt(t) t^log3) where t
*                   the precision using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Fexp(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           tmp, tmp1;
	long            s, f = 0, i, ex, n, t = BinPrec - 3 * BitsPerDigit;
	double          a, b;
	double          reg;
	long            j, l0, l1, l2, s1, ex1;

	if (Fis0(x)) {
		Fasdbl(y, 1.0);
		return;
	}
	FasF(y, x);
	s = x->m.sign;
	if (s)
		y->m.sign = PLUS;
	Fnorm(y);
	ex1 = y->e;
	a = log(y->m.vec[y->m.length - 1] / BigDigit) * INVLOG2;
	a += ex1;
	if (x->m.length > 2)
		reg = 1.246294;
	else
		reg = 5.0;
	t = t + sqrt(t) - (ex1 < 0) * ex1;
	b = -sqrt(t / reg);
	if (a > b) {
		n = 1 - (long) (reg * b);
		f = 1 + a - b;
		y->e -= f;
	} else
		n = 1 - t / a;

	cFmaxlength(&tmp, Prec);
	cFmaxlength(&tmp1, Prec);
	Fasint(&tmp, 1);
	l1 = 2;
	l2 = 1 + t / BitsPerDigit;
	s1 = 0;
	BinPrec = (l1 + 2) << LogDigit;

	for (i = n; i; i--) {
		Fdiasint(&tmp, i);
		j = y->m.length - l1;
		if (j > 0) {
			IasIsrint(&tmp1.m, &(y->m), (j << LogDigit));
			tmp1.e = y->e;
			FmuasF(&tmp, &tmp1);
		} else
			FmuasF(&tmp, y);
		ex = tmp.e;
		s1 = s1 - ex;	/* I've seen this in PARI */
		l0 = s1 / BitsPerDigit;
		l1 += l0;
		if (l1 > l2)
			l1 = l2;
		s1 %= BitsPerDigit;
		BinPrec = (l1 + 2) << LogDigit;
		Fplasint(&tmp, 1);
	}
	if (f)
		while (f--) {
			FasF(y, &tmp);
			FmuasF(&tmp, y);
		}
	if (s)
		FasintdiF(y, 1, &tmp);
	else {
		FasF(y, &tmp);
		Fnormalize(y);
	}
	BinPrec = Prec << LogDigit;
	dF(&tmp);
	dF(&tmp1);
}

/*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Flog
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Flog needs a real argument!
*                   Flog needs an argument > 0!
* side effects    : none
* algorithm       : y = log(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Flog(y, x)
	register pFloat y;
	register const Float *x;
{
	Float           power, term, sum, tmp;
	double          a, b, aa, bb, xc;
	long            n, f = 0, f1 = 0, s = 0;
	long            i, j, l, t = Prec;
	long            hlp, l0, l1, l2, ex, ex1;

	if (x->m.sign || !x->m.length) {
		Ferror("Flog needs an argument > 0!");
		return;
	}
	cFasF(&power, x);
	Fplasint(&power, -1);
	ex1 = power.e;
	if (Feq0(&power)) {
		y->m.length = y->m.sign = PLUS;
		y->e = -BinPrec;
		dF(&power);
		return;
	}
	FasF(y, x);

	if (ex1 < 0) {
		ex1 = -ex1;
		ex1 = ex1 + BitsPerDigit - ex1 % BitsPerDigit;
		BinPrec += ex1;
		Prec += (ex1 >> LogDigit);
	}
		
	if (y->e < 1) {
		s = 1;
		FasintdiF(y, 1, x);
	}
	while (y->e > 1) {
		f1++;
		Fsqrt(y, y);
	}

	FasFplint(&power, y, -1);
	xc = log(power.m.vec[Prec - 1] / BigDigit) +  power.e * LOG2;
	l = Prec;
	b = 16 * l * LOG2;
	a = -xc;
	aa = a / LOG2;
	bb = 2.75 * sqrt(l / 3.0);
	if (aa <= bb) {
		n = 1 + 16 / 2.75 * sqrt(3.0 * l);
		f = 1 + bb - aa;
	} else
		n = 2 + b / a;
	for (i = 0; i < f; i++, Fsqrt(y, y));

	Fplasint(y, -1);
	FasFplint(&power, y, 2);
	FdiasF(y, &power);
	FasF(&power, y);
	FmuasF(y, &power);
	ex = y->e;
	cFmaxlength(&term, Prec);
	cFasF(&sum, &power);

	n <<= 1;
	n++;
	l1 = (f + f1) / 16 + 1;
	hlp = 0;
	l2 = Prec - 3 + f / BitsPerDigit;
	BinPrec = (l1 + 2) * BitsPerDigit;
	Fdiasint(&power, n);
	n -= 2;
	cFmaxlength(&tmp, l2 << 2);

	for (i = n; i >= 1; i -= 2) {
		j = y->m.length - l1;
		if (j > 0) {
			IasIsrint(&tmp.m, &(y->m), j << LogDigit);
			tmp.e = y->e;
			FmuasF(&power, &tmp);
		} else
			FmuasF(&power, y);
		Fasintdiint(&term, 1, i);
		hlp -= ex;	/* I've seen this in PARI */
		l0 = hlp / BitsPerDigit;
		l1 += l0;
		if (l1 > l2)
			l1 = l2;
		hlp %= BitsPerDigit;
		BinPrec = (l1 + 2) * BitsPerDigit;
		FasFplF(&power, &power, &term);
	}
	Prec = t;
	BinPrec = t << LogDigit;
	FasFmuF(y, &sum, &power);
	Fslasint(y, 1 + f + f1);
	if (s)
		y->m.sign = !y->m.sign;

	dF(&power);
	dF(&term);
	dF(&sum); 
	dF(&tmp);
}

/*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FsqrF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *z, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : z = x ^ 2 in time O(t^log3) where t
*                   the precision, using the trivial method.
*
*****************************************************************/

void
FsqrF(z, x)
	register pFloat z;
	register const Float *x;
{
	long		ex = x->e - Flength(x);
	if (z != x) 
		IasI(&(z->m), &(x->m));
	ImuasI(&(z->m), &(z->m));
	z->e = (ex << 1) + Flength(z);
	Fnormalize(z);
}

/*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FsqrF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *z
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : z = z ^ 2 in time O(t^log3) where t
*                   the precision, using the trivial method.
*
*****************************************************************/

void
Fsqr(z)
	register pFloat z;
{
	long		ez = z->e - Flength(z);
	ImuasI(&(z->m), &(z->m));
	z->e = (ez << 1) + Flength(z);
	Fnormalize(z);
}

/*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFpowF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *z, *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : z = x ^ y in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
FasFpowF(z, x, y)
	register pFloat z;
	register const Float *x, *y;
{
	if (Fis0(y)) {
		Fasdbl(z, 1.0);
		return;
	}
	if (!x->m.sign) {
		Flog(z, x);
		FmuasF(z, y);
		Fexp(z, z);
	} else {
		/**
		** This is a bug: in this place should stay
		** a Float to Rational conversion. At the
		** moment we just truncate y and give a non
		** reliable result
	   	**/

		Float           yc;
		cFasF(&yc, y);
		Ftrunc(&yc, &yc);
		FasFpowF(z, x, &yc);
		z->m.sign = (yc.m.vec[0] & 1);
		dF(&yc);
	}
}

/*****************************************************************
*
* filename        : trans1.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFpowF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x, *a, int n
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = a ^ n in time O(log(n) t^log3) where t
*                   the precision,  using the binary method.
*
*****************************************************************/

void
FasFpowint(x, a, n)
	register pFloat x;
	register const Float *a;
	register int    n;
{
	Float           y, h;
	int             m;

	if (n == 0) {
		Fasdbl(x, 1.0);
		return;
	}
	cF(&h);
	Fasint(x, 1);

	if (n < 0) {
		m = -n;
		cF(&y);
		FasintdiF(&y, 1, a);
	} else {
		m = n;
		cFasF(&y, a);
	}

	while (m > 0) {
		if (m % 2 == 1)
			FmuasF(x, &y);
		FasF(&h, &y);
		FmuasF(&y, &h);
		m >>= 1;
	}

	dF(&y);
	dF(&h);
}
