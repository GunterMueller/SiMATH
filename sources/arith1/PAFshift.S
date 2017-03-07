/*C
			PAFshift( )

	"Papanikolaou floating point package: shifting"
*
* filename        : shift.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFslF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *res, *x, int i
* return value    : void
* extern          : IasI(), Islasint()
* error messages  : none
* side effects    : none
* algorithm       : res = x << i in time O(log(t)) where t the
*                   precision
*
*****************************************************************
*
* filename        : shift.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fslasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *res, int i
* return value    : void
* extern          : Islasint()
* error messages  : none
* side effects    : none
* algorithm       : res <<= i in time O(log(t)) where t the
*                   precision
*
*****************************************************************
*
* filename        : shift.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFsrF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *res, *x, int i
* return value    : void
* extern          : IasI()
* error messages  : none
* side effects    : none
* algorithm       : res = x >> i in time O(log(t)) where t the
*                   precision
*
*****************************************************************
*
* filename        : shift.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsrasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *res, int i
* return value    : void
* extern          : none
* error messages  : none
* side effects    : none
* algorithm       : res >>= i in time O(1)
*
C*/
/*H
	Version  1      02.09.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFshift      : 931130
H*/                                                             

#include<_PAFarith.h>      


/*****************************************************************
*
* filename        : shift.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFslF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *res, *x, int i
* return value    : void
* extern          : IasI(), Islasint()
* error messages  : none
* side effects    : none
* algorithm       : res = x << i in time O(log(t)) where t the
*                   precision
*
*****************************************************************/

void
FasFslint(res, x, i)
	register pFloat res;
	register const Float *x;
	register unsigned int i;
{
	IasI(&(res->m), &(x->m));
	res->e = x->e + i;
}

/*****************************************************************
*
* filename        : shift.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fslasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *res, int i
* return value    : void
* extern          : Islasint()
* error messages  : none
* side effects    : none
* algorithm       : res <<= i in time O(log(t)) where t the
*                   precision
*
*****************************************************************/

void
Fslasint(res, i)
	register pFloat res;
	register unsigned int i;
{
	res->e += i;
}

/*****************************************************************
*
* filename        : shift.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFsrF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *res, *x, int i
* return value    : void
* extern          : IasI()
* error messages  : none
* side effects    : none
* algorithm       : res = x >> i in time O(log(t)) where t the
*                   precision
*
*****************************************************************/

void
FasFsrint(res, x, i)
	register pFloat res;
	register const Float *x;
	register unsigned int i;
{
	IasI(&(res->m), &(x->m));
	res->e = x->e - i;
}

/*****************************************************************
*
* filename        : shift.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsrasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *res, int i
* return value    : void
* extern          : none
* error messages  : none
* side effects    : none
* algorithm       : res >>= i in time O(1)
*
*****************************************************************/

void
Fsrasint(res, i)
	register pFloat res;
	register unsigned int i;
{
	res->e -= i;
}
