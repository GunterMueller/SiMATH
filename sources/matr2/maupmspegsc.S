/*M
.SH NAME
maupmspegsc - matrix of univariate polynomials over modular single primes, Euclid-Gauss step for columns

.SH SYNOPSIS
.nf
#include<_matr2.h>

single maupmspegsc(p, M, A, B)
single p;
matrix M,A,B;

.SH DESCRIPTION
maupmspegsc() is identical to maupmspegsr() with the role
of the rows and columns swapped when transforming M.

.SH SEE ALSO
maiegsr
M*/
/*H
	Version 1       22.05.1989      U. Schneiders, Th. Weis
	Version 2	26.03.1992	_UPMSPEGS -> _MAUPMSPEGS
					UPMSPEGSC -> MAUPMSPEGSC.  PS
   DATE maupmspegsc   : 890501.920331
H*/


#include <_matr2.h>

single maupmspegsc( p, M, A, B )
single p;
matrix M, A, B;

{
	matrix AS;      /* durchlaeuft A von oben nach unten            */
	matrix BS;      /*      "      B        "                       */
	matrix BSb;     /* die erste Zeile von BSb entspricht der Spalte*/
			/* von M mit dem betragsmaessig kleinsten Ele-  */
			/* ment der ersten Zeile.                       */
	matrix MS;      /* durchlaeuft M von oben nach unten            */
	matrix MT;      /* die ersten Elemente von MT entsprechen einer */
			/* Spalte von M.                                */
	matrix MTS;     /* durchlaeuft MT von oben nach unten.          */
	list Y;         /* eine Zeile von B.                            */
	list Z;         /* eine Zeile von M.                            */
	list ZM;        /* zeigt auf den Anfang einer Zeile von M.      */
	list Zb;        /* zeigt bei addieren auf den Anfang der ersten */
			/* Zeile von BSb.                               */
	list ZB;        /* durchlaeuft eine Zeile von B.                */
	pol a;          /* Hilfsvariable. Beim Addieren M(1,1). */
	pol b;          /* Hilfsvariable. Betragsmaessig kleinstes Ele- */
			/* ment der ersten Zeile, spaeter M(1,1).       */
	pol c;          /* Hilfsvariable. Das c-fache der ersten Spalte */
			/* wird von der i-ten abgezogen.                */
	pol d;          /* Hilfsvariable.                               */
	pol e;          /* Hilfsvariable.                               */
	single fertig=0, ersteRunde, alle0=1, i, j, m=0;
        single aa, bb, fa, fb;

	bind( M, A, B );
	init( MT, a, b, c, d, e, fa, fb );

	if ( lred(lfirst(M)) != _0 ) {
	    MS = M;
/* kreiere erste Spalte */
	    MT = linv( lcinv(M) );
	    AS = A;
	    while ( alle0 ) {
/* Suche Element != 0. Vertausche eventuell die erste Zeile von M, bzw B*/
/* mit der ensprechenden Zeile.                                         */
		ZM = Z = lfirst( MS );
		i = 0;
		while ( Z != _0 ) {
		    if ( lfirst(Z) ) {
			alle0 = 0;
			if ( i ) {
			    Z = lfirst( M );
			    while ( Z != _0 ) {
				a = lfirst( Z );
				lsfirst( Z, lfirst (ZM) );
				lsfirst( ZM, a );
				Z = lred( Z );
				ZM = lred( ZM );
				}
			    Z = lfirst( A );
			    lsfirst( A,lfirst(AS) );
			    lsfirst( AS, Z );
			    }
/*                      else existiert ein Element != 0 in der ersten Zeile */
			break;
			}
		    else {
			Z = lred( Z );
			i++;
			}
		    }  
		if ( alle0 ) {
		    MS = lred( MS );
		    AS = lred( AS );
/* falls MS = _0 so existiert kein Eintrag != 0 und fertig */
		    if ( MS == _0 ) break;
		    }
		}     
	    if ( !alle0 ) { 
		while ( !fertig ) {
/* suche Spalte mit kleinstem Element != 0 */
		    for( ZM=lfirst(M), i=0, ersteRunde=1, BS=B;
			 ZM!=_0; i++, ZM=lred(ZM), BS=lred(BS) )    
  			 if ( a = lfirst(ZM) ) { 
			     if ( ersteRunde ) {
			  	 bb = pdegree(1,a);
				 b = a;
				 m = i;
				 BSb = BS;
				 ersteRunde = 0;
				 }
			     else {                                                                        
                                 aa = pdegree(1,a);  
                                 fa = plc(1,a);
                                 fb = plc(1,b);
				 if ( ( bb > aa ) || ( bb == aa && fb > fa ) ){
				     bb = aa; 
				     b = a;
				     m = i;
				     BSb = BS;
				     }
				 }
			     }                               
		    MS = M;
/* falls m != 0, muessen erste und m-te Spalte von M, bzw erste und m-te  */
/* Zeile von B vertauscht werden, dabei Aufbau von MT, die zweite Spalte. */
		    if ( m ) {
			Z = lfirst( BSb );
			lsfirst( BSb, lfirst(B) );
			lsfirst( B, Z );
			while( MS != _0 ) {
			    ZM = Z = lfirst( MS );
			    for ( j=m; j--; ) Z = lred( Z );
			    a = lfirst( ZM );
			    lsfirst( ZM, lfirst(Z) );
			    lsfirst( Z, a );
			    MS = lred( MS );
			    }
			}
		    MS = M;
		    MTS = MT;
		    while ( MS != _0 ) {
			lsfirst( MTS, lred( lfirst(MS) ) );
			MTS = lred( MTS );
			MS = lred( MS );
			}
/* bilde Spalte i - c * Spalte 1, sooft wie Elemente in Zeile 1         */
/* wende jeden Schritt auch auf die Zeilen von B an.                    */
		    ZM = lred( lfirst(M) );
		    BS = lred( B );
		    Zb = lfirst( B );
		    while ( ZM != _0 ) {
			if ( a = lfirst( lfirst(MT) ) ) {
			    ZB = lfirst( BS );
			    Y = Zb;
			    MTS = MT;
			    MS = M;
			    c = pmsneg( 1, p, pmsquot(1, p, a, b) );
/* hier auf Spalten von M */
			    while ( MS != _0 ) {
				Z = lfirst( MTS );
				e = lfirst( Z );
				d = pmsprod( 1, p, lfirst( lfirst(MS) ), c );
				lsfirst( Z, pmssum(1, p, e, d) );
				lsfirst( MTS, lred(Z) );
				MTS = lred( MTS );
				MS = lred( MS );
				}
/* hier auf Zeilen von B */
			    while ( Y != _0 ) {
				d = pmsprod( 1, p, lfirst(Y), c );
				e = lfirst( ZB );
				lsfirst( ZB, pmssum(1, p, e, d) );
				ZB = lred( ZB );
				Y = lred( Y );
				}
			    }
			else {
			    MTS = MT;
			    while ( MTS != _0 ){
				lsfirst( MTS, lred( lfirst(MTS) ) );
				MTS = lred( MTS );
				}
			    }
			ZM = lred( ZM );
			BS = lred( BS );
			}
/* Test, ob alle Elemente der ersten Zeile ausser M(1,1) = 0            */
		    for( Z=lred( lfirst(M) ), fertig=1; Z!=_0; Z=lred(Z) )
			if ( lfirst(Z) ) {
			    fertig = 0;
			    break;
			    }
		    }
		}
	    }
	return( alle0 );
}
