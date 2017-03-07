/*M
.SH NAME
getcs - get character, skipping space (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

single getcs( )       

.SH DESCRIPTION
getcs read a character from stdin and returns it. The following characters will be ignored: blanks, tabs, carriage returns, line feeds and form feeds. In case of an error or end of file, getcs returns EOF. 

M*/
      
/*H
	Version  1      24.02.1987      R.Boeffgen
	Version  2      24.03.1987      Name geaendert.   RB
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE getcs         : 890501.941201
H*/
/*
	For the definition of getcs please refer to the header file _list.h.
*/
