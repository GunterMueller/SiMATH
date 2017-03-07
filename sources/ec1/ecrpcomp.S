/*M
.SH NAME
ecrpcomp - elliptic curve over rational numbers, point comparison
                                                                      
.SH SYNOPSIS                                                                  
.nf                                                                           
#include<_ec1.h>

single ecrpcomp(P1, P2)  
list P1, P2;                                                                     
.SH DESCRIPTION
.TP 4
.B Pi 
= ( xi yi zi )      i = 1,2
 rat xi, yi, zi; 
 define the points P1, P2.  
 P1, P2 must be normed (s. ecrpnorm ).
.PP
ecrpcomp returns :
   1, for P1 = P2,      i.e. x1 = x2, y1 = y2, z1 = z2,
  -1, for P1 = - P2,    i.e. x1 = x2, y1 != y2, z1 = z2,
   0, for P1 != +/- P2, i.e. x1 != x2    or    z1 != z2. 
.SH SEE ALSO
ecrpnorm
                                                                  
M*/  

/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	28.12.1992	Doku neu.  PS
	Version 3	27.01.1993	Leichte Aendereungen. JG
   DATE ecrpcomp      : 921130.930115.930531
H*/

#include <_ec1.h>
	    
single ecrpcomp( P1, P2 )
    list P1, P2;
{
    bind( P1, P2 );

    if( icomp( lfirst( P1 ), lfirst( P2 ) ) )
    {
	return( 0 );
    }

    if( icomp( lthird( P1 ), lthird( P2 ) ) )
    {
	return( 0 );
    }
        
    /* P1 = +/- P2  */

    if( icomp( lsecond( P1 ), lsecond( P2 ) ) )
    {
        /* P1 = - P2  */
	return( -1 );
    }
    
    /* P1 = P2  */
    return( 1 );
}
