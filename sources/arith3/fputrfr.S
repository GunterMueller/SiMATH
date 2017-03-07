/*M
.SH NAME
fputrfr - file put rational function over rationals

.SH SYNOPSIS
.nf
#include<_arith3.h>

single fputrfr(r, R, V, pf)  
single r; 
rfunc R; 
list V; 
FILE *pf;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B R
is a rational function in r variables over the rational numbers.
.TP 4
.B V
is a list, containing the variables names of R (s. pmakevl).
For r = 0, V is the empty list.        
.TP 4
.B pf
points on an open output file *pf.
.PP                    
fputrfr writes the function R to *pf, and returns
.IP
.nf
0       by success,
ERROR   else.

.SH SEE ALSO
pmakevl
                                            
M*/
                              
/*H
	Version 1       18.03.1988      B. Weis
	Version 2       19.03.1988      B. Weis
			Dokumentation verbessert
	Version 3       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE fputrfr       : 890501.9301__
H*/


#include <_arith3.h>

single fputrfr(r,R,V,pf)
single r;
rfunc R;
list V;
FILE *pf;
{
    single a=0;
    bind(R,V);

/* R gleich 0 */

    if (!R) {if (fputs("0 #",pf) == EOF) a = ERROR, errmsgio("fputrfr","FF101");}

/* R ungleich 0 */

    else {
	if (fputpi(r,lfirst(R),V,pf) == ERROR) a = ERROR, errmsgio("fputrfr","FF101");
	R = lsecond(R);
	if (!ispione(r,R)) {
	    if (fputc('/',pf) == EOF) a = ERROR, errmsgio("fputrfr","FF101");
	    if (fputc(' ',pf) == EOF) a = ERROR, errmsgio("fputrfr","FF101");
	    if (fputpi(r,R,V,pf) == ERROR) a = ERROR, errmsgio("fputrfr","FF101");
	    }
	}

/* Ausgabe */

    return(a);
}
