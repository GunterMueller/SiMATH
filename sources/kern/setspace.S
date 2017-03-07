/*C
			setspace( anz )

	"set SPACE"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h
	setspace( anz )  single anz;
	im Groben :
	   Der SPACE wird auf anz Zellen vergroessert, falls dies moeglich
	   ist.
	im Detail :
	   Sei n die kleinste natuerliche Zahl mit n * BL_SIZE >= anz ,
	   und sei anz1 = n * BL_SIZE.
	   Falls anz <= SPACE-Groesse, wird setspace ignoriert.
	   Ansonsten wird zunaechst SP_MAX auf das naechstgroessere Viel-
	   fache von BL_SIZE gesetzt bzw. auf den maschinenbedingten
	   Hoechstwert, falls es diesen uebersteigt.
	   Dann wird der SPACE auf anz1 Zellen vergroessert, falls anz
	   <= SP_MAX, bzw. auf SP_MAX Zellen, falls anz > SP_MAX und
	   SP_MAX > SPACE-Groesse.
	   Entsprechende Meldungen werden auf stderr abgesetzt.
	   SPACE-Ueberlauf wird auf stdout gemeldet.
C*/
/*H
	Version  1      09.02.1987      R. Boeffgen
	Version  2      23.03.1987      AVAIL nachkorrigiert. RB
	Version  3      24.03.1987      islist zu !isatom. MAR
	Version  4      25.06.1987      stdout mit stderr bei kontrol-
					lierter Ausgabe koordiniert. RB
	Version  5      17.08.1987      gehoert ab jetzt zur srclib.kern. MAR
	Version  6      17.12.1987      SPACE wird blockweise vergroessert. PS
	Version  7      06.02.1988      SP_MAX beruecksichtigt. PS
	Version  8      27.08.1991      "# undef fprintf" ergaenzt. PS
	Version  9	17.12.1992	englische Meldungen. PS
	Version 10	06.05.1996	Fehlermeldung, falls 
						ltop(ptol(A)) != A
					Marc Conrad
   DATE setspace      : 890501.910915.930115.960601
H*/


# include <_list.h>
# undef printf
# undef fprintf


void setspace( single anz )
{
	extern void *malloc();
	PCELL pc, pcend;
	int sp_size, meldung;
	FILE *pf;

    /***    Initialisierung von sp_size    ***/
	sp_size = BL_NR * BL_SIZE;

    /***    falls sp_size >= anz    ***/
	if ( sp_size >= anz )  return;

    /***    Koordination von stdout und stderr    ***/
	if ( inocmp( fileno(stdout), fileno(stderr) ) ) pf = stderr;
	else pf = stdout;

    /***    SP_MAX ueberpruefen und ggf. korrigieren    ***/
	if ( SP_MAX > BL_NR_MAX * BL_SIZE ) {
		SP_MAX = BL_NR_MAX * BL_SIZE;
		fprintf( pf, "\n***   SP_MAX too large!                    ***" );
		fprintf( pf, "\n***   Reduced to maximum %d (%d blocks).   ***\n",SP_MAX,SP_MAX/BL_SIZE);
	}
	else if ( SP_MAX%BL_SIZE ) SP_MAX = (SP_MAX/BL_SIZE+1)*BL_SIZE;

    /***    ggf. Schalter fuer Zusatz zur Abschlussmeldung setzen    ***/
	if ( SP_MAX <= sp_size ) meldung = 1;
	else meldung = 0;

    /***    falls anz > SP_MAX, Meldung ueber Groesse von SP_MAX absetzen    ***/
	if ( anz > SP_MAX ) {
	    if ( SP_MAX / BL_SIZE == 1 )
		fprintf( pf, "\n***   SP_MAX = %d      (1 block)   ***\n",BL_SIZE);
	    else
		fprintf( pf, "\n***   SP_MAX = %d      (%d blocks)   ***\n",SP_MAX,SP_MAX/BL_SIZE);
	    anz = SP_MAX;
	}

    /***    SPACE blockweise vergr., bis Min(anz,SP_MAX) erreicht ist    ***/
    /***    AVAIL blockweise auffuellen                                  ***/
	while ( sp_size < anz ) {
	    /*    Blockanzahl um 1 erhoehen    */
	    BL_NR++;
	    /*    Blockanfangsadresse in Referenzliste BL_START eintragen
		  Abbruch bei Fehler    */
	    if (( BL_START[BL_NR-1] = (PCELL)malloc( BL_SIZE * sizeof(CELL) )) == NULL ) {
		    printf("\n***   SPACE overflow   ***\n");
		    BL_NR--;
		    lend();
		    exit(1);
	    }
	    /*    AVAIL auffuellen und sp_size aktualisieren    */
	    pcend = BL_START[BL_NR-1];
	    sp_size += BL_SIZE;
	    pc = pcend + BL_SIZE;
	    while( pc-- != pcend ) { 
		pc->adr = AVAIL; 
		AVAIL = ptol(pc, BL_NR-1);
		if ( ltop( AVAIL ) != pc ) { 
			fprintf(pf, "\n*** Error in the SIMATH list system ***\n"); 
			fprintf(pf, "*** AVAIL = %d, pc = %ld, ptol(pc) = %d, ltop(AVAIL) = %ld ***\n", (int) AVAIL, (unsigned long) pc, ptol(pc, BL_NR-1), (unsigned long) ltop(AVAIL));
			fprintf(pf, " Please inform simath@tnt.math.metro-u.ac.jp about this error. ***\n");
			} 
		} 
	}

    /***    Abschlussmeldung ueber SPACE-Groesse absetzen    ***/
	if ( meldung ) 
	    fprintf( pf ,"\n***   SPACE won't be enlarged as SP_MAX <= SPACE size.      ***");
	if( BL_NR < BL_NR_MSG ) { return ; }  
	fprintf( pf ,"\n***   # blocks = %2d  ",BL_NR);
	fprintf( pf ,"       # cells = %2d * %5d = %6d   ***\n",BL_NR,BL_SIZE,BL_NR*BL_SIZE );

}
