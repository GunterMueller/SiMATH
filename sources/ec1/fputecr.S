/*M
.SH NAME
fputecr - file put elliptic curve                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_ec1.h>

single fputecr(E, pf)
list E;
FILE *pf;
                                                                       
.SH DESCRIPTION
fputecr writes the data of the elliptic curve E/Q, beeing found in the list E, 
to the output file *pf 
and returns 0 or ERROR in case an error has occured.
A description of the list E can be found in the documentation of 'ecrinit'
                                                                 
.SH SEE ALSO
ecrinit                                                                    
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
   DATE fputecr       : 930531
H*/	

#include <_ec1.h>

fputecr( E, pf )
list E;
FILE *pf;
{
    bind( E );
    
    if( fprintf( pf, "\n\n") < 0 )
    {
       return( ERROR );
    }

    if( fputecrac( E, pf ) == ERROR )
    {
       return( ERROR );
    }

    if( fputecimin( E, pf ) == ERROR )
    {
       return( ERROR );
    }

    if( fputecisnf( E, pf ) == ERROR )
    {
       return( ERROR );
    }

    if( fputecrinv( E, pf ) == ERROR )
    {
       return( ERROR );
    }
    
    return( 0 );
}   
