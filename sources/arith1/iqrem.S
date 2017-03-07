/*M
.SH NAME
iqrem - integer quotient and remainder

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iqrem(A,B,pQ,pR)
int A,B,*pQ,*pR;

.SH DESCRIPTION
iqrem() calculates the integers *pQ = A / B and *pR = A - (*pQ) * B
for B!=0 and returns 0. 
M*/
/*H
	Version  1      08.08.1986      R.Boeffgen    
	Version  2      11.11.1991      komplett neu geschrieben.  MC
	Version  3 	14.02.1992	Essener Arithm. eingebaut.  MC
	Version  4	03.09.1993	Heidelberger Arithmetik eingebaut.  MC
	Version  5	03.11.1994	MX-Version entfernt. MP
	Version  6	12.12.1998	Version von 1991 entfernt. MC
   DATE iqrem         : 890501.911215.920331.931130.941201
H*/

#include <_arith1.h>
#ifndef LP64
#include <_Earith.h>
#endif

int iqrem(A, B, pq, pr)
    int A, B, *pq, *pr;
{

/* triviale Faelle					*/
    if (issingle(A)) {
	if (issingle(B)) {
	    *pr = A % B; *pq = A / B;
	} else {
	    *pr = A; *pq = 0;
	}
	return (0);
    } else if (issingle(B)) {
        return (isqrem(A, B, pq, pr));
    } else {
#ifdef LP64
	return (iqrem_3(A, B, pq, pr));
#else
        single uza, uzb;
	LONG ea[LAENGE], eb[LAENGE];

	bind(A, B);
	if ((uza = itoEsb(A, ea, LAENGE - 2)) != 2 &&
	    (uzb = itoEsb(B, eb, LAENGE)) != 2) {
	    if( Ecomp(ea, eb)  == 1 ) { *pr = A; *pq = 0; return 0; }
	    Ediv(ea, eb, ea, eb);
	    if (uza == uzb) {
	        A = Etoi(ea);
	    } else {
	        A = Etoineg(ea);
	    }
	    if (uza == 1) {
	        B = Etoi(eb);
	    } else { 
	        B = Etoineg(eb);
	    }

	    *pq = A;
	    *pr = B;
	    return (0);
	} else {
	    return (iqrem_3(A, B, pq, pr));
	}
#endif
    }
}



