/*M
.SH NAME
fgetvl - file get variable list

.SH SYNOPSIS
.nf
#include<_pol1.h>

list fgetvl(pf)  
FILE *pf;

.SH DESCRIPTION
fgetvl read a list V of variable names from the open file *pf.
The variable names must be seperated by Blank, ',' or ';', the end of the list must be marked by '#'.
The first character of a variable's name must be a letter, all other characters
must be alphanumeric.
fgetvl returns the list V by success, ERROR else.

.SH SEE ALSO
pmakevl

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE fgetvl        : 890501.9301__
H*/


#include <_pol1.h>

list fgetvl(pf)
FILE *pf;
{
    single err=0;
    char c, *fn;
    list V, Vi;
    init2(V,Vi);

/* Einlesen der Variablennamen */

    V = _0;
    if ((c = fgetcs(pf)) == EOF) {err = 1; fn = "P211";}
    while (!err  &&  isascii(c)  &&  c != '#') {
	if (c == ','  ||  c == ';') {
	    if ((c = fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
	    continue;
	    }
	if (isalpha(c)) {
	    Vi = _0;
	    while (isascii(c) && isalnum(c)) {
		Vi = lcomp(c,Vi);
		if ((c = fgetc(pf)) == EOF) {err = 1; fn = "P211"; break;}
		}
	    if (err) break;
	    if (ungetc(c,pf) == EOF) {err = 1; fn = "P211"; break;}
	    if ((c = fgetcs(pf)) == EOF) {err = 1; fn = "P211"; break;}
	    Vi = linv(Vi);
	    V = lcomp(Vi,V);
	    }
	else {
	    err = 1;
	    fn = "P213";
	    while (c != '#') {
		if ((c = fgetcs(pf)) == EOF) break;
		}
	    break;
	    }
	}
    if (!err  &&  !isascii(c)) {err = 1; fn = "P213";}
    if (err) {V = ERROR; errmsgio("fgetvl",fn);}
    else V = linv(V);

/* Ausgabe */

    return(V);
}
