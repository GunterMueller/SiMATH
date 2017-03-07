/*M
.SH NAME
ecqnfprojtop - elliptic curve over quadratic number field, point in projective representation to affine representation

.SH SYNOPSIS
.nf
#include<_ec2.h>

list  ecqnfprojtop(D,PL)  
int D;
list PL; 

.SH DESCRIPTION
.TP 4
.B D
is an integer number, D != 0 or 1, D square-free.
.TP 4
.B PL
= (x y z) is a list of three elements of Q(D^(1/2)). PL is the projective representation of a point, say P.
.PP
ecqnfprojtop returns a list of two elements of Q(D^(1/2)), which is the affine representation of P, ( the list (0) for z = 0 ) or ERROR in case of an error occurs. 

M*/
                    
/*H
	Version 1       03.03.1997  	Susanne Schmitt
H*/

#include <_ec2.h>

list ecqnfprojtop( D,P )
int D;
list P;
{
    if( lthird( P ) == 0 )
    {
	return( 0 );
    }
    else
    {
        nfel x, y, z;
        
	bind( P );
        init( x, y, z );

	x=lfirst(P);
	y=lsecond(P);
	z=lthird(P);
	x=qnfquot(D,x,z);
	y=qnfquot(D,y,z);

	z=list2(x,y);
	return( z );
    }
}
