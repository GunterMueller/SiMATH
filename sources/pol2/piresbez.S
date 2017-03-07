/*M
.SH NAME                    
piresbez - polynomial over integers resultant, Bezout algorithm
                                                    
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
pol piresbez(r, P1, P2) 
single r; 
pol P1, P2;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 < r < BASIS.
.TP 4                                                                           
.B P1, P2                                                                       
are polynomials in r variables over the integer numbers.
.PP
piresbez returns (maybe up to the sign) the resultant of P1 and P2.
In order to do that, piresbez computes, if necessary, the determinant of the Bezout-matrix for P1 and P2 (which is, maybe up to the sign, equal to the resultant)  and returns it.                                                                        
.SH SEE ALSO
 pirescoll
 piressylv
 pibezout
                                                                    
M*/                                                                             

/*H
	Version 1       01.10.1987      B. Weis
   DATE piresbez      : 890501
H*/


#include <_pol2.h>

pol piresbez(r,P1,P2)
single r;
pol P1, P2;
{
	single e1, e2;
	pol H, P3, k1, k2;
	bind2(P1,P2);
	init4(H,P3,k1,k2);

/* Sonderfaelle und Minimierung des Problems */

	if (!P1  ||  !P2) P3 = 0;
	else if (!lfirst(P1)  &&  !lfirst(P2)) P3 = pvinsert(0,1,r-1);
	else if (!lfirst(P1)) P3 = piexp(r-1,lsecond(P1),lfirst(P2));
	else if (!lfirst(P2)) P3 = piexp(r-1,lsecond(P2),lfirst(P1));
	else {
		H = P1;
		while (H != _0) {
			e1 = lfirst(H);
			H = lred(H);
			k1 = lfirst(H);
			H = lred(H);
			}
		H = P2;
		while (H != _0) {
			e2 = lfirst(H);
			H = lred(H);
			k2 = lfirst(H);
			H = lred(H);
			}
		if (e1  &&  e2) P3 = 0;
		else if (e1) {
			P1 = ppmvquot(r,P1,e1);
			H = piexp(r-1,k2,e1);
			if (!lfirst(P1)) P3 = piexp(r-1,lsecond(P1),lfirst(P2));
			else {
				P3 = pibezout(r,P1,P2);
				P3 = mapidet(r-1,P3);
				}
			P3 = piprod(r-1,P3,H);
			}
		else if (e2) {
			P2 = ppmvquot(r,P2,e2);
			H = piexp(r-1,k1,e2);
			if (sodd(e2)  &&  sodd(lfirst(P1))) H = pineg(r-1,H);
			if (!lfirst(P2)) P3 = piexp(r-1,lsecond(P2),lfirst(P1));
			else {
				P3 = pibezout(r,P1,P2);
				P3 = mapidet(r-1,P3);
				}
			P3 = piprod(r-1,P3,H);
			}
		else {
			P3 = pibezout(r,P1,P2);
			P3 = mapidet(r-1,P3);
			}
		}

/* Ausgabe */

	return(P3);
}
