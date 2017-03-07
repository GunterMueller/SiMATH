/*M
.SH NAME
fputpgfs - file put polynomial over Galois-field

.SH SYNOPSIS
.nf
#include<_pol3.h>

single fputpgfs(r, p, AL, P, V, Vgfs, pf)  
single r, p; 
list AL, V, Vgfs;
pol P; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B P
is a polynomial over GF(p^n) in r variables.
.TP 4
.B VL
is the list of variables names, used by the polynomial P (s. pmakevl).
.TP 4
.B Vgfs
is a list which contains one element, representing the name of a primitive element in GF(p^n)/(Z/pZ).
.TP 4
.B pf
points to an input file.
.PP
fputpgfs writes P to the file *pf, the end of P will be marked with '#'.
fputpgfs returns 0 by success and ERROR else.             

.SH SEE ALSO
.nf
gfsalgen
pmakevl

M*/        
    
/*H
	Version 1       06.04.1988      B. Weis
   DATE fputpgfs      : 890501.9301__
H*/


#include <_pol3.h>

single fputpgfs(r,p,AL,P,V,Vgfs,pf)
single r;
single p;
list AL;
pol P;
list V, Vgfs;
FILE *pf;
{
	single a=0;

	V = lcconc(Vgfs,V);
	if (fputpms(r+1,p,P,V,pf) == ERROR) a = ERROR, errmsgio("fputpgfs","P201");

	return(a);
}
