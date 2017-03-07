/*C
			PAFtrans2( )

	"Papanikolaou floating point package: transcendental functions 2"

*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fe
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = e = exp(1) using the modified Taylor series 
*                   in time O(t) where t the precision
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fpi
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = pi using the Ramanujans series for
*                   1/(2 pi sqrt(2)) in time O(t) where t the
*                   precision
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fpi1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = pi using Chudnovskys series for 1/pi,
*                   Lecture Notes in Pure and applied Mathematics,
*                   Vol. 113, Computer Algebra in time O(t) where
*                   t the precision
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Feuler
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = gamma using Brent's method in time O(t^2). See
*                   Some new Algorithms for High-Precision Calcu-
*                   lation of Euler's constant, Mathematics of
*                   Computation, Vol. 34, Number 149, Jan. 1980
*                   Pages 305-312
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fcatalan
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = catalan using Cauley Platform Method
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fbesselj
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x, int n
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = Jn(x) in time O(t^2) using the series
*                   expansion
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsin
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fsin needs a real argument!
* side effects    : none
* algorithm       : y = sin(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fcos
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fcos needs a real argument!
* side effects    : none
* algorithm       : y = cos(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ftan
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Ftan needs a real argument!
* side effects    : none
* algorithm       : y = tan(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fcot
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fcot needs a real argument!
* side effects    : none
* algorithm       : y = cot(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsinh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = sinh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fcosh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = cosh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ftanh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = tanh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fcoth
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = coth(x) in time O(sqrt(t) t^log3) where t
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
   DATE PAFtrans2     : 931130
H*/                                                             

#include<_PAFarith.h>      


Float           F_e;
Float           F_pi;
Float           F_euler;
Float           F_catalan;

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fe
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = e = exp(1) using the modified Taylor series
*                   in time O(t) where t the precision
*
*****************************************************************/

#define	INVLN2	1.44269504088896340737	/* 1/log(2) */

void
Fe(x)
	register pFloat x;
{
	Float           fac;
	double          f, t;
	int             i, n;

	if (!F_e.m.vec)
		cF(&F_e);
	if (F_e.m.length >= Prec) {
		FasF(x, &F_e);
		Fnormalize(x);
	} else {
		n = 2;
		f = 0.0;
		t = BinPrec - 96.0;
		while (f < t) {
			f += log((double) n) * INVLN2;
			n++;
		}
		n -= 2;
		Fasint(x, 1 + n);
		cFasint(&fac, n);

		for (i = 1; i < n; i++) {
			ImuasD(&fac.m, n - i);
			IplasI(&(x->m), &fac.m);
		}

		x->e = Flength(x);
		fac.e = Flength(&fac);
		FdiasF(x, &fac);
		FasF(&F_e, x);

		dF(&fac);
	}
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fpi
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = pi using the Ramanujans series for
*                   1/(2 pi sqrt(2)) in time O(t*t^log3) where t
*                   the precision
*
*****************************************************************/

void
Fpi1(x)
	register pFloat x;
{
#define l0  96059601
#define l1  1103
#define l2  26390
#define lc  26.5174264803184	/* log2(l0) */

	Float           term;
	unsigned long   n, m, s, p, i = 0, t = BinPrec;

	if (!F_pi.m.vec)
		cF(&F_pi);
	if (F_pi.m.length >= Prec) {
		FasF(x, &F_pi);
		Fnormalize(x);
	} else {
		n = (t - 96) / lc;
		m = 4 * n - 1;
		p = l1 + n * l2;
		cFasint(&term, p);
		while (n) {
			FasFdiint(&term, &term, l0);
			s = m >> 1;
			if (m < 1625) {
				ImuasD(&term.m, s * m * (m - 2));
				s++;
				m++;
				IdiasD(&term.m, s * m * m);
			} else if (m < 46341) {
				ImuasD(&term.m, s);
				ImuasD(&term.m, m * (m - 2));
				s++;
				m++;
				IdiasD(&term.m, s);
				IdiasD(&term.m, m * m);
			} else {
				ImuasD(&term.m, s);
				ImuasD(&term.m, m);
				ImuasD(&term.m, m - 2);
				s++;
				m++;
				IdiasD(&term.m, s);
				IdiasD(&term.m, m);
				IdiasD(&term.m, m);
			}
			p -= l2;
			Fasint(x, p);
			BinPrec = 104 + i * lc;
			FasFplF(&term, &term, x);
			m -= 5;
			n--;
			i++;
		}
		FasFdiint(&term, &term, 9801);
		Fasdbl(x, 8.0);
		Fsqrt(x, x);
		FmuasF(&term, x);
		BinPrec = t;
		FasintdiF(x, 1, &term);
		FasF(&F_pi, x);
		dF(&term);
	}
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fpi
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = pi using the Chudnovskys series for 1/pi,
*                   Lecture Notes in Pure and applied Mathematics,
*                   Vol. 113, Computer Algebra in time O(t*t^log3)
*                   where t the precision
*
*****************************************************************/

void
Fpi(x)
	register pFloat x;
{
	long            l, n, n1, hprec = BinPrec, prec;
	double          alpha;
	Float           p1, p2, p3, h;

#define k1     545140134
#define k2     13591409
#define k3     640320
#define alpha2 1.4722004

	if (!F_pi.m.vec)
		cF(&F_pi);
	if (F_pi.m.length >= Prec) {
		FasF(x, &F_pi);
		Fnormalize(x);
	} else {
		prec = Prec;
		cFasint(&p1, k1);
		cF(&p2);
		cF(&p3);
		cF(&h);

		n = 1 + (prec - 3) / alpha2;
		n1 = 6 * n - 1;

		FasFmuint(&h, &p1, n);
		FasFplint(&p2, &h, k2);
		FasF(&p1, &p2);
		if (prec >= 4)
			l = 4;
		else
			l = prec;
		alpha = l;
		BinPrec = l << LogDigit;

		while (n) {
			if (n > 1290) {
				if (n1 > 46340) {
					FasFmuint(&h, &p1, n1 - 2);
					Fmuasint(&h, n1);
					Fmuasint(&h, n1 - 4);
					Fdiasint(&h, n * n);
					FasFdiint(&p3, &h, n);
				} else {
					FasFmuint(&h, &p1, n1 * (n1 - 2));
					Fmuasint(&h, n1 - 4);
					Fdiasint(&h, n * n);
					FasFdiint(&p3, &h, n);
				}
			} else {
				FasFmuint(&h, &p1, n1 * (n1 - 2));
				Fmuasint(&h, n1 - 4);
				FasFdiint(&p3, &h, n * n * n);
			}
			Fdiasint(&p3, 100100025);
			Fdiasint(&p3, 327843840);
			Fplasint(&p2, -k1);
			FasFmiF(&p1, &p2, &p3);
			alpha += alpha2;
			l = 1 + alpha;
			if (l > prec)
				l = prec;
			BinPrec = l << LogDigit;
			n--;
			n1 -= 6;
		}
		FasintdiF(x, 53360, &p1);
		Fasint(&h, k3);
		Fsqrt(&h, &h);
		FmuasF(x, &h);
		BinPrec = hprec;
		FasF(&F_pi, x);
		dF(&p1);
		dF(&p2);
		dF(&p3);
		dF(&h);
	}
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fpi
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = gamma using Brent's method in time O(t^2). See
*                   Some new Algorithms for High-Precision Calcu-
*                   lation of Euler's constant, Mathematics of
*                   Computation, Vol. 34, Number 149, Jan. 1980
*                   Pages 305-312
*
*****************************************************************/

void
Feuler(y)
	register Float *y;
{
	long            l, n, k, x, xx;
	Float           u, v, a, b, c, t;

	if (!F_euler.m.vec)
		cF(&F_euler);
	if (F_euler.m.length >= Prec) {
		FasF(y, &F_euler);
		Fnormalize(y);
	} else {
		l = Prec;
		cFmaxlength(&u, l);
		cFmaxlength(&v, l);
		cFmaxlength(&a, l);
		cFmaxlength(&b, l);
		cFmaxlength(&c, l);
		cFmaxlength(&t, l);

		x = 1 + 8 * (l - 3) * LOG2;
		xx = x * x;
		n = 1 + 3.591 * x;

		Fasint(&a, x);
		Flog(&u, &a);
		u.m.sign = MINUS;
		FasF(&a, &u);
		Fasint(&b, 1);
		Fasint(&v, 1);

		for (k = 1; k <= n; k++) {
			Fmuasint(&b, xx);
			Fdiasint(&b, k * k);
			Fmuasint(&a, xx);
			Fdiasint(&a, k);
			FasFplF(&c, &a, &b);
			FasFdiint(&a, &c, k);
			FasF(&t, &u);
			FasFplF(&u, &t, &a);
			FasF(&t, &v);
			FasFplF(&v, &t, &b);
		}
		FasFdiF(y, &u, &v);
		FasF(&F_euler, y);
		dF(&u);
		dF(&v);
		dF(&a);
		dF(&b);
		dF(&c);
	}
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fcatalan
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : x = catalan using Brent's method
*
*****************************************************************/

void
Fcatalan(y)
	register pFloat y;
{
	Float           term, p, temp;
	unsigned long   i = 1, j = 3;
	if (!F_catalan.m.vec)
		cF(&F_catalan);
	if (F_catalan.m.length >= Prec) {
		FasF(y, &F_catalan);
		Fnormalize(y);
	} else {
		Fasdbl(y, 0.5);
		cFasdbl(&term, 0.5);
		cFasdbl(&p, 0.5);
		cFmaxlength(&temp, Prec);
		while (!Fis0(&term)) {
			Fmuasint(&p, i);
			Fdiasint(&p, j);
			Fmuasint(&term, i);
			Fdiasint(&term, j);
			FasFdiint(&temp, &p, j);
			FasFplF(&term, &term, &temp);
			FasFplF(y, y, &term);
			i++;
			j += 2;
		}
		FasF(&F_catalan, y);
		dF(&term);
		dF(&p);
		dF(&temp);
	}
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fbesselj
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x, int n
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = Jn(x) in time O(t^2) using the series
*                   expansion
*
*****************************************************************/

void
Fbesselj(y, n, x)
	register pFloat y;
	register int    n;
	register const Float *x;
{
	Float           e, f, s;
	long            i, m = 0, ex, z = BinPrec, t;

	if (n < 0) {
		n = -n;
		if (n % 2)
			m = 1;
	}
	cFasint(&f, 1);
	for (i = 2; i <= n; i++)
		Fmuasint(&f, i);
	t = z;
	ex = x->e;
	if (ex > z)
		BinPrec = z = ex;
	FasFpowint(y, x, n);
	Fsrasint(y, n);
	FdiasF(y, &f);
	ex = z + abs(y->e);
	BinPrec = ex + BitsPerDigit - (ex % BitsPerDigit);
	FasF(&f, y);

	Fasint(y, 1);
	cFasint(&e, 1);
	cFasF(&s, x);
	s.m.sign = MINUS;
	FmuasF(&s, x);
	s.e -= 2;

	i = 1;
	for (;;) {
		FmuasF(&e, &s);
		Fdiasint(&e, i);
		Fdiasint(&e, n + i);
		if (Fis0(&e))
			break;
		FasFplF(y, y, &e);
		i++;
	}
	BinPrec = t;
	FmuasF(y, &f);
	if (m)
		y->m.sign = !y->m.sign;

	dF(&e);
	dF(&f);
	dF(&s);
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsin
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fsin needs a real argument!
* side effects    : none
* algorithm       : y = sin(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Fsin(y, x)
	register pFloat y;
	const Float    *x;
{
	Float 		p0;
	long            ex, t = Prec;
	ex = x->e;
	if (ex <= 0) {
		Fcos(y, x);
		cFasF(&p0, y);
		Fplasint(&p0, 1);
		if (BinPrec < (y->m.length << LogDigit))
			BinPrec = y->m.length << LogDigit;
		ex = -ex;
		BinPrec += 2 * (ex + BitsPerDigit - ex % BitsPerDigit);
		Prec = BinPrec >> 5;
		Fplasint(y, -1);
		y->m.sign = !y->m.sign;
		Prec = t;
		BinPrec = t << LogDigit;
		Fnormalize(y);
		FmuasF(y,&p0);
		Fsqrt(y,y);
		dF(&p0);
		return;
	}
	Fpi(&F_pi);
	F_pi.e--;
	FasFplF(y, x, &F_pi);
	F_pi.e++;
	Fcos(y, y);
	y->m.sign = !y->m.sign;
	Prec = t;
	BinPrec = t << LogDigit;

}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fcos
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fcos needs a real argument!
* side effects    : none
* algorithm       : y = cos(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/


void
Fcos(y, x)
	register pFloat y;
	const Float    *x;
{
	Float           p0, tmp;
	double          d, df;
	long            ex, f, s = 0, t = Prec;
	long            i, j, k, n, s1, t0, t1, t2;

        /**
        ** test for zero
        **/

	if (!x->m.length) {
		Fasdbl(y, 1.0);
		return;
	}
        
        /**
        ** p0 = x; increase the precision to BinPrec + log2(p0)
        **/

	cFasF(&p0, x);
	ex = p0.e;
	if (ex > 0) {
		BinPrec += ex + BitsPerDigit - ex % BitsPerDigit;
		Prec = BinPrec >> 5;
	}
      
        /**
        ** normalize p0 and set p0 = abs(p0)
        **/

	Fnormalize(&p0);
	p0.m.sign = PLUS;

        /**
        ** calculate pi and reduce p0 according to the equation
        **     cos(p0) = cos(p0' + k pi) = (-1)^k cos(p0')
        **/

	Fpi(y);
	if (FgeF(&p0, &F_pi)) { 
		FasFdiF(y, &p0, &F_pi);
		Ftrunc(y, y);
		s = y->m.vec[0] & 1;
		FmuasF(y, &F_pi);
		FmiasF(&p0, y);
	} 

	/**
	** calculate ex = log2(p0) exactly (as double); the calculate the
        ** reduction range k and find the number f of reduction steps needed
        ** so that  
        **     p0 * 2 ^ f     <   p0 * 2 ^ k   =  p0 * 2 ^ (-sqrt(t/4)).
        ** Then reduce p0.
        **/

        ex = log(fabs(p0.m.vec[p0.m.length-1]*1/BigDigit)) + ex*LOG2;
	k = -sqrt(BinPrec / 4.0);
	if (ex > k) {
		n = 1 + sqrt(4.0 * BinPrec);
		f = 1 + ex - k;
		p0.e -= f;
	} else {
		n = 1 + (BinPrec * 1.0) / abs(ex);
		f = 0;
	}

        /**
        ** reduce further the number of steps using a fix-point iteration
        **/ 

	d = 0.0;
	for (i = 2; i <= n; i++)
		d += log((double) i) * INVLOG2;
	i = 0;
	df = i * k + d;
	while (df > 0) {
		i++;
		d -= log((double) n) * INVLOG2;
		df = i * k + d;
		n--;
	}
	n++;

        /**
        ** make n even
        **/

	if (n & 1)
		n++;

        /**
        ** Set p0 = -p0^2, y = 1; then evaluate the taylor series for 
        **           cos(x)-1 = -x^2/2! + x^4/4! -+ ...
        ** using increasing precision at each step
        **/

	FasF(y, &p0);
	FmuasF(&p0, y);
	p0.m.sign = MINUS;
	Fasdbl(y, 1.0);
	cF(&tmp);

        /**
        ** starting precision
        **/

	t1 = - k / BitsPerDigit;
	t1 *= 2;
	t2 = Prec - 2;
	s1 = 0;
	BinPrec = (t1 + 2) << LogDigit;

	for (i = n; i > 2; i -= 2) {
		Fdiasint(y, i * (i - 1));
		j = p0.m.length - t1;
		if (j > 0) {
			IasIsrint(&tmp.m, &p0.m, (j << LogDigit));
			tmp.e = p0.e;
			FmuasF(y, &tmp);
		} else
			FmuasF(y, &p0);
		ex = y->e;
		s1 = s1 - ex;	/* I've seen this in PARI */
		t0 = s1 / BitsPerDigit;
		t1 += t0;
		if (t1 > t2)
			t1 = t2;
		s1 %= BitsPerDigit;
		BinPrec = (t1 + 2) << LogDigit;
		Fplasint(y, 1);
	}
	Fdiasint(y, i * (i - 1));
	FmuasF(y, &p0);

        /**
        ** we have calculated y = cos(x/2^f) - 1. We will calculate now 
        ** cos(x/2^(f-1)) - 1 = 2 * y * (y + 2). y is exact, (y+2) is exact
        ** so the final result (cos(x)-1) is exact. Error can only occur if
        ** x was very near to pi/2.
        **/
  
	if (f) {
		FasFplint(&p0, y, 2);
		for (i = 0; i < f; i++) {
			FmuasF(y, &p0);
			y->e++;
			FasFplint(&p0, y, 2);
		}
	}

	/**
        ** Before adding 1 we check the result for very small y and increase
        ** the precision accordingly so that the final result after the addition
        ** is correct at BinPrec + abs(log2(y)) digits
        **/

	ex = abs(y->e);
	if (ex > BinPrec) {
		BinPrec = ex + BitsPerDigit - ex % BitsPerDigit;
		Prec = BinPrec >> 5;
	}

	Fplasint(y, 1);

	/**
        ** correct the sign and normalize the answer
        **/

	if (s)
		y->m.sign = !y->m.sign;

	/** 
        ** set the old precision
        **/
	
	Prec = t;
	BinPrec = t << LogDigit;

	/**
        ** delete the local variables
        **/

	dF(&p0);
	dF(&tmp);
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Ftan
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Ftan needs a real argument!
* side effects    : none
* algorithm       : y = tan(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Ftan(y, x)
	register pFloat y;
	const Float    *x;
{
	Float           p0;
	long            s = 0, ex, t = Prec;

	ex = x->e;
	if (ex < 0) {
		ex = -ex;
		BinPrec += 4 * (ex + BitsPerDigit - ex % BitsPerDigit);
		Prec = BinPrec >> LogDigit;
	}
	cFasF(&p0, x);
	if (p0.m.sign) {
		s = 1;
		p0.m.sign = PLUS;
	}
	Fpi(y);
	if (FgeF(&p0, &F_pi)) {
		FasFdiF(y, &p0, &F_pi);
		Ftrunc(y, y);
		FmuasF(y, &F_pi);
		FmiasF(&p0, y);
	}
	Fcos(&p0, &p0);
	FasF(y, &p0);
	FmuasF(y, &p0);
	y->m.sign = !y->m.sign;
	FasFplint(y, y, 1);
	Fsqrt(y, y);
	FdiasF(y, &p0);
	if (s)
		y->m.sign = !y->m.sign;
	Prec = t;
	BinPrec = t << LogDigit;

	dF(&p0);
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fcot
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  : Fcot needs a real argument!
* side effects    : none
* algorithm       : y = cot(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Fcot(y, x)
	register pFloat y;
	const Float    *x;
{
	Float           p0;
	long            s = 0, ex, t = Prec;

	ex = x->e;
	if (ex < 0) {
		ex = -ex;
		BinPrec += 4 * (ex + BitsPerDigit - ex % BitsPerDigit);
		Prec = BinPrec >> LogDigit;
	}
	cFasF(&p0, x);
	if (p0.m.sign) {
		s = 1;
		p0.m.sign = PLUS;
	}
	Fpi(y);
	if (FgeF(&p0, &F_pi)) {
		FasFdiF(y, &p0, &F_pi);
		Ftrunc(y, y);
		FmuasF(y, &F_pi);
		FmiasF(&p0, y);
	}
	Fcos(&p0, &p0);
	FasF(y, &p0);
	FmuasF(&p0, y);
	p0.m.sign = !p0.m.sign;
	FasFplint(&p0, &p0, 1);
	Fsqrt(&p0, &p0);
	FdiasF(y, &p0);
	if (s)
		y->m.sign = !y->m.sign;
	Prec = t;
	BinPrec = t << LogDigit;

	dF(&p0);
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): sinh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = sinh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Fsinh(y, x)
	register pFloat y;
	const Float    *x;
{
	Float           temp;
	cFasF(&temp, x);
	Fexp(y, &temp);
	FasintdiF(&temp, 1, y);
	FmiasF(y, &temp);
	y->e--;
	dF(&temp);
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): cosh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = cosh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Fcosh(y, x)
	register pFloat y;
	const Float    *x;
{
	Float           temp;
	cFasF(&temp, x);
	Fexp(y, &temp);
	FasintdiF(&temp, 1, y);
	FasFplF(y, y, &temp);
	y->e--;
	dF(&temp);
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): tanh
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = tanh(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Ftanh(y, x)
	register pFloat y;
	const Float    *x;
{
	Float           temp1, temp2;
	cF(&temp1);
	cF(&temp2);
	Fexp(y, x);
	FasintdiF(&temp1, 1, y);
	FasFplF(&temp2, y, &temp1);
	FmiasF(y, &temp1);
	FdiasF(y, &temp2);
	dF(&temp1);
	dF(&temp2);
}

/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): coth
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *y, *x
* return value    : void
* extern          :
* error messages  :
* side effects    : none
* algorithm       : y = coth(x) in time O(sqrt(t) t^log3) where t
*                   the precision,  using Brent's method.
*                   The algorithm is described in: R.P. Brent, The
*                   Complexity of Multiple-Precision Arithmetic
*                   (in Complexity of Computational Problem Solving,
*                   Univ. of Queensland Press, Brisbane, 1976,
*                   126-165).
*
*****************************************************************/

void
Fcoth(y, x)
	register pFloat y;
	const Float    *x;
{
	Float           temp1, temp2;
	cF(&temp1);
	cF(&temp2);
	Fexp(y, x);
	FasintdiF(&temp1, 1, y);
	FasFmiF(&temp2, y, &temp1);
	FasFplF(y, y, &temp1);
	FdiasF(y, &temp2);
	dF(&temp1);
	dF(&temp2);
}
