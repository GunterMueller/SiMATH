/*M
.SH NAME
gf2sqrtsv - Galois field of characteristic 2, solving a quadratic equation, special version

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gf2sqrt(AL, a, b)  
list AL; 
gfel a, b;

.SH DESCRIPTION
.TP 4
.B AL
can be seen as an arithmetic list of GF(2^n) (s. gf2algen).
.TP 4
.B a, b
are elements in GF(2^n).
.PP
gf2sqrtsv computes the roots of the equation
.IP
x^2 + a*x + b = 0 
.PP
(for unknown x) in GF(2^n) and returns them in a list (without multiples).

.SH CAUTION
Not as usual, AL, a and b are NOT in special bit-representation.

.SH SEE ALSO
gf2algen

M*/

/*H
	Version 1	01.12.1993		Georg J. Lay
   DATE gf2sqrtsv     : 941201
H*/

#include <_arith2.h>

gfel gf2sqrtsv (AL,a,b)
 {
 single n,i,j,dim;

 obj   _1,x,x2,x_2i,a_i,X_2,B,ha,hx,erg,X0,X1;
 bind (AL,a,b);
 init (_1,x,x2,x_2i,a_i,X_2,B,ha,hx,erg,X0,X1);

/*
	_1			die Eins
	x			formale Nullstelle des erzeugenden Polynoms
	n			Grad der Koerpererweiterung ueber GF(2)
	x2			x^2
	a_i			a  x^i
	x_2i			x^{2i}

	hx, ha			Hilfsvariablen

	Fuehre die Loesung der Gleichung auf die Loesung eines
	linearen Gleichungssystems  zurueck.

	X1			spezielle Loesung
	X0			Loesung des homogenen Teils
	dim			Dimension des Loesungsraumes
				Es gibt 1+dim verschiedene Loesungen
	erg			Ergebnisliste
*/

 hx = lfirst (AL);
 n  = pdegree (1,hx);		/* Koerpergrad ueber GF(2)		*/

 _1 = list2 (0,1);

 x = list2 (1,1);
 x2= gfsprod (2,AL,x,x);

 x_2i = _1;
 a_i = a;	
 X_2 = _0;

 for (i = 0; i<n; i++)
   {
   hx = (x_2i == 0) ? list2 (1,0) : ptodp (1,x_2i);	hx = lred  (hx);
   ha = (a_i  == 0) ? list2 (1,0) : ptodp (1,a_i);	ha = lred  (ha);
   
   for (j = pdegree (1,x_2i); j < n-1; j++)	hx = lcomp (0,hx);	
   for (j = pdegree (1,a_i ); j < n-1; j++)	ha = lcomp (0,ha);	

   hx = vecmisum (2,hx,ha);

   X_2 = lcomp (hx,X_2);

   x_2i = gfsprod (2,AL,x_2i,x2);
   a_i  = gfsprod (2,AL,a_i,x);
   }

 X_2 = matransp (X_2);

 B = (b == 0) ? list2 (1,0) : ptodp (1,b);
 B = lred  (B);

 for (j = pdegree (1,b); j < n-1; j++)	B = lcomp (0,B);	

 dim = mamsssle (2,X_2,B,&X0,&X1);

 erg = _0;

 if (dim >= 0)
   {
   for (j = n-1; j>=0; j--) {
     if (lfirst (X0) != 0)	break;
     X0 = lred (X0); }

   if (X0 == _0)	X0 = 0;
   else {
     X0 = lcomp (j,X0);
     X0 = dptop (1,X0); }

   erg = lcomp (X0,erg);
   }

 if (dim >= 1)
   {
   X1 = lfirst (X1);

   for (j = n-1; j>=0; j--) {
     if (lfirst (X1) != 0)	break;
     X1 = lred (X1); }

   if (X1 == _0)	X1 = 0;
   else {
     X1 = lcomp (j,X1);
     X1 = dptop (1,X1); }

   X1 = gfssum (2,AL,X1,X0);
   erg = lcomp (X1,erg);
   }

 return (erg);
 }
