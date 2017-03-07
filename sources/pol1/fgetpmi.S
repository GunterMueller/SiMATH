/*M
.SH NAME
fgetpmi - file get polynomial over modular integers

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol fgetpmi(r,M,V,pf)  
single r; 
int M; 
list V; 
FILE *pf;

.SH DESCRIPTION
.TP 4
.B r
is an integer, 0 <= r < BASIS.
.TP 4
.B M
is a positiv integer.
.TP 4
.B V
= ( V1 ... Vr ) is a list of variable names           ( s. pmakevl ), Vr is the
name of the main variable.
.PP
fgetpmi reads a polynomial in the r variables V1, ..., Vr over Z/(M*Z) from the open file *pf.
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
 4. Variable names must be mentioned in V, they are                             
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
fgetpmi returns the polynomial p by success, ERROR else.                          
.SH SEE ALSO                                                                    
pmakevl
       
M*/

/*H
	Version 1	31.07.91	J.Schmitt
   DATE fgetpmi       : 910915.9301__
H*/

#include <_pol1.h>

pol fgetpmi(r,M,V,pf)
single r;
int M;
list V;
FILE *pf;
{
    single err=0, i, kg, kPsign, namax, vil, Sch=0;
    char c, *fn;
    int kP, kPevi;
    list kPev, vi;
    pol P=0;
    bind(M,V,P);
    init(kP,kPevi,kPev,vi);
    namax = isvarl(r,V);

/* r gleich 0 */

    if (!r) {
	c = ' ';
	while (c != '#') {
	    if ((kP = fgeti(pf)) == ERROR) {err = 1; break;}
	    P = isum(kP,P);
	    if ((c = fgetcs(pf)) == EOF) {err = 1; break;}
	    if (ungetc(c,pf) == EOF) {err = 1; break;}
	    if (c != '#'  &&  c != '-'  &&  c != '+') 
				{err = 2; fn = "P213"; break;}
	}
	if (err) {
	    while ((c = fgetcs(pf)) != EOF  &&  c != '#');
	    if (err == 1) fn = "P211";
	}
	else P = mihom(M,P);
    }
 
/* r ungleich 0 */

    else {
	do {
	    /* Lese Monom */
	    if ((c = fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
	    if (c == '#') {err = 1; fn = "P212"; break;}
	    if (Sch  &&  index("+-",c) == NULL) {err = 1; fn = "P213"; break;}
	    Sch = 1;
	    /* Bestimmung des Vorzeichens */
	    switch (c) {
		case '-': kPsign = -1; break;
		case '+': kPsign = 1; break;
		default : kPsign = 1;
			  c = ungetc(c,pf);
			  break;
		}
	    if (c == EOF) {err = 1; fn = "P211"; break;}
	    kg = 0;
	    if ((c = fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
	    if (ungetc(c,pf) == EOF) {err = 1; fn = "P211"; break;}
	    if (isdigit(c)) {
		/* Einlesen Koeffizient */
		if ((kP = fgeti(pf)) == BASIS) {err = 1; fn = "P211"; break;}
		kg = 1;
		}
	    else kP = 1;
	    if (kPsign == -1) kP = ineg(kP);
	    if ((c = fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
	    if (!kg  &&  !isalpha(c)) {err = 1; fn = "P213"; break;}
	    else if (c == '*') {
		if ((c = fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
		}
	    if (ungetc(c,pf) == EOF) {err = 1; fn = "P211"; break;}
	    /* Vorbesetzung des Exponentenvektors */
	    kPev = _0;
	    for (i = r; i; i--) kPev = lcomp(0,kPev);
	    while (isalpha(c)) {
		/* Einlesen Variable */
		vil = 0;
		vi = _0;
		if ((c = fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
		while (index("+-^*#",c) == NULL  &&  !isspace(c)  &&  vil <= namax) {
		    if (!isalnum(c)) {err = 1; fn = "P213"; break;}
		    vi = lcomp(c,vi);
		    vil++;
		    if ((c = fgetc(pf)) == EOF) {err = 1; fn = "P211"; break;}
		    }
		if (err) break;
		if (vil == namax+1) {err = 1; fn = "P214"; break;}
		else vi = linv(vi);
		if (!(i = lsrch(vi,V))) {err = 1; fn = "P214"; break;}
		if (ungetc(c,pf) == EOF) {err = 1; fn = "P211"; break;}
		if ((c=fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
		/* Bestimmung und Eintrag des Exponenten */
		if (c == '*') {
		    if ((c=fgetc(pf)) == EOF) {err = 1; fn = "P211"; break;}
		    if (c != '*') {
			kPevi = isum(1,lelt(kPev,i));
			if (kPevi >= BASIS) {err = 1; fn = "P215"; break;}
			leset(kPev,i,kPevi);
			if (ungetc(c,pf) == EOF) {err = 1; fn = "P211"; break;}
			if ((c=fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
			if (ungetc(c,pf) == EOF) {err = 1; fn = "P211"; break;}
			if (!isalpha(c)) {err = 1; fn = "P213"; break;}
			continue;
			}
		    }
		if (c == '^'  ||  c == '*') {
		    if ((kPevi = fgeti(pf)) == ERROR) {err = 1; fn = "P211"; break;}
		    if (kPevi) {
			if (isign(kPevi) < 0) {err = 1; fn = "P216"; break;}
			kPevi = isum(kPevi,lelt(kPev,i));
			if (kPevi >= BASIS) {err = 1; fn = "P215"; break;}
			leset(kPev,i,kPevi);
			}
		    }
		else {
		    kPevi = isum(1,lelt(kPev,i));
		    if (kPevi >= BASIS) {err = 1; fn = "P215"; break;}
		    leset(kPev,i,kPevi);
		    if (ungetc(c,pf) == EOF) {err = 1; fn = "P211"; break;}
		    }
		if ((c=fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
		if (c == '*') {
		    if ((c=fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
		    }
		if (ungetc(c,pf) == EOF) {err = 1; fn = "P211"; break;}
		}
	    if (err) break;
	    kP = mihom(M,kP);
	    if (kP) {
		/* Reduktion des Exponentenvektors */
		while (kPev != _0) {
		    kPevi = lfirst(kPev);
		    kPev = lred(kPev);
		    kP = list2(kPevi,kP);
		    }
		/* Einfuegen des Monoms in P */
		P = pmisum(r,M,P,kP);
		}
	    }
	while (c != '#');
	while (c != EOF  &&  c != '#') {
	    if ((c=fgetc(pf)) == EOF) {err = 1; fn = "P211"; break;}
	}
    }

/* Ausgabe */

    if (err) {P = ERROR; errmsgio("fgetpmi",fn);}
    else fgetc(pf);
    return(P);
}
