/*C
			ecrsnftoic_o(a4, a6)

	"elliptic curve over rational numbers, short normal form,
	 to integer coefficients"
	Quellbibliothek: srclib.ec1
	Include-Datei:   _ec1.h
	list erctoic_o(a4, a6)  rat a4, a6;
	L = erctoic_o(a4, a6);
	Sei E die durch a4 und a6 in kurzer Weierstrass-Normalform
	gegebene elliptische Kurve ueber Q. ecrsnftoic_o liefert eine
	Liste L = ( a4'  a6'  u ) mit den Koeffizienten einer zu E
	birational isomorphen Kurve E', die ganze Koeffizienten hat,
	und dem die Transformation beschreibenden Parameter u, so dass
		a4 = u^4 * a4',
		a6 = u^6 * a6'.
	a4' und a6' sind vom Type int, u ist vom Type rat.
C*/
/*H
	Version 1       15.06.1991      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3 	18.09.1991 	Kommentar und zurueckgegebene
					Liste geaendert.  MP
   DATE ecrsnftoic_o    : 910715.910915.911215
H*/
/*cS
	ecrsnftoic_o ruft auf: ecrbtco_old, rprod
	Macros: lfifth, lfirst, lfourth, list2, list3, lsecond
Sc*/

#include <_ec1.h>

list            ecrsnftoic_o(a4, a6)
    rat             a4, a6;
{
    int             a4i, a6i, h;
    rat             a4r, a6r, u;
    list            L;

    bind(a4, a6);

    init(a4i, a6i, h);
    init(a4r, a6r, u);
    init(L);

    h = 1;

    if (a4 != 0)
	h = ilcm(h, lsecond(a4));
    if (a6 != 0)
	h = ilcm(h, lsecond(a6));

    u = list2(1, h);

    L = ecrbtco_old(0, 0, 0, a4, a6, 0, 0, 0, u);

    a4r = lfourth(L);
    a6r = lfifth(L);

    if (a4r != 0)
	a4i = lfirst(a4r);
    else
	a4i = 0;
    if (a6r != 0)
	a6i = lfirst(a6r);
    else
	a6i = 0;

    return (list3(a4i, a6i, u));
}
