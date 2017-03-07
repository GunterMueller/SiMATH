/*C
			PAFmul( )

	"Papanikolaou floating point package: multiplication"
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmuF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod, *x, *y
* return value    : void
* extern          : Fnormalize(), Israsint(), Islasint(),
*                   IasImuI()
* error messages  : none
* side effects    : none
* algorithm       : prod = x * y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FmuasF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod, *y
* return value    : void
* extern          : Fnormalize(), Israsint(), Islasint(), ImuasI()
* error messages  : none
* side effects    : none
* algorithm       : prod *= y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmuint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod,*x int i
* return value    : void
* extern          : Fnormalize(), IasImuD()
* error messages  : none
* side effects    : none
* algorithm       : prod = x * i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fmuasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod, int i
* return value    : void
* extern          : Fnormalize(), ImuasD()
* error messages  : none
* side effects    : none
* algorithm       : prod *= i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmu10
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod,*x int i
* return value    : void
* extern          : Fnormalize(), Ias1(), ImuasD(), ImuasI()
* error messages  : none
* side effects    : none
* algorithm       : prod = x * 10^i in time O(t^log(3)) where t
*                   the precision
*
*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmu10
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod, int i
* return value    : void
* extern          : ImuasD()
* error messages  : none
* side effects    : none
* algorithm       : prod *= 10^i in time O(t^log(3)) where t
*                   the precision
*
C*/
/*H
	Version  1      17.07.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFmul        : 931130
H*/                                                             

#include<_PAFarith.h>      


/*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmuF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod, *x, *y
* return value    : void
* extern          : Fnormalize(), Israsint(), Islasint(),
*                   IasImuI()
* error messages  : none
* side effects    : none
* algorithm       : prod = x * y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************/

void
FasFmuF(prod, x, y)
	register pFloat prod;
	register const Float *x, *y;
{
	long ex = x->e - Flength(x), ey = y->e - Flength(y);
	IasImuI(&(prod->m), &(x->m), &(y->m));
	prod->e = ex + ey + Flength(prod); 
	Fnormalize(prod);
}

/*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FmuasF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod, *y
* return value    : void
* extern          : Fnormalize(), Israsint(), Islasint(), ImuasI()
* error messages  : none
* side effects    : none
* algorithm       : prod *= y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************/

void
FmuasF(prod, y)
	register pFloat prod;
	register const Float *y;
{
	long ex = prod->e - Flength(prod), ey = y->e - Flength(y);
	ImuasI(&(prod->m), &(y->m));
	prod->e = ex + ey + Flength(prod); 
	Fnormalize(prod);
}

/*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmuint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod,*x int i
* return value    : void
* extern          : Fnormalize(), IasImuP()
* error messages  : none
* side effects    : none
* algorithm       : prod = x * i in time O(t) where t the precision
*
*****************************************************************/

void
FasFmuint(prod, x, i)
	register pFloat prod;
	register Float const *x;
	register int    i;
{
	DigitType absi = abs(i);

	IasImuD(&(prod->m), &(x->m), absi);
	prod->e = x->e + Flength(prod) - Flength(x);
	prod->m.sign = (i < 0) ? !x->m.sign : x->m.sign;
	Fnormalize(prod);
}

/*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fmuasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod, int i
* return value    : void
* extern          : Fnormalize(), ImuasP()
* error messages  : none
* side effects    : none
* algorithm       : prod *= i in time O(t) where t the precision
*
*****************************************************************/

void
Fmuasint(prod, i)
	register pFloat prod;
	register int    i;
{
	DigitType absi = abs(i);
	long	lprod = Flength(prod);
			
	ImuasD(&(prod->m), absi);
	if (i < 0)
		prod->m.sign = !prod->m.sign;
	prod->e += Flength(prod) - lprod; 
	Fnormalize(prod);
}

/*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmu10
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod,*x int i
* return value    : void
* extern          : Fnormalize(), Ias1(), ImuasP(), ImuasI()
* error messages  : none
* side effects    : none
* algorithm       : prod = x * 10^i in time O(t^log(3)) where t
*                   the precision
*
*****************************************************************/

void
FasFmu10(prod, x, i)
	register pFloat prod;
	register const Float *x;
	register int    i;
{
	long            j, q, r;
	long    	lx = Flength(x);
	if (x->m.length) {
		Ias1(&(prod->m));
		q = abs(i);
		r = q % 9;
		for (j = 0; j < r; j++)
			ImuasD(&(prod->m), 10);
		q -= r;
		while (q > 0) {
			ImuasD(&(prod->m), BigPow10);
			q -= LogPow10;
		}
		ImuasI(&(prod->m), &(x->m));
		prod->e = x->e + Flength(prod) - lx;
	} else {
		prod->m.length = 0;
		prod->m.sign = PLUS;
		prod->e = -BinPrec;
	}
}

/*****************************************************************
*
* filename        : mul.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmu10
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *prod, int i
* return value    : void
* extern          : ImuasP()
* error messages  : none
* side effects    : none
* algorithm       : prod *= 10^i in time O(t^log(3)) where t
*                   the precision
*
*****************************************************************/

void
Fmuas10(prod, i)
	register pFloat prod;
	register int    i;
{
	long            j, q, r;
	long		lprod = Flength(prod);
	if (prod->m.length) {
		q = abs(i);
		r = q % 9;
		for (j = 0; j < r; j++)
			ImuasD(&(prod->m), 10);
		q -= r;
		while (q > 0) {
			ImuasD(&(prod->m), BigPow10);
			q -= LogPow10;
		}
		prod->e += Flength(prod) - lprod;
	} else {
		prod->m.length = 0;
		prod->m.sign = PLUS;
		prod->e = -BinPrec;
	}
}
