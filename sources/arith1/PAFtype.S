/*C
			PAFtype( )

	"Papanikolaou floating point package: typer"
*
* filename        : type.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fisint, Fisuint, Fislong, Fisulong, Fisdbl
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : BOOLEAN
* extern          :
* error messages  :
* side effects    : none
* algorithm       : time O(1)
*
C*/
/*H
	Version  1      19.07.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFtype       : 931130
H*/                                                             

#include<_PAFarith.h>      
/*

*
* filename        : type.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fisint, Fisuint, Fislong, Fisulong, Fisdbl
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : Float *x
* return value    : BOOLEAN
* extern          :
* error messages  :
* side effects    : none
* algorithm       : time O(1)
*
*****************************************************************/

BOOLEAN
Fisint(x)
	const Float    *x;
{
	long            ex = x->e;
	if (Fis0(x))
		return 1;
	return ((ex >= 0) && (ex <= BitsPerDigit));
}

BOOLEAN
Fisuint(x)
	const Float    *x;
{
	long            ex = x->e;
	if (Fis0(x))
		return 1;
	return ((ex >= 0) && (ex <= BitsPerDigit));
}

BOOLEAN
Fislong(x)
	const Float    *x;
{
	long            ex = x->e;
	if (Fis0(x))
		return 1;
	return ((ex >= 0) && (ex <= BitsPerDigit));
}

BOOLEAN
Fisulong(x)
	const Float    *x;
{
	long            ex = x->e;
	if (Fis0(x))
		return 1;
	return ((ex >= 0) && (ex <= BitsPerDigit));
}

BOOLEAN
Fisdbl(x)
	const Float    *x;
{
	long            ex = x->e;
	if (Fis0(x))
		return 1;
	return ((ex <= 0x3ff) && (ex > -1023));
}
