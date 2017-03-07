/*C
			PAFassign ( )

	"Papanikolaou floating point package: assignments"
*
* filename        : assign.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasF, FasI, Fasdbl, Fasint, Fas1, Fas0, IasF,
*                   dblasF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declaration
* return value    : void
* extern          : cFmaxlength(), dF(), Feq0(), Fnorm(), Frndtoi(),
*                   IasI(), Iasint(), Islasint(), frexp()
* error messages  : dblasF: Impossible assignment double = Float!
* side effects    : none
* algorithm       : x = y in time O(log(t)) where t the precision
*                   of y
*
C*/
/*H
	Version  1      17.08.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFassign     : 931130
H*/                                                             

#include<_PAFarith.h>      


/*****************************************************************
*
* filename        : assign.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasF, FasI, Fasdbl, Fasint, Fas1, Fas0, IasF,
*                   dblasF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declaration
* return value    : void
* extern          : cFmaxlength(), dF(), Feq0(), Fnorm(), Frndtoi(),
*                   IasI(), Iasint(), Islasint(), frexp()
* error messages  : dblasF: Impossible assignment double = Float!
* side effects    : none
* algorithm       : x = y in time O(log(t)) where t the precision
*                   of y
*
*****************************************************************/

void
FasF(x, y)
	register Float *x;
	register const Float *y;
{
	IasI(&(x->m), &(y->m));
	x->e = y->e;
}

void
FasI(x, y)
	register Float *x;
	register const Integer *y;
{
	IasI(&(x->m), y);
	x->e = Flength(x);
}


/* #ifdef USE_SLOW_FASDBL*/

void 
Fasdbl(x, d)
	register Float *x;
	register double d;
{
	char            s[32];
	sprintf(s, "%1.15e", d);
	atoF(s, x);
}
/*#endif*/


#ifdef USE_IEEE_FASDBL
void
Fasdbl(x, d)
	register pFloat x;
	register double d;
{
	long           *mantisse, exponent;
	double          fraction;
	if (d == 0.0) {
		x->m.length = x->m.sign = PLUS;
		x->e = -BinPrec;
	} else {
		fraction = frexp(d, &exponent);
		mantisse = (long *) &fraction;
		x->m.length = 2;
		x->m.sign = (d < 0);
		x->m.vec[1] = (mantisse[0] & 0x000fffff) | 0x00100000;
		x->m.vec[0] = mantisse[1];
		x->e = exponent;
	}
}
#endif

#ifdef USE_PORTABLE_FASDBL

void
Fasdbl(x, d)
pFloat          x;
        double          d;
{
        DigitType       m;
        long            ex;
        int             i;

        if (d == 0) {
                x->m.length = 0;
                x->m.sign = PLUS;
                x->e = -BinPrec;
                return;
        }
        if (d < 0) {
                x->m.sign = MINUS;
                d = -d;
        } else
                x->m.sign = PLUS;
        x->m.length = DigitsPerDouble;
        d = frexp(d, &ex);
	for (i = 0; i < DigitsPerDouble; i++) {
                d = ldexp(d, BitsPerDigit);
                m = (DigitType) d;
                d -= m;
                x->m.vec[DigitsPerDouble - i - 1] = m;
        }
        i = ex;
        if (i > 0) {
                x->e = -i;
                i += BitsPerDigit - ((x->e) % BitsPerDigit);
                Islasint(&(x->m), i);
        } else
                x->e = i;
}
#endif

void
Fasint(x, i)
	register Float *x;
	int             i;
{
	Iasint(&(x->m), i);
	x->e = BitsPerDigit - Flead0s(x->m.vec[0]);
}

void
Fas1(x)
	register Float *x;
{
	x->m.length = 1;
	*(x->m.vec) = 1;
	x->m.sign = PLUS;
	x->e = 1;
}

void
Fas0(x)
	register Float *x;
{
	x->m.length = x->m.sign = PLUS;
	x->e = -BinPrec;
}

void
IasF(x, y)
	register pInteger x;
	register const Float *y;
{
	Float           copy;
	cFmaxlength(&copy, y->m.length);
	Frndtoi(&copy, y);
	IasI(x, &copy.m);
	dF(&copy);
}

void
dblasF(d, x)
	double         *d;
	register const Float *x;
{
	double          y, ma;
	long            ex, s;
	unsigned long   x0, x1;

	if (x->m.length == 0 || x->e < -1023) { *d = 0.0; return; }

	s = ((x->m.sign) ? -1 : 1);

	Fnorm(x);
	if (x->m.length < 2)
		Islasint(&(x->m), BitsPerDigit);

	if (x->e >= 0x3ff) {
		Ferror("Impossible assignment double = Float!");
		return;
	}

	x0 = (unsigned long) (x->m.vec[(x->m.length) - 1]);
	ma = ldexp((double) x0, BitsPerDigit);
	x1 = (unsigned long) (x->m.vec[(x->m.length) - 2]);
	ma += (double) x1;
	y = ldexp(2.0, -65 + x->e);
	if (s < 0)
		(*d) = -1.0 * y * ma;
	else
		(*d) = y * ma;
}
