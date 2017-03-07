/*M
.SH NAME
ecrprodcp - elliptic curve over the rationals, product over all c_p- values

.SH SYNOPSIS
.nf
#include<_ec2.h>

int ecrprodcp(E)  
list E;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.   
.PP
ecrprodcp returns the product over all c_p values with p divides the conductor of the curve E/Q, or ERROR in case of an error occurs.
.PP
If the list E does not contain the product over the c_p values, ecrprodcp will compute the product (with help of ecrcond) and add it to E. E will be changed.
 
.SH SEE ALSO
 ecrinit
 ecitatealg
 ecrcond

M*/
            
/*H
	Version 1	17.12.1992	Josef Gebel
   DATE ecrprodcp     : 930531.9311__
H*/	

#include <_ec2.h>

int ecrprodcp( E )
list E;
{
    bind( E );
    
    if( lsecond( lfourth( E ) ) == _0 )
    {
	/*  Das Produkt uber alle c_p-Werte ist noch nicht berechnet  */
        int  N;
        init( N );

	N = ecrcond( E );
    
        if( N == ERROR )
        {
	    return( ERROR );
        }
    }

    return( lfirst( lfourth( lsecond( lfourth( E ) ) ) ) );
}   
