/*M
.SH NAME
fputo - file put object (MACRO)  

.SH SYNOPSIS
.nf
#include<_list.h>

single fputo(a, pf)  
obj a; 
FILE *pf;
   
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.  
.PP
fputo writes the object a to the file *pf and returns 0 by success and ERROR else. 

M*/
        
/*H
	Version 1       04.03.1987      R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputo         : 890501.941201
H*/
/*
	For the definition of fputo please refer to the header file _list.h.
*/
