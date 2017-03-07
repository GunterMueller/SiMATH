/*C
			PAFcomp ( )

	"Papanikolaou floating point package: comparisons"
*
* filename        : comp.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FeqF, FneF, FgtF, FgeF, FltF, FleF, Feq0,
*                   Fis0, Fne0, Fgt0, Fge0, Flt0, Fle0, FcompF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declarations
* return value    : void
* extern          : Fnormalize(), Flength(), IeqI(), IgtI()
* error messages  : none
* side effects    : none
* algorithm       : comparisons of arguments in time O(log(t))
*                   where t the precision of the smallest argu
*                   ment
*
C*/
/*H
	Version  1      17.07.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFcomp       : 931130
H*/                                                             

#include<_PAFarith.h>      


/*****************************************************************
*
* filename        : comp.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FeqF, FneF, FgtF, FgeF, FltF, FleF, Feq0,
*                   Fis0, Fne0, Fgt0, Fge0, Flt0, Fle0, FcompF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : see function declarations
* return value    : void
* extern          : Fnormalize(), Flength(), IeqI(), IgtI()
* error messages  : none
* side effects    : none
* algorithm       : comparisons of arguments in time O(log(t))
*                   where t the precision of the smallest argu
*                   ment
*
*****************************************************************/

BOOLEAN
FeqF(x, y)
	const Float    *x, *y;
{
	if (!x->m.length)
		return (!y->m.length);
	if (!y->m.length)
		return (!x->m.length);
	Fnormalize(x);
	Fnormalize(y);
	return ((x->e) == (y->e) && IeqI(&(x->m), &(y->m)));
}

BOOLEAN
FneF(x, y)
	const Float    *x, *y;
{
	return !FeqF(x, y);
}

BOOLEAN
FgtF(x, y)
	const Float    *x, *y;
{
	register long   ex, ey, s;
	BOOLEAN         j;

	if (!x->m.length)
		return Flt0(y);
	if (!y->m.length)
		return Fgt0(x);

	if (!(s = x->m.sign - y->m.sign)) {
		Fnormalize(x);
		Fnormalize(y);
		if ((ex = x->e) == (ey = y->e))
			return IgtI(&(x->m), &(y->m));
		j = (ex > ey);
		if (x->m.sign)
			j = !j;
		return j;
	} else
		return (s < 0);
}

BOOLEAN
FgeF(x, y)
	const Float    *x, *y;
{
	return (FeqF(x, y) || FgtF(x, y));
}

BOOLEAN
FltF(x, y)
	const Float    *x, *y;
{
	return FgtF(y, x);
}

BOOLEAN
FleF(x, y)
	const Float    *x, *y;
{
	return (FeqF(x, y) || FgtF(y, x));
}

BOOLEAN
Feq0(x)
	const Float    *x;
{
	return (!x->m.length);
}

BOOLEAN
Fis0(x)
	const Float    *x;
{
	return (!x->m.length || (x->e < -BinPrec + 96));
}

BOOLEAN
Fne0(x)
	const Float    *x;
{
	return (x->m.length > 0);
}

BOOLEAN
Fgt0(x)
	const Float    *x;
{
	return (!x->m.sign && x->m.length);
}

BOOLEAN
Fge0(x)
	const Float    *x;
{
	return (!x->m.sign);
}

BOOLEAN
Flt0(x)
	const Float    *x;
{
	return x->m.sign;
}

BOOLEAN
Fle0(x)
	const Float    *x;
{
	return (x->m.sign && !x->m.length);
}

BOOLEAN
FcompF(x, y)
	const Float    *x;
	const Float    *y;
{
	if (FltF(x, y))
		return -1;
	return FgtF(x, y);
}
