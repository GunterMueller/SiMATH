/*M
.SH NAME
SIMATHinit - SIMATH initialization

.SH SYNOPSIS
.nf
#include <_list.h>

int SIMATHinit(); 

a = SIMATHinit(); 

.SH DESCRIPTION 
SIMATHinit() initializes the SIMATH list system. 
In normal applications you don't need to call this function explicitly.
This is done for you by Sinit() and Sbind(), or by using the 
SIMATH-preprocessor.
 

.PP
The first call of SIMATHinit() returns a = 1, all the following calls
of SIMATHinit() do nothing and return a = 0. 

.SH SEE ALSO
.BR Sinit(), 
.BR Sbind(),
.BR Sfree()
M*/
/*C
			SIMATHinit()

	"SIMATH-system initialization"
	Quellbibliothek: srclib.kern
	Include-Datei:	 _list.h
	int SIMATHinit() 
	a = SIMATHinit(); 
!!!	Wird nur vom System benutzt.
C*/
/*H
	Version	 1	19.01.1988	BW und MAR.
	Version	 2	06.02.1988	an Blockstruktur des SPACE angepasst.  PS
	Version	 3	15.07.1988	expliziter Aufruf von isatom entfernt,
					isatom ist nur noch Macro.  BW
	Version	 4	14.12.1988	an SUN-SIMATHinit angepasst.  PS
	Version	 5	15.03.1990	ueberfluessige Variable sz geloescht.  PS 
	Version	 6	02.05.1991	globale Variablen fuer die floating-
					point-Arithmetik eingebaut.  MC
	Version	 7	03.07.1991	BL_NR_MAX fuer SUN-Rechner auf 63
					(statt 31) gesetzt.
					Trick "i=0; if (i) {...}" ersetzt durch
					"if (llength(_0)) {...}", um auch den
					Optimierer von SUN4 zu ueberlisten.  PS
	Version	 8	17.07.1991	STOCK ausgeblendet.  PS
	Version	 9	29.08.1991	"# undef ltop/ptol" geloescht.
					ltop und ptol werden nicht mehr mit
					Trick eingebunden, da sie wieder Macros
					sind.
					"# undef printf" eingefuegt.  PS
	Version 10	12.12.1991	"jmp_buf FL_JMP" rausgeworfen.
					Definition stattdessen in _(T)list.h,
					weil vieta sonst abstuerzt.  PS
	Version 11	16.11.1992	globale Variablen MADUMMY und MANUMMY
					fuer das Matrizensystem eingebaut.  PS
	Version 12	13.10.1993	TRACE_ON, TRACE_CC geloescht.
					(Testsystem existiert nicht mehr.)  PS
	Version 13	01.12.1993	etwas geaendert wegen HP-Vertraeglich-
					keit.  MC
	Version 14	20.01.1994	EVORD, GBRHO und FL_JMP als globale 
					Variablen hinzugefuegt.	 MP
	Version 15	12.10.1994	SEMIRAND als globale Variable definiert
					und auf 1 gesetzt.  _H_BOUND als 
					globale Variable definiert und auf 0 
					gesetzt. BL_NR_MAX wird jetzt ueber 
					ein Macro in <CONFIG.H> definiert und 
					kann daher leichter bei der
					Installation angepasst werden.
					isiprime() wird durch einen Trick hier
					eingebunden, weil ifact() (in arith1)
					isiprime() (in arith2) benoetigt. MP
	Version 16	09.10.1995	Added ITERMAX as global variable. MP
	Version 17	22.03.1996	FL_STZ = 0, damit overflow-handling
					funktioniert. Marc Conrad
	Version 18	06.05.1996	AVAIL wird jetzt nur noch in setspace()
					aufgerufen. SPACE wird nun nicht mehr
					benoetigt. Marc Conrad
	Version 19	11.10.1996	POW2 rausgeworfen, FL_LN2 wird jetzt
					in fllog() initialisiert. Abfrage am 
					Anfang (SIMATHinit_called). Englische
					Dokumentation. Marc Conrad
	Version 20 	31.01.1997	igkapt() wird eingebunden. (mit ifdef) 
   DATE SIMATHinit    : 890501.900315.910715.910915.911215.921130.931130.940315.941201.951201.960501.960601.961201
H*/

#include <_list.h>
#undef printf

/* Globale Variablen Listensystem */

/* PCELL 	SPACE; */
PCELL	*BL_START;
int	SP_MAX, ST_SIZE /*, STOCK_SZ */;
int	BL_SIZE, BL_NR, BL_NR_MAX, BL_NR_MSG;
int	GC_CC, GC_COUNT, GC_MESS, GC_QUOTE, GC_TEST, GC_TIME;
int	ST_INDEX = 0, ST_SIZE = 0; 
int **STACK /*, *STOCK */;
int	AVAIL;
int	LN_SIZE, MARGIN;
int	DUM, NUM;
/* int	   STOCK_IND = -1; */

/***************************/

/* Globale Variablen Arithmetiksystem */

int    DIFF[481],LIST_SP[169];

int FL_STZ;
int FL_EPS;
int FL_LN2;		   

int SEMIRAND;

/***************************/

/* Globale Variablen Polynomsystem */

int POLDUMMY;
int LIST_GSP[51];
int EVORD, GBRHO;
single ITERMAX;

/***************************/  

/* Globale Variablen Matrizensystem */

int MADUMMY, MANUMMY;

/***************************/	  

/* Globale Variables fuer elliptische Kurven */

double _H_BOUND;
single _R_C_M;

/***************************/	  

/* sonstige Variablen */

jmp_buf FL_JMP; 

single SS_MESS = 0;
static int SIMATHinit_called = 0; 


int SIMATHinit()
{


/* Da in Version 2.0 der Schalter '-u' beim Binder nicht existiert,
   muessen diese Moduln mittels 'Trick' explizit eingebunden werden.
   Den Trick "int i = 0; if ( i ) { ... }" durchschaut der Optimierer
   des Binders auf SUN4.
*/


/* 
Mit dieser Abfrage kann SIMATHinit() auch mehrmals aufgerufen werden. 
*/
if( SIMATHinit_called) { return( 0 ); } 

SIMATHinit_called = 1; 
{

	if ( llength(_0) ) {
		gc();
		inocmp();
		islist();
		lend();
		setspace();
		setstack();
		setstock();	/* wird im Moment nicht benutzt */
		xfprintf();
		xprintf();

		isiprime();     /* erforderlich, weil ifact() (aus arith1) */
				/* isiprime() (aus arith2) benutzt.	   */

#ifdef HAVE_SM_EXT		
		igkapt();  /* wird evtl. von isiprime() benutzt */
#endif
	}
}


/* Initialisierung des Listensystems */


{
	char *malloc();
	PCELL p;
    /***    initialisiere globale Parameter    ***/
	LN_SIZE = 80;
	MARGIN = ST_INDEX = 0;
	GC_CC = GC_COUNT = GC_MESS = GC_TEST = GC_TIME = 0;
	GC_QUOTE = 10;
	ST_SIZE = 500;
     /* STOCK_SZ = 500; */
	BL_SIZE = 16383;

	/* MAX_BLOCK_NUMBER is defined in <CONFIG.H> and depends on the
	system. "Usually", it is 63.*/

	BL_NR_MAX = MAX_BLOCK_NUMBER;

	BL_NR = 0;
	SP_MAX = BL_NR_MAX * BL_SIZE;
	DUM = NUM = 0;	   
	FL_LN2 = 0; 
    /***    allociere STACK, (STOCK, SPACE) und Referenzliste BL_START	  ***/
	if (
		(STACK = (int**)malloc( ST_SIZE * sizeof(int*) )) == NULL
	  /* || (STOCK = (int*)malloc( STOCK_SZ * sizeof(int) )) == NULL */
	 /*    || (SPACE = (PCELL)malloc( BL_SIZE * sizeof(CELL) )) == NULL */
	     || (BL_START = (PCELL*)malloc( BL_NR_MAX * sizeof(PCELL) )) == NULL
	   )
	{
# undef printf
		printf("\n*** Datenspeicher zu klein ***\n");
		exit(1);
	}
    /***    binde GC_CC, DUM, NUM, FL_LN2    ***/
	bind( GC_CC );
	bind( DUM ); bind( NUM );	 
	bind( FL_LN2 );
	ST_INDEX+=4;
    /***    initialisiere AVAIL	   ***/
	BL_NR_MSG = 2; 
	AVAIL = _0; 
}
/***************************/

/* Initialisierung des Arithmetiksystems */

{
	unsigned  *p, u;
	char a[500];
	int    i,w,k,j,l;			      
	
	FL_EPS = 5;	      
	FL_STZ = 0;	

   /***	   SEMIRAND beeinflusst das Verhalten von irand() ***/

	SEMIRAND = 1;
	
   /***	   DIFF ist ein Array, in dem die Differenzen der Einheiten aus
	   Z/2310*Z stehen. (Begonnen wird bei 1009.) Das Feldende ist
	   durch 0 gekennzeichnet.
	   DIFF hat also 481 Elemente.
	   Erstellung :		***/
	for (i = 1010, p = (unsigned *)DIFF; i <= 3319; i++)
		if (i%2	 &&  i%3  &&  i%5  &&  i%7  &&	i%11) *p++ = i;
	for (i = 0, l = 1009; i <480; i++)
		{j = DIFF[i]; DIFF[i] = j-l; l = j;}
	DIFF[480] = 0;

   /***	   LIST_SP ist ein Array, in dem alle 168 Primzahlen < 1000 stehen.
	   Das Feldende ist durch 0 gekennzeichnet.
	   LIST_SP hat also 169 Elemente.
	   Erstellung :		***/
	for ( i=0 ; i<500 ; i++ ) *(a+i) = 't';
	a[0] = 'f';
	w = 1;
	do
	    {
		if (*(a+w) == 't')
		{ 
			k = 3*w + 1;
			do
			    {
				*(a+k) ='f';
				k = k+2*w+1;
			}
			while ( k < 500 );
		}
		w++;
	}
	while ( w < 32 );
	p = (unsigned *)LIST_SP;
	*p++ = 2;
	for ( i=0 ; i<500 ; i++ )
		if ( *(a+i) == 't' ) *p++ = 2*i+1;
	*p = 0;

}
/***************************/

/* Initialisierung des Polynomsystems */

{
	init(POLDUMMY);
	ST_INDEX++;
	LIST_GSP[ 0] = 1073741789;    LIST_GSP[ 1] = 1073741783;    
	LIST_GSP[ 2] = 1073741741;    LIST_GSP[ 3] = 1073741723;    
	LIST_GSP[ 4] = 1073741719;    LIST_GSP[ 5] = 1073741717;    
	LIST_GSP[ 6] = 1073741689;    LIST_GSP[ 7] = 1073741671;    
	LIST_GSP[ 8] = 1073741663;    LIST_GSP[ 9] = 1073741651;    
	LIST_GSP[10] = 1073741621;    LIST_GSP[11] = 1073741567;    
	LIST_GSP[12] = 1073741561;    LIST_GSP[13] = 1073741527;    
	LIST_GSP[14] = 1073741503;    LIST_GSP[15] = 1073741477;    
	LIST_GSP[16] = 1073741467;    LIST_GSP[17] = 1073741441;    
	LIST_GSP[18] = 1073741419;    LIST_GSP[19] = 1073741399;    
	LIST_GSP[20] = 1073741387;    LIST_GSP[21] = 1073741381;    
	LIST_GSP[22] = 1073741371;    LIST_GSP[23] = 1073741329;    
	LIST_GSP[24] = 1073741311;    LIST_GSP[25] = 1073741309;    
	LIST_GSP[26] = 1073741287;    LIST_GSP[27] = 1073741237;    
	LIST_GSP[28] = 1073741213;    LIST_GSP[29] = 1073741197;    
	LIST_GSP[30] = 1073741189;    LIST_GSP[31] = 1073741173;    
	LIST_GSP[32] = 1073741101;    LIST_GSP[33] = 1073741077;    
	LIST_GSP[34] = 1073741047;    LIST_GSP[35] = 1073740963;    
	LIST_GSP[36] = 1073740951;    LIST_GSP[37] = 1073740933;    
	LIST_GSP[38] = 1073740909;    LIST_GSP[39] = 1073740879;    
	LIST_GSP[40] = 1073740853;    LIST_GSP[41] = 1073740847;    
	LIST_GSP[42] = 1073740819;    LIST_GSP[43] = 1073740807;    
	LIST_GSP[44] = 1073740793;    LIST_GSP[45] = 1073740783;    
	LIST_GSP[46] = 1073740781;    LIST_GSP[47] = 1073740697;    
	LIST_GSP[48] = 1073740693;    LIST_GSP[49] = 1073740691;    
	LIST_GSP[50] = 0;
	
	ITERMAX = 500;
}

/***************************/

/* Initialisierung des Matrizensystems */

{
	init(MADUMMY, MANUMMY);
	ST_INDEX += 2;
}
/***************************/

/* Initianlisierung der globalen Konstanten fuer elliptische Kurven */

{
	_H_BOUND = 0.0;
	_R_C_M   = 0;
}
/***************************/
return(1); 
}

