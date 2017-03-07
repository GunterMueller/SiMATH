/*M
.SH NAME
qffmsicn - quadratic function field over modular singles ideal class number

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsicn(m, P)  
single m; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B P
is a square free polynomial in Z/mZ[X].
.PP
qffmsicn returns the ideal class number of the field Z/mZ(X,P^(1/2)).

M*/
           
/*H
	Version 1	11.11.1991      A.Stein
	Version 2	18.05.1992	pmsmonic ergaenzt.  AS
   DATE qffmsicn      : 920331.921130
H*/


#include <_arith3.h>

int qffmsicn(m,P)
single m;
pol P;
{
	int A; 
	bind(A,P);

/* Grad P ungerade */
	if (sodd(lfirst(P)))  A = qffmsdcns1(m,P);

/* Grad P gerade, sign(P) kein Quadrat in Z/mZ */
	else if (ijacsym(lsecond(P),m) < 0) { 
		A = qffmsdcns2(m,P);
		A = isum(A,A);
        }

/* Grad P gerade, sign(P) ein Quadrat in Z/mZ */
	else { 
		int R;
		P = pmsmonic(1,m,P);
		A = qffmsdcns3(m,P);
		R = qffmsregbg(m,P);
		A = iquot(A,R);
        }

/* Ausgabe */
	return(A);
}
