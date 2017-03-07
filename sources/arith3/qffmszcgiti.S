/*M
.SH NAME
qffmszcgiti - quadratic function field over modular singles zero class group isomorphy type, imaginary case

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmszcgiti(m, D, LG, IT)  
single m; 
pol D; 
list LG, IT;
 
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X], such that either
.IP
D is of odd degree, or
.IP
deg(D) is even and the leading coefficient of D is not a square in the multiplicative group of (Z/mZ), i.e.
.PP
Z/mZ(X,D^(1/2)) is an imaginary quadratic function field.
.TP 4               
.B LG
is a list, containing generators of the ideal class group (s. qffmsicggii).
.TP 4
.B IT
is a list, representing the isomorphic type of the ideal class group (s. qffmsicggii).
.PP
qffmszcgiti returns the isomorphic type of the zero class group, i.e. qffmszgciti returns a list of l integers m1, ...,ml such that the zero class group is isomorphic to 
.IP
 (Z / m1Z) x (Z / m2Z) x ... x (Z / mlZ). 

.SH SEE ALSO
Literature: B.Weis, Diplomarbeit, Universitaet Saarbruecken, 1986.
.nf
qffmsicggii

M*/
 
/*H
        Version 1       09.03.1993	A.Stein
   DATE qffmszcgiti   : 930531
H*/

#include <_arith3.h>

list qffmszcgiti(m,D,LG,IT)
single m; 
pol D; 
list LG, IT;
{
	single ind;
	int Pi, Fi;
	list LM, LM1, L;
	init(Pi,Fi,LM,LM1,L);
	bind(D,LG,IT);

	ind = lfirst(D);
	if(  iodd(ind) ) return( IT );
	LG = lfirst(LG);
	LM = lcinv(LG);
	for( ind=0, L=_0; LM != _0 ; LM = lred(LM) ) {
		LM1 = lfirst(LM);
		Pi = lsecond(lfirst(LM1));
		Fi = lfirst(lfirst(lsecond(LM1)));
		if( iodd(Fi) ) {
			if( !ind ) {
				Fi = ip2quot(Pi,1);
				Fi = ineg(Fi);
				if( icomp(Fi,1) ) L = lcomp(Fi,L);
				ind = 1;
			}
			else {
				Fi = ineg(Pi);
				L = lcomp(Fi,L);
			}
		}
		else {
			Fi = ineg(Pi);
			L = lcomp(Fi,L);
		}
	}
	for( ind=0; ( IT != _0 ) && !ind ; ) {
		Pi = lfirst(IT);
		if( ieven(Pi) ) IT = lred(IT);
		else ind = 1;
	}
	L = lconc(L,IT);
	return( L );
}
