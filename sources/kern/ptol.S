/*M
.SH NAME
ptol - pointer to list (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

list ptol(pc, j)
PCELL pc;
single j;

.SH DESCRIPTION
.TP 4
.B pc
is a PCELL i.e. CELL*.
.B j
is the memory block number to which *pc belongs.
.PP
ptol returns the corresponding list to *pc.

M*/
/*C
			ptol(pc, j)                (MACRO)

	"pointer to list"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	!!! wird nur vom System benutzt !!!
	list ptol(pc)  PCELL pc;
	L = ptol(pc);
	L ist die Liste, auf die pc zeigt.
C*/
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
   DATE ptol          : 890501.910915.911215.941201
H*/
/*
	For the definition of ptol please refer to the header file _list.h.
*/
