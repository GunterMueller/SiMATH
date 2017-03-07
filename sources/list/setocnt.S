/* DOC_SKIP */
/* (MACRO) */
/*M 
.SH NAME 
setocnt - set output-counter

.SH SYNOPSIS 
.nf 
#include<_list.h>  

single setocnt(pf, n)  
FILE *pf; 
single n;
  
.SH DESCRIPTION 
.TP 4
.B n
is a natural number, 0 <= n < LN_SIZE.
.PP
The value of the output counter of the file *pf will be set to n.
setocnt returns 0 by success and EOF else.

M*/

/*H
	Version 1       26.03.1987      R. Boeffgen
	Version 2	02.11.1993	"MACRO" in 1. Zeile geschrieben, damit
					srctrans die Datei nicht uebersetzt.  PS
   DATE setocnt       : 890501.9112__
H*/



/*** setocnt steht auf der Datei xfputc.S. ***/
/***       Bitte dort nachsehen !!!        ***/
