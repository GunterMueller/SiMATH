/*M
.SH NAME
ecracdif - elliptic curve with integer coefficients, actual curve, difference of points

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecracdif(E1, P1, Q1)  
list E1, P1, Q1;

.SH DESCRIPTION
ecracdif computes the difference S of the points P and Q,
.P
S = P + (-Q) = P - Q,
.P
and returns S as a list of three elements.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4                                                                           
.B P1 = ( xP, yP, zP ) int xP, yP, zP                                           
defines the point P on the actual model of E/Q.       
.TP 4                                                                           
.B Q1 = ( xQ, yQ, zQ ) int xQ, yQ, zQ                                           
defines the point Q on the actual model of E/Q.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	21.01.1993	Josef Gebel (neues Konzept)
   DATE ecracdif      : 930531
H*/

#include<_ec1.h>

list ecracdif( E, P, Q )
list E, P, Q;
{

    list R;
    
    bind( E, P, Q );
    init( R );

    R = ecracneg( E, Q );
    return( ecracsum( E, P, R ) );
}
