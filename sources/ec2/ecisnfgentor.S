/*M
.SH NAME
ecisnfgentor - elliptic curve with integer coefficients, short normal form, generators of the torsion group

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecisnfgentor(E)  
list E;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
If the torsion group of the model in short Weierstrass normal form of the curve E/Q is cyclic, ecisnfgentor returns a list,
consisting of three integers, defining a point on the curve E, which is a generator of the torsion group.
.PP
If the torsion group is bicyclic, ecisnfgentor returns a list, consisting of two lists of integers, defining two points on E, which are generators of the torsion group.
.PP
If the list E does not contain the generators of the torsion group of the curve E, ecisnfgentor will compute it and add it to the list E. E will be changed.

.SH SEE ALSO
 ecrinit

M*/
            
/*H
	Version 1 	12.01.1993	Josef Gebel (neues Konzept,
					ecisnfgentor ersetzt ECISNFTGTOR)
	Version 2	03.11.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecisnfgentor  : 930531.931130
H*/

#include <_ec2.h>

list ecisnfgentor( E )
list E;
{
    if( ( lfifth( lthird( E ) ) == _0 )
    ||  ( lsecond( lfifth( lthird( E ) ) ) == _0 ) )
    {
	/*   EZS der Torsionsgruppe noch nicht berechnet   */

        single          n;
        list            LH1, LH2, P1, P2, L1, L2, L3;

        bind( E );

        init( L1, L2, L3 );
        init( LH1, LH2 );

        L1 = _0;
	L3 = ecisnftorgr( E );
        n  = ecrordtor( E );
    
        switch ( n )
        {
            case  1: L1 = list1( 1 );    /* zyklisch */
	             L2 = L3;
		     break;
    
            case  2: L1 = list1( 2 );    /* zyklisch */
	             if( lthird( lfirst( L3 ) ) )
		     {
	                 L2 = list1( lfirst( L3 ) );
		     }
		     else
		     {
	                 L2 = list1( lsecond( L3 ) );
		     }
		     break;
    
            case  3: L1 = list1( 3 );    /* zyklisch */
	             if( lthird( lfirst( L3 ) ) )
		     {
	                 L2 = list1( lfirst( L3 ) );
		     }
		     else
		     {
	                 L2 = list1( lsecond( L3 ) );
		     }
		     break;
    
            case  4: init( P1, P2 );
		     LH1 = L3;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
	                 {
		             /*   y-Koordinate von P1 != 0  ==>    */
		             /*   P1 hat Ordnung 4                 */
             
		             L1 = list1( 4 );          /* zyklisch */
		             L2 = list1( P1 );
			     break;
	                 }
	                 LH1 = lred( LH1 );
	             }
		     if( L1 == _0 )
		     {
		         LH1 = L3;
			 L2  = _0;
		         L1  = list2( 2,  2 );
	                 while( LH1 != _0 )
	                 {
	                     P1 = lfirst( LH1 );
	                     if( lthird( P1 ) )
			     {
				 L2 = lcomp( P1, L2 );
				 if( llength( L2 ) == 2 )
				 {
				     break;
				 }
			     }
			     LH1 = lred( LH1 );
   		         }
		     }
		     break;
    
            case  5: L1 = list1( 5 );                  /* zyklisch */
	             if( lthird( lfirst( L3 ) ) )
		     {
	                 L2 = list1( lfirst( L3 ) );
		     }
		     else
		     {
	                 L2 = list1( lsecond( L3 ) );
		     }
		     break;
    
            case  6: L1  = list1( 6 );                 /* zyklisch */
                     init( P1, P2 );
                     LH1 = L3;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
	                 {
		             /*   y-Koordinate von P1 != 0  ==>    */
		             /*   P1 hat Ordnung 3 oder 6          */
             
		             P2 = ecisnfmul( E, P1, 3 );
	                     if( lthird( P2 ) )
	                     {
		                 /*   P1 hat Ordnung 6             */
                                 L2 = list1( P1 );
			         break;
	                     }
	                 }
	                 LH1 = lred( LH1 );
	             }
		     break;
    
            case  7: L1 = list1( 7 );                  /* zyklisch */
	             if( lthird( lfirst( L3 ) ) )
		     {
	                 L2 = list1( lfirst( L3 ) );
		     }
		     else
		     {
	                 L2 = list1( lsecond( L3 ) );
		     }
		     break;
    
            case  8: init( P1, P2 );
		     LH1 = L3;
		     LH2 = _0;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
		         {
                             /*   P1 hat Ordnung 4 oder 8   */
		             P2 = ecisnfdouble( E, P1 );
		             L2 = list1( P1 );
		             if( lsecond( P2 ) )
		             {
                                 /*   P1 hat Ordnung  8     */
		             
			         L1 = list1( 8 );      /* zyklisch */
			         break;
			     }
                             /*   P1 hat Ordnung 4          */
	                 }
		         else
		         {
			     /*   In LH2 stehen die Punkte */
			     /*   mit Ordnung 2            */
			     LH2 = lcomp( P1, LH2 );
	                 }
		         LH1 = lred( LH1 );
	             }
                     if( L1 == _0 )
		     {
		         /*   In L2 steht der Punkt P1, dessen      */
		         /*   Ordnung 4 ist. Weiter gilt:           */
		         /*   P2 = 2 * P1 ==> P2 hat Ordnung 2.     */
		         /*   Gesucht wird jetzt einer der beiden   */
		         /*   Punkte der Ordnung 2, die jeweils     */
		         /*   zusammen mit P1 die Gruppe erzeugen.  */
		         /*   Dies sind genau die beiden Punkte     */
		         /*   der Ordnung 2, die ungleich P2 sind.  */
    
                         L1 = list2( 4, 2 ); 
			 LH2=lred(LH2); /**SS**/
    
		         while( LH2 != _0 )
		         {
		             P1 = lfirst( LH2 );
			     if( lfirst( P1 ) != lfirst( P2 ) )
			     {
			         /*   Zweiter Erzeuger gefunden     */
			         L2 = leins( L2, 1, P1 );
			         break;
			     }
		             LH2 = lred( LH2 );
		         }
		     }
		     break;
    
            case  9: L1  = list1( 9 );                 /* zyklisch */
                     LH1 = L3;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
		         P2 = ecisnfmul( E, P1, 3 );
	                 if( lthird( P2 ) )
	                 {
		             /*   P1 ist Punkt der Ordnung 9   */
                             L2 = list1( P1 );
			     break;
	                 }
	                 LH1 = lred( LH1 );
	             }
		     break;
    
            case 10: L1 = list1( 10 );                 /* zyklisch */
                     LH1 = L3;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
	                 {
		             /*   y-Koordinate von P1 != 0  ==>    */
		             /*   P1 ist ein Punkt der Ordnung 5   */
		             /*     oder ein Punkt der Ordnung 10  */
             
		             P2 = ecisnfmul( E, P1, 5 );
	                     if( lthird( P2 ) )
	                     {
		                 /*   P1 ist Punkt der Ordnung 10  */
                                 L2 = list1( P1 );
			         break;
	                     }
	                 }
	                 LH1 = lred( LH1 );
	             }
		     break;
    
            case 12: init( P1, P2 );
                     LH1 = L3;
		     LH2 = _0;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
		         {
                             /*   P1 hat Ordnung 3, 4, 6 oder 12   */
    
		             P2 = ecisnfdouble( E, P1 );
		             if( lsecond( P2 ) )
		             {
                                 /*   P1 hat Ordnung 3, 6 oder 12  */
    
		                 P2 = ecisnfmul( E, P1, 3 );
		                 if( lthird( P2 ) )
		                 {
                                     /*   P1 hat Ordnung 6 oder 12 */
		                     L2 = list1( P1 );
		                     if( lsecond( P2 ) )
		                     {
                                         /*   P1 hat Ordnung 12    */
		             
			                 L1 = list1( 12 ); 
			                 break;
						       /* zyklisch */
			             }
	                         }
	                     }
	                 }
		         LH1 = lred( LH1 );
	             }
                     if( L1 == _0 )
		     {
		         /*   In L2 steht der Punkt P1, dessen      */
		         /*   Ordnung 6 ist. Weiter gilt:           */
		         /*   P2 = 3 * P1 ==> P2 hat Ordnung 2.     */
		         /*   Gesucht wird jetzt einer der beiden   */
		         /*   Punkte der Ordnung 2, die jeweils     */
		         /*   zusammen mit P1 die Gruppe erzeugen.  */
		         /*   Dies sind genau die beiden Punkte     */
		         /*   der Ordnung 2, die ungleich P2 sind.  */
    
                         L1 = list2( 6, 2 ); 
    
		         LH1 = lred( L3 );
		         while( LH1 != _0 )
		         {
		             P1 = lfirst( LH1 );
			     if( lsecond( P1 ) == 0 )
			     {
			         /*   P1 hat Ordnung 2     */
			         if( lfirst( P1 ) != lfirst( P2 ) )
			         {
			             /*   Zweiter Erzeuger gefunden     */
			             L2 = leins( L2, 1, P1 );
			             break;
			         }
			     }
		             LH1 = lred( LH1 );
		         }
		     }
		     break;
             
            case 16: init( P1, P2 );
		     L1 = list2( 8, 2 );
		     LH1 = L3;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
		         {
                             /*   P1 hat Ordnung 4 oder 8   */
    
		             P2 = ecisnfdouble( E, P1 );
		             if( lsecond( P2 ) )
		             {
                                 /*   P1 hat Ordnung  8     */
			         L2 = list1( P1 );
			         break;
			     }
	                 }
		         LH1 = lred( LH1 );
	             }
		     /*   In L2 steht der Punkt P1, dessen      */
		     /*   Ordnung 8 ist. Weiter gilt:           */
		     /*   P2 = 4 * P1 ==> P2 hat Ordnung 2.     */
		     /*   Gesucht wird jetzt einer der beiden   */
		     /*   Punkte der Ordnung 2, die jeweils     */
		     /*   zusammen mit P1 die Gruppe erzeugen.  */
		     /*   Dies sind genau die beiden Punkte     */
		     /*   der Ordnung 2, die ungleich P2 sind.  */
    
		     LH1 = lred( L3 );
		     while( LH1 != _0 )
		     {
		         P1 = lfirst( LH1 );
		         if( lsecond( P1 ) == 0 )
		         {
			     /*   P1 hat Ordnung 2   */
	                     if( lfirst( P1 ) != lfirst( P2 ) )
			     {
			         /*   Zweiter Erzeuger gefunden     */
			         L2 = leins( L2, 1, P1 );
			         break;
			     }
		         }
		         LH1 = lred( LH1 );
		     }
		     break;

            default: return ( ERROR );
        }
    
        LH1 = lfourth( E );
        LH2 = list2( n, L1 );
        leset ( LH1, 3, LH2 );
        leset (   E, 4, LH1 );
    
        LH1 = lthird(  E  );
        LH2 = list2( lfirst( lfifth( LH1 ) ), L2 );
        leset ( LH1, 5, LH2 );
        leset (   E, 3, LH1 );

        return( L2 );
    }
    
    return( lsecond( lfifth( lthird( E ) ) ) );
}
