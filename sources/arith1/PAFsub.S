/*C
			PAFsub( )

	"Papanikolaou floating point package: subtraction"
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmiF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif, *x, *y
* return value    : void
* extern          : FasFplF()
* error messages  : none
* side effects    : none
* algorithm       : dif = x - y in time O(t) where t the precision
*
*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FmiasF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif, *y
* return value    : void
* extern          : cFasF(), FasFplF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : dif -= y in time O(t) where t the precision
*
*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFplint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif,*x int i
* return value    : void
* extern          : cFasint(), FasFplF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : dif = x - i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fmiasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif, int i
* return value    : void
* extern          : cFasint(), FplasF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : dif -= i in time O(t) where t the precision
*
*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fdec
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif
* return value    : void
* extern          : Fplasint()
* error messages  : none
* side effects    : none
* algorithm       : dif-- in time O(t) where t the precision
*
C*/
/*H
	Version  1      19.07.1993      Marc Conrad (Anpassung fuer SIMATH)
	Version  2	09.02.1994	FasFmiF aufrufbar mit x == y.  MC
   DATE PAFsub        : 931130.940315
H*/                                                             

#include<_PAFarith.h>      


/*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFmiF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif, *x, *y
* return value    : void
* extern          : FasFplF()
* error messages  : none
* side effects    : none
* algorithm       : dif = x - y in time O(t) where t the precision
*
*****************************************************************/

void
FasFmiF(dif, x, y)
	register pFloat dif;
	register const Float *x, *y;
{                                             
	if ( x == y ) Fasint( dif, 0 ); 
	else { 
	y->m.sign = !y->m.sign;
	FasFplF(dif, x, y);
	if (dif != y)
		y->m.sign = !y->m.sign;
	}
}

/*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FmiasF
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif, *y
* return value    : void
* extern          : cFasF(), FasFplF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : dif -= y in time O(t) where t the precision
*
*****************************************************************/

void
FmiasF(dif, y)
	register pFloat dif;
	register const Float *y;
{
	y->m.sign = !y->m.sign;
	FasFplF(dif, dif, y);
	y->m.sign = !y->m.sign;
}

/*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): FasFplint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif,*x int i
* return value    : void
* extern          : cFasint(), FasFplF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : dif = x - i in time O(t) where t the precision
*
*****************************************************************/

void
FasFmiint(dif, x, i)
	register pFloat dif;
	register const Float *x;
	register int    i;
{
	Float           small;
	cFasint(&small, -i);
	FasFplF(dif, x, &small);
	dF(&small);
}

/*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fmiasint
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif, int i
* return value    : void
* extern          : cFasint(), FplasF(), dF()
* error messages  : none
* side effects    : none
* algorithm       : dif -= i in time O(t) where t the precision
*
*****************************************************************/

void
Fmiasint(dif, i)
	register pFloat dif;
	register int    i;
{
	Float           small;
	cFasint(&small, -i);
	FasFplF(dif, dif, &small);
	dF(&small);
}

/*****************************************************************
*
* filename        : sub.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fdec
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *dif
* return value    : void
* extern          : Fplasint()
* error messages  : none
* side effects    : none
* algorithm       : dif-- in time O(t) where t the precision
*
*****************************************************************/

void
Fdec(dif)
	register Float *dif;
{
	Float           small;
	cFasint(&small, -1);
	FasFplF(dif, dif, &small);
	dF(&small);
}
