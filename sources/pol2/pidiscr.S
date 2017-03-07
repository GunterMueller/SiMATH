/*M
.SH NAME
pidiscr - polynomial over integers discriminant

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pidiscr(r, P, n)  
single r, n; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers of degree >= 2.
.TP 4
.B n
is an integer number, 1 <= n <= 4.
.PP
pidiscr returns the discriminant, say P1, of P with regard to the main variable, so P1 is a polynomial in r-1 variables.
.PP
The value of n determines the algorithm used by pidisc as follows : In the case n < 4, pidiscr computes the resultant of P and its derivation, namely
.IP
 n = 1: computation of the determinant of the 
        Sylvester matrix (s. piressylv),
 n = 2: Collins algorithm over the integer numbers, 
        Sylvester matrix over Z/mZ (s. pirescoll).
 n = 3: Collins algorithm over Z and Z/mZ.
.PP
In the case n = 4, pidiscr uses the Hankel matrix for the one-level computation of the discriminant (s. pidiscrhank).
In case of doubt, you should try n = 4, especially if P is monic with regard to the main variable.
.PP
For n < 4 and r = 1, pidiscr uses the Collins algorithm.

.SH SEE ALSO
 piressylv
 pirescoll
 pidiscrhank

M*/

/*H
	Version 1       31.05.1987      B. Weis
	Version 2       31.07.1987      B. Weis
			Berechnung von n vorgezogen
	Version 3       04.08.1987      B. Weis
			Dokumentation geaendert
	Version 4       06.10.1987      B. Weis
			Parameter n eingefuehrt und entsprechende
			Aenderungen an Programm und Dokumentation
	Version 5	10.04.1993	Marc Conrad.			
			n=4 eingefuehrt, 
   DATE pidiscr       : 890501.930531
H*/

#include <_pol2.h>

pol pidiscr(r,P,n)
single r;
pol P;
single n;
{
	single e;
	pol P1, P2;
	bind(P);
	init2(P1,P2);

/* Berechnung der Diskriminante */   
	if ( pdegree( r, P ) == 0 ) return ( 0 ); 
	if ( n == 4 ) P1 = pidiscrhank( r, P );
	else {

	P1 = pideriv(r,P);
	if (r > 1)
		switch (n) {
			case 1: P1 = piressylv(r,P,P1); break;
			case 2: P1 = pirescoll(r,P,P1,1); break;
			case 3: P1 = pirescoll(r,P,P1,2); break;
			default: P1 = ERROR;
			}
	else P1 = pirescoll(r,P,P1,1);
	if (P1 != ERROR) {
		e = pdegree(r,P);
		P2 = plc(r,P);
		r--;
		P1 = piquot(r,P1,P2);
		if (e%4 >= 2) P1 = pineg(r,P1);
		}
         }
/* Ausgabe */

	return(P1);
}
