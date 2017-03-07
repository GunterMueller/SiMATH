/*M
.SH NAME                                                       
ecqnftorgr - elliptic curve over quadratic number field, torsion group                    
                 
.SH SYNOPSIS
.nf                                     
#include<_ec3.h>
    
list  ecqnftorgr(E)             
list   E;                                           
                                            
.SH DESCRIPTION                      
ecqnftorgr() returns the torsion group of an elliptic curve E over a quadratic
number field K = Q(D^(1/2))                                     
.PP                                                            
.TP 4                                                                    
.B E                                      
is a list containing all information about the elliptic curve defined over K (se
e 'ecqnfinit').       
M*/
/*H              
        Version 1       09.08.1998      S. Schmitt
   DATE ecqnftorgr     :
H*/                

# include <_ec3.h>

list ecqnftorgr(E)
list E;
{
    if( ( lfifth( lfirst( E ) ) == _0 )
    ||  ( lfirst( lfifth( lfirst( E ) ) ) == _0 ) )
    {
	/*   Torsionsgruppe des urspruenglichen   */
	/*   Modells noch nicht berechnet         */

	list BT,L,T;
	int d;
	
	bind(E);
	init(BT,L,T,d);

	T = eqisnftorgr(E);

	d = ecqnfflddisc(E);
	BT = eqisnfbtac ( E );
	T = ecqnfbtlp(d,T,BT,0);

	/** Eintrag der Torsionsgruppe in E **/

        L = lfirst( E );
	T = list2(T,_0);
	leset( L, 5, T );
	leset(  E, 1, L );

	/** Eintrag der Ordnung der Torsionsgruppe in E **/
	T = lfirst(T);
	d = llength(T);
	L = lfourth(E);
	T = list2(d,_0);
	leset(L,3,T);
	leset(E,4,L);
	

    }

    return( lfirst( lfifth( lfirst( E ) ) ) );
}

	
