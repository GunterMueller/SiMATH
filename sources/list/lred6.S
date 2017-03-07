/*M
.SH NAME
lred6 - list reductum, 6 objects

.SH SYNOPSIS
.nf
#include<_list.h>

list lred6(L)
list L;

.SH DESCRIPTION
.TP 4
.B L
is a list, containing at least 6 objects. L = (a_1, a_2, a_3, a_4, a_5, a_6, a_7 ...)
.PP
lred6 returns the list (a_7, ...) or the empty list, if L = (a_1, a_2, a_3, a_4, a_5, a_6).

M*/

/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       19.12.1988      Unterprogramm statt Macro.  PS
   DATE lred6         : 890501.8910__
H*/



# include <_list.h>

list lred6(L)
list L;
{
	single i;

	for ( i=1 ; i<=6 ; i++ ) L = lred(L);
	return(L);
}
