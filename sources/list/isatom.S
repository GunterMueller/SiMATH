/*M
.SH NAME
isatom - is atom ? (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

single isatom(a)  
obj a;

.SH DESCRIPTION
isatom returns 
.TP 4 
1,
if a is an atom, and
.TP 4
0, 
else.

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
					MAR
	Version 3       10.11.1987      &&1 hinzugefuegt.   RB
	Version 4       02.02.1988      Neufassung.   BW
	Version 5       14.07.1988      gehoert wieder zur srclib.list.
					ist wieder Macro.   PS
	Version 6	18.11.94	Macro nur noch im Header definiert. MP
   DATE isatom        : 890501.941201
H*/
/*
	For the definition of isatom please refer to the header file _list.h.
*/
