/*M
.SH NAME
ecrregulator - elliptic curve over the rational numbers, regulator

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecrregulator(E)  
list E;
      
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.            
.PP
ecrregulator computes the regulator of the elliptic curve E/Q with an error smaller than 10^-(NTH_EPS).
.PP
ecrregulator uses the global double variable _H_BOUND (default _H_BOUND = 0.0).
For _H_BOUND = 0, ecrregulator searches for points with unbounded Weil height, for
_H_BOUND = h > 0, ecrregulator searches for points with Weil height smaller than h.
.PP
ecrregulator returns the regulator of the curve E or -1 in case of an error occurs.

.SH SEE ALSO
 ecrinit

M*/
                             
/*H
	Version 1	06.04.1992	Josef Gebel (neues Konzept,
					ecrregulator ersetzt ECIREG)
	Version 2	18.10.1993	Warnung des Apollo-Compilers
					beseitigt.  PS
	Version 3	21.11.1994	In der Dokumentation auf die globale
					Variable _H_BOUND verwiesen. MP
   DATE ecrregulator  : 921130.930531.931130.941201
H*/

#include <_ec2.h>

floating ecrregulator( E )
list E;
{
    if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lfourth( lfourth( lfourth( E ) ) ) == 0 ) )
    {
	/*   Regulator noch nicht berechnet   */
   
        bind( E );
  
        ecrmaninalg( E );
    }

    return( lfourth( lfourth( lfourth( E ) ) ) );
}
