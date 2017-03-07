/*M
.SH NAME
pmsalidpo - polynomial over modular single arithmetic lists and idempotents (number field modulo prime)

.SH SYNOPSIS
.nf
#include<_pol2.h>

list pmsalidpo(p, F, pLI)  
single p; 
pol F; 
list *pLI;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B F
is an univariate and square-free polynomial over Z/pZ.
.PP
Let F1,...,Fg be the irreducible factors of F over Z/pZ, then the ring Z/pZ[X]/(F(X)) is the direct product of the finite fields Z/pZ[X]/(Fi(X)), (1 <= i <=g).
.PP
pmsalidpo computes the idempotent elements, say E1,...,Eg, of this ring, i.e. for 1 <= i <=g,
.IP
Ei = 1 modulo Fj    ,for i  = j,
   = 0 modulo Fj    ,for i != j.
.PP
Beyond that, pmsalidpo computes the arithmetic lists, say AL1,...,ALg, of the finite fields, so for 1 <= i <= g,
.IP
ALi is the aritmetic list of Z/pZ[X]/(Fi(X))      (s. gfsalgen).
.PP
pmsalidpo returns the list LAL = (AL1 ... ALg) and writes the list (E1 ... Eg) to *pLI.

.SH NOTES
LAL = ERROR, in the case of F mod p is not square-free.
 	     
.SH SEE ALSO
gfsalgen

M*/

/*H
					
	Version 1	15.03.95	Wolfgang Schwarz
	Version 2	07.07.95	pitopms entfernt 
					(F ueber Z/pZ vorausgesetzt), WS.
   DATE pmsalidpo     : 951201   
H*/

#include <_pol2.h>

pol pmsalidpo(p,F,pLI)
single p;pol F;list *pLI;
{
	list LI,L,Lrest,AL,LAL;
	pol Fi,G,H;
	bind(F);
	init(LI,L,Lrest,AL,LAL,Fi,G,H);	

/* normieren + faktorisieren */
	
	F = pmsmonic(1,p,F);
	L = upmscfact(p,F);

/* Idempotente berechnen */

	Lrest = L;
	LAL = _0;
	LI = _0;
	while (Lrest != _0)
	{	Fi = lfirst(Lrest);
		AL = gfsalgen(p,pdegree(1,Fi),Fi);
		G = pmsquot(1,p,F,Fi);
		H = pmsrem(1,p,G,Fi);
		if (!H) return(ERROR); /* Polynom nicht quadratfrei */
		H = gfsinv(p,AL,H);
		G = pmsprod(1,p,G,H);
		LI = lcomp(G,LI);
		LAL = lcomp(AL,LAL);
		Lrest = lred(Lrest);
	}

/* Ausgabe */

	*pLI = LI;
	return(LAL);
}
