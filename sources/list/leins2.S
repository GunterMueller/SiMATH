/*M
.SH NAME
leins2 - list element insert, 2nd position

.SH SYNOPSIS
.nf
#include<_list.h>

list leins2(a, L)  
obj a; 
list L;
 
.SH DESCRIPTION
.TP 4
.B L
is a list, say L = (a_1, ...,a_n).     
.PP
leins2 returns the list
.IP
(a_1, a, a_2, ..., a_n).
.PP
L will be changed.

M*/
          
/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       10.02.1987      jetzt als function, mit dem neuen L
					als Funktionswert.
   DATE leins2        : 890501
H*/


# include <_list.h>

list leins2 ( a, L )
int a;
list L;
{
	list L1 = lred( L );
	lsred( L , lcomp(a,L1) );
	return( L );
}
