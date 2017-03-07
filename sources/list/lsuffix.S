/*M
.SH NAME
lsuffix - list suffix (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>

list lsuffix(L, a)  
list L; 
obj a; 
 
.SH DESCRIPTION
.TP 4
.B L
is a list.
.PP
Let L = (a1, ..., an). lsuffix returns the list
.IP
(a1, ..., an, a).
.PP
L will be changed.

M*/
               
/*H
	Version 1       14.10.1986              R.Boeffgen
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE lsuffix       : 890501.941201
H*/
/*
	For the definition of lsuffix please refer to the header file _list.h.
*/
