/*M
.SH NAME
ecimindif - elliptic curve with integer coefficients, minimal model, difference of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecimindif(E1, P1, Q1)
list E1, P1(xP, yP, zP), Q1(xQ, yQ, zQ);
int xP, yP, zP, xQ, yQ, zQ;

.SH DESCRIPTION
ecimindif computes the difference S of the points P and Q,
.P
S = P + (-Q) = P - Q,
.P
and returns S as a list of three elements.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
The model representing E is of restricted typ (i.e. a1', a3' = 0 or 1, a2' = -1,
0, 1 ). 

.TP 4
.B P1, Q1
define the points P and Q on the minimal model of the elliptic curve E/Q.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	21.01.1993	Josef Gebel (neues Konzept)
   DATE ecimindif     : 930115.930531
H*/

#include<_ec1.h>

list ecimindif( E, P, Q )
list E, P, Q;
{
    list R;

    bind( E, P, Q );
    init( R );

    R = eciminneg( E, Q );
    R = eciminsum( E, P, R );

    return( R );
}
