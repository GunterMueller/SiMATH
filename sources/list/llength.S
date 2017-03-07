/*M
.SH NAME
llength - list length

.SH SYNOPSIS
.nf
#include<_list.h>

single llength(L)  
list L;

.SH DESCRIPTION
.Tp 4
.B L
is a list.
.PP
llength returns the length of L.

M*/
               
/*H
	Version  1      08.08.1986      R.Boeffgen
   DATE llength       : 890501
H*/


# include <_list.h>

single llength( L )             /* safe */
list L;
{
	single n = 0;
	while ( L!=_0 )  L=lred(L), n++;
	return( n );
}
