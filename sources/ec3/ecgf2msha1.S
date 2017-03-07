/*C
		ecgf2msha1(G, a1, a2, a3, a4, a6, P, a, m, pl, ts)

	"elliptic curve over Galois-field with characteristic 2, modified
	Shanks' algorithm, first part"
	Quellbibliothek: srclib.ec3
	include-Datei:   _ec3.h
	list ecgf2msha1(G, a1, a2, a3, a4, a6, P, a, m, pl, ts)
		obj G; gf2el a1, a2, a3, a4, a6; list P; int a, m;
		single pl, ts;
	L = ecgf2msha1(G, a1, a2, a3, a4, a6, P, a, m, pl, ts);
	Dabei muss gelten:
		- G ist ein irreduzibles normiertes Polynom in einer
		  Variablen ueber Z/2Z vom Grad n in der speziellen
		  Bit-Darstellung (vgl.udpm2tosb) als erzeugendes
		  Polynom fuer GF(2^n).
		- a1, a2, a3, a4, a6 sind Elemente aus GF(2^n), die als
		  Polynome in einer Variablen ueber Z/2Z vom Grad < n
		  in spezieller Bit-Notation dargestellt werden.
		- P = ( x  y  z ) ist ein projektiver Punkt auf der
		  durch a1, a2, a3, a4, a6 gegebenen elliptischen Kurve
		  ueber GF(2^n), d.h. insbesondere, dass die
		  Koordinaten x, y, z des Punktes Elemente aus GF(2^n)
		  sind.
		- a und m sind ganze Zahlen,
		- pl und ts sind einfach genau.
	a1, a2, a3, a4, a6 sind Koeffizienten einer elliptischen Kurve
	E ueber dem durch G definierten endlichen Koerper der
	Charakteristik 2 vom Grad n. P = (x, y, z) ist ein Punkt auf
	dieser elliptischen Kurve E in projektiver Darstellung.
	ecgf2msha1 berechnet mit Hilfe eines modifizierten
	Babystep-Giantstep-Algorithmus die Ordnung ord des Punktes P in
	der Punktgruppe der elliptischen Kurve E und ein Vielfaches
	res der Ordnung von P. res liegt im Hasse-Intervall (und ist
	damit ein moeglicher Wert fuer die Ordnung der Punktgruppe).
	a und m sind ganze Zahlen, so dass fuer die Ordnung der
	Punktgruppe der Kurve gilt
		#E(GF(2^n)) = a mod m.
	(Mit Hilfe dieser Kongruenz werden Speicherplatz und Laufzeit
	des ueblichen Babystep-Giantstep-Algorithmus verringert.)
	Ist der Paramenter pl == 0, so erfolgt keine Ausgabe auf
	stdout. Ist pl != 0, so erhaelt man waehrend der Laufzeit auf
	stdout einige einfache Ausgaben ueber den gegenwaertigen Stand
	der Berechnungen.
	ts ist eine positive ganze Zahl, die die Groesse der benutzten
	Tabelle kontrolliert.  Wird ts auf 0 gesetzt, so wird die
	Feldgroesse unter der Annahme, dass genuegend Speicherplatz
	vorhanden ist, vom Programm so bestimmt, dass die Laufzeit
	minimiert wird. Ist ts != 0, so wird die Groesse der
	benoetigten Tabelle mit ts/100 multipliziert. Werte kleiner als
	100 verkleinern also die Tabelle, Werte groesser als 100
	vergroessern die Tabelle und sollten nicht benutzt werden, da
	dann sowohl der Speicherplatzbedarf, als auch die Laufzeit
	ansteigen. ts = 100 hat dieselbe Wirkung, wie ts = 0.
	(Eine Verkleinerung der Tabelle bedeutet eine Verkleinerung der
	Anzahl der Babysteps und fuehrt daher zu einer Vergroesserung
	der Anzahl der Giantsteps.)
	Hinweis: Der berechnete Speicherplatzbedarf liegt in der
	Groessenordnung von
			     sqrt(sqrt(2^n))
			     ------------- *  1/128 KB,
			   	 sqrt(m)
	wobei n der Grad des Koerpes ist.
	Vorsicht: Die auftretenden Tabellen koennen durchaus die
	Groessenordnung von mehreren Megabytes erreichen.
	ecgf2msha1 liefert (sofern genuegend Speicherplatz fuer die
	Tabelle vorhanden war) stets eine aus drei Eintraegen
	bestehende Liste L = (status ord res).
		Ist status < 0, so war die Ordnung des Startpunktes zu
	gering.
		Ist status > 0, so enthaelt ord die Ordnung des
	Startpunktes P, und res enthaelt ein Vielfaches von ord im
	Hasse-Intervall, so dass res = a mod m.
	ecgf2msha1 liefert NULL, falls die Tabelle nicht angelegt
	werden konnte.
C*/
/*H
  	Version 1	30.10.1992	Michael Pfeifer
	Version 2       07.11.1995      Output in English  MP
   DATE ecgf2msha1    : 930531.9311__.951201
H*/

#include <_ec3.h>

#define PATTERN ~(3 << 30)

static asqsorts(single,single,single*);
static single asbsrchs(single,single*,single,single);
static int ecgf2ord(obj,gf2el,gf2el,gf2el,gf2el,gf2el,int,list);

list            ecgf2msha1(G, a1, a2, a3, a4, a6, P, a, m, pl, ts)
    gf2el           a1, a2, a3, a4, a6;
    obj             G;				  /* Definierendes Polynom des Koerpers */
    list            P;				  /* Zufaelliger Punkt auf der Kurve */
    int             a, m;			  /* Kongruenz */
    single          pl;				  /* Print Level */
    single          ts;				  /* Tabellengroesse */
{
    single          deg,			  /* Grad des Minimalpoynoms */
                    i,				  /* Hilfsvariable */
                    j,				  /* Hilfsvariable */
                    h,				  /* Hilfsvariable in den Giant Steps */
                    ind,			  /* Tabellenindex */
                    p_lc;			  /* Zaehler */

    int             lh_int,			  /* Hilfsvariable */
                    nelts,			  /* Maechtigkeit des Koerpers */
                    ug,				  /* untere Schranke des Hasse-Intervalls */
                    og,				  /* obere Schranke des Hasse-Intervalls */
                    ug_m,			  /* modifizierte untere Schranke */
                    table,			  /* Anzahl der Punkte in der Tabelle */
                    t_size,			  /* Tabellengroesse */
                    ls,				  /* Laenge eine Giant Steps */
                    maxgs,			  /* Maximale Anzahl der Giant Steps  */
                    res,			  /* moegliche Gruppenordnung  */
                    ord;			  /* Ordnung des Startpunktes */

    gf2el           x0,				  /* x-Koordinate von P */
                    y0,				  /* y-Koordinate von P */
                    x1,				  /* x-Koordinate von m * P */
                    y1,				  /* y-Koordinate von m * P */
                    x2,				  /* x-Koordinate eines Hilfspunktes */
                    y2;				  /* y-Koordinate eines Hilfspunktes */

    list            MP,				  /* MP = m * P */
                    HP2,			  /* HP2 = (x2, y2) */
                    Q,				  /* Q = ls * P */
                    H,				  /* H = ug_m * P */
                    TP;				  /* Hilfspunkt zum Test der Punktordnung */

    single         *T;				  /* Tabelle fuer die Baby Steps */

    bind(G, a1, a2, a3, a4, a6, P, a, m);

    init(lh_int, nelts, ug, og, ug_m, table, t_size, ls, maxgs, res, ord);
    init(x0, y0, x1, y1, x2, y2);
    init(MP, HP2, Q, H, TP);

    /*
     * Berechnung des Koerpergrads
     */

    deg = lfirst(G);

    /*
     * Berechnung von oberer und unterer Schranke des Hasse-Intervalles
     */

    nelts = iexp(2, deg);
    lh_int = isqrt(iprod(4, nelts));
    ug = idif(nelts, lh_int);
    og = isum(nelts, lh_int);
    og = isum(og, 2);

    if (pl) {
	printf("ecgf2msha(): Hasse interval: [%i, ... , %i]\n", ug, og);
    }

    /*
     * Vorausgesetzt sei eine Kongruenz der Form #E(K) = a mod m. Berechne davon abhaengig die Anzahl der Punkte
     * in der Tabelle und die Speicherplatzanforderungen. Die Groesse der Tabelle wird um den Faktor sqrt(m)
     * reduziert. Die Tabellengreoesse ist gleich der Anzahl der Baby Steps und die Anzahl der Giant Steps haengt
     * von der Anzahl der Baby Steps ab. Schliesslich wird die Tabellengroesse noch um einen Faktor 2 reduziert,
     * da man in den Giant Steps gewisse Symmetrien ausnutzt.
     */

    table = idif(og, ug);
    table = isqrt(table);
    table = isprod(table, 10);
    table = iquot(table, isqrt(isprod(m, 100)));
    table = iquot(table, 2);
    if (ts != 0) {
	table = isprod(table, ts);
	table = isquot(table, 100);
    }
    t_size = isprod(table, 2);
    t_size = isum(t_size, 2);

    /*
     * Berechne MP = m * P. Da #E(K) = a mod m ist, genuegt es, die Vielfachen von MP in der Tabelle zu speichern.
     */

    MP = ecgf2mul(G, a1, a2, a3, a4, a6, m, P);
    if (isppecgf2pai(G, MP) == 1) {

	/*
	 * ERROR. The first list entry is set to -1. ***
	 */

	return (list3(-1, 0, 0));
    }

    /*
     * Speicherplatzanforderung fuer die Liste der Vielfachen des Punktes MP. Tatsaechlich wird nur das letzte
     * Wort der x-Koordinate in der Tabelle abgespeichert. Daher genuegt es, zwei Bytes fuer jeden Punkt
     * bereitzustellen: ein Byte fuer das letzte Wort der x-Koordinate und ein Byte fuer den Index des Punktes.
     */

    if (pl) {
	printf("ecgf2msha(): number of points in the table: %i\n", t_size / 2);
	printf("ecgf2msha(): %i KB\n", isquot(t_size / 2, 128));
    }

    T = (single *) malloc(t_size * sizeof(single));
    if (T == NULL) {

	/*
	 * Nicht genuegend Speicherplatz fuer die Tabelle.
	 */

	return (NULL);
    }

    /*
     * (x0, y0) ist die affine Darstellung von P. (x1, y1) ist die affine Darstellung von MP.
     */

    x0 = lfirst(P);
    y0 = lsecond(P);
    x1 = lfirst(MP);
    y1 = lsecond(MP);

    /*
     * Die ersten beiden Elemente des Feldes werden auf -1 bzw. 0 gesetzt, um ein korrektes Funktionieren der
     * Sortier- und Suchroutinen zu gewaehrleisten.
     */

    *T = -1;
    *(T + 1) = 0;

    /*
     * Das letzte Wort der x-Koordinate von MP wird dem dritten Element des Feldes zugewiesen. 1 wird dem vierten
     * Element des Feldes zugewiesen.
     */

    *(T + 2) = (lfirst(llast(x1)) & PATTERN);
    *(T + 3) = 1;

    /*
     * Der Anfang der Baby-Steps. Die Tabelle enthaelt das letzte Wort der x-Koordinaten der Vielfachen von MP und
     * den Index des Punktes.
     */

    HP2 = MP;

    p_lc = 0;

    if (pl) {
	printf("ecgf2msha(): begin of baby steps\n");
    }

    for (i = 2, j = 4; i <= table; i++, j = j + 2) {
	HP2 = ecgf2sum(G, a1, a2, a3, a4, a6, MP, HP2);
	if (isppecgf2pai(G, HP2) == 1) {

	    /*
	     * ERROR. Der erste Listeneintrag wird auf -2 gesetzt. ***
	     */

	    return (list3(-2, 0, 0));
	}
	x2 = lfirst(HP2);
	*(T + j) = (lfirst(llast(x2)) & PATTERN);
	*(T + j + 1) = i;

	/*
	 * Ausgabe des aktellen Standes der Berechnungen.
	 */

	if (pl) {
	    if (mihom((table / 10) + 1, i) == 0) {
		p_lc++;
		printf("         %i0 %%\n", p_lc);
	    }
	}
    }

    /*
     * Der erste Teil des Algorithmus ist beendet. Die Tabelle ist also erzeugt und wird nun entsprechend der
     * ersten Listeneintraege sortiert.
     */

    if (pl) {
	printf("ecgf2msha(): sorting the table...\n");
    }

    asqsorts(1, table, T);

    /*
     * Berechne eine modifizierte untere Schranke fuer den Anfang der Giant-Steps. Ist ug die untere Schranke des
     * Hasse-Intervalls, so ist ug_m die groesste ganze Zahl kleiner als ug, so dass ug_m = a mod m.
     */

    ug_m = iprod(iquot(ug, m), m);
    ug_m = isum(ug_m, a);
    while (icomp(ug_m, ug) >= 0) {
	ug_m = idif(ug_m, m);
    }

    /*
     * ls ist die Schrittweite eines Giant-Steps. (Mit anderen Worten: die Tabelle wird in jedem Giant-Step um ls
     * verschoben.)
     */

    ls = idif(table, 1);
    ls = iprod(ls, m);

    /*
     * Verdopple die Laenge eines Giant-Steps. Es wird stets auch ueberprueft, ob das negative eines Punktes zu
     * einem Treffer fuehrt.
     */

    ls = iprod(ls, 2);

    /*
     * maxgs ist die Maximalanzahl der Giant-Steps. mazgs wird auds der Groesse des Hasse-Intervalls und der
     * Laenge der Giant-Steps berechnet. maxgs wird nicht wirklich benietigt. Falls keine Fehler auftreten,
     * terminiert der Algorithmus, bevor maxgs erreicht wird. Normalerweise ist maxgs etwa doppelt so gross, wie
     * die Anzhal der Punkte in der Tabelle. Statistisch gesehen werden allerdings nur die Haelfte der Giant-Steps
     * ausgefuehrt.
     */

    maxgs = idif(og, ug);
    maxgs = iquot(maxgs, ls);
    maxgs = isum(maxgs, 1);

    /*
     * p_lc stellt die Anzahl der ausgefuehrten Giant-Steps in 10 % Schritten dar. p_lc wird im Algorithmus nicht
     * wirklich benoetigt.
     */

    p_lc = 0;

    /*
     * Q = ls * P. ls ist die Laenge eines Giant-Steps. Der Punkt Q wird in jedem Giant-Step addiert.
     */

    Q = ecgf2mul(G, a1, a2, a3, a4, a6, ls, P);

    /*
     * H = ug_m * P. ug_m ist die modifizierte untere Schranke.
     */

    H = ecgf2mul(G, a1, a2, a3, a4, a6, ug_m, P);

    /*
     * Beginn der Giant-Steps.
     */

    if (pl) {
	printf("ecgf2msha(): begin of giant steps\n");
    }

    /*
     * Falls keine Fehler auftritt, wird j in der naechsten Schleife maxgs niemals erreichen.
     */

    for (j = 0; j <= maxgs; j++) {

	/*
	 * Ausgabe des aktellen Standes der Berechnungen.
	 */

	if (pl) {
	    if (mshom((maxgs / 10) + 1, j + 1) == 0) {
		p_lc++;
		printf("         %i0 %%\n", p_lc);
	    }
	}

	if (isppecgf2pai(G, H) == 1) {

	    /*
	     * Ist H der Fernpunkt auf E?
	     */

	    h = -1;
	}
	else {

	    /*
	     * H ist nicht der Fernpunkt auf E. x2 ist eine Element aus GF(2^n).
	     */

	    x2 = lfirst(H);
	    h = lfirst(llast(x2));
	}
	if (h != -1) {
	    ind = asbsrchs(h, T, 0, table);
	}
	else {
	    ind = 0;
	}

	if (ind != -1) {
	    single          ui;			  /* der obere Index */
	    single          li;			  /* der untere Index */
	    single          g;			  /* ein Zaehler */

	    /*
	     * Ein geeigneter Index trat in der Tabelle auf. res koennte ein Vielfaches der Ordnug des Punktes P
	     * sein. (Beachte, dass nur das letzte Wort der x-Koordinate in der Tabelle abgespeichert ist. Es muss
	     * ueberprueft werden, ob es noch andere Indizes gibt, so dass das letzte Wort von x2 mit dem letzten
	     * Wort des in der Tabelle gespeicherten Punktes uebereinstimmt.
	     */

	    ui = li = ind;

	    if (ind != 0) {
		g = 0;
		while (*(T + ind - g) == h) {
		    li = ind - g;
		    g = g + 2;
		}
	    }

	    if (ind != table) {
		g = 0;
		while (*(T + ind + g) == h) {
		    ui = ind + g;
		    g = g + 2;
		}
	    }

	    /*
	     * Die folgenden Berechnungen muessen fuer jeden Punkt wiederholt werden, dessen Ordnung korrekt sein
	     * koennte, d.h. fuer jeden Index zwischen li und ui.
	     */

	    for (ind = li; ind <= ui; ind = ind + 2) {
		res = iprod(j, ls);
		res = isum(res, isprod(m, *(T + ind + 1)));
		res = isum(ug_m, res);

		/*
		 * Da nur das letzte Wort der x-Koordinate in der Tabelle abgespeichert wird, muss ueberprueft
		 * werden, ob res * P = 0 ist. In diesem Falle koennte res die Gruppenordnung sein. Wenigstens ist
		 * dann res ein Vielfaches der Punktordnung von P und res liegt im Hasse-Intervall.
		 */

		TP = ecgf2mul(G, a1, a2, a3, a4, a6, res, P);
		if (isppecgf2pai(G, TP)) {

		    /*
		     * An diesem Punkt hat man nun einen Punkt P und eine ganze Zahl res gefunden, so dass res * P
		     * = 0 ist. Bestimme nun die genaue Ordnung von P, d.h. den kleinesten Teiler von res, so dass
		     * ord * P = 0 ist.
		     */

		    if (pl) {
			printf("ecgf2msha(): computing the order of the starting point...\n");
		    }

		    ord = ecgf2ord(G, a1, a2, a3, a4, a6, res, P);

		    free(T);

		    return (list3(1, ord, res));
		}

		res = iprod(j, ls);
		res = idif(res, isprod(m, *(T + ind + 1)));
		res = isum(ug_m, res);

		/*
		 * Da nur das letzte Wort der x-Koordinate in der Tabelle abgespeichert wird, muss ueberprueft
		 * werden, ob res * P = 0 ist. In diesem Falle koennte res die Gruppenordnung sein. Wenigstens ist
		 * dann res ein Vielfaches der Punktordnung von P und res liegt im Hasse-Intervall.
		 */

		TP = ecgf2mul(G, a1, a2, a3, a4, a6, res, P);
		if (isppecgf2pai(G, TP)) {

		    /*
		     * An diesem Punkt hat man nun einen Punkt P und eine ganze Zahl res gefunden, so dass res * P
		     * = 0 ist. Bestimme nun die genaue Ordnung von P, d.h. den kleinesten Teiler von res, so dass
		     * ord * P = 0 ist.
		     */

		    if (pl) {
			printf("ecgf2msha(): computing the order of the starting point...\n");
		    }

		    ord = ecgf2ord(G, a1, a2, a3, a4, a6, res, P);

		    free(T);

		    return (list3(1, ord, res));
		}

	    }
	}
	H = ecgf2sum(G, a1, a2, a3, a4, a6, H, Q);
    }

    free(T);

    /*
     * ERROR. Der erste Listeneintrag wird auf -3 gesetzt. ***
     */

    return (list3(-3, 0, 0));
}

 /*
  * Ende von ecgf2msha1.
  */





/*c
   			asqsorts(f, l, T);

  	"array of singles quick sort, special version"
  	void asqsorts(f, l, T)  single f, l, *T;
	asqsorts(f, l, T);
	T ist ein Zeiger auf die von ecgf2sha1 erzeugte Tabelle T
	(array vom Typ single) der Form
		[ x_f, f, x_(f+1), f+1, ... x_l, l ].
	asqsorts liefert eine nach der Groesse der x-Werte sortierte
	Tabelle der Form
		[ x_g, g, x_(g+1), g+1, ... x_k, k ].
   	Dabei gilt x_g <= x_g+1 <= ... <= x_k und die Indizes g, g+1,
	... , k sind eine Permutation der Indizes f, f+1, ... , l.
	asqsorts ist ein static-Modul zu ecgf2msha1. Die Tabelle T wird
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

    while (i < k) {
	do {
	    i++;
	}
	while ((*(T + 2 * i) < S) && (i < k));

	do {
	    k--;
	}
	while ((*(T + 2 * k) > S) && (k > 0));

	if (k > i) {
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

    if (l < k - 1) {
	asqsorts(l, k - 1, T);
    }
    if (k + 1 < r) {
	asqsorts(k + 1, r, T);
    }

    return;
}

 /*
  * Ende von asqsorts.
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
        enthaltenen x_j. asbsrchs ist ein static-Modul zu ecgf2snfmsha1.
c*/
/*H
        Version 1       14.10.1991      Michael Pfeifer
H*/

static single   asbsrchs(x, T, ug, og)
    single          x, *T, ug, og;

{
    single          i = 2 * ((og + 1 + ug) / 2);

    /*
     * i ist die Mitte der Tabelle.
     */

    if (og - ug < 0) {

	/*
	 * Die Tabelle ist leer.
	 */

	return (-1);
    }

    if (x == *(T + i)) {

	/*
	 * x mit Index i in der Tabelle gefunden.
	 */

	return (i);
    }

    if (og == ug) {

	/*
	 * x nicht in der Tabelle gefunden.
	 */

	return (-1);
    }

    if (x < *(T + i)) {

	/*
	 * x nicht in der oberen Haelfte der Tabelle gefunden.
	 */

	return (asbsrchs(x, T, ug, i / 2 - 1));
    }
    else {

	/*
	 * x nicht in der unteren Haelfte der Tabelle gefunden.
	 */

	return (asbsrchs(x, T, i / 2 + 1, og));
    }
}

 /*
  * End of asbsrchs.
  */

/*c
                        ecgf2ord(G, a1, a2, a3, a4, a6, res, P)

        "elliptic curve over Galois-field witch characteristic 2 order of
	 point"
        int ecgf2ord(G, a1, a2, a3, a4, a6, res, P)
	        obj G; gf2el a1, a2, a3, a4, a6; int res; list P;
	ord = ecgf2ord(G, a4, a6, res, P); P ist ein Punkt auf der
	durch a1, a2, a3, a4 und a6 in Weierstrass-Normalform gegebenen
	elliptischen Kurve. ord ist ein Vielfaches der Punktordnung von
	P, d.h. ord*P = 0. ecgf2ord berechnet die genaue Ordnung von P.
	ecgf2ord ist ein static-Modul zu ecgf2msha1.
c*/
/*H
        Version 1       15.10.1992      Michael Pfeifer
H*/

static int      ecgf2ord(G, a1, a2, a3, a4, a6, res, P)
    obj             G;
    gf2el           a1, a2, a3, a4, a6;
    int             res;
    list            P;
{
    single          exp;
    int             hi, ho, ord, pme;
    list            HP, L;

    bind(G, a1, a2, a3, a4, a6, res, P);

    init(hi, ho, pme, ord);
    init(HP, L);

    ord = 1;

    L = ifact(res);
    L = ifel(L);


    while (L != _0) {
	pme = lfirst(L);
	exp = lsecond(L);
	L = lred2(L);

	hi = 1;
	ho = iquot(res, iexp(pme, exp));
	HP = ecgf2mul(G, a1, a2, a3, a4, a6, ho, P);

	while (isppecgf2pai(G, HP) == 0) {
	    hi = iprod(hi, pme);
	    HP = ecgf2mul(G, a1, a2, a3, a4, a6, pme, HP);
	}
	ord = iprod(ord, hi);
    }
    return (ord);
}

 /*
  * Ende von ecgf2ord.
  */
