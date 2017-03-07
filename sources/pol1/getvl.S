/*M
.SH NAME
getvl - get variable list

.SH SYNOPSIS
.nf
#include<_pol1.h>

list getvl();

.SH DESCRIPTION
getvl read a list V of variable names from stdin.
The variable names must be seperated by Blank, ',' or ';', the end of the list must be marked by '#'.
The first character of a variable's name must be a letter, all other characters
must be alphanumeric.
getvl returns the list V by success, ERROR else.
 
.SH SEE ALSO
pmaklvl

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getvl         : 890501.9301__.941201
H*/
/*
	For the definition of getvl please refer to the header file _pol1.h.
*/
