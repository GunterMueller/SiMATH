/*C
			PAFglob ( )

	"Papanikolaou floating point package: globals"
*
* filename        : glob.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsetprec
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : long
* return value    : void
* extern          : ceil()
* error messages  : none
* side effects    : none
* algorithm       : sets the precision to t digits in time O(1)
*
C*/
/*H
	Version  1      02.09.1993      Marc Conrad (Anpassung fuer SIMATH)
   DATE PAFglob       : 931130
H*/                                                             

#include<_PAFarith.h>      


/*****************************************************************
*
* filename        : glob.c
* author          : Papanikolaou Thomas
* date            : Mon Feb  8 21:02:40 MET 1993
* function name(s): Fsetprec
* last change     : Mon Feb  8 21:02:40 MET 1993
* arguments       : long
* return value    : void
* extern          : ceil()
* error messages  : none
* side effects    : none
* algorithm       : sets the precision to t digits in time O(1)
*
*****************************************************************/

#ifdef DIGIT16
long            DecPrec = 20;
long            BinPrec = 160;
long            Prec = 10;
#else
long            DecPrec = 20;
long            BinPrec = 160;
long            Prec = 5;
#endif

void
Fsetprec(t)
	register long   t;
{
	if (t > 0) {
		DecPrec = t;
		Prec = 3 + (long) (ceil((t / (L2B10 * BitsPerDigit))));
		BinPrec = BitsPerDigit * Prec;
	} else {
#ifdef DIGIT16
                DecPrec = 20;
                BinPrec = 160;
                Prec = 10;
#else
                DecPrec = 20;
                BinPrec = 160;
                Prec = 5;
#endif
	}
}
