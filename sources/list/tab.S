/*M
.SH NAME
tab - tabulator (MACRO)

.SH SYNOPSIS
.nf
#include<_list.h>
 
single tab(n)  
single n;
  
.SH DESCRIPTION
For MARGIN < n <= LN-SIZE,
tab fills the actual line with blank up to the n-th column, else tab has no effect. 
tab returns 0 by success and ERROR else.

M*/

/*H
	Version 1       04.03.1987      R.Boeffgen
	Version 2       01.04.1987      Kommentar verbessert MAR.
	Version 3	18.11.94	Macro nur noch im Header definiert. MP
   DATE tab           : 890501.941201
H*/
/*
	For the definition of tab please refer to the header file _list.h.
*/
