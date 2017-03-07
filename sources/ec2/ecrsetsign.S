/*M
.SH NAME
ecrsetsign - curve over the rational numbers, set sign

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrsetsign(E, C)
list E;
single C;

.SH DESCRIPTION
ecrsetsign() enters the value C of the sign of the functional
equation of the L-series of E at its correct position in the list E.
All other entries in E that depend on the value of C such as 
all further entries in the list L44 and all entries containing bases
(for each of the three models) will be deleted if they exist.
On successful completion, ecrsetsign() returns 0 and ERROR otherwise.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.
.TP 4
.B C
must either be +1 or -1. 

.SH SEE ALSO
ecrinit
M*/
/*H
        Version 1       01.12.96      Josef Gebel
   DATE ecrsetsign  : 961201
H*/
	

#include <_ec2.h>

single ecrsetsign(E, C)
list   E;
single C;
{
    if( sabs( C ) == 1 )
    {
        list L, M;
        init( L, M );

        bind( E );

        L = lfourth( E );
        M = list6( C, ERROR, 0, 0, 0, 0 );
        leset( L, 4, M );
        leset( E, 4, L );

        L = lfirst( E );
        leset( L, 7, _0 );
        leset( E, 1, L );

        L = lsecond( E );
        leset( L, 7, _0 );
        leset( E, 2, L );

        L = lthird( E );
        leset( L, 7, _0 );
        leset( E, 3, L );

        return( 0 );
    }
    return( ERROR );
}
