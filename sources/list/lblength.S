/*M
.SH NAME
lblength - list bounded length

.SH SYNOPSIS
.nf
#include<_list.h>

single lblength(L)  
list L; 
single b;
 
.SH DESCRIPTION
.TP 4
.B L 
is a list.
.TP 4
.B b
is an integer number, b < BASIS.
.PP
lblength returns 
.IP
min{ lenth(L), b}.

M*/
         
/*H
	Version  1      08.08.1993	 Marc Conrad
   DATE lblength      : 931130
H*/


# include <_list.h>

single lblength(L, b)		/* safe */
	list L;
	single b;
{
	single n = 0;

	while ((n < b) && (L != _0))
		L = lred(L), n++;
	return (n);
}
