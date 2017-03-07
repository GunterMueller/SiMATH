/*C
			islist(L)
	"is list ?" (rekursiv)
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	single islist(L)  obj L;
	n = islist(L);
	n = 1, falls L eine korrekte Listenstruktur besitzt und zusaetzlich
	       AVAIL korrekt ist,
	und 0, sonst.
	AVAIL, der Bereich der freien Zellen, zaehlt hierbei nicht als
	Liste.
	Falls AVAIL fehlerhaft ist, bricht das Programm mit einer Meldung
	auf stdout ab.
C*/
/*H
	Version 1       14.10.1986      R.Boeffgen
	Version 2       24.03.1987      Neu !   M.A.R.
	Version 3       17.08.1987      gehoert ab jetzt zur srclib.kern. MAR.
	Version 4       23.12.1987      an Blockstruktur des SPACE angepasst. PS
	Version 5       22.06.1988      Fehler korrigiert. PS
	Version 6       09.09.1988      " p && " eingefuegt. PS
	Version 7       09.03.1990      Fehler in der Berechnung von OG[i]
					korrigiert. PS       
	Version 8 	01.12.1993	Details geaendert wegen HP-Anpassung. MC
   DATE islist        : 890501.8909__.900315.940315
H*/


# include <_list.h>                                 


# define      mark(p) ( (p)->adr |=  MARK )
# define    unmark(p) ( (p)->adr &= ~MARK )
# define    ismark(p) ( (p)->adr &   MARK )
# define         MARK (1<<31)     

static single isInBlock(unsigned long p, unsigned long *u, unsigned long *o) {
    single i;
    for ( i=0 ; i<BL_NR ; i++ )
	if ( u[i]<=p && p<=o[i] )
	    return(!((p-u[i])%8));
    return(0);
}

/*         ltop, spezielle Version                */
/* setzt im Gegensatz zu ltop nur das 2.Bit auf 0 */
/* ltop setzt nur noch 2. Bit auf 0  (Dez' 93)    */


single islist( obj L )
{
	static single anf = 0;

	obj a;
	unsigned long *UG, *OG, p1;
	single s=1,i;
	PCELL q,p,philf = NULL;

/* 1.Spezialfall : L Atom */
	if ( isatom(L)) return(0);

/* 2.Spezialfall : L = _0 */
	if ( L == _0 ) return(1);

/* 3. special case : list system is not started */
	if ( BL_NR == 0 ) return(0);

/* Initialisierung */
	anf++;
	if ( (UG = (unsigned long*)malloc( BL_NR * sizeof(unsigned long) )) == NULL ) {
		printf("\n*** nicht genuegend Speicherplatz vorhanden ***\n");
		exit(1);
	}
	if ( (OG = (unsigned long*)malloc( BL_NR * sizeof(unsigned long) )) == NULL ) {
		printf("\n*** nicht genuegend Speicherplatz vorhanden ***\n");
		exit(1);
	}
	for ( i=0 ; i<BL_NR ; i++ ) {
		UG[i] = (unsigned long)BL_START[i];
		OG[i] = (unsigned long)(BL_START[i] + (BL_SIZE-1));
	}

/* AVAIL markieren beim ersten Aufruf von islist */
	if ( anf == 1 )
	    for ( p=ltop(AVAIL) ; p != ltop( _0 ) ; p = q  ) {
		    if ( ismark(p) ) {
			    printf("\n*** Fehler im Listenspeicher !!! ***\n");
			    exit(1);
		    }
		    q = ltop(p->adr);
		    mark(p);
	    }

/* Listenstruktur ueberpruefen und Liste markieren */
	a = L;
	while ( a != _0 ) {
		p = ltop( a );
		if ( !isInBlock((unsigned long)p, UG, OG) ) { s = 0; break; }
		a = p->inh;
		if ( !isatom(a) ) { s = islist( a ); if ( !s ) break; }
		if ( ismark(p) ) { philf = p; s = 0; break; }
		a = p->adr;
		mark(p);
	}

/* Markierungen in L entfernen */
	p = ltop( L );
	if (isInBlock((unsigned long) p, UG, OG)) {
	    while ( p && ismark(p) && p!=philf ) {
		unmark(p);
		p = ltop( p->adr );
		p1 = (unsigned long)p;
		if ( p1 && !isInBlock(p1, UG, OG)) break;
	    }
	}

/* Markierungen in AVAIL entfernen beim letzten Aufruf von islist */
	if ( anf == 1 )
	    for ( p=ltop(AVAIL) ; p != ltop(_0);  p=ltop(p->adr) ) unmark(p);
	anf--;

/* Platz fuer UG und OG wieder freigeben */
	free(UG);
	free(OG);

/* Funktionswert liefern */
	return( s );

}
