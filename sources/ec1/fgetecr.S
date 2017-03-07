/*M
.SH NAME
fgetecr - file get elliptic curve over rational numbers                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_ec1.h>

list fgetecr(pf)
FILE *pf;
                                                                       
.SH DESCRIPTION
fgetecr reads the elliptic curve 

   E: Y^2 + a1 XY + a3 Y = X^3 + a2 X^2 + a4 X + a6
    
with rational coefficients a1, a2, a3, a4, a6
from the input file *pf, and returns a 
   list (a1 a2 a3 a4 a6 ) 
   rat a1, a2, a3, a4, a6 .
                                                                  
M*/

/*H
	Version 1       17.12.1992	Josef Gebel (neues Konzept)
   DATE fgetecr       : 930531
H*/

#include <_ec1.h>

list fgetecr( pf  )
FILE *pf;
{
    rat a1r, a2r, a3r, a4r, a6r;

    init( a1r, a2r, a3r, a4r, a6r );

    if( ( a1r = fgetr( pf ) ) == ERROR )
    {
        return( ERROR );
    }
   
    if( ( a2r = fgetr( pf ) ) == ERROR )
    {
        return( ERROR );
    }
    
    if( ( a3r = fgetr( pf ) ) == ERROR )
    {
        return( ERROR );
    }
    
    if( ( a4r = fgetr( pf ) ) == ERROR )
    {
        return( ERROR );
    }
    
    if( ( a6r = fgetr( pf ) ) == ERROR )
    {
        return( ERROR );
    }

    return( list5( a1r, a2r, a3r, a4r, a6r ) );

}
