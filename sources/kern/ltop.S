/*M
.SH NAME
ltop - list to pointer

.SH SYNOPSIS
.nf
#include<_list.h>

PCELL ltop(L)
list L;

.SH DESCRIPTION
ltop() returns the pointer corresponding to list L.
On ILP32 platforms it is provided as macro (see _list.h for definition),
while on LP64 platforms it is provided as function.

M*/
/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       17.08.1987      gehoert ab jetzt zur srclib.kern.
					Ist kein Macro mehr in der Aus=
					lieferungsversion, sondern
					nur noch zum Entwickeln hier.
					( vgl. _kern.h )
					Dadurch wird Geschwindigkeit erhalten
					und dennoch keine Information ueber
					Verankerung der Listen an dritte.
					MAR.
	Version 3       29.08.1991      auch in der Auslieferversion wieder
					Macro.  PS
	Version 4       12.12.1991      im Kommentar "(MACRO)" ergaenzt.  PS
	Version 5	18.11.94	Macro nur noch im Header definiert. MP
   DATE ltop          : 890501.910915.911215.941201
H*/

#include <_list.h>
#ifdef LP64

PCELL ltop(list L) {
    if (L&CELL_MASK)
	return((BL_START[(L&BLOCK_MASK)>>CELL_WIDTH] + (L&CELL_MASK) -1));
    return(NULL);
}
#endif
