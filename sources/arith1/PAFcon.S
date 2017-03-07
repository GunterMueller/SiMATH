/*C
			PAFcon ( )

	"Papanikolaou floating point package: construction"
*
* filename        : con.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): cF, cFasF, cFasI, cFasdbl, cFasint, cFasuint,
*                   cFaslong, cFasulong, cFmaxlength, dF, ncF,
*                   ncFasF, ncFasI, ncFasdbl, ncFmaxlength, ddF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declarations
* return value    : void or Float *
* extern          :
* error messages  :
* side effects    : none
* algorithm       : construct x in time O(1)
*
C*/
/*H
	Version  1      02.09.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFcon        : 931130
H*/                                                             

#include<_PAFarith.h>      


/*****************************************************************
*
* filename        : trans2.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): cF, cFasF, cFasI, cFasdbl, cFasint, cFasuint,
*                   cFaslong, cFasulong, cFmaxlength, dF, ncF,
*                   ncFasF, ncFasI, ncFasdbl, ncFmaxlength, ddF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declarations
* return value    : void or Float *
* extern          :
* error messages  :
* side effects    : none
* algorithm       : construct x in time O(1)
*
*****************************************************************/

void
cF(x)
	register Float *x;
{
	cI(&(x->m));
	x->e = 0;
}

void
cFasF(x, y)
	register Float *x;
	register const Float *y;
{
	cIasI(&(x->m), &(y->m));
	x->e = y->e;
}

void
cFasI(x, y)
	register Float *x;
	register const Integer *y;
{
	cIasI(&(x->m), y);
	x->e = Flength(x);
}

void
cFasdbl(x, d)
	register Float *x;
	register double d;
{
	cF(x);
	Fasdbl(x, d);
}

void
cFasint(x, i)
	register Float *x;
	register int    i;
{
	cIasint(&(x->m), i);
	x->e = BitsPerDigit - Flead0s(abs(i));
}

void
cFasuint(x, ui)
	register Float *x;
	register unsigned int ui;
{
	cIasuint(&(x->m), ui);
	x->e = BitsPerDigit - Flead0s(ui);
}

void
cFaslong(x, l)
	register Float *x;
	register long   l;
{
	cIaslong(&(x->m), l);
	x->e = BitsPerDigit - Flead0s(abs(l));
}

void
cFasulong(x, ul)
	register Float *x;
	register unsigned long ul;
{
	cIasulong(&(x->m), ul);
	x->e = BitsPerDigit - Flead0s(ul);
}

void
cFmaxlength(x, i)
	register Float *x;
	register int    i;
{
	cImaxlength(&(x->m), i);
	x->e = 0;
}

void
dF(x)
	register Float *x;
{
	dI(&(x->m));
}

Float          *
ncF()
{
	register Float *x;
        x = (Float *) malloc(sizeof(Float));
        cF(x);
        return x;
}

Float          *
ncFasF(y)
	Float          *y;
{
	register Float *x;
        x = (Float *) malloc(sizeof(Float));
        cFasF(x, y);
        return x;
}

Float          *
ncFasI(y)
	Integer        *y;
{
	register Float *x;
        x = (Float *) malloc(sizeof(Float));
        cFasI(x, y);
        return x;
}

Float          *
ncFasdbl(d)
	double          d;
{
	register Float *x;
        x = (Float *) malloc(sizeof(Float));
        cFasdbl(x, d);
        return x;
}

Float          *
ncFasint(i)
	int             i;
{
	register Float *x;
        x = (Float *) malloc(sizeof(Float));
        cFasint(x, i);
        return x;
}

Float          *
ncFmaxlength(i)
	register int    i;
{
	register Float *x;
        x = (Float *) malloc(sizeof(Float));
        cFmaxlength(x, i);
        return x;
}

void
ddF(x)
	Float          *x;
{
	dF(x);
	free((char *) x);
}
