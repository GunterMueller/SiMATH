/*M
.SH NAME
fputs - file put string (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

single fputs(s,pf)  
char *s; 
FILE *pf;
    
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.  
.PP
fputs writes the string s to the file *pf and returns 0 by success and EOF else. 

M*/
           
/*H
	Version 1       24.02.1987      R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE fputs         : 890501.9107__.941201
H*/
/*
	For the definition of fputs please refer to the header file _list.h.
*/
