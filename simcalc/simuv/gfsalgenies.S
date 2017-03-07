/*C
                        gfsalgenies( p, Gm, m, n, ALn )

        "Galois-field with single characteristic arithmetic list generator
	 isomorphic embedding of subfield"
        Quellbibliothek: srclib.arith3
        Include-Datei:   _arith3.h
	list gfsalgenies(p,Gm, m,n,ALn)  single p,m,n; pol Gm; list ALn;
        L = gfsalgenies(p,Gm, m,n,ALn);
        Es wird die Arithmetikliste des endlichen Koerpers GF(p^m) ueber 
        GF(p) erzeugt (vgl. gfsalgen, 1<p<BASIS, 1<=m<BASIS). 
        ZUSAETZLICH wird eine isomorphe Einbettung des durch die Arith-
        metikliste ALn gegebenen Teilkoerpers GF(p^n) < GF(p^m) in GF(p^m)
        gegeben. Dabei wird vorausgesetzt:
                 GF(p^n) := GF(p)(t), 
                 GF(p^m) := GF(p)(s), 
                 n teilt echt m,
                 m = m0 * n und 
                 f(X) := Irr(t, Z/pZ) aus Z/pZ[X] (vom Typ pms !).
        Dann gilt:
	Ist Gm das Nullpolynom, so
        wird zufallsmaessig ein irreduzibles Polynom ueber Z/pZ vom
        Grad m bestimmt und anschliessend f(X) in GF(p^m)[X] faktorisiert.
	Ist f(X)=Gm ein irreduzibles Polynom in einer Veraenderlichen ueber
	Z/pZ vom Grad m, wird dieses Polynom in GF(p^m)[X] faktorisiert.
	(Es wird nicht ueberprueft, ob Gm irreduzibel ist!)

        f(X) zerfaellt dabei in n verschiedene Linearfaktoren, die den n
        konjugierten Nullstellen t, t^p, t^(p^2), ..., t^(p^(n-1)) ent-
        sprechen. Eine beliebige Nullstelle (als Linearkombination von 
        s-Potenzen) entspricht dem Bild von t unter einer isomorphen Ein-
        bettung; es wird die Nullstelle von kleinstem Grad (in s) ge-
        sucht und uebergeben.
        Es ist L = ( ALm, P ), wobei ALm die Arithmetikliste von GF(p^m) 
        ist und einem Ergebnis von "gfsalgen" entspricht. Das Polynom P
        stellt das Bild von t unter der isomorphen Einbettung dar, also
        als Linearkombination von s-Potenzen vom Grad kleiner m:
        P = a(0) + a(1)*s + ... + a(m-1)*s^(m-1), a(i) = gfel, P = upgfs.
!!!     HINWEIS:          P ist vom Typ gfel !
C*/ 
/*H     
	Version 1       13.06.1989      V. Schwinn
	Version 2       04.07.1991      ueberfl. Variable m0 beseitigt.  PS
	Version 3       15.11.1996      S. Schmitt (Gm eingefuegt)
   DATE gfsalgenies   : 890801.8909__.910715
H*/

#include <_arith3.h>  

list gfsalgenies( p, Gm, m, n, ALn )
single p, m, n;
pol Gm;
list ALn;

{ single k, r;
  obj a; 
  gfel P;
  list ERG, ALm, L, Z;  

  bind( Gm, ALn );
  init( a, P, ERG, ALm, L, Z );               

/* Gm = irred. Polynom fuer gfsalgen; P = 2. Teil des Resultats; ALm =   */
/* 1. Teil des Resultats; das Resulat wird mittels ERG uebergeben        */


  k  = m % n; 

  /***if (( k ) || ( m <= n ) || ( n == 1 ))      ****/
  if (( k ) || ( m < n ) || ( n == 1 ))     
  { return( _0 );                                    /* sinnlose Eingabe */ 
  }

  /**Gm = 0;        **/                 /* Nullpolynom fuer gfsalgen       */
  ALm = gfsalgen( p, m, Gm);
    
  Z = lfirst( ALn );              /* Irr(t,Fp) wird in Fp^m faktor.  */
  Z = pmstopgfs(1, p, Z );
  L = upgfsrf( p, ALm, Z );                      /* L = (g1, ... gn) */

  r = m;                          /* gi von minimalem Grad suchen    */
  while ( L != _0 )
  { Z = lfirst( L );
    L = lred( L );
    k = lfirst( Z );              /* k = Grad von gi ( in s )        */
    if ( k<r )
    { P = Z;
      r = k;
    }
  }
      
  ERG = list2( ALm, P );
            
  return( ERG );
}
