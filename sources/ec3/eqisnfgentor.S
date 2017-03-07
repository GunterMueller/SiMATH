/*M
.SH NAME
eqisnfgentor - elliptic curve over quadratic number field with integral 
coefficients, short normal form, generators of torsion group

.SH SYNOPSIS
.nf
#include<_ec3.h>

list eqisnfgentor(E)
list E;

.SH DESCRIPTION
eqisnfgentor() returns a list (P) or (P Q) with the generators of the torsion
group of E(K) as projective points, if the torsion group is cyclic or 
bicyclic, respectively. If the torsion group is not yet computed, it will be 
computed and stored in E.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over a
quadratic number field K (see 'ecqnfinit').
M*/
/*H
        Version 1       19.08.1998      S. Schmitt
   DATE eqisnfgentor   : 980830
H*/

#include <_ec3.h>

list eqisnfgentor( E )
list E;
{
    if( lthird(E)==_0 ||
	( lfifth( lthird( E ) ) == _0 )
    ||  ( lsecond( lfifth( lthird( E ) ) ) == _0 ) )
    {
	/*   EZS der Torsionsgruppe noch nicht berechnet   */

        single          n;
        list            LH1, LH2, P1, P2, L1, L2, L3;
	int d;

        bind( E );

        init( L1, L2, L3 );
        init( LH1, LH2 );
	init(d);

        L1 = _0;
	L3 = eqisnftorgr( E );
        n  = ecqnfordtor( E );
	d = ecqnfflddisc(E);
    
        switch ( n )
        {
            case 1: L1 = list1( 1 );    /* zyklisch trivial */
	            L2 = L3;
		    break;
            case  2: 	/** zyklisch Primzahlordnung **/
            case  3: 
            case  5: 
            case  7: 
            case 11: 
            case 13: L1 = list1( n );  
	             if( lthird( lfirst( L3 ) ) ) L2 = list1( lfirst( L3 ) );
		     else 			  L2 = list1( lsecond( L3 ) );
		     break;
            case  4: init( P1 );
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
				 if( llength( L2 ) == 2 ) break;
			     }
			     LH1 = lred( LH1 );
   		         }
		     }
		     break;
    
            case  6: 
            case 10: 
	    case 14: L1  = list1( n );                 /* zyklisch */
                     init( P1, P2 );
                     LH1 = L3;
		     n = iquot(n,2);
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
	                 {
		             /*   y-Koordinate von P1 != 0  ==>    */
		             /*   P1 hat Ordnung 3 oder 6          */
			     /*   bzw. 5 oder 10                   */
			     /*   bzw. 7 oder 14                   */
             
		             P2 = eqisnfmul( d, E, P1, n );
	                     if( lthird( P2 ) )
	                     {
		                 /*   P1 hat Ordnung 6, 10 bzw. 14 */
                                 L2 = list1( P1 );
			         break;
	                     }
	                 }
	                 LH1 = lred( LH1 );
	             }
		     n = isum(n,n);
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
		             P2 = eqisnfdouble( d, E, P1 );
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
		

                     if( L1 == _0 )	/** nicht zyklisch **/
		     {
		         /*   In L2 steht der Punkt P1, dessen      */
		         /*   Ordnung 4 ist. (Es kann nur einen     */
			 /*   geben!) Weiter gilt:                  */
		         /*   P2 = 2 * P1 ==> P2 hat Ordnung 2.     */
		         /*   Gesucht wird jetzt einer der beiden   */
		         /*   Punkte der Ordnung 2, die jeweils     */
		         /*   zusammen mit P1 die Gruppe erzeugen.  */
		         /*   Dies sind genau die beiden Punkte     */
		         /*   der Ordnung 2, die ungleich P2 sind.  */
    
                         L1 = list2( 4, 2 ); 
    
		         while( LH2 != _0 )
		         {
		             P1 = lfirst( LH2 );
			     if( lthird(P1) && lfirst( P1 ) != lfirst( P2 ) )
			     {
			         /*   Zweiter Erzeuger gefunden     */
			         L2 = leins( L2, 1, P1 );
			         break;
			     }
		             LH2 = lred( LH2 );
		         }
		     }
		     break;
    
            case  9: init( P1, P2 );
		     LH1 = L3;
		     LH2 = _0;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
			 P2 = eqisnfmul( d, E, P1, 3 );
	                 if( lthird( P2 ) )
		         {
                             /*   P1 hat Ordnung 9   */
		             
			    L1 = list1( 9 );      /* zyklisch */
			    L2 = list1( P1 );
			    break;
	                 }
		         else if(lthird(P1))
		         {
			     /*   In LH2 stehen die Punkte */
			     /*   mit Ordnung 3            */
			     LH2 = lcomp( P1, LH2 );
	                 }
		         LH1 = lred( LH1 );
	             }
                     if( L1 == _0 )	/** nicht zyklisch **/
		     {
		         /*   In LH2 stehen die Punkte mit          */
		         /*   Ordnung 3                             */
    
                         L1 = list2( 3, 3 ); 

			 P1 = lfirst(LH2);
			 LH2 = lred(LH2); 
    
		         while( LH2 != _0 )
		         {
		             P2 = lfirst( LH2 );
			     if( lfirst( P1 ) != lfirst( P2 ) )
			     {
			         /*   Zweiter Erzeuger gefunden     */
			         L2 = list2( P1,P2);
			         break;
			     }
		             LH2 = lred( LH2 );
		         }
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
    
		             P2 = eqisnfdouble( d, E, P1 );
		             if( lsecond( P2 ) )
		             {
                                 /*   P1 hat Ordnung 3, 6 oder 12  */
    
		                 P2 = eqisnfmul( d, E, P1, 3 );
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
			 else if(!lsecond(P1)) LH2 = lcomp(P1,LH2);
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
  
			 /** in LH2 stehen die Punkte der Ordnung 2 **/ 
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
	    case 15: init(P1,P2);
		     L1 = list1(15); /** zyklisch **/
		     LH1 = L3;
		     while(LH1!=_0)
		     {	
			P1 = lfirst(LH1);
			P2 = eqisnfmul(d,E,P1,3);
			if(lthird(P2))
			{	
				/** P1 hat Ordnung 5 oder 15 **/
				P2 = eqisnfmul(d,E,P1,5);
				if(lthird(P2))
				{
					/** P1 hat Ordnung 15 **/
					L2 = list1(P2);
					break;
				}
			}
			LH1 = lred(LH1);
		     }
		     break;
					
            case 16: init( P1, P2 );
                     LH1 = L3;
		     LH2 = _0;
		     L2 = _0;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
		         {
                             /*   P1 hat Ordnung 4, 8 oder 16   */
    
		             P2 = eqisnfdouble( d, E, P1 );
		             if( lsecond( P2 ) )
		             {
                                 /*   P1 hat Ordnung 8 oder 16  */
    
		                 P2 = eqisnfdouble( d, E, P2 );
		                 if( lsecond( P2 ) )
		                 {
                                     /*   P1 hat Ordnung 16 */
		                     L2 = list1( P1 );
			             L1 = list1( 16 ); 
			             break;
						       /* zyklisch */
	                         }
				 L2 = list1( P1 );
	                     }
			     LH2 = lcomp(P1, LH2);
	                 }
			 LH1 = lred(LH1);
		     }
                     if( L1 == _0 && L2 != _0)
		     {
		         /*   In L2 steht ein Punkt P1, dessen      */
		         /*   Ordnung 8 ist.                        */

                         L1 = list2( 8, 2 ); 

			 P2 = lfirst(L2);
			 P2 = eqisnfdouble(d,E,P2);
			 P2 = eqisnfdouble(d,E,P2);
			
			 /* Es ist P2=4*P1 ein Punkt der Ordnung 2 */
			 /* Gesucht wird ein Punkt der Ordnung 2,  */
			 /* der ungleich P2 ist                    */

			 LH1 = L3;
    
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
		     else if(L1==_0)
		     {
			/* in LH2 stehen alle Punkte mit Ordnung 4 */

			L1 = list2(4,4);
			P1 = lfirst(LH2);
			LH2 = lred(LH2);
			while(LH2!=_0)
			{
			   P2 = lfirst(LH2);

			   if(lfirst(P1)!=lfirst(P2))
			   {
				/** P2 != +- P1 **/
				P2 = eqisnfsum(d,E,P1,P2);
				if(lsecond(P2))
				{
					/** 2*(P1+P2)!=0 **/
					L2 = list2(P1,P2);
					break;
				}
			   }
			   LH2 = lred(LH2);
			}
		     }
		     break;
	    case 18: init(P1,P2);
		     L1 = list1(18); /** zyklisch **/
		     LH1 = L3;
		     while(LH1!=_0)
		     {	
			P1 = lfirst(LH1);
			if(lthird(P1) && lsecond(P1))
			{	
			    /** P1 hat Ordnung 3, 6, 9 oder 18 **/
			    P2 = eqisnfmul(d,E,P1,3);
			    if(lthird(P2) && lsecond(P2))
			    {
				/** P1 hat Ordnung 9 oder 18 **/
			    	P2 = eqisnfmul(d,E,P1,3);
			    	if(lthird(P2))
			    	{
					/** P1 hat Ordnung 18 **/
					L2 = list1(P2);
					break;
				}
			    }
			}
			LH1 = lred(LH1);
		     }
		     break;
	    case 20: init(P1,P2);
		     L1 = list2(10,2);
		     LH1 = L3;
		     while(LH1!=_0)
		     {	
			P1 = lfirst(LH1);
			if(lthird(P1) && lsecond(P1))
			{	
			    /** P1 hat Ordnung 5 oder 10 **/
			    P2 = eqisnfmul(d,E,P1,5);
			    if(lthird(P2))
			    {
				/** P1 hat Ordnung 10 **/
				L2 = list1(P1);
				break;
			    }
			}
			LH1 = lred(LH1);
		     }
			/** L2 enth"alt einen Punkt der Ordnung 10. 
			   P2 = 5*P1 ist ein Punkt der Ordnung 2. 
				Gesucht ist ein Punkt der Ordnung 2, != P2 **/

		     LH1 = L3;
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
		     break;
	    case 24: init(P1,P2);
		     L1 = list2(12,2);
		     LH1 = L3;
		     while(LH1!=_0)
		     {	
			P1 = lfirst(LH1);
			if(lthird(P1) && lsecond(P1))
			{	
			    /** P1 hat Ordnung 3,4,6 oder 12 **/
			    P2 = eqisnfdouble(d,E,P1);
			    if(lsecond(P2))
			    {
				/** P1 hat Ordnung 3,6 oder 12 **/
				P2 = eqisnfmul(d,E,P1,3);
				if(lthird(P2) && lsecond(P2))
				{
					/** P1 hat Ordnung 12 **/
					L2 = list1(P1);
					break;
				}
			    }
			}
			LH1 = lred(LH1);
		     }
		     P2 = eqisnfdouble(d,E,P2);
			/** L2 enth"alt einen Punkt der Ordnung 12. 
			   P2 = 6*P1 ist ein Punkt der Ordnung 2. 
				Gesucht ist ein Punkt der Ordnung 2, != P2 **/

		     LH1 = L3;
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
		     break;
            case 36: init( P1, P2 );
		     L1 = (6,6);
                     LH1 = L3;
		     LH2 = _0;
	             while( LH1 != _0 )
	             {
	                 P1 = lfirst( LH1 );
	                 if( lsecond( P1 ) && lthird( P1 ) )
		         {
                             /*   P1 hat Ordnung 3 oder 6   */
    
		             P2 = eqisnfmul( d, E, P1,3 );
		             if( lthird( P2 ) )
		             {
                                 /*   P1 hat Ordnung 6 */
    
		                     LH2 = lcomp( P1, LH2 );
	                     }
	                 }
			 LH1 = lred(LH1);
		     }
			/** LH2 enthaelt alle Punkte der Ordnung 6 **/

		     P1 = lfirst(LH2);
		     LH2 = lred(LH2);
		     while(LH2!=_0)
		     {
			P2 = lfirst(LH2);
			if(lfirst(P2)!=lfirst(P1))
			{
				/** P2!= +- P1 **/
			    P2 = eqisnfsum(d,E,P1,P2);
			    if(lsecond(P2!=0))
			    {
				/** 2*(P1+P2)!=0 **/
				LH1 = eqisnfmul(d,E,P2,3);
				if(lthird(LH1)!=0)
				{
					/** 3*(P1+P2)!=0 **/
				   P2 = eqisnfsum(d,E,P1,P2);
				   if(lsecond(P2)!=0)
				   {	
					/** 2*(2P1 + P2)!=0 **/
					L2 = lcomp(P1,P2);
					break;
				   }
				}
			    }
			}
			LH2 = lred(LH2);
		     }
		     break;


            default: return ( ERROR );
        }
   
	/** Eintrag der Ordnung und der Struktur in E **/ 
        LH1 = lfourth( E );
        LH2 = list2( n, L1 );
        leset ( LH1, 3, LH2 );
        leset (   E, 4, LH1 );
   
	/** Eintrag des Erzeugers in E **/ 
        LH1 = lthird(  E  );
        LH2 = list2( lfirst( lfifth( LH1 ) ), L2 );
        leset ( LH1, 5, LH2 );
        leset (   E, 3, LH1 );

        return( L2 );
    }
    
    return( lsecond( lfifth( lthird( E ) ) ) );
}
