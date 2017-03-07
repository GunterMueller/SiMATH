/*M
.SH NAME
 getecr - get elliptic curve over the rational numbers

.SH SYNOPSIS
.nf
 #include<_ec1.h>

 list getecr( );

.SH DESCRIPTION

 getecr reads the rational coefficients
 a1, a2, a3, a4, a6 of an elliptic curve
 E : Y^2 + a1 XY + a3 y = X^3 + a2 X^2 + a4 X + a6
 from stdin and returns a list ( a1 a2 a3 a4 a6 )
                          rat a1, a2, a3, a4, a6.
M*/
/*H
	Version 1      	17.12.1992   	Josef Gebel (neues Konzept)
   DATE getecr        : 930531
H*/

#include <_ec1.h>

list getecr(  )
{
    rat a1r, a2r, a3r, a4r, a6r;

    init( a1r, a2r, a3r, a4r, a6r );

    do
    {
        printf("\n   a1 :   ");
    }
    while( ( a1r = getr( ) ) == ERROR );
   
    do
    {
        printf("\n   a2 :   ");
    }
    while( ( a2r = getr( ) ) == ERROR );
    
    do
    {
        printf("\n   a3 :   ");
    }
    while( ( a3r = getr( ) ) == ERROR );
    
    do
    {
        printf("\n   a4 :   ");
    }
    while( ( a4r = getr( ) ) == ERROR );
    
    do
    {
        printf("\n   a6 :   ");
    }
    while( ( a6r = getr( ) ) == ERROR );

    return( list5( a1r, a2r, a3r, a4r, a6r ) );

}
