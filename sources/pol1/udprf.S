/*M
.SH NAME
udprf - dense polynomial root finding 

.SH SYNOPSIS
.nf
#include<_pol1.h>

single udprf(fromto, P, sort, pROOTS)
single fromto;
pol P;
single sort;
list *pROOTS;

.SH DESCRIPTION
udprf() computes all real and complex roots of the polynomial P,
saves its results in the list *pROOTS and returns
.PP
.nf
    0: if P equals 0
    1: if the degree of P equals 0
    2: if the maximum number of iterations was exceeded
    3: if all real and complex roots could be calculated
.fi

The maximum number of iterations is determined by the
global variable ITERMAX, which equals 500 by default.
This value may be modified for instance using ITERMAX=1000.
Be aware that udprf() may exceptionally miss some roots of
ill-conditioned polynomials and return 3 anyway.
If you get incorrect result in roots, try
modifying your polynomial to get the roots.
A better approximation of the root can be achieved by
increasing the SIMATH constant FL_EPS.

.PP
.TP 4
.B P
is a polynomial over the domain specified by fromto.

.TP 4
.B fromto
is a flag which indicates the domain of the coefficients
of P. For fromto=0, P is interpreted as a polynomial
over floating point number, whereas for fromto=1
the coefficients are considered integers and for
fromto=2 they are considered to be rational numbers.

.TP 4
.B sort
is a flag where for sort=1 the list of real root
will be sorted using the bubble-sort function lflbsort().

.TP 4
.B pROOTS
is the pointer to the list of real and complex roots.
The list *pROOTS itself consists of two lists where
the first list contains the real roots and
the second one contains the complex roots.

.SH SEE ALSO
flflbsort, linit, udpflrf, udprrf, udpirf
M*/

/*H
        Version 1       27.12.1994      Th. Weis
	Version 2	20.04.1997	Andreas Heiser
   DATE udprf         : 951201
H*/

#include <_pol1.h>

static cpval(single,single,floating,floating,floating[],floating*,floating*);
static quadsolv(floating,floating,floating,floating,floating,floating,floating*,floating*);

single udprf(fromto, P, sort, pROOTS)
single fromto;
pol    P;
single sort;
list   *pROOTS;
{

  bind(P);

  *pROOTS = list2(_0, _0);
  if(P == 0) return(0);
                /*
                 * Polynom identisch 0;
                 * liefert Liste von zwei leeren Listen
                 * und Wert 0 zurueck
                 */

  {
    single n;

    n = lfirst(P);
    	
    if(n < 1) return(1);
                /*
                 * zu niedriger Polynomgrad;
                 * liefert Liste von zwei leeren Listen
                 * und Wert 1 zurueck
                 */
	
    if(n==3)
    {	if(fromto==1)
		P=udpitofl(P);
	if(fromto==2)
		P=udprtofl(P);
	*pROOTS=udp3rf(P);
	return(3);
    }
    if(n==4)
    {	if(fromto==1)
		P=udpitofl(P);
	if(fromto==2)
		P=udprtofl(P);
	*pROOTS=udp4rf(P);
	return(3);
    }	
    {
      double   ceil(), dd;

      single   j, i, iu, iter, k, m, wert, wert2;

      obj      coef;

      list     h;
      list     P1, NULLST, RROOTS, CROOTS;

      floating EPSQUAD, EPSROOT, EXPONENT, MACH_EPS, ZEHN;
      floating *a;
      floating *zreal, *zimag;
      floating p, q, temp, temp2, temp3, temp4, start, eps,
               x0real, x0imag, x1real, x1imag, x2real, x2imag,
               f0r,    f0i,    f1r,    f1i,    f2r,    f2i,
               h1real, h1imag, h2real, h2imag, hnr,    hni,
               fdr,    fdi,    fd1r,   fd1i,   fd2r,   fd2i,
               fd3r,   fd3i,   b1r,    b1i;

      complex  z;

      /**bind(P); **/

      init(coef);

      init(h);
      init(P1, NULLST, RROOTS, CROOTS);

      init(EPSQUAD, EPSROOT, EXPONENT, MACH_EPS, ZEHN);
      init(p, q, temp, temp2, temp3, temp4, start, eps);
      init(x0real, x0imag, x1real, x1imag, x2real, x2imag);
      init(f0r,    f0i,    f1r,    f1i,    f2r,    f2i);
      init(h1real, h1imag, h2real, h2imag, hnr,    hni);
      init(fdr,    fdi,    fd1r,   fd1i,   fd2r,   fd2i);
      init(fd3r,   fd3i,   b1r,    b1i);

      init(z);

      a = (floating*)malloc((n+1)*sizeof(floating));
      if(a == NULL) {
        printf("\n udprf() not enough memory for a !!\n");
        exit(1);
      }

      zreal = (floating*)malloc((n+1)*sizeof(floating));
      if(zreal == NULL) {
        printf("\n udprf() not enough memory for zreal !!\n");
        exit(1);
      }

      zimag = (floating*)malloc((n+1)*sizeof(floating));
      if(zimag == NULL) {
        printf("\n udprf() not enough memory for zimag !!\n");
        exit(1);
      }

      init(a[0..n], zreal[0..n], zimag[0..n]);
                /*
                 * Speicherplatz fuer a, zreal, zimag reservieren
                 * und initialisieren
                 */

      RROOTS = _0;
      CROOTS = _0;
      P1 = lcopy(P);
      P1 = lred(P1);
      switch(fromto) {
        case 1: /* Z --> R */
          for(i = n; i >= 0; --i) {
            coef = lfirst(P1);
            a[i] = itofl(coef);
            P1 = lred(P1);
            zreal[i] = a[i];
            zimag[i] = 0;
          }
          break;
        case 2: /* Q --> R */
          for(i = n; i >= 0; --i) {
            coef = lfirst(P1);
            a[i] = rtofl(coef);
            P1 = lred(P1);
            zreal[i] = a[i];
            zimag[i] = 0;
          }
          break;
        case 0:  /* R --> R */
        default: /* R --> R */
          for(i = n; i >= 0; --i) {
            a[i] = lfirst(P1);
            P1 = lred(P1);
            zreal[i] = a[i];
            zimag[i] = 0;
          }
      }
                /*
                 * Polynom fuer Berechnung aufbereiten;
                 * von Z, Q bzw R nach R umformen
                 */

      m = 0;
      for(i = 0; i < n; ++i) {
        if(zreal[i] == 0) {
          NULLST = list1(0);
          RROOTS = lconc(RROOTS, NULLST);
          m = m + 1;
        }
        else break;
      }
      if(m != 0) {
        n = n - m;
        if(n != 0) {
          for(i = 0; i <= n; ++i) {
            a[i] = a[i+m];
            zreal[i] = zreal[i+m];
          }
        }
      }
                /*
                 * Polynom solange durch x dividieren,
                 * bis 0 keine Nullstelle mehr ist
                 */

      if(n != 0) {
        start = Cfltofl(0.125);
                /*
                 * Startwert einstellen
                 */

        dd = ceil((FL_EPS - 2)/0.1107309364962455);
        k = (int)dd;
        k = (-(k/2));
        ZEHN = Cfltofl(10.0);
        EXPONENT = itofl(k);
        MACH_EPS = flpow(ZEHN, EXPONENT);
        EPSQUAD = flprod(MACH_EPS, MACH_EPS);
        EPSROOT = flsqrt(MACH_EPS);
        temp = Cfltofl(2.0);
        eps = flprod(temp, MACH_EPS);
                /*
                 * Rechengenauigkeit einstellen
                 */

        iu = 0;
        do {
                /*
                 * Mullerverfahren bis iu = n-1
                 */

          temp = flabs(zreal[iu]);
          wert = flcomp(temp, EPSQUAD);
          while(wert == (-1)) {
            zreal[iu] = 0;
            zimag[iu] = 0;
            iu = iu + 1;
            temp = flabs(zreal[iu]);
            wert = flcomp(temp, EPSQUAD);
          }
                /*
                 * Nulloesungen des Rest-Polynoms
                 */

          if(iu >= n-1) {
            temp = Cfltofl(1.0);
            temp = flneg(temp);
            temp = flquot(temp, zreal[n]);
            zreal[n-1] = flprod(zreal[n-1], temp);
            zimag[n-1] = 0;
            NULLST = list1(zreal[n-1]);
            RROOTS = lconc(RROOTS, NULLST);
            break;
          }
                /*
                 * wenn iu = n-1 --> Ende
                 */

          iter = 0;
                /*
                 * Iterationszaehler initialisieren
                 */

          x0real = flneg(start); x0imag = 0;
          x1real = start;        x1imag = 0;
          x2real = 0;            x2imag = 0;
                /*
                 * Startwerte fuer Muller-Iteration
                 */

          h1real = fldif(x1real, x0real); h1imag = 0;
          h2real = fldif(x2real, x1real); h2imag = 0;
          f0r = zreal[n]; f0i = 0;
          f1r = f0r;      f1i = 0;
          for(i = n; i >= iu+1; --i) {
            temp = flprod(f0r, x0real);
            f0r = flsum(temp, zreal[i-1]);
            temp = flprod(f1r, x1real);
            f1r = flsum(temp, zreal[i-1]);
                /*
                 * Auswertung nach Horner
                 * Funktionswerte an den Stellen x0real, x1real
                 */
          }
          f2r = zreal[iu]; f2i = 0;
                /*
                 * zugehoerige Funktionswerte
                 */

          temp = flabssum(f0r, f0i);
          temp2 = flabssum(f1r, f1i);
          wert = flcomp(temp, EPSQUAD);
          wert2 = flcomp(temp2, EPSQUAD);
          if((wert == (-1)) || (wert2 == (-1))) {
                /*
                 * Startwert ist gute Naeherung
                 */

            wert = flcomp(temp, temp2);
            if(wert == (-1)) {
              zreal[iu] = x0real;
              zimag[iu] = x0imag;
            }
            else {
              zreal[iu] = x1real;
              zimag[iu] = x1imag;
            }
            iu = iu + 1;
          }
          temp = fldif(f1r, f0r);
          fd1r = flquot(temp, h1real);
          fd1i = 0;
                /*
                 * 1. dividierte Differenz Nr. 1
                 * fd1 = (f1 - f0) / h1
                 */

          do {
                /*
                 * Muller-Iteration
                 */

            temp2 = flprod(h2imag, h2imag);
            temp3 = flprod(h2real, h2real);
            temp = flsum(temp3, temp2);
            fdr = fldif(f2r, f1r);
            fdi = fldif(f2i, f1i);
            temp2 = flprod(fdr, h2real);
            temp3 = flprod(fdi, h2imag);
            temp2 = flsum(temp2, temp3);
            fd2r = flquot(temp2, temp);
            temp2 = flprod(fdi, h2real);
            temp3 = flprod(fdr, h2imag);
            temp2 = fldif(temp2, temp3);
            fd2i = flquot(temp2, temp);
                /*
                 * 1. dividierte Differenz Nr. 2
                 *  fd2 = (f2 - f1) / h2
                 */

            fdr = fldif(fd2r, fd1r);
            fdi = fldif(fd2i, fd1i);
            hnr = flsum(h1real, h2real);
            hni = flsum(h1imag, h2imag);
            temp = flprod(hnr, hnr);
            temp3 = flprod(hni, hni);
            temp = flsum(temp, temp3);
            temp2 = flprod(fdr, hnr);
            temp3 = flprod(fdi, hni);
            temp2 = flsum(temp2, temp3);
            fd3r = flquot(temp2, temp);
            temp2 = flprod(fdi, hnr);
            temp3 = flprod(fdr, hni);
            temp2 = fldif(temp2, temp3);
            fd3i = flquot(temp2, temp);
                /*
                 * 2. dividierte Differenz
                 * fd3 = (fd2 - fd1) / (h1 + h2)
                 */

            temp = flprod(h2real, fd3r);
            temp2 = flprod(h2imag, fd3i);
            temp = fldif(temp, temp2);
            b1r = flsum(temp, fd2r);
            temp = flprod(h2real, fd3i);
            temp2 = flprod(h2imag, fd3r);
            temp = flsum(temp, temp2);
            b1i = flsum(temp, fd2i);
                /*
                 *  h2 * fd3
                 */

            h1real = h2real;
            h1imag = h2imag;
                /*
                 * letzte Korrektur merken,
                 */

            if((fd3r != 0) || (fd3i != 0) || (b1r != 0) || (b1i != 0))
              quadsolv(fd3r, fd3i, b1r, b1i, f2r, f2i, &h2real, &h2imag);
            else {
              h2real = Cfltofl(0.5);
              h2imag = 0;
            }
                /*
                 * neue berechnen
                 */

            x1real = x2real;
            x1imag = x2imag;
                /*
                 * alte Loesung merken,
                 */

            x2real = flsum(x2real, h2real);
            x2imag = flsum(x2imag, h2imag);
                /*
                 * neue berechnen:
                 * x2 = x2 + h2
                 */

            f1r = f2r;
            f1i = f2i;
            fd1r = fd2r;
            fd1i = fd2i;
            cpval(n, iu, x2real, x2imag, zreal, &f2r, &f2i);
                /*
                 * genauso fuer Funktionswerte
                 */

            i = 0;
            temp = itofl(n);
            temp2 = flabssum(f2r, f2i);
            temp4 = flabssum(f1r, f1i);
            temp3 = flprod(temp, temp4);
            wert = flcomp(temp2, temp3);
            while((wert == 1) && (i < 10)) {
              i = i + 1;
              temp4 = Cfltofl(0.5);
              h2real = flprod(h2real, temp4);
              h2imag = flprod(h2imag, temp4);
              x2real = fldif(x2real, h2real);
              x2imag = fldif(x2imag, h2imag);
              cpval(n, iu, x2real, x2imag, zreal, &f2r, &f2i);
              temp2 = flabssum(f2r, f2i);
                /*
                 * h2 halbieren, x2, f2 korrigieren
                 */

              wert = flcomp(temp2, temp3);
            }
                /*
                 * uneffektive Richtungen und damit overflow vermeiden
                 */

            iter = iter + 1;
            if(iter > ITERMAX) {
              if(sort) lflbsort(RROOTS);
              *pROOTS = list2(RROOTS, CROOTS);
              return(2);
            }
                /*
                 * ITERMAX (= 500) ueberschritten
                 */

            temp = flabssum(h2real, h2imag);
            temp4 = flabssum(x2real, x2imag);
            temp3 = flprod(eps, temp4);
            wert = flcomp(temp2, MACH_EPS);
            wert2 = flcomp(temp, temp3);
          } while((wert == 1) || (wert2 == 1));
                /*
                 * Ende Muller-Iteration
                 */

          temp = flabssum(f1r, f1i);
          temp2 = flabssum(f2r, f2i);
          wert = flcomp(temp, temp2);
          if(wert == (-1)) {
            x2real = x1real;
            x2imag = x1imag;
          }
                /*
                 * bessere Naeherung auswaehlen
                 */

          temp = flabs(x2imag);
          temp3 = flabs(x2real);
          temp2 = flprod(EPSROOT, temp3);
          wert = flcomp(temp, temp2);
          if(wert == 1) {
            temp4 = Cfltofl(2.0);
            p = flprod(temp4, x2real);
            temp4 = flprod(x2real, x2real);
            temp = flneg(temp4);
            temp4 = flprod(x2imag, x2imag);
            q = fldif(temp, temp4);
            temp4 = flprod(p, zreal[n]);
            zreal[n-1] = flsum(zreal[n-1], temp4);
            for(i = n-2; i >= iu+2; --i) {
              temp = flprod(p, zreal[i+1]);
              temp4 = flprod(q, zreal[i+2]);
              temp = flsum(temp, temp4);
              zreal[i] = flsum(zreal[i], temp);
            }

            zreal[iu+1] = x2real;        zimag[iu+1] = x2imag;
            z = ccri(zreal[iu+1], zimag[iu+1]);
            NULLST = list1(z);
            CROOTS = lconc(CROOTS, NULLST);
            zreal[iu] = x2real;          zimag[iu] = flneg(x2imag);
            z = ccri(zreal[iu], zimag[iu]);
            NULLST = list1(z);
            CROOTS = lconc(CROOTS, NULLST);
            iu = iu + 2;
                /*
                 * Polynomgrad um 2 erniedrigen
                 */

          }
                /*
                 * abdividieren einer komplexen Nullstelle
                 * und der komplex Konjugierten
                 */

          else {
            for(i = n-1; i >= iu+1; --i) {
              temp4 = flprod(zreal[i+1], x2real);
              zreal[i] = flsum(zreal[i], temp4);
            }

            zreal[iu] = x2real; zimag[iu] = 0;
            NULLST = list1(zreal[iu]);
            RROOTS = lconc(RROOTS, NULLST);
            iu = iu + 1;
                /*
                 * Polynomgrad um 1 erniedrigen
                 */

          }
                /*
                 * reelle Nullstelle abdividieren
                 */

        } while(iu != n);
                /*
                 * Ende Mullerverfahren
                 */

      }
      if(sort) lflbsort(RROOTS);
      *pROOTS = list2(RROOTS, CROOTS);
                /*
                 * fuer sort = 1 Liste der reellen Nullstellen
                 * sortieren;
                 * Liste pROOTS zusammenbauen
                 */

      free(zimag);
      free(zreal);
      free(a);
                /*
                 * reservierten Speicherplatz fuer zimag, zreal und a
                 * wieder freigeben
                 */

      return(3);
    }    
  }
}
                /***  Ende udprf ***/


/*c
                cpval( n, iu, xreal, ximag, zreal, pfreal, pfimag )

        "complex polynomial-evaluation"
        cpval(n, iu, xreal, ximag, zreal, pfreal, pfimag)
             single n, iu; floating xreal, ximag;
             floating zreal[]; floating *pfreal, *pfimag;
        cpval(n, iu, xreal, ximag, zreal, pfreal, pfimag);

        Eingabeparameter:
           n, iu                n-iu ist der Polynomgrad
           xreal                Realteil der Auswertungsstelle
           ximag                Imaginaerteil der Auswertungsstelle
           zreal[]              relle Polynomkoeffizienten

        Ausgabeparameter:
           pfreal               Realteil des Polynomwerts
           pfimag               Imaginaerteil des Polynomwerts

        cpval bestimmt  den  Funktionswert  eines Polynoms vom Grade n mit
        den reellen Koeffizienten  zreal[iu], ..., zreal[n-1], zreal[n] an
        der (komplexen) Stelle (xreal, ximag).
c*/

static cpval(n, iu, xreal, ximag, zreal, pfreal, pfimag)
single   n,iu;
floating xreal,ximag;
floating zreal[];
floating *pfreal,*pfimag;
{
  single   i;
  floating temp, temp2, temp3;

  bind(xreal, ximag);

  init(temp, temp2, temp3);

  *pfreal = zreal[n];
  *pfimag = 0;

  if(ximag == 0)
    for(i = n; i >= iu+1; --i) {
      temp3 = flprod(*pfreal, xreal);
      *pfreal = flsum(temp3, zreal[i-1]);
    }
                /*
                 * Funktionswert reell
                 */

  else
    for(i = n; i >= iu+1; --i) {
      temp = *pfreal;
      temp2 = flprod(*pfreal, xreal);
      temp3 = flprod(*pfimag, ximag);
      temp2 = fldif(temp2, temp3); 
      *pfreal = flsum(temp2, zreal[i-1]);
      temp2 = flprod(temp, ximag);
      temp3 = flprod(xreal, *pfimag);
      *pfimag = flsum(temp2, temp3);
    }
                /*
                 * Funktionswert komplex
                 */
}
                /***  Ende cpval  ***/


/*c
                quadsolv( ar, ai, br, bi, cr, ci, ptreal, ptimag )

        "quadratic equation solve"
        quadsolv(ar, ai, br, bi, cr, ci, ptreal, ptimag)
                floating ar, ai, br, bi, cr, ci;
                floating *ptreal, *ptimag;
        quadsolv(ar, ai, br, bi, cr, ci, ptreal, ptimag);

        Eingabeparameter:
           ar, ai               Faktor von t^2
           br, bi               Faktor von t
           cr, ci               Konstanter Term

        Ausgabeparameter:
           ptreal, ptimag       komplexe Loesung

        Berechnung  der  betragsmaessig  kleinsten  Loesung  der Gleichung
          a * t^2 + b * t + c = 0 .  a, b, c und t sind komplex.
        Formel dazu:
                                   2c
                    t = ------------------------
                                       2
                         - b +/- sqrt(b  - 4ac)    .

        Die Formel ist fuer a = 0 gueltig!
c*/

static quadsolv(ar, ai, br, bi, cr, ci, ptreal, ptimag)
floating ar, ai, br, bi, cr, ci;
floating *ptreal, *ptimag;
{
  single   wert;

  floating temp, temp2, temp3;
  floating sr, si, qr, qi, h;

  bind(ar, ai, br, bi, cr, ci);

  init(temp, temp2, temp3);
  init(sr, si, qr, qi, h);

  temp = flprod(br, br);
  temp3 = flprod(bi, bi);
  sr = fldif(temp, temp3);
  temp = Cfltofl(2.0);
  temp3 = flprod(br, bi);
  si = flprod(temp, temp3);
                /*
                 *  s = b * b
                 */

  temp = flprod(ar, cr);
  temp3 = flprod(ai, ci);
  qr = fldif(temp, temp3);
  temp = flprod(ar, ci);
  temp3 = flprod(ai, cr);
  qi = flsum(temp, temp3);
                /*
                 *  q = a * c
                 */

  temp = Cfltofl(4.0);
  temp3 = flprod(temp, qr);
  sr = fldif(sr, temp3);
  temp3 = flprod(temp, qi);
  si = fldif(si, temp3);
  temp = flprod(sr, sr);
  temp2 = flprod(si, si);
  temp3 = flsum(temp, temp2);
  h = flsqrt(temp3);

  if(si == 0 && flsign(sr) == 1) qr = flsqrt(sr);
  else {
    qr = flsum(h, sr);
    wert = flcomp(qr, 0);
    if(wert == (-1)) qr = 0;
    temp = Cfltofl(2.0);
    temp3 = flquot(qr, temp);
    qr = flsqrt(temp3);
  }
  if(si == 0 && flsign(sr) == 1) qi = 0;
  else qi = fldif(h, sr);
  wert = flcomp(qi, 0);
  if(wert == (-1)) qi = 0;
  temp3 = flquot(qi, temp);
  qi = flsqrt(temp3);
  wert = flcomp(si, 0);
  if(wert == (-1)) qi = flneg(qi);
                /*
                 *  q = sqrt(s)
                 */

  temp = flprod(qr, br);
  temp3 = flprod(qi, bi);
  h = flsum(temp, temp3);
  if(flcomp(h, 0) == 1) {
    qr = flneg(qr);
    qi = flneg(qi);
  }

  sr = fldif(qr, br);
  si = fldif(qi, bi);
                /*
                 *  s = -b +/- q,
                 *  so dass Betrag s gross
                 */

  temp = flprod(sr, sr);
  temp3 = flprod(si, si);
  h = flsum(temp, temp3);
  temp = flprod(cr, sr);
  temp3 = flprod(ci, si);
  temp = flsum(temp, temp3);
  temp2 = Cfltofl(2.0);
  temp3 = flprod(temp2, temp);
  *ptreal = flquot(temp3, h);
  temp = flprod(ci, sr);
  temp3 = flprod(cr, si);
  temp = fldif(temp, temp3);
  temp3 = flprod(temp2, temp);
  *ptimag = flquot(temp3, h);
                /*
                 *  t = (2 * c) / s
                 */
}
                /***  Ende quadsolv  ***/

