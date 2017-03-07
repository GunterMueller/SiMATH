/*M
.SH NAME
fputecrp - file put elliptic curve over rational numbers, point

.SH SYNOPSIS
.nf
#include<_ec1.h>

single fputecrp(P, pf)
list P(x, y, z );
int x, y, z;
FILE *pf;

.SH DESCRIPTION
fputecrp writes the point P of an elliptic curve E/Q in the shape
    ( x/z^2 , y/z^3 ) , for z!= 0, 
    (   0 : 1 : 0   ) , else ,
to the output file *pf,
and returns 0 or ERROR in case of an error has occured. 
M*/

/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	20.11.1992	neu.  PS
   DATE fputecrp      : 921130
H*/

#include<_ec1.h>

single fputecrp( P, pf )                     
    list P;
    FILE *pf;
{
    int z;

    z = lthird( P );

    if( z )
    {
	rat x, y;
	int z1;

	bind(P,z);
	init(x,y,z1);

        z1 = iprod( z, z );
	x = rcons( lfirst( P ), z1 );
        z1 = iprod( z1, z );
	y = rcons( lsecond(P), z1 );
	if ( fprintf(pf,"( %r , %r )",x,y) < 0 ) {
	    errmsgio("fputecrp","EA110"); 
	    return(ERROR); 
	}
    }
    else
	if ( fprintf(pf,"( 0 : 1 : 0 )") < 0 ) { 
	    errmsgio("fputecrp","EA110"); 
	    return(ERROR); 
	}
    
    return( 0 );
}
