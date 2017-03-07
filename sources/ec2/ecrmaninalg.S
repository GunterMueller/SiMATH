/*M
.SH NAME
ecrmaninalg - elliptic curve over rational numbers, Manin algorithm

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrmaninalg(E)  
list E; 
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.  
.PP
ecmaninalg computes with help of the Manin-algorithm, under the conjecture of Birch and Swinnerton-Dyer, the rank and a basis of the elliptic curve E/Q and adds the results (rank, basis, torsion group with generator(s) and structure, Tate-Shafarevic group, reall period) to the list E.
E will be changed.
.PP
ecrmaninalg return 0 by success and ERROR else.
.SH NOTES
ecrmaninalg creates three temporary file: _NTP_FILE.TMP.pid, _LC_FILE.TMP.pid and _LC_HELP.TMP.pid, and deletes them after computation.
.PP
ecrmaninalg uses the global double variable _H_BOUND, which is equal to 0.0 by default.
If _H_BOUND is positive then the height in the search for points
will be limited by _H_BOUND.
For _H_BOUND = 0.0 the search is not limited but
for most applications _H_BOUND = 11.0 is sufficient.
    
.SH SEE ALSO
ecrinit

M*/
                   
/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	28.12.1992	Parameter LC in ECIREG an erster
					(statt an zweiter) Strelle.  PS
	Version 3	21.01.1993	Anpassung an neues Konzept. 
					Auslagerung von 'ecisnfpbwh'
					und 'ecimindivby2'. JG.
	Version 4	01.01.1993	Neues 'ecisnfpbwh' JG.
	Version 5	01.01.1993	Globalen Parameter _H_BOUND zur Be-
                                        grenzung der Punktsuche eingebaut. JG.
   DATE ecrmaninalg   : 921130.930115.930531.941201
H*/

#include <_ec2.h>

char *ntp_file, *lc_file, *hil;
single pid;


/*****************************************************************/
/***                                                           ***/
/***                    static functions                       ***/
/***                B  E  G  I  N  N  I  N  G                  ***/
/***                                                           ***/
/*****************************************************************/

/*c
			lcomb( L1, L2 )

	"list combination"
	static lcomb( L1, L2 )  list L1, L2;
	static-Modul zu ecrmaninalg.
	s = LCOMB( l1, l2 );
	L1 ist entweder leer oder eine Liste von k Listen (k > 1), die
	jeweils l (l > 1) Zahlen enthalten.
	L2 ist eine Liste ( i1  i2  i3  i4  ... ik )
	lcomb kombiniert die beiden Listen L1 und L2 wie folgt:
	Falls L1 leer ist, so wird L = ( ( i1 )  ( i2 )  ...  ( ik ) )
	gesetz.
	Falls L1 = ( ( i11  i12 ... i1l )  ( i21  i22 ... i2l ) ... 
                 ... ( ik1  ik2 ... ikl ) ) ist, so wird 
        L = ( ( i11  i12 ... i1l  i1 )  ( i21  i22 ... i2l  i2 ) ...
                 ... ( ik1  ik2 ... ikl  ik )  ) gesetzt.
        Dabei werden die Punkte nach aufsteigender x-Koordinaten
	(und bei Gleichheit nach aufsteigender z-Koordinaten)
	angeordnet. Falls 2 Teillisten ( ij1  ij2 ... ijl  ik ) und
	( ij1  ij2 ... ijl  ik ) gleich sind, so wird eine aus der Liste 
	L gestrichen, es gibt also nur verschiedene Teillisten in L.
	Das Ergebnis wird in die temporaere Datei _LC_FILE.TMP.pid
	geschrieben. Waehrend Funktionslaufs wird eine weitere
	temporaere Datei _LC_HELP.TMP.pid kreiert und vor dem
	Verlassen der Funtion wieder geloescht.
	Rueckgabe: 0.
c*/
/*cS
	lcomb ruft auf: fclose, fgetl, fopen, lcomp, lcopy, linv, 
		llength, system
	Macros: fprintf, lfirst, list1, lred
Sc*/

static lcomb( L, l, r )
list L;
single *l, r;
{
    list      L1, L2, L3;
    single    i, j, k, l1, flag;
    FILE      *fptr1, *fptr2;
    char      *lc_help, *sys_ord;

    extern char  *hil, *lc_file;

    sys_ord = ( char * ) malloc( 50 );
    lc_help = ( char * ) malloc( 25 );
    *lc_help = '\0';
    strcat( lc_help, "LC_HELP.TMP." );
    strcat( lc_help, hil);

    init( L1 );
    bind( L );

    if( *l == 0 )
    {
        L1 = L;
        fptr2 = fopen( lc_file, "a" );
	while( llength( L1 ) >= r )
	{
            fprintf( fptr2, "%l\n", list1( lfirst( L1 ) ) );
	    L1 = lred( L1 );
	    (*l)++;
	}
        fclose( fptr2 );
    }
    else
    {
        init( L2, L3 );
	l1 = *l;
	*l = 0;

        *sys_ord = '\0';
        strcat( sys_ord, "mv " );
        strcat( sys_ord, lc_file );
        strcat( sys_ord, " " );
        strcat( sys_ord, lc_help );
        strcat( sys_ord, " > /dev/null" );
        system( sys_ord );

        fptr1 = fopen( lc_help, "r" );
        fptr2 = fopen( lc_file, "a" );
        while( l1 )
        {
	    L2 = fgetl( fptr1 );
            L1 = L;
            while( L1 != _0 )
            {
	        i  = lfirst ( L1 );
		L3 = L2;

	        flag = 1;

	        while( flag )
	        {
	            j = lfirst( L3 );
		    if( i <= j )
		    {			
			flag = 0;
	            }
	            L3 = lred( L3 );
                    if( ( L3 == _0 ) && flag )
                    {
			flag = 0;
		        L3 = lcopy( L2 );
		        L3 = linv( L3 );
		        L3 = lcomp( i, L3 );
		        L3 = linv( L3 );
	                fprintf( fptr2, "%l\n", L3 );
			(*l)++;
	            }
		}
	        L1 = lred( L1 );
            }
	    l1--;
        } 
        fclose( fptr1 );
        fclose( fptr2 );

        *sys_ord = '\0';
        strcat( sys_ord, "rm -f " );
        strcat( sys_ord, lc_help );
        system( sys_ord );

    } 

    return( 0 );
}
/**************  Ende von   l c o m b   *********************/
 
static floating succ_min_prod( E, L, r )
list L;
single r;
{
    single   i;
    list     P, R, S;
    floating erg, tol, fl1, fl2;

    bind( L );
    init( R, S,P );
    init( erg, tol, fl1, fl2 );

    R = _0;

    i = 1;
    tol = Cfltofl( 0.0001 );
    erg = itofl( 1 );
    fl2 = itofl( 1 );

    while( ( i <= r ) && ( L != _0 ) )
    {
        P = lfirst( L );
	S = lcomp( P, R );
        fl1 = eciminreg( E, S, i, 0 );

        if( flcomp( fl1, tol ) > 0 )
        {
            R = lcomp( P, R );
            fl2 = lsecond( L );
            erg = flprod( erg, fl2 );
            i++;
        }
        L = lred2( L );
    }
  
    while( i <= r )
    {
        erg = flprod( erg, fl2 );
        i++;
    }
    return( erg );
}
/**************  Ende von   l c o m b   *********************/

/*c
                   eciminregmin( E, LP, rlb )

	"elliptic curve with integer coefficients, 
	 regulator minimalisation"
        static list eciminregmin( E, LP, rlb )
            list E, LP;  floating rlb;
	static-Modul zu ecrmaninalg.
	L =  eciminregmin( E, LP, rlb );
	eciminregmin berechnet den minimalen Regulator
	aus der Punktmenge LP, d.h. 
	   R = min{ det( ( ntp( Pi, Pj ) )1 <= i, j <= r ) }
        unter der Nebenbedingung R > 0. 
	Es muss gelten:
	   - E ist eine Liste mit allen wichtigen Daten der
	     elliptischen Kurve E/Q (s. 'ecrinit').
	   - rlb > 0 (untere Schranke fuer den Regulator)
	   - r > 0 (Rang von E/Q)
        Dabei werden alle Neron-Tate-Pairings h( P_i, P_j ) aller 
	Punktepaare ( P_i, P_j ) mit P_i, P_j aus LP in die temporaere 
	Datei _NTP_FILE.TMP.pid geschrieben. 
	Analog werden alle moeglichen Kombinationen "r aus l" in die
	temporaere Datei _LC_FILE.TMP.pid geschrieben, wobei l die
	Anzahl der Punkte in LP ist. 
	Beide Dateien werden beim Verlassen der Funktion wieder geloescht.
        Rueckgabe: bei fehlerhaftem Lauf: ERROR,
	   sonst: Liste L = ( B  R ) list B; floating R;
		  mit B = ( P1 ... Pr ) Basis von E/Q und
		  R = Regulator von E/Q.
c*/

static list eciminregmin( E, LP, rlb )
list E, LP;
floating rlb;
{
    single i, j, l, m, r;
    list L, L1, P, Q, R;
    floating erg, fl1, fl2, tol1, tol2;
    matrix M;
    FILE *fptr;
    char *sys_ord;

    sys_ord = ( char * ) malloc( 50 );

    bind( E, LP, rlb );

    l = m = llength( LP ) / 2;
    r = ecrrank( E );
	 

    if( ( m < r )  ||  ( r <= 0 ) ||  ( flsign( rlb ) <= 0 ) )
    {
	return( ERROR );
    }

    init( L, L1, P, Q, R );
    init( erg, fl1, fl2, tol1, tol2 );
    init( M );

    L1 = LP;

    R = _0;
    for( i = 0; i < r; i++ )
    {
        P = lfirst( L1 );
	R = lcomp( P, R );
        L1  = lred2( L1 );
    }
    R = linv( R );

    erg = eciminreg( E, R, r, 0 );

    tol1 = flsquot( rlb, 2 );
    tol2 = flprod( rlb, itofl( 3 ) );

    /*   Falls eine berechnete Determinante R < tol1 ist,   */
    /*   so ist sie (wahrscheinlich) gleich Null (Test!).   */
    /*   Falls eine berechnete Determinante R < tol2 ist,   */
    /*   so ist gleich dem Regulator,                       */
    /*   denn waere der Regulator kleiner als R, dann       */
    /*   koennte er hoechstens R/4 sein. Es gilt aber:      */
    /*       R       tol2       tol2                        */
    /*      ---  <  ------  <  ------  =  rlb  ===>         */
    /*       4         4          3                         */
    /*   Widerspruch, da rub kleiner als der Regulator ist. */
    
    if( flcomp( erg, tol1 ) < 0 )
    {
	/* Test, ob fl1 == 0   */
	/* Noch zu schreiben   */
	erg = 0;
    }

    if( erg )
    {
	if( flcomp( erg, tol2 ) < 0 )
	{
            /*   Regulator gefunden (s.o.). l = 1 ==>  */
            /*   Abbruchbedingung der while-Schleife   */
            /*   bei der naechsten Abfrage erfuellt.   */
	    P = _0;
	    while( R != _0 )
	    {
	        Q = lfirst( R );
		fl1 = eciminnetahe( E, Q );
		P = lcomp2( fl1, Q, P );
		R = lred( R );
	    }
            L = list2( linv( P ), erg );
	    return( L );
        }
    }

    L1 = LP;

    i = 0;
    fptr = fopen( ntp_file, "a" );

    while( L1 != _0 )
    {
	P   = lfirst ( L1 );
	fl1 = eciminnetahe( E, P );
	fprintf( fptr, "%.p\n", fl1 );

        L1  = lred2( L1 );
	L   = L1;

	while( L != _0 )
	{
	    
	    Q   = lfirst( L );
	    fl1 = eciminnetapa( E, Q, P );
	    fprintf( fptr, "%.p\n", fl1 );
	    L   = lred2( L );
	}
    }
    fclose( fptr );

    L1 = _0;
    i = l;
    while( l )
    {
	l--;
	L1 = lcomp( l, L1 );
    }

    *sys_ord = '\0';
    strcat( sys_ord, "rm -f " );
    strcat( sys_ord, lc_file );
    system( sys_ord );

    for( i = 0; i < r; i++)
    {
	lcomb( L1, &l, r );
    }
     
    M = maconszero( r, r );
    L1   = _0;
    fptr = fopen( lc_file, "r" );
  
    while( l )
    {
        Q   = fgetl( fptr );
        fl1 = eciminregs( Q, M, m );
        
	if( flcomp( fl1, tol1 ) < 0 )
        {
	    /* Test, ob fl1 == 0   */
	    /* Noch zu schreiben   */
	    fl1 = 0;
        }

	if( fl1 )
	{
	    if( flcomp( fl1, tol2 ) < 0 )
	    {
		/*   Regulator gefunden (s.o.). l = 1 ==>  */
		/*   Abbruchbedingung der while-Schleife   */
		/*   bei der naechsten Abfrage erfuellt.   */
		l = 1;
	        erg = fl1;
                L1 = Q;
	    }

	    if( !erg || ( flcomp( fl1, erg ) < 0 ) )
	    {
		/*   gerade berechneter Regulator kleiner  */
		/*   als der vorher berechnete Regulator   */
	        erg = fl1;
                L1 = Q;
            }
	}
	l--;
    }

    fclose( fptr );

    *sys_ord = '\0';
    strcat( sys_ord, "rm -f " );
    strcat( sys_ord, lc_file );
    system( sys_ord );

    if( !erg )
    {
        return( list2( _0, 0 ) );
    }

    Q = LP;
    P = _0;

    l = 0;
    while( L1 != _0 )
    {
         i = lfirst( L1 );
         l = i - l;

         while( l )
         {
	     l--;
	     Q = lred2( Q );
         }
	 R   = lfirst( Q );
	 fl1 = eciminnetahe( E, R );

         P = lcomp2( fl1, R, P );
         l = i;
	 L1 = lred( L1 );
    }

    L = list2( linv( P ), erg );

    strcat( sys_ord, "rm -f " );
    strcat( sys_ord, ntp_file );
    system( sys_ord );

    return( L );
}
/**************  Ende von   e c i m i n r e g m i n   *******/

/*c
			eciminregs( L, M, r )

	"elliptic curve with integer coefficients, regulator,
	 special version"
	static floating eciminregs( L, M, r ) list L; matrix M; single r;
	static-Modul zu ecrmaninalg.
	R = eciminregs( L, M, r );
c*/
/*cS
	eciminregs ruft auf: getntp, lcopy, leset, mafldet,
	Macros: lfirst, lred
Sc*/

floating eciminregs( L, M, l )
list L;
matrix M;
single l;
{
    single   i, j, k, p, q;
    floating erg, flh;
    list     L1, L2, LZ;

    init( erg, flh );
    init( L1, L2, LZ );

    bind( L, M );

    L1 = lcopy( L );
    i  = 1;
  
    while( L1 != _0 )
    {
        /*   Eintragen der Werte in die Matrix M     */
        L2 = L1;
        p  = lfirst( L1 );
        j  = i;
 
        while( L2 != _0 )
        {
            q   = lfirst( L2 );

	    flh = getntp( p, q, l );

	    masetel( M, i, j, flh );

	    if( j != i )
	    {
		 masetel( M, j, i, flh );
	    }
 
            j++;
	    L2 = lred( L2 );
        }
        i++;
        L1 = lred( L1 );
    }
    erg = mafldet( M );
      
    return( erg );
}
/**************  Ende von   e c i m i n r e g s   *************/

/*c
			getntp( p, q, r )

	"get Neron-Tate pairing"
        floating getntp( p, q, r ) single p, q, r;
        f = getntp( p, q, r );
	static-Modul zu ecrmaninalg.
	getntp liest den Wert 
	     h = h( P_p, P_q )
        aus der von 'eciminregmin' erzeugten Datei _NTP_FILE.TMP.pid ein.
	Rueckgabe: h.
c*/
/*cS
	getntp ruft auf: fclose, fgetfl, flquot, fopen
	Macros: fldif, itofl
Sc*/


floating getntp( p, q, r )
single p, q, r;
{
    single n;
    floating erg;
    FILE *fptr;

    init( erg );

    n = 1 + p * r - ( ( p - 1 ) * p ) / 2 + q - p;

    fptr = fopen( ntp_file, "r" );

    while( n )
    {
	erg = fgetfl( fptr );
	n--;
    }
    fclose( fptr );

    return( erg );
}
/**************  Ende von   g e t n t p   *******************/

/*****************************************************************/
/***                                                           ***/
/***                    static functions                       ***/
/***                         E  N  D                           ***/
/***                                                           ***/
/*****************************************************************/


ecrmaninalg( E )
list E;
{
    single     i, n, c, rank, ot, ordTSG, NTH_EPS_ALT;
    int        hi;
    floating   fl1, fl2, omega, vol, regulator, rlb, rub,
	       rsm, hb, hdiff, hmin, H, bound, HB, _H;
    list       L, BAS, LP, LP1, LP2, BT;

    extern single pid;
    extern char   *ntp_file, *lc_file, *hil;

    bind( E );

    if( ecracdisc( E ) == 0 )
    {
	/*   Diskriminante = 0: E ist keine elliptische Kurve   */
	return( ERROR );
    }
  
    init( hi );
    init( fl1, fl2, omega, vol, regulator, rlb, rub );
    init( rsm, hb, hdiff, hmin, H, bound, HB, _H );
    init( L, BAS, LP, LP1, LP2, BT );

    _H = Cfltofl( _H_BOUND );

/***************************************************************/
/*                                                             */
/*          Im folgenden werden alle Berechnungen              */
/*              fuer das minimale Modell von                   */
/*      eingeschraenktem Typ (s. 'ecrinit') durchgefuehrt.     */
/*                                                             */
/***************************************************************/

    /*   Berechnung der Torsionsgruppe  (implizit)             */
    ot = ecrordtor ( E );                 /* Ordnung der TGr.  */
    /*   Berechnung der Torsionsgruppe          ( E N D E )    */
  
  
    /*   Berechnung der reellen Periode omega                  */
    omega = ecrrperiod( E );
    if( isign( ecimindisc( E ) ) > 0 )
    {
	omega = flsum( omega, omega );
    }
  
    /*   Berechnung des Rangs r (nach Birch und                */
    /*   Swinnerton-Dyer) und dem Wert der r-ten Ableitung     */
    /*   der L-Reihe an der Stelle s = 1.                      */
    rank = ecrrank( E );
    /*   Berechnung des Rangs ...               ( E N D E )    */


    if( rank )
    {
        /*    Bestimmung der Differenz zwischen Neron-Tate-    */
        /*    Hoehe h(P) und Weil-Hoehe d(P) auf E(Q).         */
        hdiff =  ecisnfdwhnth( E );

        pid = getpid();

        hil = ( char * ) malloc( 30 );
        *hil = '\0';
        sprintf( hil, "%d", pid);

        lc_file  = ( char * ) malloc( 25 );
        ntp_file = ( char * ) malloc( 25 );
        *lc_file  = '\0';
        *ntp_file = '\0';
        strcat(  lc_file,  "_LC_FILE.TMP." );
        strcat(  lc_file,  hil );
        strcat( ntp_file, "_NTP_FILE.TMP." );
        strcat( ntp_file, hil );

        LP  = _0;
	LP1 = _0;
	hb  = 0;
	HB  = 0;
  
        /*   Bestimmung von h' = min{ 1, hmin } mit            */
        /*                 /            |    P in E(Q),     \  */
        /*      hmin = min< hdiff, h(P) |  P !in Etors(Q)    > */
        /*                 \            | h(P) < 2 * hdiff  /  */
        H   = flsum( hdiff, hdiff );  /* H = 2 * hdiff */
        /*   In LP stehen alle Punkte P in E(Q) mod Etors(Q)   */
        /*   mit h(P) < 2 * hdiff.                             */

        if( _H && ( flcomp( _H, H ) < 0 ) )
        {
            H = _H;
        }

        i = ecisnfpbwh( E, &LP, &hb, H, 1, 0, &LP1 );
        if( flcomp( hb, HB ) > 0 )
        {
            HB = hb;
        }
        
        if( LP != _0 )
        {
            hmin = lsecond( LP );
            H  = flsum( hmin, hdiff );

            if( _H && ( flcomp( _H, H ) < 0 ) )
            {
                H = _H;
            }

            i = ecisnfpbwh( E, &LP, &hb, H, 2, 0, &LP1 );
            if( flcomp( hb, HB ) > 0 )
            {
                HB = hb;
            }
        }

        hmin = hdiff;
        L    = LP;
        while( L != _0 )
        {
            fl2 = lsecond( L );
      
            if( flcomp( fl2, hmin ) < 0 )
            {
	        hmin = fl2;
            }
            L   = lred2( L );
        }
    /*   Bestimmung von h' ...              ( E N D E )    */
    }


    /*   Abschaetzung des Regulators nach oben durch           */
    /*                 L^(r)(1) * | Etors(Q) |^2               */
    /*      R <= R' = ---------------------------              */
    /*                     r! * c * omega                      */

    c  = ecrprodcp( E );
    hi = iprod( c, ifactl( rank ) );
    fl2 = flprod( omega, itofl( hi ) );
    i   = ot * ot;
    rub = ecrlserrkd( E );
    rub = flprod( rub, itofl( i ) );
    rub = flquot( rub, fl2 );

    /* Abschaetzung des Regulators nach oben      ( E N D E )  */
	
    if( !rank )
    {
	BAS = _0;
	regulator = itofl( 1 );
    }
    else if( ( rank == 1 ) && ( LP != _0 ) )
    {
        fl1 = rub;
        L   = lfirst ( LP );
	regulator = lsecond( LP );
	BAS = list2( L, regulator );
        fl1 = flquot( rub, regulator );
    }
    else
    {
        /* Abschaetzung des r-ten sukzessiven Minimums         */
        /* im Gitter E(Q) / Etors(Q) (modulo Torsion)          */
        /* nach oben durch                                     */
        /*                  2^r * R'                           */
        /*        B <= ------------------,                     */
        /*              v_r * (h')^(r-1)                       */
        /*   mit v_r = Volumen der r-ten Einheitskugel.        */
        
	n = 2;
        fl2 = itofl( 1 );
        for( i = 1; i < rank; i++)
        {
            fl2 = flprod( hmin, fl2 );
	    n *= 2;
        }

	/* fl2 = hmin^(r-1)  und  n = 2^r   */

	rsm = flprod( rub, itofl( n ) );
        /* Abschaetzung des r-ten ...             ( E N D E )  */
		
        vol = volunitball( rank );
        fl2 = flprod( fl2, vol );
        rsm = flquot( rsm, fl2 );

        /* Berechnung der Schranke                             */
        /*        B' = B + hdiff                               */
        /* und der Menge                                       */
        /*       LP = { P in E(Q)/Etors(Q) | d(P) < B' }       */
        /*       ( >= { P in E(Q)/Etors(Q) | h(P) < B } )      */
        /* in Manins Algorithmus.                              */

        bound = flsum( rsm, hdiff );

        /*   Bestimmung aller Punkte P auf E/Q mit d( P ) < B' */

        if( _H && ( flcomp( _H, H ) < 0 ) )
        {
            bound = _H;
        }

        i = ecisnfpbwh( E, &LP, &hb, bound, 0, hmin, &LP1 );
        if( flcomp( hb, HB ) > 0 )
        {
            HB = hb;
        }

        if( i != 2 )
        {
            /*   LP == _0, kein Punkt auf E(Q) gefunden: ERROR */
            ordTSG = -1;
	    return( ERROR );
        }
        /*   Bestimmung aller Punkte P ...      ( E N D E )    */

  
        /*    Entfernen der Punkte P mit h(P) > B              
        LP1 = lcopy( LP );
        LP2 = linv( LP1 );
        fl2 = lfirst( LP2 );
        fl1 = flsum( rsm, NTH_TOL );

	while( flcomp( fl2, fl1 ) > 0 )
        {
            LP2 = lred2( LP2 );
	    if( LP2 == _0 )
	    {
		break;
	    }
            fl2 = lfirst( LP2 );
        }
        LP1 = linv( LP2 );
            Entfernen der Punkte P mit ...    ( E N D E )    */

        /*   Abschaetzung des Regulators nach unten durch      */
        /*              __r_        vol                        */
        /*       R >= (  || h_i ) * ---                        */
        /*              i=1         2^r                        */
        rlb = flsquot( vol, sexp( 2, rank ) );
        fl1 = succ_min_prod( E, LP, rank );
        rlb = flprod( rlb, fl1 );
        
        /*   Abschaetzung des R. nach unten ... ( E N D E )    */

  
        /*   Fuer die folgenden Rechnungen muss die Genauig-   */
        /*   keit nicht so gross sein                          */
        NTH_EPS_ALT = eciminntheps( E, 4 );
        
        /*   Berechnung eines kompletten Vertretersystem von       */
        /*      E^  modulo  ( 2 * E^ )                             */
        /*   mit E^ = E(Q) modulo Etors(Q).                        */
        n--;
        /*   n = 2^r - 1, da ( 0 : 1 : 0 ) zwar in E^, aber        */
        /*   nicht in LP liegt (wg. 'Torsionsfreiheit').           */
        
	LP2 = LP;
	LP1 = _0;
	i   = 0;
	H   = 0;
	fl1 = 0;

	while( ( i < n ) && ( LP2 != _0 ) )
	{
	    L   = lfirst ( LP2 );
	    fl2 = fl1;
	    fl1 = lsecond( LP2 );
            if( !isineciminpl( E, L, fl1, LP1 )  )
            {
	        i++;
	        eciminplinsp( L, fl1, &LP1 );
            }
	    LP2 = lred2( LP2 );
	}
	H = flsum( fl1, fl2   );
	H = flquot( H, itofl( 6 ) );  
	/*   Eigentlich muesste H <- H/4 stehen, aber   */
	/*      min{ h(P+Q)/4, h(P-Q)/4 } < H/4         */
	H = flsum( H, hdiff );
        if( _H && ( flcomp( _H, H ) < 0 ) )
        {
            H = _H;
        }
        i = ecisnfpbwh( E, &LP, &hb, H, 2, 0, &LP2 );
        if( flcomp( hb, HB ) > 0 )
        {
            HB = hb;
        }

        if( LP == ERROR )
        {
	    return( ERROR );
        }
        /*   Bestimmung aller Punkte P ...      ( E N D E )    */


        /*   Berechnung eines kompletten ...        ( E N D E )    */



        /*   Bestimmung einer Basis von E/Q (modulo Torsion)   */
        /*   durch Minimierung des Regulators                  */
	/*   Genauigkeit bei der Berechnung der Neron-Tate-    */
	/*   Hoehe muss gross sein                             */
        n = eciminntheps( E, NTH_EPS_ALT );
        LP1  = eciminregmin( E, LP, rlb );
        if( ( BAS = lfirst( LP1 ) ) == _0 )
        {
            return( ERROR );
        }
        regulator = lsecond( LP1 );
        /*   Bestimmung einer Basis ...         ( E N D E )    */
    }

    /*   Berechnung der Ordnung der Tate-Shafarevic-Gruppe I_I_I   */
    fl1 = flquot( rub, regulator );
    ordTSG = flround( fl1 ); 
    fl2 = flabs( fldif( itofl( ordTSG ), fl1 ) );
    fl2 = flquot( fl2, fl1 );
 
    if( ( flcomp( fl2, Cfltofl( 0.2 ) ) > 0 ) || ( ordTSG < 0 ) )
    {
        /*   Vermutliche Ordnung der Tate-Shafarevic-Gruppe ist    */
        /*   nicht nahe genug an einer ganzen Zahl ==> Fehler      */
        ordTSG = -1;
    }
    else
    {
        n = isqrt( ordTSG );
        if( ( n * n - ordTSG ) )
        {
            /*   #|_|_| kein Quadrat ==> Fehler im Algorithmus     */
            ordTSG = -1;
        }
    }
    /*   Berechnung der Ordnung der Tate-Sha...     ( E N D E )    */
  
        
    /*   Eintragen der berechneten Werte in die Liste E            */
    if( rank )
    {
        L = lsecond( E );
        n = leset( L, 7, BAS );
        n = leset( E, 2, L );
    }

    L = lfourth(  E  );
    LP = lfourth( L );
    n = leset( LP, 4, regulator );
    n = leset( LP, 5, ordTSG );
    n = leset( L, 4, LP  );
    n = leset( E, 4, L );

    return( 0 );
        
}
/*****************   Ende von   e c r m a n i n a l g   *********/
