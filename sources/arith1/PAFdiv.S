/*C
			PAFdiv( )

	"Papanikolaou floating point package: division"
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, *x, *y
* return value    : void
* extern          : Fnormalize(), Israsint(), Islasint(),
*                   IasIdiI(), IdiasI(), ImuasI()
* error messages  : none
* side effects    : none
* algorithm       : quot = x / y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiF1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, *x, *y
* return value    : void
* extern          : Fnormalize(), Israsint(), Islasint(),
*                   IasIdiI()
* error messages  : none
* side effects    : none
* algorithm       : quot = x / y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiF1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, *x, *y
* return value    : void
* extern          : cFasF, FasFdiF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : quot /= y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot,*x, int i
* return value    : void
* extern          : Fnormalize(), Islasint(), IasIdiD()
* error messages  : none
* side effects    : none
* algorithm       : quot = x / i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiint1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot,*x, int i
* return value    : void
* extern          : Fnormalize(), Islasint(), IasIdiD()
* error messages  : none
* side effects    : none
* algorithm       : quot = x / i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fdiasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int i
* return value    : void
* extern          : Fnormalize(), Islasint(), IdiasD()
* error messages  : none
* side effects    : none
* algorithm       : quot /= i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fdiasint1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int i
* return value    : void
* extern          : Fnormalize(), Islasint(), IdiasD()
* error messages  : none
* side effects    : none
* algorithm       : quot /= i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasintdiF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int i, Float *x
* return value    : void
* extern          : Fnormalize(), cIasint(), Islasint(), IasIdiI()
*                   dI()
* error messages  : none
* side effects    : none
* algorithm       : quot = i / x in time O(t) where t the precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasintdiF1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int i, Float *x
* return value    : void
* extern          : Fnormalize(), cIasint(), Islasint(), IasIdiI()
*                   dI()
* error messages  : none
* side effects    : none
* algorithm       : quot = i / x in time O(t) where t the precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fasintdiint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int s, int t
* return value    : void
* extern          : Fnormalize(), Iasint(), Islasint(), IdiasD()
* error messages  : none
* side effects    : none
* algorithm       : quot = s / t in time O(t) where t the precision
*
*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fasintdiint1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int s, int t
* return value    : void
* extern          : Fnormalize(), Iasint(), Islasint(), IdiasD()
* error messages  : none
* side effects    : none
* algorithm       : quot = s / t in time O(t) where t the precision
*
C*/
/*H
	Version  1      19.07.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2      20.01.1994      FasFdiF mit quot == x aufrufbar.  MC
   DATE PAFdiv        : 931130.940315
H*/                                                             

#include<_PAFarith.h>      




/*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, *x, *y
* return value    : void
* extern          : Fnormalize(), Israsint(), Islasint(),
*                   IasIdiI(), IdiasI(), ImuasI()
* error messages  : none
* side effects    : none
* algorithm       : quot = x / y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************/

void
FasFdiF(quot, x, y)
	register pFloat quot;
	register const Float *x, *y;
{
	Integer 	r;
	long            t = BinPrec, ex = x->e - Flength(x), 
			ey = y->e - Flength(y);

        if ( quot == x ) FdiasF( x, y ); 
	else {
	Iasint(&(quot->m), 1);
	t += ((y->m.length << LogDigit) + BitsPerDigit);
	Islasint(&(quot->m), t);
	cI(&r);
	Idiv(&(quot->m), &r, &(quot->m), &(y->m));
	dI(&r);
	ImuasI(&(quot->m), &(x->m));
	quot->e = -t + ex - ey + Flength(quot);
	Fnormalize(quot);
	}
}

/*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiF1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, *x, *y
* return value    : void
* extern          : Fnormalize(), Israsint(), Islasint(),
*                   IasIdiI()
* error messages  : none
* side effects    : none
* algorithm       : quot = x / y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************/

void
FasFdiF1(quot, x, y)
	register pFloat quot;
	register const Float *x, *y;
{
	Integer 	r;
	long            t = BinPrec, ex = x->e - Flength(x), 
			ey = y->e - Flength(y);
	t += ((y->m.length << LogDigit) + BitsPerDigit);
	Islasint(&(x->m), t);
	cI(&r);
	Idiv(&(quot->m), &r, &(x->m), &(y->m));
	dI(&r);
	Israsint(&(x->m), t);
	quot->e = -t + ex - ey + Flength(quot);
	Fnormalize(quot);
}

/*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiF1
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, *x, *y
* return value    : void
* extern          : cFasF, FasFdiF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : quot /= y in time O(t^log(3)) where t the
*                   precision
*
*****************************************************************/

void
FdiasF(quot, y)
	register pFloat quot;
	register const Float *y;
{
	Float           copy;
	cFasF(&copy, quot);
	FasFdiF(quot, &copy, y);
	dF(&copy);
}

/*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFdiint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot,*x, int i
* return value    : void
* extern          : Fnormalize(), Islasint(), IasIdiP()
* error messages  : none
* side effects    : none
* algorithm       : quot = x / i in time O(t) where t the precision
*
*****************************************************************/

void
FasFdiint(quot, x, i)
	register pFloat quot;
	register const Float *x;
	register int    i;
{
	long            ex;

	Fnormalize(x);
	Islasint(&(x->m), BitsPerDigit);
	ex = x->e - (x->m.length << LogDigit); 
	IasIdiD(&(quot->m), &(x->m), abs(i));
	Israsint(&(x->m), BitsPerDigit);
	quot->e = ex + Flength(quot);
	if (i < 0)
		quot->m.sign = !quot->m.sign;
	Fnormalize(quot);
}

/*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fdiasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int i
* return value    : void
* extern          : Fnormalize(), Islasint(), IdiasP()
* error messages  : none
* side effects    : none
* algorithm       : quot /= i in time O(t) where t the precision
*
*****************************************************************/

void
Fdiasint(quot, i)
	register pFloat quot;
	register int    i;
{
	long            ex; 

	Fnormalize(quot);
	Islasint(&(quot->m), BitsPerDigit);
	ex = quot->e - (quot->m.length << LogDigit);
	IdiasD(&(quot->m), abs(i));
	quot->e = ex + Flength(quot);
	if (i < 0)
		quot->m.sign = !quot->m.sign;
	Fnormalize(quot);
}

/*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasintdiF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int i, Float *x
* return value    : void
* extern          : Fnormalize(), cIasint(), Islasint(), IasIdiI()
*                   dI()
* error messages  : none
* side effects    : none
* algorithm       : quot = i / x in time O(t) where t the precision
*
*****************************************************************/

void
FasintdiF(quot, i, x)
	register pFloat quot;
	register int    i;
	register const Float *x;
{
	Float           small;
	long            t = BinPrec, ex;

	if (!i) {
		quot->m.length = 0;
		quot->m.sign = PLUS;
		quot->e = -t;
		return;
	} 
	ex = x->e - Flength(x);
	cIasint(&small.m, i);
	t += ((x->m.length << LogDigit) + BitsPerDigit);
	Islasint(&small.m, t);
	IasIdiI(&(quot->m), &small.m, &(x->m));
	quot->e = - t - ex + Flength(quot);
	Fnormalize(quot);
	dI(&small.m);
}

/*****************************************************************
*
* filename        : div.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fasintdiint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *quot, int s, int t
* return value    : void
* extern          : Fnormalize(), Iasint(), Islasint(), IdiasP()
* error messages  : none
* side effects    : none
* algorithm       : quot = i / j in time O(t) where t the precision
*
*****************************************************************/

void
Fasintdiint(quot, i, j)
	register pFloat quot;
	register int    i, j;
{
	long            t = BinPrec, absj; 
                      

	if (!j)
		Ferror("FasFintdiint: division with 0.");
	
	if (!i) {
		quot->m.length = 0;
		quot->m.sign = PLUS;
		quot->e = -t;
		return;
	} 

	absj = abs(j);

	Iasint(&(quot->m), i);
	t += BitsPerDigit;
	Islasint(&(quot->m), t);
	IdiasD(&(quot->m), absj);
	quot->e = -t + Flength(quot);
	if (j < 0)
		quot->m.sign = !quot->m.sign;
	Fnormalize(quot);
}

