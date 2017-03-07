/*C
			PAFadd( )
	"Papanikolaou floating point package: addition"
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFplF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum, *x, *y
* return value    : void
* extern          : FasF(), Fnormalize(), Israsint(), Islasint()
*                   IasIplI()
* error messages  : none
* side effects    : none
* algorithm       : sum = x + y in time O(t) where t the precision
*
*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FplasF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum, *y
* return value    : void
* extern          : cFasF(), FasFplF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : sum += y in time O(t) where t the precision
*
*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFplint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum,*x int i
* return value    : void
* extern          : cFasint(), FasFplF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : sum = x + i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fplasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum, int i
* return value    : void
* extern          : cFasint(), FplasF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : sum += i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Finc
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum
* return value    : void
* extern          : Fplasint()
* error messages  : none
* side effects    : none
* algorithm       : sum++ in time O(t) where t the precision
*
*****************************************************************
C*/
/*H
	Version  1      17.09.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFadd        : 931130
H*/                                                             

#include<_PAFarith.h>   

   
/*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFplF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum, *x, *y
* return value    : void
* extern          : FasF(), Fnormalize(), Israsint(), Islasint()
*                   IasIplI()
* error messages  : none
* side effects    : none
* algorithm       : sum = x + y in time O(t) where t the precision
*
*****************************************************************/

#define add_is0(x)  (!x->m.length || (x->e < -BinPrec + 96))

void
FasFplF(sum, x, y)
	register pFloat sum;
	register const Float *x, *y;
{
	Float 		x1, y1;
	long            ed, e1, e2;
	long            ld, lx1, ly1;

	if (add_is0(x)) {
		IasI(&(sum->m), &(y->m));
		sum->e = y->e;
		return;
	}
	if (add_is0(y)) {
		IasI(&(sum->m), &(x->m));
		sum->e = x->e;
		return;
	}
	e1 = x->e;
	e2 = y->e;
	if (e1 < e2) {
		cFasF(&x1, y);
		cFasF(&y1, x);
	} else {
		cFasF(&x1, x);
		cFasF(&y1, y);
	}

	lx1 = Flength(&x1);
	ly1 = Flength(&y1);
	ld = lx1 - ly1;
	if (ld > 0) {
		Islasint(&y1.m, ld);
		ld = lx1;
	} else {
		Islasint(&x1.m, -ld);
		ld = ly1;
	}
	e1 = x1.e - ld;
        e2 = y1.e - ld;

	Islasint(&x1.m, e1-e2);
	IasIplI(&(sum->m), &x1.m, &y1.m);
	sum->e = e2 + Flength(sum);
	Fnormalize(sum);

	dF(&x1);
	dF(&y1);
}

/*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FplasF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum, *y
* return value    : void
* extern          : cFasF(), FasFplF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : sum += y in time O(t) where t the precision
*
*****************************************************************/

void
FplasF(sum, y)
	register pFloat sum;
	register const Float *y;
{
	FasFplF(sum, sum, y);
}

/*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFplint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum,*x int i
* return value    : void
* extern          : cFasint(), FasFplF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : sum = x + i in time O(t) where t the precision
*
*****************************************************************/

void
FasFplint(sum, x, i)
	register pFloat sum;
	register const Float *x;
	register int    i;
{
	Float           small;
	cFasint(&small, i);
	FasFplF(sum, x, &small);
	dF(&small);
}

/*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fplasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum, int i
* return value    : void
* extern          : cFasint(), FplasF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : sum += i in time O(t) where t the precision
*
*****************************************************************/

void
Fplasint(sum, i)
	register pFloat sum;
	register int    i;
{
	Float           small;
	cFasint(&small, i);
	FasFplF(sum, sum, &small);
	dF(&small);
}

/*****************************************************************
*
* filename        : add.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Finc
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *sum
* return value    : void
* extern          : Fplasint()
* error messages  : none
* side effects    : none
* algorithm       : sum++ in time O(t) where t the precision
*
*****************************************************************/

void
Finc(sum)
	register Float *sum;
{
	Float           one;
	cFasint(&one, 1);
	FasFplF(sum, sum, &one);
	dF(&one);
}
