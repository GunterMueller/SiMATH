/*M
.SH NAME
ecrrank - curve over the rational numbers, rank

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrrank(E)
list (E);

.SH DESCRIPTION
ecrrank() returns the rank of the free part of the Mordell-Weil
group of the elliptic curve E/Q.
.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.SH NOTE
The method used for the computation of the rank depends on the
value of the global variable _R_C_M (rank computation method).

.TP 4
.B _R_C_M = 0
If a 2-isogeny on E/Q exists, the rank is computed by 2-descent using the 2-isogeny. 
If this method is not successful or if there is no
2-isogeny, the rank is computed by general 2-descent.
If this method does not succeed, the rank is computed using the 
conjecture of Birch and Swinnerton-Dyer (Manin's conditional algorithm).

.TP 4
.B _R_C_M = 1
If a 2-isogeny on E/Q exists, the rank is computed by 
2-descent using the isogeny. Otherwise, the return value is ERROR.
 
.TP 4
.B _R_C_M = 2
The rank is computed by general 2-descent.

.TP 4
.B _R_C_M = 3
The rank is computed using the conjecture of Birch and 
Swinnerton-Dyer (Manin's conditional algorithm).

The default value if _R_C_M is 0.

.SH NOTE
The global variable _H_BOUND is used to limit the bounds
for a point search, i.e. it holds that max{|x|,|z|}<_H_BOUND.
If _H_BOUND equals 0, the point search in Manin's algorithm is not
limited, but it is limited by 11 in the methods of 2-descent.
The default value of _H_BOUND is 11.

.SH SEE ALSO
ecrinit, ecrrank2d ,ecrrankg2d
M*/
/*H
	Version 1	21.01.1993	Josef Gebel (neues Konzept, 
					ecrrank ersetzt ECIRKBSD)
	Version 2	10.07.1993	Konstante LC_BOUND eingef. JG. 
	Version 3	11.10.1995	Auslagerung der eigentlichen Berechnung
                                        in die Funktion ECRRANKS (um das Array 
                                        A mit den Koeffizienten der L-Reihe zu 
                                        retten. JG.
                                        2-Abstieg nach Tate, falls 2-Torsion 
                                        nichttrivial. JG.
	Version 4	12.03.1996	Unterscheidung zwischen Rangberechnung
                                        mittels 2-Abstieg (bei nichttrivialer 
                                        2-Torsion: `ecrrank2d') und via
                                        Vermutung von Birch und 
					Swinnerton-Dyer (`ecrrankbsd'). JG.
        Version 5       10.12.1996      Berechnung des Rangs auch mit
	                                allgemeinem 2-Abstieg. Einfuehrung 
                                        der globalen Steuervariable _R_C_M. JG.
   DATE ecrrank       :  930531.931130.951201.960501.970101
H*/

#include<_ec2.h>

extern single _R_C_M;	/** wird noch in SIMATH eingebaut **/

single ecrrank( E )
list E;
{
    bind( E );
    if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lsecond( lfourth( lfourth( E ) ) ) == ERROR ) )
    {
	/***   The rank 4 has not yet been computed   ***/
        single r;

        switch( _R_C_M )
        {
            case  0: 
            case  1: if( ( ecrordtor( E ) % 2 ) == 0 )
                     {
                         /***   2 - isogeny - descent possible   ***/
         
                         if( ( r = ecrrank2d( E ) ) != ERROR )
                         { 
                             return( r );
                         }
                     }
                     if( _R_C_M )
                     { 
                         return( ERROR );
                     }
            case  2: if( ( ( r = ecrrankg2d( E ) ) != ERROR ) || _R_C_M )
                     {
                         return( r );
                     }
            case  3: return( ecrrankbsd( E ) );
            default: return( ERROR );
        }
    }

    return( lsecond( lfourth( lfourth( E ) ) ) );
}   
