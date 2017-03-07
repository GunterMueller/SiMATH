/*M
.SH NAME
ecmpsnfmsha1 - elliptic curve over modular primes, short normal form, modified Shanks' algorithm, first part

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecmpsnfmsha1(p, a4, a6, PL, a, m, pl, ts)
int p, a4, a6; 
list PL; 
int a, m; 
single pl, ts;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p > 37.
.TP 4
.B a4, a6 
are the coefficients of an elliptic curve, say E, in short Weierstrass normal form over Z/pZ.
.TP 4
.B PL 
is a list, containing three elements of Z/pZ, defining a point, say P, in projective representation on E.
.TP 4
.B a,m
are integer number, so that #E(Z/pZ) = a mod m holds. (Generally, a and m will be computed with the Schoof-algorithm.)
.TP 4
.B pl
switches the output of intermediary results to stdout during the computation on (pl != 0) or off (pl = 0).
.TP 4
.B ts
is a positive integer number, controlling the lenght of the used table. For ts = 0, the program uses a table long enough to minimize the running time (assuming that enough memory is available). For ts != 0, the programm uses ts percent of the required table lenght, so values larger than 100 should not be used, because then, both running time as the required memory will be increased.  
.PP
ecmpsnfmsha1 computes with help of a modified babystep-giantstep algorithm the order of the point P and a multiple of the order of P in the Hasse interval of p.
.PP
If the required table could not be created, ecmpisnfmsha1 returns NULL, else it returns a list 
.IP
(status res ord ), int status, res, ord;
.PP
If status < 0, then the order of the point P was not large enough for a successfully computation.
.PP
If status > 0, then ord contains the order of the starting point P, and res contains a multiple of ord in the Hasse-interval, so that res = a mod m holds. 
.SH NOTES
1.) The required memory is of magnitude 
.IP
 sqrt(sqrt(p))    1
 ------------- * --- KB.
    sqrt(m)      128    
.PP
2.) For p < 30000, ecmspsnfnp is faster than ecmpsnfmsha1.
     
.SH SEE ALSO
ecmspsnfnp

M*/
         
/*H
	Version 1	14.11.91	Michael Pfeifer
	Version 2	30.09.92	korrekten Header _ec2 eingebunden,
					ecmpsnfmsha1 liefert nun den korrekten
					Typ `list' zurueck. Der Variablenname
					`plc' wurde durch `p_lc' ersetzt.  MP
   DATE ecmpsnfmsha1  : 920331.921130
H*/

#include <_ec2.h>

#define PATTERN ~(3 << 30)

/*
#define NOMINATOR 1
#define DENOMINATOR 1
*/

static asqsorts(single,single,single*);
static single asbsrchs(single,single*,single,single);
static int ecmpord(int,int,int,int,list);

list            ecmpsnfmsha1(p, a4, a6, P, a, m, pl, ts)
    int             p, a4, a6;
    list            P;
    int             a, m;
    single          pl, ts;
{
    single          ui, oi, ind, g, h, i, j, k, l;
    single          p_lc, ps, maxgs;
    int             x0, y0, x1, y1, x2, y2, xh, yh;
    int             sqp, ug, og;
    int             ugs, ls;
    int             k1, l1;
    int             res, ord;
    list            Q, H, MP;

/*
    list            HP1, HP2;
*/

    single         *T;

    void            ecmpsnfsums();
    void            ecmpsnfmuls();

    bind(p, a4, a6, P, a, m);

    init(x0, y0, x1, y1, x2, y2, xh, yh);
    init(sqp, ug, og);
    init(ugs, ls);
    init(k1, l1);
    init(res, ord);
    init(Q, H, MP);
/*
    init(HP1, HP2);
*/

    /*
     * ug und og sind die untere und die obere Grenze des Hasse-Intervalls.
     * sqp ist der ganzzahlige Anteil von 2 * sqrt(p).
     */

    sqp = isqrt(isprod(p, 4));
    ug = idif(isum(p, 1), sqp);
    og = isum(isum(p, 1), sqp);
    k1 = iroot(p, 4, &ps);
    if (ps != 0)
    {
	k1 = isum(k1, 1);
    }

/*
    k1 = iprod(k1, NOMINATOR);
    k1 = iquot(k1, DENOMINATOR);
*/

    if (ts != 0)
    {
	k1 = iprod(k1, ts);
	k1 = iquot(k1, 100);
    }

    k1 = isum(k1, 1);

    k1 = iprod(k1, isqrt(m));

    l1 = isprod(k1, 2);

    /*
     * k ist die Anzahl der von 0 verschiedenen Punkte, die letztendlich in
     * der Tabelle abgelegt werden. l ist die tatsaechlich benoetigte
     * Feldlaenge.
     */

    k = iquot(k1, m);
    k = k + 1;
    l = 2 * k;

    if (pl)
    {
	printf("\n   Hasse-Intervall: [%i, ... , %i]", ug, og);
    }

    /*
     * MP = m * P. Aufgrund der Kongruenz #E(Z/pZ) = a (mod m) genuegt es,
     * die Vielfachen von MP = m * P zu betrachten und abzuspeichern.
     */

    MP = ecmpsnfmul(p, a4, a6, m, P);

    /*
     * Bereitstellen von Speicherplatz fuer die Liste mit den Vielfachen des
     * Punktes MP auf E. Tatsaechlich wird spaeter nur das letzte Wort der
     * x-Koordinaten abgespeichert. Es genuegt daher, fuer jeden Punkt 2
     * Bytes zu allokieren.
     */

    if (pl)
    {
	printf("\n   Anzahl der Punkte in der Tabelle: %i", k + 1);
	printf("\n   Das entspricht %i KB an Speicherplatz",
	       isquot(k + 1, 128));
    }

    T = (single *) malloc((l + 2) * sizeof(single));
    if (T == NULL)
    {
	return (NULL);
    }

    /*
     * P = (x0, y0) ist der urspruenglich ausgewaehlte Punkt. (x1, y1) und
     * (x2, y2) werden mit den Koordinaten des Punktes MP vorbesetzt. (MP = m *
     * P).
     */

    x0 = lfirst(P);
    y0 = lsecond(P);
    x1 = lfirst(MP);
    y1 = lsecond(MP);
    x2 = x1;
    y2 = y1;

    /*
     * Die beiden ersten Feldelemente werden mit -1 und 0 vorbesetzt, um ein
     * korrektes Funktionieren der Such- und Sortiertoutien zu
     * gewaehrleisten. Das dritte Feldelement wird mit dem letzten Wort der
     * x-Koordinate von MP besetzt. Das vierte Feldelement wird mit 1
     * besetzt.
     */

    *T = -1;
    *(T + 1) = 0;

    /*
     * Die Liste T enthaelt nur das erste Wort der jeweiligen x-Koordinaten
     * und den "Index" des jeweiligen Punktes.
     */

    if (issingle(x2) == 0)
    {
	*(T + 2) = (lfirst(x2) & PATTERN);
    }
    else
    {
	*(T + 2) = (x2 & PATTERN);
    }
    *(T + 3) = 1;

    if (pl)
    {
	printf("\n   Beginn der Baby-Steps.");
	p_lc = 0;
    }

    for (i = 2, j = 4; i <= k; i++, j = j + 2)
    {
	ecmpsnfsums(p, a4, a6, &x1, &y1, &x2, &y2);

	if (issingle(x2) == 0)
	{
	    *(T + j) = (lfirst(x2) & PATTERN);
	}
	else
	{
	    *(T + j) = (x2 & PATTERN);
	}

	*(T + j + 1) = i;

	if (pl)
	{
	    if (mshom((k / 10) + 1, i) == 0)
	    {
		p_lc++;
		printf("\n         %i0 %%", p_lc);
	    }
	}
    }

    /*
     * Der naechste Test dient nur der Kontrolle. Er wird in der
     * Einbauversion nicht durchgefuehrt. Es wird ueberprueft, ob
     * Multiplikation und fortgesetzte Addition dasselbe Ergebnis liefern.
     */

/*
    HP1 = ecmpsnfmul(p, a4, a6, m, P);
    HP1 = ecmpsnfmul(p, a4, a6, k, HP1);
    HP2 = list3(x2, y2, 1);
    if (isppecmpeq(p, HP1, HP2) != 1)
    {
	free(T);
	return (list3(-2, 1, 1));
    }
*/

    /*
     * Die Tabelle wurde korrekt erstellt. Sortieren der Tabelle.
     */

    if (pl)
    {
	printf("\n   Sortieren der Tabelle.");
    }

    asqsorts(1, k, T);

    /*
     * Der naechste Test ueberprueft, ob die Tabelle korrekt sortiert wurde.
     * Auch er wird in der Einbauversion nicht durchgefuehrt.
     */

/*
    for (j = 0; j < k; j = 2 + j)
    {
	if (*(T + j) > *(T + j + 2))
	{
	    free(T);
	    return (list3(-3, 1, 1));
	}
    }
*/

    /*
     * ugs ist die modifizierte untere Grenze des Hasse-Intervalls, bei der
     * die Giantsteps beginnen muessen.
     */

    ugs = iprod(iquot(ug, m), m);
    ugs = isum(ugs, a);
    if (icomp(ugs, ug) >= 0)
    {
	ugs = idif(ugs, m);
    }

    /*
     * ls ist die Schrittweite bei den Giantsteps.
     */

    ls = iprod(iquot(l1, m), m);
    ls = idif(ls, isprod(m, 4));

    /*
     * Q = ls * P mit dem uspruenglich gewaehlten Punkt P und der
     * Schrittweite ls.
     */

    Q = ecmpsnfmul(p, a4, a6, ls, P);

    x1 = lfirst(Q);
    y1 = lsecond(Q);

    /*
     * H = ugs * P mit dem urspruenglich gewaehlten Punkt P und dem
     * Anfangswert ugs fuer die Giantsteps.
     */

    H = ecmpsnfmul(p, a4, a6, ugs, P);

    x2 = lfirst(H);
    y2 = lsecond(H);

    maxgs = isprod(sqp, 2);
    maxgs = iquot(maxgs, idif(ls, 1));
    maxgs = maxgs + 1;

    /*
     * Beginn der Giant-Steps.
     */

    if (pl)
    {
	printf("\n   Beginn der Giant-Steps.");
	p_lc = 0;
    }

    for (j = 0; j <= maxgs; j++)
    {

	if (pl)
	{
	    if (mshom((maxgs / 10) + 1, j + 1) == 0)
	    {
		p_lc++;
		printf("\n         %i0 %%", p_lc);
	    }
	}

	if (x2 != -1)
	{
	    if (issingle(x2) == 0)
	    {
		h = (lfirst(x2) & PATTERN);
	    }
	    else
	    {
		h = (x2 & PATTERN);
	    }
	    ind = asbsrchs(h, T, 0, k);
	}
	else
	{
	    ind = 0;
	    h = -1;
	}

	/*
	 * An dieser Stelle hat ind den Wert -1, falls das erste Wort von x2
	 * nicht in der Tabelle enthalten ist. Sonst enthaelt (T + ind) das
	 * erste Wort von x2.
	 */

	if (ind != -1)
	{

	    /*
	     * Das erste Wort von x2 tritt in der Tabelle auf. Der von
	     * asbsrchs gelieferte Index ist allerdings nicht notwendig
	     * eindeutig bestimmt. Die naechsten beiden while-Schleifen
	     * dienen dazu, einen unteren Index ui und einen oberen Index oi
	     * zu bestimmen, so dass die in der Tabelle gespeicherten Werte
	     * in diesem Bereich dem ersten Wort von x2 entsprechen.
	     */

	    ui = oi = ind;

	    if (ind != 0)
	    {
		g = 0;
		while (*(T + ind - g) == h)
		{
		    ui = ind - g;
		    g = g + 2;
		}
	    }

	    if (ind != k)
	    {
		g = 0;
		while (*(T + ind + g) == h)
		{
		    oi = ind + g;
		    g = g + 2;
		}
	    }

	    for (ind = ui; ind <= oi; ind = ind + 2)
	    {
		res = iprod(j, ls);
		res = isum(res, isprod(m, *(T + ind + 1)));
		res = isum(ugs, res);

		/*
		 * Da nur das erste Wort der x-Koordinaten der Vielfachen der
		 * Punkte in der Tabelle abgespeichert ist, muss man
		 * ueberprufen, ob (ug + j * l +/- *(T + ind + 1)) * P
		 * tatsaechlich der Nullpunkt der Kurve ist.
		 */

		if (issingle(x0))
		{
		    xh = x0;
		}
		else
		{
		    xh = lcopy(x0);
		}
		if (issingle(y0))
		{
		    yh = y0;
		}
		else
		{
		    yh = lcopy(y0);
		}
		ecmpsnfmuls(p, a4, a6, &xh, &yh, res);
		if (xh == -1)
		{

		    /*
		     * res enthaelt an dieser Stelle mit hoher
		     * Wahrscheinlichkeit die Gruppenordnung. res enthaelt
		     * mit Sicherheit ein Vielfaches der Ordnung von P. ord
		     * enthaelt die genaue Ordnung von P. Die Routine ecmpord
		     * ermoeglicht es, die Schleife abzubrechen, wenn ein
		     * einziger Punkt gefunden wurde.
		     */

		    if (pl)
		    {
			printf("\n   Berechnung der Ordnung des Startpunktes.");
			printf("\n   res = %i", res);
		    }
		    ord = ecmpord(p, a4, a6, res, P);

		    free(T);
		    return (list3(1, res, ord));
		}

		res = iprod(j, ls);
		res = idif(res, isprod(m, *(T + ind + 1)));
		res = isum(ugs, res);

		if (issingle(x0))
		{
		    xh = x0;
		}
		else
		{
		    xh = lcopy(x0);
		}
		if (issingle(y0))
		{
		    yh = y0;
		}
		else
		{
		    yh = lcopy(y0);
		}
		ecmpsnfmuls(p, a4, a6, &xh, &yh, res);
		if (xh == -1)
		{
		    if (pl)
		    {
			printf("\n   Berechnung der Ordnung des Startpunktes.");
			printf("\n   res = %i", res);
		    }
		    ord = ecmpord(p, a4, a6, res, P);

		    free(T);
		    return (list3(1, res, ord));
		}
	    }
	}

	ecmpsnfsums(p, a4, a6, &x1, &y1, &x2, &y2);
    }

    free(T);
    return (list3(-5, 1, 1));
}

 /*
  * Ende von ecmpsnfmsha1. *****************************************************
  */

/*c
                        asqsorts(f, l, T);

        "array of singles quick sort, special version"
        void asqsorts(f, l, T)  single f, l, *T;
        asqsorts(f, l, T);
        T ist ein Zeiger auf die von ecmpsnfsha erzeugte Tabelle T
        (array vom Typ single) der Form
                [ x_f, f, x_(f+1), f+1, ... x_l, l ].
        asqsorts liefert eine nach der Groesse der x-Werte sortierte
        Tabelle der Form
                [ x_g, g, x_(g+1), g+1, ... x_k, k ].
        Dabei gilt x_g <= x_g+1 <= ... <= x_k und die Indizes g, g+1,
        ... , k sind eine Permutation der Indizes f, f+1, ... , l.
        asqsorts ist ein static-Modul zu ecmpsnfmsha1. Die Tabelle T wird
        veraendert.
c*/
/*H
        Version 1       11.10.1991      Michael Pfeifer
H*/

static          asqsorts(l, r, T)
    single          l, r, *T;

{
    single          h, i, k, S;

    i = l;
    k = r + 1;
    S = *(T + 2 * l);

    while (i < k)
    {
	do
	{
	    i++;
	}
	while ((*(T + 2 * i) < S) && (i < k));

	do
	{
	    k--;
	}
	while ((*(T + 2 * k) > S) && (k > 0));

	if (k > i)
	{
	    h = *(T + 2 * k);
	    *(T + 2 * k) = *(T + 2 * i);
	    *(T + 2 * i) = h;

	    h = *(T + 2 * k + 1);
	    *(T + 2 * k + 1) = *(T + 2 * i + 1);
	    *(T + 2 * i + 1) = h;
	}
    }

    h = *(T + 2 * l);
    *(T + 2 * l) = *(T + 2 * k);
    *(T + 2 * k) = h;

    h = *(T + 2 * l + 1);
    *(T + 2 * l + 1) = *(T + 2 * k + 1);
    *(T + 2 * k + 1) = h;

    if (l < k - 1)
    {
	asqsorts(l, k - 1, T);
    }
    if (k + 1 < r)
    {
	asqsorts(k + 1, r, T);
    }

    return;
}

 /*
  * Ende von asqsorts. *********************************************************
  */

/*c
                        asbsrchs(x, T, ug, og)

        "array of single precisions, binary search, special version"
        single asbsrchs(x, T, ug, og)  single x, *T, ug, og;
        n = asbsrchs(x, T, ug, og);
        x ist eine Ganze Zahl, T ist ein Zeiger auf die von asqsorts
        sortierte Tabelle, ug bzw. og sind die untere bzw. obere Grenze
        des zu durchsuchenden Intervalles. T ist von der Form
                [ x_g, g, x_(g+1), ... , x_k, k ]
        mit x_g <= x_(g+1) <= ... <= x_k und es gilt x_g = *T(2*ug) und
        x_k = *T(2*og). asbsrchs liefert den Index j falls x = x_j fuer
        ein in T enthaltenes x_j und -1, falls x != x_j fuer alle in T
        enthaltenen x_j. asbsrchs ist ein static-Modul zu ecmpsnfmsha1.
c*/
/*H
        Version 1       14.10.1991      Michael Pfeifer
H*/

static single   asbsrchs(x, T, ug, og)
    single          x, *T, ug, og;

{
    single          i = 2 * ((og + 1 + ug) / 2);

    /*
     * i ist die Tabellenmitte
     */

    if (og - ug < 0)
    {

	/*
	 * Tabelle ist leer.
	 */

	return (-1);
    }

    if (x == *(T + i))
    {

	/*
	 * x ist in der Tabelle an i-ter Stelle.
	 */

	return (i);
    }

    if (og == ug)
    {

	/*
	 * x ist nicht in der Tabelle enthalten.
	 */

	return (-1);
    }

    if (x < *(T + i))
    {

	/*
	 * x ist nicht in der oberen Haelfte.
	 */

	return (asbsrchs(x, T, ug, i / 2 - 1));
    }
    else
    {

	/*
	 * x ist nicht in der unteren Haelfte.
	 */

	return (asbsrchs(x, T, i / 2 + 1, og));
    }
}

 /*
  * Ende von asbsrchs. *********************************************************
  */

/*c
                        ecmpord(p, a4, a6, res, P)

        "elliptic curve over modular prime order of point"
        int ecmpord(p, a4, a6, res, P)  int p, a4, a6, res; list P;
        ord = ecmpord(p, a4, a6, res, P);
        P ist ein Punkt auf der durch a4 und a6 in kurzer
        Weierstrass-Normalform gegebenen elliptischen Kurve. ord ist
        ein Vielfaches der Punktordnung von P, d.h. ord*P = 0. ecmpord
        berechnet die genaue Ordnung von P. ecmpord ist ein
        static-Modul zu ecmpsnfmsha1.
c*/
/*H
        Version 1       15.10.1991      Michael Pfeifer
H*/

static int      ecmpord(p, a4, a6, res, P)
    int             p, a4, a6, res;
    list            P;
{
    single          exp;
    int             hi, ho, ord, pme;
    list            HP, L;

    bind(p, a4, a6, res, P);

    init(hi, ho, pme, ord);
    init(HP, L);

    ord = 1;

    L = ifact(res);
    L = ifel(L);

    while (L != _0)
    {
	pme = lfirst(L);
	exp = lsecond(L);
	L = lred2(L);

	hi = 1;
	ho = iquot(res, iexp(pme, exp));
	HP = ecmpsnfmul(p, a4, a6, ho, P);

	while (isppecmppai(p, HP) == 0)
	{
	    hi = iprod(hi, pme);
	    HP = ecmpsnfmul(p, a4, a6, pme, HP);
	}
	ord = iprod(ord, hi);
    }
    return (ord);
}

 /*
  * Ende von ecmpord. **********************************************************
  */
