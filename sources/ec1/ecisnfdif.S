/*M
.SH NAME
ecisnfdif - elliptic curve with integer coefficients, minimal model, difference of points
 
.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnfdif(E1, P1, Q1)  
list E1, P1, Q1;

.SH DESCRIPTION
ecisnfdif computes the difference S of the points P and Q,
.P
S = P + (-Q) = P - Q,
.PP
and returns S as a list of with three elements.
.TP 4
.B P1 = ( xP, yP, zP ) int xP, yP, zP
defines the point P on the model of E/Q in short Weierstrass normal form.
.TP 4 
.B Q1 = ( xQ, yQ, zQ ) int xQ, yQ, zQ
defines the point Q on the model of E/Q in short Weierstrass normal form.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	21.01.1993	Josef Gebel (neues Konzept)
   DATE ecisnfdif     : 920331.930531
H*/

#include<_ec1.h>

list ecisnfdif( E, P, Q )
list E, P, Q;
{
    list R;
    
    bind( E, P, Q );
    init( R );
    
    R = ecisnfneg( E, Q );
    return( ecisnfsum( E, P, R ) );
}
