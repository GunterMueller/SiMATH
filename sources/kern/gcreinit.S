/*C
			gcreinit(bls, blnrm)

	"garbage collector reinitialization"
	Quellbibliothek: srclib.kern
	Include-Datei:   _list.h               
	single gcreinit(bls, blnrm)  single bls, blnrm;
	sp_max = gcreinit(bls, blnrm);                     
	Es muss gelten bls >= 0, blnrm >= 0.
	Der SIMATH-Listenspeicher (SPACE) wird neu angelegt. 
	Dabei erhalten die SIMATH-Variablen BL_SIZE und BL_NR_MAX die
	Werte bls beziehungsweise blnrm. Ist bls oder blnrm gleich
	Null, so werden die alten Werte von BL_SIZE beziehungsweise
	BL_NR_MAX beibehalten.
	Allen im STACK gebundenen Variablen, die vor dem Aufruf Zeiger
	auf Listen waren, wird der Wert 0 zugewiesen. (Ausnahme: 
	wenn der Zeiger auf die leere Liste gezeigt hat.)
	BL_SIZE ist die Anzahl der Listenelemente, die ein Block
	enthaelt, BL_NR_MAX die maximale Anzahl von Bloecken, die
	waehrend eine Programmes angelegt werden kann. Werden mehr
	Listenelemente benoetigt, so wird das Programm in der Regel mit
	einer Fehlermeldung beendet.
	sp_max erhaelt den Wert SP_MAX.
C*/
/*H  
	Version 1	19.04.1993	Marc Conrad
	Version 2	06.05.1996	SPACE rausgeorfen (s. SIMATHinit())
					Marc Conrad
	Version 3	11.10.1996	FL_LN2 rausgeworfen. Marc Conrad
   DATE gcreinit      : 930531.9311__.960601.961201
H*/

extern int FL_LN2;  

#include <_list.h>

#define XXissingle(A) (issingle(A) || (A) == _0) 

gcreinit( bls, blnrm )     
single bls, blnrm;
{
	char *malloc();
	single i;
	PCELL p;
/* 
Mit C++ ist es nicht mehr klar, dass SIMATHinit() aufgerufen wird.
Aber wie kann man was re-initialisiere, das nicht initialisiert ist? :-) 
*/
	SIMATHinit(); 

	if ( bls )       
		BL_SIZE = bls;       

	if ( blnrm ) 
		BL_NR_MAX = blnrm;    
	
	for( i = ST_INDEX - 1; i >= 0 ; i-- )  
	if ( !XXissingle( *(*(STACK+i)) ) )  *(*(STACK + i)) = 0;


	SP_MAX = BL_NR_MAX * BL_SIZE;
	FL_LN2 = 0;
/***    allociere SPACE und Referenzliste BL_START    ***/
	for (i = BL_NR - 1; i >= 0; i--) {
		free(BL_START[i]);
	}
	free(BL_START);

	BL_NR = 0;     

	if (
	    (BL_START = (PCELL *) malloc(BL_NR_MAX * sizeof(PCELL))) == NULL
		) {
# undef printf
		printf("\n*** Datenspeicher zu klein ***\n");
		exit(1);
	}
	AVAIL = _0; 

/* Initialisierung des Arithmetiksystems */

	return( SP_MAX );
}
