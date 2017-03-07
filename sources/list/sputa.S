/*M
.SH NAME
sputa - string put atom (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>
 
char *sputa(a, str)  
atom a; 
char *str;
 
.SH DESCRIPTION
sputa writes the atom a to str and returns a pointer to str. 

.SH CAUTION
sputa does not verify, if str is large enough.

M*/

/*H
	Version 1       26.02.1987      R.Boeffgen
	Version 2       14.08.1991      "sprintf(str,"%d",a)" -> "(...,str)",
					damit auf jeden Fall der Zeiger auf die
					Ergebniszeichenreihe geliefert wird,
					denn auf einigen Rechnern ist sprintf
					nicht vom Typ char* sondern vom Typ int
					und liefert die Anzahl der uebertragenen
					Zeichen zurueck.  PS
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE sputa         : 890501.910915.941201
H*/
/*
	For the definition of sputa please refer to the header file _list.h.
*/
