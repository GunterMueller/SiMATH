/*M
.SH NAME
fgetpgf2 - file get polynomial over Galois-field with characteristic 2

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol fgetpgf2(r, G, VL, Vgf2, pf)  
single r; 
obj G; 
list VL, Vgf2;
FILE *pf;
       
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B VL
is the list of variables names of lenght >= r (s. pmakevl).
.TP 4
.B Vgf2
is a list which contains one element, representing the name of a primitive element in GF(2)/(Z/2Z).         
.TP 4
.B pf
points to an output file.
.PP     
fgetpgf2 reads a polynomial in r variables over GF(2^n) from the file *pf, with coefficients represented in special bit representation.
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
fgetpgf2 returns the polynomial by success, ERROR else.
                                                                
M*/
                     
/*H
	Version 1	28.04.1993	J.Schmitt
   DATE fgetpgf2      : 930531
H*/


#include <_pol3.h>

pol fgetpgf2(r,G,V,Vgf2,pf)
single r;
obj G;
list V, Vgf2;
FILE *pf;
{
	list eV;
	pol P, PS, k;
	bind(G,V);
	init(eV,P,PS,k);

/* Einlesen Polynom */

	V = lcconc(Vgf2,V);
	if ((P = fgetpms(r+1,2,V,pf)) == ERROR) errmsgio("fgetpgf2","P211");

/* Reduziere P */

	if (r  &&  P) {
		P = ptodip(r,P);
		PS = _0;
		while (P != _0) {
			k = lfirst(P);
			k = ptodp(1,k);
			P = lred(P);
			k = udpm2togf2el(G,k);
			if (k) eV = lfirst(P), PS = lcomp2(eV,k,PS);
			P = lred(P);
		}
		if (PS != _0) PS = linv(PS), P = diptop(r,PS);
		else P = 0;
	}
	else if (P) { P = ptodp(1,P); P = udpm2togf2el(G,P);}

/* Ausgabe */

	return(P);
}
