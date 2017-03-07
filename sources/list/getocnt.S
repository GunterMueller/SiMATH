/* DOC_SKIP */
/* (MACRO) */
/*M
.SH NAME
getocnt - get output-counter

.SH SYNOPSIS
.nf
#include<_list.h>

single getocnt(pf)  
FILE *pf;

.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.
.PP
getocnt returns the output-counter of the current output line of *pf.
 
M*/
                    
/*H
	Version 1       27.03.1987      R. Boeffgen
	Version 2	02.11.1993	"MACRO" in 1. Zeile geschrieben, damit
					srctrans die Datei nicht uebersetzt.  PS
   DATE getocnt       : 890501.9112__.931130
H*/



/*** getocnt steht auf der Datei xfputc.S. ***/
/***       Bitte dort nachsehen !!!        ***/
