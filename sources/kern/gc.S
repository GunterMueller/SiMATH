/*C
			gc( )
  
	"garbage collector"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	!!! wird vom System automatisch benutzt !!!
	Alle Zellen im SPACE, die vom STACK erreichbar sind,
	werden markiert. Danach wird eine Liste aller freien Zellen
	angelegt (AVAIL), und die Markierungen werden entfernt.
	Die globalen Variablen GC_COUNT und GC_CC werden aktualisiert.
	Falls noetig wird der SPACE vergroessert.  Wird dabei SP_MAX
	erreicht, wird das Programm mit einer entsprechenden Meldung
	auf stdout abgebrochen.
	Ist GC_TEST = 1, so werden alle Listen im SPACE auf Korrektheit
	ueberprueft. Wird dabei eine nicht korrekte Liste gefunden, so
	wird eine entsprechende Meldung auf stdout ausgegeben.
C*/
/*H
	Version  1      07.08.1986      R.Boeffgen
	Version  2      06.02.1987      gc wurde dynamisiert durch setspace. RB
	Version  3      13.03.1987      SP_MAX eingefuehrt.  RB
	Version  4      24.03.1987      islist zu !isatom. MAR.
	Version  5      24.03.1987      GC_TEST eingebaut. MAR.
	Version  6      26.06.1987      stdout mit stderr bei kontrol-
					lierter Ausgabe koordiniert. RB
	Version  7      17.08.1987      gehoert ab jetzt zur srclib.kern. MAR.
	Version  8      17.12.1987      SPACE durch Bloecke realisiert. PS
	Version  9      05.02.1988      SP_MAX wird ueberprueft und ggf.
					korrigiert. PS
	Version 10      07.12.1989      einheitl. Version fuer MX2(+), SUN und
					Apollo. PS
	Version 11      27.08.1991      "# undef fprintf" ergaenzt. PS
	Version 12	17.12.1992	englische Meldungen. PS
	Version 13 	19.04.1993	cc >= ... ersetzt durch cc > ..., da 
					sonst implizit BL_SIZE > GC_QUOTE 
					vorausgesetzt wird.  MC
	Version 14 	01.12.1993	einiges geaendert, damit es auch auf HP
					funktioniert.  MC
	Version 15 	10.01.1993	!isatom durch isl ersetzt.  MC
	Version 16	23.11.1994	Dokumentation korrigiert, GC_MESS 
					korrekt abgefragt. MP
	Version 17	27.04.1996	HZ is defined in the SIMATH header
					_list.h. MP
   DATE gc            : 890501.900101.9003__.910915.930115.930531.940315.941201.960601
H*/


# include <_list.h>


# define      mark(p) ( (p)->adr |=  MARK )
# define    unmark(p) ( (p)->adr &= ~MARK )
# define    ismark(p) ( (p)->adr &   MARK )
# define         MARK (1U<<31)

# undef printf
# undef fprintf

/* genau dann 1 falls a mit 01..... (als Bitstruktur) anfaengt: */

#define isl( a ) ( (a >> 30) == 1 )

static void marklist(list L) {
	obj a;
	PCELL p, q;

	p = ltop(L);

	while (p != ltop(_0)) {
		if (ismark(p))
			return;
		q = ltop(p->adr);
		a = p->inh;
		mark(p);
		if (isl(a))
			marklist(a);
		p = q;
	}
	return;
}


single gc() {
	obj a;
	single t0, t1, cc = 0, j;
	register unsigned n;
	register i = ST_INDEX;
	PCELL p;
	static struct tms buffer;
	FILE *pf;

	/***    Koordination von stdout und stderr    ***/
	if (inocmp(fileno(stdout), fileno(stderr)))
		pf = stderr;
	else
		pf = stdout;

	/***    Anfangs-Rechenzeit    ***/
	times(&buffer);
	t0 = buffer.tms_utime;

	/***   falls GC_TEST = 1, ueberpruefen, ob alle   ***/
	/***   gesicherten Listen korrekt sind            ***/
	/*if (GC_TEST) {
		while (i--) {
			a = **(STACK + i);
			if (!islist(a) && !isatom(a)) {
				printf("\n***  Warning in gc: islist(a)=0; a=");
				putbits(a);
				printf(" ***\n");
			}
		}
		i = ST_INDEX;
	}*/

	/***    aktuelle Listen markieren    ***/
	while (i--) {
		a = **(STACK + i);
		if (GC_TEST && !isatom(a) && !islist(a)) {
			fputs("\n***  Warning in gc: islist(a)=0; a=", stderr);
			fputbits(a, stderr);
			fputs(" ***\n", stderr);
		}
		else if (isl(a))
			marklist(a);
	}

	/***    unmarkierte Zellen sammeln    ***/
	AVAIL = _0;
	for (j = BL_NR - 1; j >= 0; j--) {
		p = BL_START[j] + BL_SIZE;
		do {
		    p--;
		    if (ismark(p))
			unmark(p);
		    else {
			p->adr = AVAIL;
			AVAIL = ptol(p,j);
			cc++;
		    }
		} while (p != BL_START[j]);
	}


	/***    globale Zaehler setzen    ***/
	GC_COUNT++, GC_CC = isum(GC_CC, cc);
	times(&buffer);
	t1 = buffer.tms_utime - t0;
	GC_TIME += t1;
	if (!GC_MESS && cc > (BL_NR * BL_SIZE) / GC_QUOTE)
		return;

	/***    Meldung absetzen, falls GC_MESS gesetzt    ***/
	if (GC_MESS)
		fprintf(pf, "\n***   gc: %d cells in %.2f sec.   ***\n", cc, 1.* t1 / HZ);

	/***    SPACE vergroessern, falls notwendig    ***/
	if (cc <= (BL_NR * BL_SIZE) / GC_QUOTE) {
		/* SP_MAX ueberpruefen und ggf. korrigieren    */
		if (SP_MAX > BL_NR_MAX * BL_SIZE) {
			SP_MAX = BL_NR_MAX * BL_SIZE;
			fprintf(pf, "\n***   SP_MAX too large!                    ***");
			fprintf(pf, "\n***   Reduced to maximum %d (%d blocks).   ***\n", SP_MAX, SP_MAX / BL_SIZE);
		} else if (SP_MAX % BL_SIZE)
			SP_MAX = (SP_MAX / BL_SIZE + 1) * BL_SIZE;
		if (SP_MAX >= (BL_NR + 1) * BL_SIZE)
			setspace((BL_NR + 1) * BL_SIZE);
		else {

			/***    Abbruch, wenn SP_MAX erreicht    ***/
			if (SP_MAX / BL_SIZE == 1)
				fprintf(pf, "\n***   SP_MAX = %d      (1 block)   ***\n", BL_SIZE);
			else
				fprintf(pf, "\n***   SP_MAX = %d      (%d blocks)   ***\n", SP_MAX, SP_MAX / BL_SIZE);
			printf("\n***   SPACE overflow   ***\n");
			lend();
			exit(2);
		}
	}
}
