/*C
  			ecgf2npcasv(G, a1, a2, a3, a4, a6)

	"elliptic curve over Galois field with characteristic 2,
	 counting algorithm"
	Quellbibliothek: srclib.ec3
	Include-Datei:   _ec3.h
	int ecgf2npcasv(G, a1, a2, a3, a4, a6)
		obj G; gf2el a1, a2, a3, a4, a6;
	N = ecgf2npcasv(G, a1, a2, a3, a4, a6);
	    G ist ein irreduzibles normiertes Polynom in einer
	Veraenderlichen ueber Z/2Z vom Grad n, in der speziellen
	Bit-Darstellung (vgl. udpm2tosb) als definierendes Polynom fuer
	den endlichen Koerper GF(2^n) der Charakteristik 2. n muss
	kleiner oder gleich 29 sein. (Fuer groessere Erweiterungsgrade
	kann man ecgf2msha1 benutzten.)
	    a1, a2, a3, a4, a6 sind Elemente dieses endlichen Koerpers
	GF(2^n), die als Polynome in einer Veraenderlichen vom Grad < n
	ueber Z/2Z dargestellt werden. a1, a2, a3, a4, a6 definieren
	eine elliptische Kurve in allgemeiner Weierstrass-Normalform
	ueber dem durch G definierten endlichen Koerper GF(2^n).
	    ecgf2csca berechnet die Ordnung n der rationalen
	Punktgruppe von E ueber GF(2^n), d.h. N = #E(GF(2^n)), mit Hilfe
	eines einfachen Abzaehlverfahrens.
C*/
/*H
	Version 1	08.12.1993	Michael Pfeifer
H*/
/*cS
	ecgf2npcasv ruft auf: ecgf2fp, ecgf2mul, ecgf2npcsv_loop; ecgf2sum,
		gf2elrand gf2squ, gf2sum, idif, iexp, iprod, isppecgf2pai,
		isqrt, isum, lcomp, llength, sexp
	Macros: lfirst, list2, lred, printf, puto
Sc*/

#include <assert.h>

#include <_ec3.h>


/*c
			ecgf2npcasv_loop(G, a1, a2, a3, a4, a6)
	static in egf2npcanp.
c*/

static list     ecgf2npcasv_loop(G, a1, a2, a3, a4, a6)
    obj             G;
    gf2el           a1;
    gf2el           a2;
    gf2el           a3;
    gf2el           a4;
    gf2el           a6;
{
    single          deg;
    single          i;
    single          lh_int;
    single          nelts;
    single          og;
    single          ug;

    list            LC;
    list            PS;
    list            P;

    bind(G);
    bind(a1);
    bind(a2);
    bind(a3);
    bind(a4);
    bind(a6);

    init(LC);
    init(PS);
    init(P);

    /*
     * deg ist der Grad der Erweiterung, ug und og sind die Schranken des
     * Hasse-Intervalles.
     */

    deg = lfirst(G);

    nelts = iexp(2, deg);
    lh_int = isqrt(iprod(4, nelts));
    ug = idif(nelts, lh_int);
    og = isum(nelts, lh_int);
    og = isum(og, 2);

    /*
     * Man sucht sich zunaechst zufaellig  einen Punkt P auf der elliptischen
     * Kurve y^2 + x*y = x^3 + a6 und multipliziert diesen mit der unteren
     * Schranke des Hasse-Intervalles, man erhaelt PS.
     */

    P = ecgf2fp(G, a1, a2, a3, a4, a6);
    PS = ecgf2mul(G, a1, a2, a3, a4, a6, ug, P);

    /*
     * LC ist die Liste der moeglichen Punktordnungen.
     */

    LC = _0;

    for (i = ug; i <= og; i++)
    {

	/*
	 * Indem man P immer wieder zu PS addiert findet man eine alle ganzen
	 * Zahlen i im Hasse-Intervall, so dass i * P = 0 ist. Jedes solche i
	 * fuegt man der Liste der moeglichen Punktordnungen hinzu. Das macht
	 * die for-Schleife.
	 */

	if (isppecgf2pai(G, PS) == 1)
	{
	    LC = lcomp(i, LC);

#ifdef DEBUG
	    {
		list            HP;

		init(HP);

		printf("\n i = %i", i);

		HP = ecgf2mul(G, a1, a2, a3, a4, a6, i, P);

		/* DEBUG */
		assert(isppecgf2pai(G, HP));
	    }
#endif

	}
	PS = ecgf2sum(G, a1, a2, a3, a4, a6, P, PS);
    }

    return (LC);
}

list            ecgf2npcasv(G, a1, a2, a3, a4, a6)
    obj             G;
    gf2el           a1;
    gf2el           a2;
    gf2el           a3;
    gf2el           a4;
    gf2el           a6;
{
    list            L;

    bind(G);
    bind(a1);
    bind(a2);
    bind(a3);
    bind(a4);
    bind(a6);

    init(L);

    L = ecgf2npcasv_loop(G, a1, a2, a3, a4, a6);
    if (llength(L) == 1)
	return (lfirst(L));
    else
	L = usinter(L, ecgf2npcasv_loop(G, a1, a2, a3, a4, a6));
    if (llength(L) == 1)
	return (lfirst(L));
    else
	L = usinter(L, ecgf2npcasv_loop(G, a1, a2, a3, a4, a6));
    if (llength(L) == 1)
	return (lfirst(L));
    else
	return (0);
}
