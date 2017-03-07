/*M
.SH NAME
ecisnffdisc - elliptic curve with integer coefficients, short normal form, factorization of discriminant

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecisnffdisc(E1)  
list E1;

.SH DESCRIPTION
ecisnffdisc computes the complete ( prime-)factorization of |D|, where D is the 
discriminant of the model in short normal form representing the elliptic curve E/Q.          
.P                                                                              
|D| = p1^e1 * ...* pn^en                                                        
.P                                                                              
ecisnffdisc returns the list                                                    
.P                                                                              
 F = ( p1 e1 p2 e2 ... pn en )                                                  
 int p1, ..., pn;                                                               
 single e1, ..., en;                                                            
.P                                                                              
If E1 does not contain the list F , F will be added to E1.                      
.TP 4                                                                           
.B E1       
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
      
.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
	Version 2	30.09.1993	Der Eintrag in 'lthird(E)' ist 
					'list3(D, FD, 0)' statt bisher 
					'list2(D, FD)'.  JG
   DATE ecisnffdisc   : 930531.931130
H*/	

#include <_ec1.h>

list ecisnffdisc( E )
list E;
{
        bind( E );
    if( ( lfourth( lthird( E ) ) == _0 )
    ||  ( lsecond( lfourth( lthird( E ) ) ) == _0 ) )
    {
	/*   Die Diskriminante ist noch nicht         */
	/*   berechnet bzw. noch nicht faktorisiert   */

        int D;
        list L, M, F;
    
        /**bind( E ); **/
    
        init( L, M, F );
	init( D );

	D = ecisnfdisc( E );
	F = ifact( iabs( D ) );
	F = linv ( F );
	F = ifel ( F );

	L = lthird ( E );
	M = lfourth( L );
	leset( M, 2, F );
	leset( L, 4, M );
	leset( E, 3, L );

	return( F );
    }

    return( lsecond( lfourth( lthird( E ) ) ) );
}   
