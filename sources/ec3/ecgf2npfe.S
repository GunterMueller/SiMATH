/*C
 		ecgf2npfe(Gm, a1, a2, a3, a4, a6, Nm, GmtoGn)

	"elliptic curve over Galois field with characteristic 2, number
	 of points after field extension"
	Quellbibliothek: srclib.ec3
	Include-Datei:   _ec3.h
	list ecgf2npfe(Gm, a1, a2, a3, a4, a6, Nm, GmtoGn)
		obj Gm; gf2el a1, a2, a3, a4, a6; int Nm; list GmtoGn;
	L = ecgf2npfe(Gm, a1, a2, a3, a4, a6, Nm, GmtoGn, n);
	    Gm ist ein irreduzibles, normiertes Polynom in einer
	Veraenderlichen ueber Z/2Z vom Grad m in der speziellen
	Bit-Darstellung (vgl. udpm2tosb) als erzeugendes Polynom fuer
	den Grundkoerper GF(2^m).
	    a1, a2, a3, a4, a6 sind Elemente aus (dem durch Gm
	definierten Koerpers) GF(2^m), die als Polynome in einer
	Variablen ueber Z/2Z vom Grad < m in spezieller Bit-Notation
	dargestellt werden. a1, a2, a3, a4, a6 sind Koeffizienten einer
	elliptischen Kurve ueber GF(2^m).
	    Nm ist eine natuerliche Zahl, Nm ist die Anzahl der
	rationalen Punkte der durch a1, a2, a3, a4, a6 ueber GF(2^m) in
	Weierstrass-Normalform gegebenen elliptischen Kurve.
	    GmtoGn ist eine zweielementige Liste, die die Einbettung
	eines endlichen Koerpers der Charakteristik 2 mit 2^m Elementen
	(gegeben durch Gm) in einen Erweiterungskoerper mit 2^n (m|n)
	Elementen (gegeben durch Gn) beschreibt. GmtoGn wird mit Hilfe
	des Programmes gf2ies erzeugt. (GmtoGn = ( Gn, re ) ist eine
	zweielementige Liste, deren erster Eintrag Gn ein irreduzibles
	Polynom in einer Veraenderlichen in spezieller Bit-Darstellung
	ist, das den Erweiterungskoerper erzeugt, und deren zweiter
	Eintrag die Einbettung einer Nullstelle des den Grundkoerper
	definierenden irreduziblen Polynoms in den Erweiterungskoerper
	ist.)
	    ecgf2npfe liefert eine Liste L der Form
		L = (Gn, a1s, a2s, a3s, a4s, a6s, Nn)
	mit
		obj Gn; gf2el a1s, a2s, a3s, a4s, a6s; int Nn
	    ecgf2fpe berechnet die Anzahl Nn der rationalen Punkte der
	gleichen elliptischen Kurve ueber dem durch Gn gegebenen
	Erweiterungskoerper. a1s, a2s, a3s, a4s und a6s sind
	Einbettungen von a1, a2, a3, a4 und a6 in diesen
	Erweiterungskoerper, der dann durch Gn definiert ist.
C*/
/*H
	Version 1	14.09.1993	Michael Pfeifer
   DATE ecgf2npfe     : 931130
H*/

#include <_ec3.h>

list            ecgf2npfe(Gm, a1, a2, a3, a4, a6, Nm, GmtoGn)
    obj             Gm;
    gf2el           a1, a2, a3, a4, a6;
    int             Nm;
    list            GmtoGn;
{
    complex         alpha, beta;
    complex         c1, c2;
    complex         ch1, ch2;
    floating        disc;
    gf2el           a1s, a2s, a3s, a4s, a6s;
    int             Nn;
    int             Tr;
    int             qm, qn;
    list            L;
    obj             Gn;
    single          deg;
    single          dm, dn;

    bind(Gm);
    bind(a1, a2, a3, a4, a6);
    bind(Nm);
    bind(GmtoGn);

    init(alpha, beta);
    init(c1, c2);
    init(ch1, ch2);
    init(disc);
    init(a1s, a2s, a3s, a4s, a6s);
    init(Nn);
    init(Tr);
    init(qm, qn);
    init(L);
    init(Gn);

    Gn = lfirst(GmtoGn);

    /*
     * Transformation der Koeffizienten.
     */

    a1s = gf2efe(GmtoGn, a1);
    a2s = gf2efe(GmtoGn, a2);
    a3s = gf2efe(GmtoGn, a3);
    a4s = gf2efe(GmtoGn, a4);
    a6s = gf2efe(GmtoGn, a6);

    /*
     * Berechnung der komplexen Zahlen alpha und beta, so dass alpha + beta =
     * Tr(E) und alpha * beta = 2^m.
     */

    dm = lfirst(Gm);
    dn = lfirst(Gn);
    qm = iexp(2, dm);
    qn = iexp(2, dn);
    deg = dn / dm;
    Tr = idif(isum(1, qm), Nm);
    disc = flquot(itofl(Tr), itofl(2));
    disc = flprod(disc, disc);
    disc = fldif(disc, itofl(qm));
    beta = list2(disc, 0);
    beta = csqrt(beta);
    ch1 = itofl(Tr);
    ch2 = itofl(2);
    ch1 = ccri(ch1, 0);
    ch2 = ccri(ch2, 0);
    ch1 = cquot(ch1, ch2);
    beta = csum(beta, ch1);
    alpha = cquot(ccri(itofl(qm), 0), beta);

#ifdef DEBUG
    printf("\n(*** DEBUG ***) ecgf2npfe(): Grad des Grundkoerpers: %i", dm);
    printf("\n(*** DEBUG ***) ecgf2npfe(): Grad der Erweiterung: %i", dn);
    printf("\n(*** DEBUG ***) ecgf2npfe(): ");
    printf("Elemente im Grundkoerper: %i", qm);
    printf("\n(*** DEBUG ***) ecgf2npfe(): ");
    printf("Elemente in der Erweiterung: %i", qn);
    printf("\n(*** DEBUG ***) ecgf2npfe(): Relativgrad: %i", deg);
    printf("\n(*** DEBUG ***) ecgf2npfe(): Spur der Kurve: %i", Tr);
    printf("\n(*** DEBUG ***) ecgf2npfe(): alpha: ");
    putfl(lfirst(alpha), 8);
    printf(" + I * ");
    putfl(lsecond(alpha), 8);
    printf("\n(*** DEBUG ***) ecgf2npfe(): beta: ");
    putfl(lfirst(beta), 8);
    printf(" + I * ");
    putfl(lsecond(beta), 8);
    {
	complex         H;

	init(H);

	H = csum(csexp(alpha, deg), csexp(beta, deg));
	printf("\n(*** DEBUG ***) ecgf2npfe(): Tr: ");
	putfl(lfirst(H), 8);
	printf(" + I * ");
	putfl(lsecond(H), 8);
    }
    fflush(stdout);
#endif

    c1 = csexp(alpha, deg);
    c2 = csexp(beta, deg);
    Nn = csum(c1, c2);
    Nn = lfirst(Nn);
    Nn = flround(Nn);

    /*
     * Nn ist an dieser Stelle die Spur der Kurve ueber dem
     * Erweiterungskoerper.
     */

    Nn = idif(qn, Nn);
    Nn = isum(Nn, 1);

    L = list6(a1s, a2s, a3s, a4s, a6s, Nn);
    L = lcomp(Gn, L);

    return (L);
}
