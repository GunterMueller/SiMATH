/*M
.SH NAME
fputecrlistp - file put elliptic curve over the rational numbers, list of points                                                                      
.SH SYNOPSIS                                                                  
.nf                                                                           
#include<_ec1.h>

single fputecrlistp(PL, mode, pf) 
list PL; 
single mode; 
FILE *pf;
                                                                     
.SH DESCRIPTION
.TP 4
.B PL
 = ( P1 P2 ... Pn )         , for mode = 0
 = ( P1 h1 P2 h2 ... Pn hn) , for mode = +/-1.
.TP 4
.B Pi 
= ( xi yi zi )       0 <= i <= n;
  int xi, yi, zi ;
  defines the point Pi on an elliptic curve E/Q.
.TP 4
.B hi
 floating hi;        0 <= i <= n;
 is the Neron-Tate height of the point Pi. 
.PP
fputecrlistp writes PL ( for mode = 0 or 1 ),
or only the Pi without hi (for mode = -1 ), to the open file *pf.
fputecrlistp returns 0, or ERROR in case of an error occurs.
                                      
M*/  

/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	20.11.1992	leicht optimiert.  PS
	Version 3	22.03.1993	Fall 1 b) verbessert.  JG
	Version 4	02.11.1993	modus = -1, 0, oder 1.  Ausgabe 
					von Deutsch nach Englisch.  JG
   DATE fputecrlistp  : 921130.930531.931130
H*/

#include <_ec1.h>

static lengthofpoint(list);

single fputecrlistp( PL, modus, pf )                     
list PL;
single modus;
FILE *pf;
{
    list P;
    single i = 1, j, l;

    if( PL == _0 )
    {
	fprintf( pf, " --- ");
	return( 0 );
    }

    bind( PL );
    init( P );
	    
    P = lfirst( PL );
    l = 0;

    if( modus > 0 )
    {
	fputs( "\n", pf );
    }

    while( 1 )
    {
	if( modus > 0 ) 
	{
	    fprintf( pf, "    %3d. ", i++ );
	}
	else
	{
	    j = lengthofpoint( P );
            l += j;
	    if( l > 63 )
	    {
	       fprintf( pf, "\n              " );
	       l = j;
	    }
	}

	if( fputecrp( P, pf ) == ERROR )
	{
	    return( ERROR );
	}

	if( modus > 0 ) 
	{ 
	    fprintf( pf, "   with height " );
	    fputflfx( lsecond( PL ), 2, 10, pf );
	    fputs( "\n", pf );
        
	    PL = lred2( PL );
	    if( PL == _0 )
	    {
                return( 0 );
	    }
	    P = lfirst( PL );
        }
	else
	{
	    PL = lred( PL );
	    if( modus )
	    {
	        PL = lred( PL );
	    }

	    if( PL == _0 )
	    {
                return( 0 );
	    }
	    P  = lfirst( PL );

	    if( ( llength( P ) != 3 ) && isfloat( P ) )
	    {
	        PL = lred( PL );
	        if( PL == _0 )
	        {
                    return( 0 );
	        }
	        P  = lfirst( PL );
	    }
	    
	    fputs( ", ", pf );
	    l += 2;
	}

    }
}
/****************** Ende von   f p u t e c r l i s t p    *************/


/*c
			lengthofpoint( P )

	"length of point"
	Quellbibliothek: srclib.ec1
	Include-Datei:   _ec1.h
        static single lengthofpoint( P )  list P; 
	l = lengthofpoint( P );
	lengthofpoint ist static zu fputecrlistp.
        Rueckgabe: Anzahl der character, die der Punkt P bei
                   der Ausgabe am Bildschirm benoetigt.
c*/

static lengthofpoint( P ) 
list P; 
{
    if( ispecrpai( P ) )
    {
	return( 13 );
    }
    else
    {
        single l;
        floating f, lg10;
        int h;
         
        bind( P );
        init( h );
        init( f, lg10 );

	l = 7;  /*   oeffnende + schliessende Klammer + Komma +        */
		/*   Leerzeichen hinter bzw. vor Klammern und Komma    */
    
        lg10 = fllog( itofl( 10 ) );

        h = lfirst( P );
	if( h )
	{
            f = fllog( itofl( iabs( h ) ) );
            f = flquot( f, lg10 );
            l += flfloor( f );
	    if( h < 0 )
	    {
	       l++;
	    }
        }
	l++;

        h = lsecond( P );
	if( h )
	{
            f = fllog( itofl( iabs( h ) ) );
            f = flquot( f, lg10 );
            l += flfloor( f );
	    if( h < 0 )
	    {
	       l++;
	    }
        }
	l++;
        
	h = lthird( P );
	if( h != 1 )
	{
	    l += 4;  /*  2 Bruchstriche + 2 * 'l++' (s.o.)   */
            f = fllog( itofl( h ) );
            f = flquot( f, lg10 );
            l += flfloor( flprod( f, itofl( 2 ) ) ); /* z^2  */
            l += flfloor( flprod( f, itofl( 3 ) ) ); /* z^3  */
	}
	return( l );
    }
}
/****************** Ende von   l e n g t h o f p o i n t   ************/
