/*M
.SH NAME
ecisnftorgr - elliptic curve with integer coefficients, short normal form, torsion group

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecisnfnftor(E)  
list E;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
ecisnftorgr returns a list
.IP
 (T1 T2 .... Tt) list T1, ...,Tt;
.PP
containing all points
.IP
Ti = (xi yi zi) int xi, yi, zi; (1 <= i <= t)
.PP
of the torsion group of the model in short normal form of E/Q.
.PP
In order to compute the torsion group of the model in short normal form, ecisnftorgr uses the theorem of Nagell-Lutz-Cassels.
If necessary, the torsion group of the model in short normal form will be added to the list E.
The list E will be changed.

.SH SEE ALSO
ecrinit
   
M*/

/*H
	Version 1 	21.12.1992	Josef Gebel (neues Konzept,
					ecisnftorgr ersetzt ECISNFTOR)
	Version 2 	03.07.1993	Fall #Etor(Q) == 2 separat.  JG
   DATE ecisnftorgr   : 920331.930531.931130.941201
H*/

#include <_ec2.h>

#define HIT     4
#define PRIME1 23
#define PRIME2 19

/*****************************************************************************/
/***                                                                       ***/
/***  S T A T I C   F U N C T I O N S    ( A N F A N G )                   ***/
/***                                                                       ***/
/*****************************************************************************/

/*c
			listofmults( E, P )

	"list of multiples"
	list listofmults( E, P )  list E, P;
	L = listofmults( E, P );
	P = ( x, y, z ) ist ein Torsionspunktpunkt auf der durch E
	in kWNF gegeben elliptischen Kurve E/Q. listofmults liefert 
	eine Liste mit den verschiedenen Vielfachen von P.
	listofmults ist ein static-Modul zu ecisnftorgr.
c*/
/*H
	Version 1 	11.09.1991	Michael Pfeifer
	Version 2 	21.12.1992	Anpassung an neues Konzept. 
					Josef Gebel.
	Version 3 	16.07.1993	Abfrage, ob #Etor = 2. JG.
H*/

static list     listofmults( E, P )
list            E, P;
{
    single          i;
    list            Q, LM;
    
    bind( E, P );
    init( Q, LM );
    
    LM = list1( P );
    Q = lcopy( P );
    
    while( 1 )
    {
        /*** Berechnung der Vielfachen des Punktes P.           */
	/*** Die Punkte sind dargestellt mit ganzen Koordinaten */

        Q = ecisnfsum( E, P, Q );
        LM = lcomp( Q, LM );
        if( ispecrpai( Q ) )
	{
	    break;
	}
    }
    return( LM );
}

 /******************* Ende von listofmults.  *******************/

/*c
			lopmerge( E, LP, LM )

	"list of points merge"
	list lopmerge( E, LP, LM )  list E, LP, LM;
	L = lopmerge( E, LP, LM );
	LP und LM sind Listen von Torsionspunkten auf dem durch E 
	gegebenen Modell in kWNF derelliptischen Kurve E/Q.
	lopmerge berechnet eine Liste L, die aus allen Summen der 
	Punkte aus LP und LM besteht. Durch die Summation mehrfach
	vorkommende Punkte werden nur einmal in L eingetragen. 
	lopmerge ist ein static-Modul zu ersnftorg.
c*/
/*H
	Version 1 	11.09.1991	Michael Pfeifer
	Version 2 	21.12.1992	Anpassung an neues Konzept. 
H*/

static list     lopmerge( E, LP, LM )
    list            E, LP, LM;
{
    list            L, LPH, LMH;
    list            P1, P2, P;

    bind( E, LP, LM );

    init( L, LPH, LMH );
    init( P1, P2, P );

    L = _0;

    LPH = LP;
    LMH = LM;

    while( LMH != _0 )
    {
	P1 = lfirst( LMH );
	LMH = lred( LMH );
	while( LPH != _0 )
	{
	    P2 = lfirst( LPH );
	    LPH = lred( LPH );

	    P = ecisnfsum( E, P1, P2 );

	    if( lmemb( P, L ) == 0 )
	    {
		L = lcomp( P, L );
	    }
	}
	LPH = LP;
    }
    return( L );
}

/***************** Ende von lopmerge.  ****************/

/*****************************************************************************/
/***                                                                       ***/
/***  S T A T I C   F U N C T I O N S    ( E N D E )                       ***/
/***                                                                       ***/
/*****************************************************************************/

ecisnftorgr( E )
list E;
{
        bind( E );
    if( lfifth( lthird( E ) ) == _0 )
    {
	/*   Torsionsgruppe noch nicht berechnet   */

        single     i, n, m, q, a4, a6, hits;
        int        p, A4, A6, D, x, y1, y2, hi1, hi2;
        list       L, LM, LP, Lh1, Lh2, P, Q;
        pol        R;
      
        /**bind( E ); **/

        init( A4, A6, D );
        init( p, x, y1, y2, hi1, hi2 );
        init( L, LM, LP, Lh1, Lh2, P, Q );
	init( R );

	A4 = ecisnfa4( E );
	A6 = ecisnfa6( E );
	D  = ecimindisc( E );

        /*   HIT ist die Anzahl der Primzahlen q, fuer die die   */
        /*   Gruppenordnung ueber dem Restklassenkoerper mod q   */
	/*   bestimmt wird.                                      */
        /*   hits enthaelt die Anzahl der bereits untersuchten   */
	/*   Primzahlen.                                         */
        hits = 0;
        
	/*   i ist die Nummer der aktuellen Primzahl q in der    */
        /*   (globalen) Liste LIST_SP, die die ersten 167        */
	/*   Primzahlen enthaelt.                                */
        i = 1;

        /*  n enthaelt das Vielfache der Gruppenordnung.         */
        n = 0;  

        while( ( hits <= HIT ) && ( i <= 167 ) )
        {
	    i++;
	    q = LIST_SP[i];
	    if( mshom( q, D ) )
	    {
		/*** E hat gute Reduktion modulo q ***/
                a4 = mshom( q, A4 );
                a6 = mshom( q, A6 );
	        m = ecmspsnfnp( q, a4, a6 );
                n = sgcd( m, n );
                if( n == 1 )
                {
                    break;
                }
                hits++;
	    }
        }   /*  ENDE: while( ( hits <= HIT ) && ( i <= 167 ) ) */	

        LP = list1( list3( 0, 1, 0 ) );

	if( n == 2 )
	{
	    /***   Die Torsionspunkte sind ( 0, 1, 0 ) und      ***/
            /***   ( x, 0, 1 ), wobei x noch zu bestimmen ist   ***/

	    if( A4 )
	    {
	        if( A6 )
	        {
		    R = list6( 3, 1, 1, A4, 0, A6 );
	        }
	        else
	        {
		    R = list4( 3, 1, 1, A4 );
	        }
	    }
	    else
	    {
		R = list4( 3, 1, 0, A6 );
	    }

            Lh1 = upifact( R );
	    Lh1 = lred( Lh1 );
	        
            while( Lh1 != _0 )
	    {
		if( pdegree( 1, lfirst( Lh1 ) ) == 1 )
		{
   
		    /*   x ist Nullstelle von R.              */
    
		    if( llength( lfirst( Lh1 ) ) == 2 )
		    {
			x = 0;
		    }
		    else
		    {
			x = ineg( lfourth( lfirst( Lh1 ) ) );
		    }
        
		    LM = list1( list3( 0, 1, 0 ) );
       
		    P = list3( x, 0, 1 );
		    LP = list2( list3( 0, 1, 0 ), P );
	       }
               Lh1 = lred2( Lh1 );
	    }
	}
        if( n > 2 )
	{

            /*  Reduktion der Faktorliste Lh1. Alle Primzahlen, die   */
	    /*  nicht wenigstens quadratisch in D/16 auftreten,       */
	    /*  treten in Lh2 nicht mehr auf.                         */

            Lh1 = ecisnffdisc( E );
	    m = lsecond( Lh1 ) - 4;
            Lh1 = lred2( Lh1 );
	    Lh1 = lcomp2( 2, m, Lh1 );
	    /*   Lh1 enthaelt nun die Primfaktorisierung von D/16.    */
	    
	    Lh2 = _0;
            while( Lh1 != _0 )
            {
	        if( lsecond( Lh1 ) >= 2 )
	        {
	            Lh2 = lcomp( lsecond( Lh1 ), Lh2 );
	            Lh2 = lcomp( lfirst( Lh1 ), Lh2 );
	        }
	        Lh1 = lred2( Lh1 );
            }

            /*   Erzeugen einer Liste L mit allen (positiven) ganzen  */
	    /*   Zahlen, die Quadrate sind und D/16 teilen. Das sind  */
	    /*   nach dem Satz von Nagell-Lutz-Cassels die Kandidaten */
	    /*   fuer die y-Koordinaten von Torsionspunkten.          */

            L = list1( 1 );
            while( Lh2 != _0 )
            {
	        p = lfirst( Lh2 );
	        m = lsecond( Lh2 );
	        i = 2;
	        hi1 = iexp( p, 2 );
	        hi2 = 1;
	        Lh1 = list1( 1 );
	        while( i <= m )
	        {
	            hi2 = iprod( hi1, hi2 );
	            Lh1 = lcomp( hi2, Lh1 );
	            i = i + 2;
        
	            /*   Lh1 enthaelt jetzt alle Potenzen von p mit   */
		    /*   geraden Exponenten, die noch D/16 teilen.    */

	        }
	        L = liprod( L, Lh1 );
	        Lh2 = lred2( Lh2 );
            }

            /*   Die y-Koordinate 0 wird der Liste hinzugefuegt, um   */
	    /*   alle 2-Teilungspunkte auf der Kurve zu finden.       */
    
            L = lcomp( 0, L );
    
            /*   LP ist die Liste, die die bereits gefundenen         */
	    /*   Torsionspunkte von E enthaelt. Der unendlich ferne   */
	    /*   Punkt ist bereits eingetragen.                       */

            while( ( L != _0 ) && ( llength( LP ) < n ) )
            {
    
	        /*   Zusammenbauen des Polynoms                       */
	        /*         R(x) = x^3 + A4*x + A6 - y_0^2.            */
	        /*   wobei y_0^2 ein in der Liste L eingetragener     */
	        /*   Teiler von D/16 ist.                             */
        
	        hi1 = lfirst( L );
        
	        /*   y1 und y2 sind positive und negative Wurzeln     */
		/*   aus y_0^2.                                       */
        
	        y1 = isqrt( hi1 );
	        y2 = ineg( y1 );
        
	        hi1 = idif( A6, hi1 );
	        L = lred( L );
        
	        if( A4 != 0 )
	        {
	            if( hi1 != 0 )
	            {
		        R = list6( 3, 1, 1, A4, 0, hi1 );
	            }
	            else
	            {
		        R = list4( 3, 1, 1, A4 );
	            }
	        }
	        else
	        {
	            if( hi1 != 0 )
	            {
		        R = list4( 3, 1, 0, hi1 );
	            }
	            else
	            {
		        R = list2( 3, 1 );
	            }
	        }
        
	        /*   Bevor R ueber Z faktorisiert wird, wird ueber-   */
	        /*   prueft, ob R mod PRIME1 und PRIME2 faktorisiert  */
		/*   werden kann.                                     */
        
	        m = llength( upmscfact( PRIME1, pitopmi( 1, R, PRIME1 ) ) );
	        if( m != 1 )
	        {
	            /*   R ist reduzibel modulo PRIME1.  */
        
	            q = llength( upmscfact( PRIME2, pitopmi( 1, R, PRIME2 ) ) );
	        }
	        else
	        {
	            /*   Falls R modulo PRIME1 irreduzibel ist, wird  */
	            /*   q audf 1 gesetzt, da es in diesem Fall       */
		    /*   irrelevant ist, ob  R modulo PRIME2          */
		    /*   irreduzibel ist.                             */
        
	            q = 1;
	        }
        
	        /*   Die eigentliche Faktorisierung von R wird nur    */
	        /*   durchgefuehrt, falls R ueber den Restklassen-    */
		/*   ringen modulo PRIME1 und PRIME2 faktorisiert     */
		/*   werden kann.                                     */
        
	        if( q != 1 )
	        {
	            /*   R ist reduzibel mod PRIME1 und mod PRIME2.   */
	            /*   R wird ueber den ganzen Zahlen faktorisiert. */
	            /*   Falls R ueber Z nicht irreduzibel ist, sind  */
	            /*   die Nullstellen von R Kandidaten fuer die    */
		    /*   x-Koordinate zur y-Koordinate +/- y_0.       */
        
	            Lh1 = upifact( R );
	            Lh1 = lred( Lh1 );
        
	            while( Lh1 != _0 )
	            {
		        if( pdegree( 1, lfirst( Lh1 ) ) == 1 )
		        {
        
		            /*   x ist Nullstelle von R.              */
        
		            if( llength( lfirst( Lh1 ) ) == 2 )
		            {
			        x = 0;
		            }
		            else
		            {
			        x = ineg( lfourth( lfirst( Lh1 ) ) );
		            }
        
		            LM = list1( list3( 0, 1, 0 ) );
        
		            if( y1 != 0 )
		            {
			        P = list3( x, y1, 1 );
				Q = ecisnfmul( E, P, n );
			        if( ispecrpai( Q ) )
			        {
			            if( lmemb( P, LP ) == 0 )
			            {
				        LM = listofmults( E, P );
				        if( LM == ERROR )
				        {
				            Lh1 = lred2( Lh1 );
				            break;
				        }
			            }
			        }
			        P = list3( x, y2, 1 );
				Q = ecisnfmul( E, P, n );
			        if( ispecrpai( Q ) )
			        {
			            if( lmemb( P, LP ) == 0 )
			            {
				        LM = listofmults( E, P );
				        if( LM == ERROR )
				        {
				            Lh1 = lred2( Lh1 );
				            break;
				        }
			            }
			        }
		            }
		            else
		            {
			        P = list3( x, y1, 1 );
				Q = ecisnfmul( E, P, n );
			        if( ispecrpai( Q ) )
			        {
			            if( lmemb( P, LP ) == 0 )
			            {
				        LM = listofmults( E, P );
				        if( LM == ERROR )
				        {
				            Lh1 = lred2( Lh1 );
				            break;
				        }
			            }
			        }
		            }
		            LP = lopmerge( E, LP, LM );
		        }
		        Lh1 = lred2( Lh1 );
	            }
	        }
            }
        }

        /***  Der unendlich ferne Punkt wird ans Ende der Liste   ***/
        /***  geschrieben                                         ***/
	LM = LP;
        LP = list1( list3( 0, 1 ,0 ) );
	while( LM != _0 )
	{
	    P = lfirst( LM );
	    if( !ispecrpai( P )  )
	    {
		LP = lcomp( P, LP );
	    }
	    LM = lred( LM );
	}

	L = lthird( E );
	leset( L, 5, list2( LP, _0 ) );
	leset( E, 3, L );

	m = llength( LP );
	L = lfourth( E );
	leset( L, 3, list2( m, _0 ) );
	leset( E, 4, L );

        return( LP );
    }

    return( lfirst( lfifth( lthird( E ) ) ) );
}

/*************** Ende von e c i s n f t o r   **********************/
