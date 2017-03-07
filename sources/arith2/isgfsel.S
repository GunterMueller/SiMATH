/*M
.SH NAME
isgfsel - is Galois-field with single characteristic element ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isgfsel(p,AL,a)  
single p; 
list AL; 
obj a;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G, AL1) can be seen as arithmetic list for GF(p^n) (s.gfsalgen), where n = llength(AL1) + 1.
.PP
isgfsel returns
.TP 4
1,
if a can be seen as an element of GF(p^n), i.e. as univariate polynomial over Z/pZ of degree < n, and
.TP 4
0,
else.
 
.SH SEE ALSO
gfsalgen

M*/
     
/*H
	Version 1       26.08.1987              Pascale Serf
	Version 2       07.12.1987              Liste AL statt Pol. G    PS
	Version 3       21.04.1988              p vom Typ single,
						AL vom Typ list.    PS
	Version 4	20.09.1990		Fall a = 0 eingefuegt.   PS
   DATE isgfsel       : 890501.910915
H*/


#include <_arith2.h>

single isgfsel(p,AL,a)
single p;
list AL;
obj a;
{
	single erg = 0;
	pol    G;

	bind(AL,a);
	init(G);

	G = lfirst(AL);
	if ( !a || ispms(1,p,a) && lfirst(a) < lfirst(G) ) erg = 1;

	return( erg );
}
