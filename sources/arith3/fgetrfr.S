/*M
.SH NAME
fgetrfr - file get rational function over rationals

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc fgetrfr(r, V, pf)  
single r; 
list V; 
FILE *pf;
     
.SH DESCRIPTION
.TP 4
.B r
is an integer, 0 <= r < BASIS.
.TP 4
.B V
= ( V1 ... Vr ) is a list of variable names           ( s. pmakevl ), Vr is the
name of the main variable.               
.TP 4
.B pf
points on an open input file *pf.
.PP
.PP
fgetrfr reads a rational function in the r variables     V1, ...,Vr over the rational numbers from *pf and returns it.
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
	Version 1       17.03.1988      B. Weis
	Version 2       22.03.1988      B. Weis
			Eingabe Bruchstrich geaendert: fgetc -> fgetcb
			Dokumentation korrigiert
	Version 3       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE fgetrfr       : 890501.9301__
H*/


#include <_arith3.h>

rfunc fgetrfr(r,V,pf)
single r;
list V;
FILE *pf;
{
    single c;
    rfunc R;
    pol PN, PZ;
    bind(V);
    init(PN,PZ,R);

/* Zaehler einlesen */

    if ((PZ = fgetpr(r,V,pf)) == ERROR) R = ERROR, errmsgio("fgetrfr","FF102");
    else {

/* Nenner erstellen */

	if ((c=fgetcb(pf)) == EOF) R = ERROR, errmsgio("fgetrfr","FF102");
	if (c == '/') {
	    if ((PN = fgetpr(r,V,pf)) == ERROR) R = ERROR, errmsgio("fgetrfr","FF102");
	    else if (!PN) R = ERROR, errmsgio("fgetrfr","FF030");
	    else {
		PZ = prtorfr(r,PZ);
		PN = prtorfr(r,PN);
		R = rfrquot(r,PZ,PN);
		}
	    }
	else {
	    if (ungetc(c,pf) == EOF) R = ERROR, errmsgio("fgetrfr","FF102");
	    else R = prtorfr(r,PZ);
	    }
	}

/* Ausgabe */

	return(R);
}
