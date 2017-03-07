/*M
.SH NAME
isum - integer sum

.SH SYNOPSIS
.nf
#include<_arith1.h>

int isum(A, B)
int A, B;

.SH DESCRIPTION
isum() returns A + B. 
M*/

/*H
								
	Version 1       23.06.1986      R.Boeffgen
	Version 2       04.07.1991      ueberfl. Zuweisung C0=_0 beseitigt.  PS
	Version 3	03.06.1992	diverse Verbesserungen.  MC
	Version 4	22.11.1994	Neuer Doumentationsstandard. MP
   DATE isum          : 890501.910715.921130.941201
H*/


# include <_arith1.h>       

#define lpmoc( A, a ) { A = AVAIL;  AVAIL = lred( AVAIL ); \
lsfirst( A, (a) ); if ( AVAIL == _0 ) {gc(); lsred( A, AVAIL );} }     
#define lpmoc_start( AA ) { if ( AVAIL == _0 ) gc(); AA = AVAIL; }

/* 
Arbeitsweise dieser beiden Macros: 

Man kann sich vorstellen, dass sukzessive in AVAIL Elemente hineingeschrieben werden. 
Dazu ist es absolut notwendig, dass im "Arbeitsbereich" dieser beiden Macros kein 
"lcomp" laeuft, oder etwas anderes, das die normalerweise freien Zellen von 
AVAIL benutzt. Die "if" - Konstruktionen innerhalb der Macros sorgen dafuer, dass man 
sich oBdA AVAIL als niemals leer werdend vorstellen kann. Um spaeter AVAIL wieder 
benutzen zu koennen, muss der Befehl "lsred( A, _0 );" ausgefuehrt werden.
Schematisch sieht das etwa so aus (mit Variablen CC und C0), falls die Liste 
( a, b, c ) erzeugt werden sollte (x stehe fuer irgendeinen nicht def. Eintrag,
-v bedeutet "zeigt auf diesen Eintrag"):

Vor lpmoc_start: 

AVAIL -v 
     ( x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, ................. )

nach lpmoc_start( CC ): 

   CC -v  
AVAIL -v
     ( x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, ................. )
d.h. CC und AVAIL zeigen beide auf das erste Element der Liste.
nach lpmoc( C0, a):
   CC -v    
   C0 -v
   AVAIL -v
     ( a, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, ................. )
d.h C0 und CC zeigen auf das erste, AVAIL zeigt auf das zweite Element der Liste.

nach lpmoc( C0, b):
   CC -v    
      C0 -v
      AVAIL -v
     ( a, b, x, x, x, x, x, x, x, x, x, x, x, x, x, x, ................. )

nach lpmoc( C0, c):
   CC -v    
         C0 -v
         AVAIL -v
     ( a, b, c, x, x, x, x, x, x, x, x, x, x, x, x, x, ................. )

nach lsred( C0, _0):

   CC -v   
         C0 -v
     ( a, b, c ) 
AVAIL -v
     ( x, x, x, x, x, x, x, x, x, x, x, x, x, ................. )
In CC steht jetzt die gewuenschte Liste.

Im Unterschied dazu wuerde die Befehlsfolge 
	CC = list1( a );  CC = lcomp( b, CC ); CC = lcomp( c, CC ); 
die Liste ( c, b, a ) erzeugen.
*/


int isum ( A , B )
int A, B;
{
    /***    A oder B Null    ***/
	if ( A==0 )  return( B );
	if ( B==0 )  return( A );
    /***    A und B einfach-genau    ***/
	if ( isatom(A) && isatom(B) )  {
				int D;
		if ( (D=A+B) >= BASIS )  return(list2(D-BASIS,1));
		if ( D <= -BASIS )  return(list2(D+BASIS,-1));
		return( D );
	}
    /***    Vorbesetzungen    ***/
	{
		obj  a, b;
		single c,  u, s=isign(A), t=isign(B);
		list  C0, CC;
		bind( A, B );       
		init( CC );
		
		
	    /***    gleiche Vorzeichen    ***/
		lpmoc_start( CC )
		if ( s==t ) {    
				if ( isatom( A ) ) a = A, A = _0; 
				else  a = lfirst(A), A = lred(A);

				if ( isatom( B ) )  b = B, B = _0; 
				else b = lfirst(B), B = lred(B);     

				c = a+b;         

				if      (c >= BASIS)  c -= BASIS,  u =  1;
				else if (c <=-BASIS)  c += BASIS,  u = -1;
				else u = 0;
				lpmoc( C0, c )      

				while ( u || (A!=_0 && B!=_0) ) {   
				if ( A!=_0 )  a = lfirst(A), A = lred(A);
				else  a = 0;
				if ( B!=_0 )  b = lfirst(B), B = lred(B);
				else  b = 0;
				c = a+b+u;
				if      (c >= BASIS)  c -= BASIS,  u =  1;
				else if (c <=-BASIS)  c += BASIS,  u = -1;
				else u = 0;
				lpmoc( C0, c )
			}
			if ( A==_0 )  A = B;
		    /***    Ergebnis durch Concatenation    ***/
			lsred( C0,A );
		}
		else
	    /***    unterschiedliche Vorzeichen    ***/
		     {  	single v = 0;
				if ( isatom( A ) ) a = A, A = _0;
				else a = lfirst(A),  A = lred(A);
				if ( isatom( B ) ) c = a + B, B = _0;
				else c = a + lfirst(B),  B = lred(B);
				if ( c!=0 )  v = c;
				lpmoc( C0, c )
			while ( A!=_0 && B !=_0 ) {
				a = lfirst(A),  A = lred(A);
				b = lfirst(B),  B = lred(B);
				c = a+b;
				if ( c!=0 )  v = c;
				lpmoc( C0, c )
			}
			if ( A==_0 )  A = B,  s = t;
		    /***    Ergebnis Null    ***/
			if ( v==0 && A==_0 )  {
				return( 0 );
			}
		    /***    uebriger Teil von A    ***/
			if ( A!=_0 && s!=ssign(v) )
			do {
				v = lfirst( A );
				A = lred( A );
				lpmoc( C0, v )
			}
			while ( v==0 );
/* 		  	vereinheitliche Vorzeichen              */
/* a und b jetzt Hilfsvariablen, die auf Listenelemente zeigen 	*/

			a = CC;
			u = 0;     

			do  {
				c = lfirst( a );
				c += u;
				if      ( v>0 && c<0 )  c += BASIS,  u = -1;
				else if ( v<0 && c>0 )  c -= BASIS,  u = 1;       
				else u = 0;
				if ( c!=0 )  b = a;
			lsfirst( a, c );
			a = lred( a );
			}
			while ( a != AVAIL );
		    /***    Concatenation bzw. Loeschen fuehrender Nullen    ***/
			if ( A==_0 )  lsred( b, _0 );
			else  lsred( C0,A );
			if ( lred(CC) == _0 ) CC = lfirst( CC );
		}
		return( CC );
	}
}
