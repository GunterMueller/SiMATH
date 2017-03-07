/*C
			ecrtoic_o(a1, a2, a3, a4, a6)

	"elliptic curve over rational numbers to integer coefficients"
	Quellbibliothek: srclib.ec1
	Include-Datei:   _ec1.h
	list erctoic_o( a1, a2, a3, a4, a6 )  rat a1, a2, a3, a4, a6;
	L = erctoic_o( a1, a2, a3, a4, a6);
	Sei E die durch a1, ... , a6 in Weierstrass-Normalform gegebene
	elliptische Kurve ueber Q. ecrtoic_o liefert eine Liste
	L = ( a1'  a2'  a3'  a4'  a6'  u) mit den Koeffizienten einer zu E
	birational isomorphen Kurve E', die ganze Koeffizienten hat, und
	dem die Transformation beschreibenden Parameter u, so dass
		ai' = u^i * ai (i = 1, ... , 6).
	a1', ... , a6' sind vom Typ int, u ist vom Typy rat.
C*/
/*H
	Version 1       15.06.1991      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3 	18.09.1991	Kommentar und zurueckgegebene
					Liste geaendert.  MP
   DATE ecrtoic_o       : 910715.910915.911215
H*/
/*cS
	erctoic_o ruft auf: ecrbtco_old, rprod
	Macros: lfifth, lfirst, lfourth, list2, list6, lsecond, lthird
Sc*/

#include <_ec1.h>

list            ecrtoic_o(a1, a2, a3, a4, a6)
    rat             a1, a2, a3, a4, a6;
{
    int             a1i, a2i, a3i, a4i, a6i, h;
    rat             a1r, a2r, a3r, a4r, a6r, u;
    list            L;

    bind(a1, a2, a3, a4, a6);

    init(a1i, a2i, a3i, a4i, a6i, h);
    init(a1r, a2r, a3r, a4r, a6r, u);
    init(L);

    h = 1;

    if (a1 != 0)
	h = ilcm(h, lsecond(a1));
    if (a2 != 0)
	h = ilcm(h, lsecond(a2));
    if (a3 != 0)
	h = ilcm(h, lsecond(a3));
    if (a4 != 0)
	h = ilcm(h, lsecond(a4));
    if (a6 != 0)
	h = ilcm(h, lsecond(a6));

    u = list2(1, h);

    L = ecrbtco_old(a1, a2, a3, a4, a6, 0, 0, 0, u);

    a1r = lfirst(L);
    a2r = lsecond(L);
    a3r = lthird(L);
    a4r = lfourth(L);
    a6r = lfifth(L);

    if (a1r != 0)
	a1i = lfirst(a1r);
    else
	a1i = 0;
    if (a2r != 0)
	a2i = lfirst(a2r);
    else
	a2i = 0;
    if (a3r != 0)
	a3i = lfirst(a3r);
    else
	a3i = 0;
    if (a4r != 0)
	a4i = lfirst(a4r);
    else
	a4i = 0;
    if (a6r != 0)
	a6i = lfirst(a6r);
    else
	a6i = 0;

    return (list6(a1i, a2i, a3i, a4i, a6i, u));
}
