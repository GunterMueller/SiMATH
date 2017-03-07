/*C
			gcfree( )

	"garbage collector with freeing blocks"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h               
	single gcfree( );
	a = gcfree( );
	Alle Zellen im SPACE, die vom STACK erreichbar sind,
	werden markiert. Danach wird eine Liste aller freien Zellen
	angelegt (AVAIL), und die Markierungen werden entfernt.
	Die globalen Variablen GC_COUNT und GC_CC werden aktualisiert.
	Falls noetig wird der SPACE vergroessert. (*)     
	Falls moeglich, wird der SPACE verkleinert, dergestalt dass
	die zuletzt allocierten Bloecke, die keine markierten Zellen
	enthalten, freigegeben werden. In diesem Fall wird eine 
	Meldung ausgegeben. 
	a ist die Anzahl der freigegebenen Bloecke.
	Mit gccpr() koennen Listen an den Anfang des SPACE kopiert 
	werden, so dass die Wahrscheinlichkeit, dass tatsaechlich 
	leere Bloecke entstehen, die freigegeben werden koennen, 
	erhoeht wird.
	Ist GC_TEST = 1, so werden alle Listen im SPACE auf Korrektheit
	ueberprueft. (**)
	Wenn bei (**) eine nicht korrekte Liste gefunden wird oder bei (*)
	SP_MAX erreicht ist, wird das Programm mit einer entsprechenden
	Meldung auf stdout abgebrochen.        
	Beispiel: 
	Sei foo( ) eine Funktion, die sehr viel Speicherplatz verbraucht,
	der wieder freigegeben werden soll. foo( ) soll als Rueckgabewert 
	eine Liste haben.     
	...
	L = foo( a, b, c )
	gcfree();        
	L = lcopy( L ); 
	gcfree();
	...                               
	Zeile 3 und 4 dienen dazu, L an den Anfang des SPACE zu kopieren. 
C*/
/*H  
	Version 1	08.03.1993	Marc Conrad
	Version 2	01.12.1993	Aenderungen wegen HP.  MC
	Version 3 	27.04.1996	HZ is defined in the SIMATH header
					_list.h. MP
   DATE gcfree        : 930531.940315.960601
H*/

# include <_list.h>

# define      mark(p) ( (p)->adr |=  MARK )
# define    unmark(p) ( (p)->adr &= ~MARK )
# define    ismark(p) ( (p)->adr &   MARK )
# define         MARK (1<<31)

# undef printf
# undef fprintf

static single marklist ( list L ) {
	obj a;
	PCELL p, q;          

	p = ltop( L );  

	while ( p != ltop(_0) ) { 
		if ( ismark(p) )  return(0);
		q = ltop(p->adr);
		a = p->inh;
		mark( p );
		if ( !isatom(a) )  marklist( a );
		p = q;
	}                      
	return(0);
}



single gcfree( )
{
	obj a;
	single  t0, t1, cc = 0, j, zaehl=0;
	register unsigned n;
	register i = ST_INDEX;
	PCELL p;
	static struct tms buffer;   
	single flag, b;
	FILE *pf;

   /***    Koordination von stdout und stderr    ***/
	if ( inocmp( fileno(stdout), fileno(stderr) ) ) pf = stderr;
	else pf = stdout;

   /***    Anfangs-Rechenzeit    ***/
	times( &buffer );
	t0 = buffer.tms_utime;

   /***   falls GC_TEST = 1, ueberpruefen, ob alle   ***/
   /***   gesicherten Listen korrekt sind            ***/
	if ( GC_TEST ) {
	    while (i--)  {
		    a = **(STACK+i);
		    if ( !islist(a) && !isatom(a) ) {
			printf("\n***   gc failed.           ***  ");
			printf("\n***   Check your lists!    ***\n");
			lend();
			exit(1);
		    }
	    }
	    i = ST_INDEX;
	}

   /***    aktuelle Listen markieren    ***/
	while (i--)  if ( a = **(STACK+i), !isatom(a) )  marklist( a );

   /***    unmarkierte Zellen sammeln    ***/
	AVAIL = _0;
	flag = 1;
	for ( j=BL_NR-1 ; j>=0 ; j-- ) {
		n = BL_SIZE;
		p = BL_START[j] + n;
		while (n--)
		    if ( ismark(--p) )  {
			unmark( p );
			if ( flag ) flag = 0;
		    }
		    else {
			p->adr = AVAIL;
			AVAIL = ptol( p , j );
			cc++;
		    }
		if ( flag && j > 0 ) {
			AVAIL = _0;
			free( BL_START[j] );
			zaehl++;
			BL_NR--;
			cc=0;
		}
	}
	if ( zaehl ) {
	fprintf( pf ,"\n*** gcfree(): #blocks = %d ",BL_NR);
	fprintf( pf ,"#freed blocks = %d ",zaehl);
	fprintf( pf ,"#cells = %d * %d = %d ***\n",BL_NR,BL_SIZE,BL_NR*BL_SIZE );
        }
   /***    globale Zaehler setzen    ***/
	GC_COUNT++; 
	if ( cc > 4 )  GC_CC = isum( GC_CC, cc );
	times( &buffer );
	t1 = buffer.tms_utime - t0;
	GC_TIME += t1;
	if ( !GC_MESS && cc >= (BL_NR*BL_SIZE)/GC_QUOTE )  return;

   /***    Meldung absetzen, falls GC_TEST gesetzt    ***/
	if ( GC_TEST ) fprintf( pf, "\n***   gc: %d cells in %.2f sec.   ***\n", cc, 1.*t1/HZ );

   /***    SPACE vergroessern, falls notwendig    ***/
	if ( cc < (BL_NR*BL_SIZE)/GC_QUOTE ) {
		/*    SP_MAX ueberpruefen und ggf. korrigieren    */
		if ( SP_MAX > BL_NR_MAX * BL_SIZE ) {
			SP_MAX = BL_NR_MAX * BL_SIZE;
			fprintf( pf, "\n***   SP_MAX too large!                    ***" );
			fprintf( pf, "\n***   Reduced to maximum %d (%d blocks).   ***\n",SP_MAX,SP_MAX/BL_SIZE);
		}
		else if ( SP_MAX%BL_SIZE ) SP_MAX = (SP_MAX/BL_SIZE+1)*BL_SIZE;
		if ( SP_MAX >= (BL_NR+1)*BL_SIZE )  setspace( (BL_NR+1)*BL_SIZE );
		else {

   /***    Abbruch, wenn SP_MAX erreicht    ***/
		    if ( SP_MAX / BL_SIZE == 1 )
			fprintf( pf,"\n***   SP_MAX = %d      (1 block)   ***\n",BL_SIZE);
		    else
		        fprintf( pf,"\n***   SP_MAX = %d      (%d blocks)   ***\n",SP_MAX,SP_MAX/BL_SIZE);
		    printf("\n***   SPACE overflow   ***\n");
		    lend();
		    exit(2);
		}
	}      
	return( zaehl );
}

