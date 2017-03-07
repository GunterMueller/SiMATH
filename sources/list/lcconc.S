/*M
.SH NAME
lcconc - list constructive concatenation

.SH SYNOPSIS
.nf
#include<_list.h>

list lcconc(L1, L2)  
list L1, L2;
  
.SH DESCRIPTION
.TP 4
.B L1, L2
are lists.
.PP
lcconc returns the constructive concatenation of L1 and L2.

M*/
       
/*H
	Version  1      23.06.1986     R.Boeffgen
   DATE lcconc        : 890501
H*/


# include <_list.h>

list lcconc ( L1, L2 )   /* unsafe L2 */
list L1,L2;
{
	list L11,L;
	if ( L1 == _0 )  return( L2 );
	if ( L2 == _0 )  return( L1 );
	bind( L2 );
	L11 = lcinv( L1 );
	L = linv( L11 );
	lsred( L11,L2 );
	return( L );
}
