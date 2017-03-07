/*M
.SH NAME
lconc - list concatenation

.SH SYNOPSIS
.nf
#include<_list.h>

list lconc(L1, L2)  
list L1, L2;
  
.SH DESCRIPTION
.TP 4
.B L1, L2
are two lists, say L1 = (a_1, ..., a_n), L2 = (b1, ..., b_m)
.PP
lconc returns the list
.IP
(a_1, ..., a_n, b_1, ..., b_m).
.PP
L1 will be changed !

.SH SEE ALSO
lcconc

M*/
                 
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE lconc         : 890501
H*/


# include <_list.h>

list lconc ( L1, L2 )    /* safe */
list L1,L2;
{
	list L;
	if ( L1 == _0 ) return( L2 );
	if ( L2 == _0 ) return( L1 );
	L = llast( L1 );
	lsred( L,L2 );
	return( L1 );
}
