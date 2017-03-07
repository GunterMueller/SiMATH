/*M
.SH NAME
isvarl - is variable list ?

.SH SYNOPSIS
.nf
#include<_pol1.h>

single isvarl(r, V) 
obj r, V;

.SH DESCRIPTION
isvarl returns 
.TP 4
a,
if V can be interpreted as a list of r variables names,
( 0 < r < BASIS ), where
.IP
.B a 
is the maximum length of the variables names of V,
.TP 4
1, 
if r = 0, and V is the empty list,
.TP 4
0,
else.
  
M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       04.06.1987      B. Weis
			kleine Korrekturen
	Version 3       10.03.1987      B. Weis
			Sonderfall einbuchstabige Variablennamen verboten
   DATE isvarl        : 890501
H*/


#include <_pol1.h>

single isvarl(r,V)
obj r, V;
{
    single a=1;
    obj Vi, Vib;

    if (r < 0  ||  r >= BASIS) a = 0;
    else if (!islist(V)) a = 0;
    else if (llength(V) != r) a = 0;
    else while (V != _0  &&  a) {
	Vi = lfirst(V);
	V = lred(V);
	if (isatom(Vi)  || Vi == _0) {a = 0; break;}
	a = smax(a,llength(Vi));
	Vib = lfirst(Vi);
	Vi = lred(Vi);
	if (isascii(Vib) == 0  ||  isalpha(Vib) == 0) {a = 0; break;}
	while (Vi != _0) {
	    Vib = lfirst(Vi);
	    Vi = lred(Vi);
	    if (isascii(Vib) == 0  ||  isalnum(Vib) == 0) {a = 0; break;}
	    }
	}

/* Ausgabe */

    return(a);
}
