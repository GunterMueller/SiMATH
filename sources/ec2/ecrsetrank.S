/*M
.SH NAME
ecrsetrank - curve over the rational numbers, set rank

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrsetrank(E, r)
list E;
single r;

.SH DESCRIPTION
ecrsetrank() enters the value r of the rank of E/Q at its correct 
position in the list E and modifies the value C of the sign of the 
functional equation of the L-series of E according to the value of r.
All other entries in E that depend on the value of r such as 
all further entries in the list L44 and all entries containing bases
(for each of the three models) will be deleted if they exist.
On successful completion, ecrsetrank() returns 0 and ERROR otherwise.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.
.TP 4
.B r
must be a  be a non-negative single.

.SH SEE ALSO
ecrinit
M*/




/*H
        Version 1       01.12.96      Josef Gebel
   DATE ecrsetrank  : 961201
H*/


#include <_ec2.h>

single ecrsetrank(E, r)
list   E;
single r;
{
    if( r >= 0 )
    {
        single C;
        list   L, M;

        init( L, M );
        bind( E );

        if( r % 2 )
        {
            C = -1;
        }
        else
        {
            C = 1;
        }

        L = lfourth( E );
        M = list6( C, r, 0, 0, 0, 0 );
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
