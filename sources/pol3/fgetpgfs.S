/*M
.SH NAME
fgetpgfs - file get polynomial over Galois-field with single characteristic

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol fgetpgfs(r, p, AL, VL, Vgfs, pf)  
single r, p; 
list AL, VL, Vgfs;
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
.B VL
is the list of variables names of lenght >= r (s. pmakevl).
.TP 4
.B Vgfs
is a list which contains one element, representing the name of a primitive element in GF(p^n)/(Z/pZ). 
.TP 4
.B pf
points to an output file.
.PP  
fgetpgfs reads a polynomial in r variables over GF(p^n) from the file *pf.
.TP 4
Following rules must be considered:
 1. The end of the polynomial must be marked with '#'.
 2. Only positive exponents are allowed. They must be
    marked by the prefix '^' or '**'. The input of the
    powers 1 or 0 is not necessary, but in the second
    case, the input of the according variable had to
    remain undone too.
 3. Coefficients of any size are allowed. The
    coefficient and its sign can be seperated by
    blanks, the coefficient and the according
    variables can be seperated by any blanks and/or
    '*'. These seperations are not necessary. The
    input of the coefficient 1 is not necessary.
 4. Variable names must be mentioned in VL, they are
    not allowed to be seperated by special
    characters.
    Single variables and its exponents can be      
    seperated to other variables by any blanks and/or
    '*'. This seperation is only necessary if no
    exponent was specified.
 5. Appears a variable in a single monomial more than
    once, the several occurances will be merged.
    Appears a monomial more than once, the several
    occurances will be merged.
.PP
fgetpgfs returns the polynomial by success, ERROR else.

M*/                                                 
    
/*H
	Version 1       06.04.1988      B. Weis
   DATE fgetpgfs      : 890501.9301__
H*/


#include <_pol3.h>

pol fgetpgfs(r,p,AL,V,Vgfs,pf)
single r;
single p;
list AL;
list V, Vgfs;
FILE *pf;
{
	list eV;
	pol MP, P, PS, k;
	bind(AL);
	init(P,PS,k);

/* Einlesen Polynom */

	V = lcconc(Vgfs,V);
	if ((P = fgetpms(r+1,p,V,pf)) == ERROR) errmsgio("fgetpgfs","P211");

/* Reduziere P */

	MP = lfirst(AL);
	if (r  &&  P) {
		P = ptodip(r,P);
		PS = _0;
		while (P != _0) {
			k = lfirst(P);
			P = lred(P);
			k = upmsrem(p,k,MP);
			if (k) eV = lfirst(P), PS = lcomp2(eV,k,PS);
			P = lred(P);
			}
		if (PS != _0) PS = linv(PS), P = diptop(r,PS);
		else P = 0;
		}
	else if (P) P = upmsrem(p,P,MP);

/* Ausgabe */

	return(P);
}
