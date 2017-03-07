/*M
.SH NAME
irand - integer randomise
.SH SYNOPSIS
.nf
#include <_arith1.h>

int irand (G)
int G;

.SH DESCRIPTION
irand() returns a random integer taken from the
range 0...G-1. The output of irand()  depends
on the value of the global variable SEMIRAND.
.TP 4
.B SEMIRAND = 1
irand() depends on the current system time.
.TP 4
.B SEMIRAND = 0
The values of irand() are deterministic,
i.e. irand() always returns the same sequence of values.
.PP
The default value of SEMIRAND is 1. If the C-function
random() respectively rand() is uniformly distributed, then so 
is irand().

M*/

/*H
        Version 1       03.04.1991      Michael Pfeifer
        Version 2       16.08.1991      fuer Apollo10000 Header
                                        /bsd4.3/usr/include/sys/time.h  PS
        Version 3       29.10.1991      random() bzw. rand() ersetzt durch
                                        random() + 1 bzw. rand() + 1.
                                        Kommentar geaendert             MP
        Version 4       30.11.1991      Im Ergebnis von rand die drei
                                        fuehrenden Bits auf 0 gesetzt.
                                        srand haengt nun nicht mehr allein
                                        von der Prozesszeit ab.         MP
        Version 5       17.01.1994      Neuer Algorithmus zur Berechnung
                                        der Zufallszahl. (Ist im Programm
                                        kommentiert.) Die Version fuer
                                        MX-Rechner existiert nicht mehr.GR
	Version 6	17.01.1996	Auf manchen Rechnern liefert
					random() nur 15 bit breite Ergeb-
					nisse -> angepasst.
					malloc() entfernt.
					irand() ist gleichverteilt (falls
					random() gleichverteilt ist).
					Neue Doku			GL
   DATE irand         : 910715.910915.911215.941201.960501
H*/

#include <_arith1.h>

#ifdef TIME_WITH_SYS_TIME
#include <sys/time.h>
#include <time.h>
#else
#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#else
#include <time.h>
#endif
#endif

int irand(G)
int G;
 {
 struct timeval  tp;
 struct timezone tzp;
 single i,stellen,bits;
 list  L;
 init (L);

/*
	macht irand() zeitabh"angig
*/

 if (SEMIRAND == 1) {
    gettimeofday(&tp, &tzp);
    srandom(tp.tv_usec ^ tp.tv_sec); 
    }

/*
	erzeugt eine Zufallszahl mit gleicher
	Anzahl von Bin"arziffern wie G.
	Weil random() auf manchen Maschinen durch rand()
	realisiert ist (rand() liefert nur 15 bits),
	werden die einzelnen Ziffern zusammengesetzt
	durch 'random() ^ random() << 15'.
*/

 iqrem (ilog2 (G),BLOG2,&stellen,&bits);

 do {
/*
	Liste L zusammenbauen. Die L"ange von L ist 1+stellen.
*/
    L = _0;
    for (i = 0; i < stellen; i++) 
	L = lcomp ( (~(3<<BLOG2)) & (random() ^ (random() << 15)), L); 
    L = lcomp (((1<<bits) - 1) & (random() ^ (random() << 15)), L);
/*
	f"uhrende Nullen beseitigen
*/
    while (llength (L) > 1) {
	if (lfirst (L) == 0)	L = lred (L);
	else			break;
	}
/*
	L nach integer-Format
*/
    if (llength (L) > 1)	L = linv (L);
    else			L = lfirst (L);
    }
 while (icomp (L,G) >= 0);
/*
	durch die Abbruchbedingung 'icomp (L,G) >= 0'
	wird eine Gleichverteilung der Zufallswerte
	erreicht (falls random() gleichverteilt ist).
	Die Anzahl der zu erwartenden Schleifendurch-
	l"aufe ist kleiner als 2.
*/

 return (L);
 }
