/*M
.SH NAME
fgetrfmsp1 - file get rational function over modular single primes, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc fgetrfmsp1(p, V, pf)  
single p; 
list V; 
FILE *pf;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B V
= ( V1 ) is a list of one variable name (s. pmakevl). 
.TP 4
.B pf
points on an open input file *pf. 
.PP
fgetrfmsp1 reads an univariate rational function over Z/pZ from *pf and returns it.
.TP 4
.nf
Following rules must be considered:
1. The function must be of the form
   P1/P2 or P1, whereby P1 and P2 are polynomials.
   For P2 = 1, the input of the denominator is not
   necessary.
2. The fraction bar must be in the same line as the
   polynomial-end character "#" of P1.
3. For the input of the polynomials, the rules given
   in getpms must be considert.


.SH SEE ALSO
.nf
pmakevl
getpms
                                                

M*/
                   
/*H
	Version 1       19.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE fgetrfmsp1    : 890501.9301__
H*/


#include <_arith3.h>

rfunc fgetrfmsp1(p,V,pf)
single p;
list V;
FILE *pf;
{
    single c;
    rfunc R;
    pol PN, PZ;
    bind(V);
    init(PN,PZ,R);

/* Zaehler einlesen */

    if ((PZ = fgetpms(1,p,V,pf)) == ERROR) R = ERROR, errmsgio("fgetrfmsp1","FF102");
    else {

/* Nenner erstellen */

	if ((c=fgetcb(pf)) == EOF) R = ERROR, errmsgio("fgetrfmsp1","FF102");
	if (c == '/') {
	    if ((PN = fgetpms(1,p,V,pf)) == ERROR) R = ERROR, errmsgio("fgetrfmsp1","FF102");
	    else if (!PN) R = ERROR, errmsgio("fgetrfmsp1","FF030");
	    else R = rfmsp1cons(p,PZ,PN);
	    }
	else {
	    if (ungetc(c,pf) == EOF) R = ERROR, errmsgio("fgetrfmsp1","FF102");
	    else R = pmstorfmsp1(p,PZ);
	    }
	}

/* Ausgabe */

	return(R);
}
