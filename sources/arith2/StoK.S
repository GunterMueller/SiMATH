/* DOC_SKIP */
/* (MACRO) */

/*M
.SH NAME
StoK - SIMATH to Kant

.SH SYNOPSIS
.nf
#include<_arith2.h>

single StoK(D, struc, data, type, digits)
obj D; 
t_handle *struc, *data;  
single type, digits;
 
.SH DESCRIPTION
.TP 4
.B D 
is a SIMATH object and will be converted to the according Kant object.
.TP 4
.B type 
determines the type, D will be converted to (s. table below).
.TP 4
.B digits 
is the Kant precision, if type represents a floating-point and arbitrary else.
.PP
type		|  D will be converted to a ..
		|	
 1		|  integer
 2 		|  floating point with 
 		|  Kant precision digits
 3		|  rational number
 16 + x	|  polynomial over x
 		|  (x = 1, 2 or 3)
 32 + x	|  matrix over x
.PP
In order to convert D, StoK needs a string, whose length is determined by the global variable KS_MEM_MAX. When using large D, the value of KS_MEM_MAX should be raised.
StoK returns 0 by success.
.SH NOTES
The usage of this function assumes the installation of the computer algebra system Kant.
Alternatively, you can use the header str_to_kant.h, included in the Kant system.
.SH SEE ALSO
StoKstr

M*/
                 
/*H
	Version  1      14.06.1993	Marc Conrad
   DATE StoK          : 931130 
H*/



/*** StoK.S steht auf der Datei KtoS.S.       ***/
/***         Bitte dort nachsehen !!!         ***/

