/*M
.SH NAME
isgf2impsb - is Galois-field with characteristic 2 irreducible and monic polynomial in special bit-representation ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isgf2impsb(G)  
obj G;
 
.SH DESCRIPTION
.PP
isgf2impsb returns 
.TP 4
1, 
if G can be seen as a generating polynomial for the finite field with characteristic 2, i.e. if G is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation of degree >= 1 (s.udpm2tosb), and
.TP 4
0,
else.
 
.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1      13.03.1992	A.Stein
   DATE isgf2impsb   : 920331
H*/

# include <_arith2.h>

single isgf2impsb(G)
obj  G;
{
	obj a;
	if( !isudpm2sb(G) ) return(0);
	a = gf2eltoudpm2(G,G);
	a = dptop(1,a);
	if ( !isimupms(2,a) ) return(0);

	return(1);
}
