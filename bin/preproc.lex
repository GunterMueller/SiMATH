/*KOM   pre88nov.c unterscheidet sich von pre88sept.c
/*KOM   in der return-Erkennung, der Behandlung von Pointer auf
/*KOM   Funktionen als Uebergabeparameter, und der Fu.def.erkennung vom Typ 2.

/*KOM   Mithilfe von makepreproc erhaelt man einen lauffaehigen Praeprozessor.



/*KOM   Dies ist ein LEX-Quellprogramm im zugehoerigen Format.
/*KOM   Grundlage sind regulaere Ausdruecke , sowohl im Definitions-
/*KOM   als auch im Anweisungsteil.


/*KOM   Im Bereich zwischen "%{..%}" werden globale Variablen gesetzt,
/*KOM   und es koennen Header angegeben werden.
/*KOM   1) <ctype.h> wird fuer 'isalphanum()' usw. benoetigt.
/*KOM   2) lfz ist der Zeilen(-ende )zaehler, d.h. '\n' wird gezaehlt.
/*KOM   3) trace ist ein Schalter fuer Testheader.
/*KOM   4) klz ist der Klammerzaehler. Bei '{' wird er um 1 erhoeht, bei
/*KOM      '}' wird er um 1 erniedrigt.
/*KOM   5) glz ist der globale ( STACK- ) Zaehler. Bei einfachen ( nicht Feld-)
/*KOM      inits oder binds gibt er die Zahl der gebundenen Variablen im
/*KOM      gesamten Unterprogramm an.
/*KOM   6) marz zaehlt alle kuenstlich gesetzten Marken vor '}' (s.u.) .
/*KOM   7) rtz ist Schalter, der Wert 1 hat, wenn im UP return auftaucht.
/*KOM   8) lz[] ist der lokale Zaehler fuer einen Block. Er ist als
/*KOM      Feld der Tiefe 'klz' angelegt und gibt die Zahl der gebundenen
/*KOM      (einfachen) Variablen in dem speziellen Block an.
/*KOM   9) mainsch ist Schalter, der Wert 1 hat, wenn main() gefunden wird.
/*KOM  10) futyp ist string,in dem der Funktionstyp gespeichert wird.
/*KOM  11) hks ist Hochkommaschalter, der bei string( ".."), oder printf
/*KOM       beim 1. Hochkomma Wert 1 erhaehlt und beim 2. den Wert 0.
/*KOM  12) kos ist der Kommentarschalter, der 1 wird bei "/*" und 0 bei
/*KOM       "*/".
/*KOM   Wenn hks oder kos an sind (d.h. Wert 1 haben) soll nichts getan
/*KOM   werden,auch wenn ein Muster erkannt wird. Denn man ist dann in
/*KOM   einem Kommentar oder string oder printf.
/*KOM   13) ibindex gibt an, ob init oder bind vorliegt (init:1,bind:2).
/*KOM   14) fi[] ist Feld der Tiefe klz, und gibt an, ob in einem Block
/*KOM       ein Feldinit (oder Feldbind) aufgetaucht ist (ja:1,nein:0).
/*KOM   15) fis zaehlt Feldinits; wird erhoeht, wenn in einem Block eines
/*KOM       auftaucht (weitere Vorkommen im selben Block werden nicht
/*KOM       gezaehlt). fis wird am Ende eines Blocks erniedrigt, in dem ein
/*KOM       Feldinit aufgetaucht ist.

%{
#include <ctype.h>
int lfz = 0 ;
int trace = 0;
int klz =0 , glz , marz , rtz ;
int lz[1000] ;
int mainsch = 0;
char futyp[1000]="int " ;
int hks = 0 ;
int kos = 0 ;
int ibindex;
int fi[1000] ;
int fis ;
%}

	       /*KOM Tabellenvergroesserungen

%a 5000
%o 10000
%p 5000

	       /*KOM         Definitionen

	/*KOM   SPACE : ein Separator

SPACE [\ \t\n]

	/*KOM   SK : Separator fuer Funktionsparameter

SK ({SPACE}|[,])

	/*KOM   SE : Separator-Kleenestar

SE ({SPACE}*)

	/*KOM   SP : Separatoren

SP ({SPACE}+)

	/*KOM   alnum : alphanumerisches Zeichen, einschliesslich Underscore

alnum [_A-Za-z0-9]

	/*KOM   iden : Identifier

iden [_A-Za-z]({alnum}*)

	/*KOM   inza : Zahl zwischen init o. bind und '(' ; war auf frueherer
	/*KOM   Version erlaubt , um die Anzahl der Variablen anzugeben.
	/*KOM   Dies ist bei der jetzigen Version irrelevant.

inza {SE}([23456])?{SE}

	/*KOM   inop : Operatoren , die im init o. bind auftreten duerfen.

inop [\-\+\*\=\/\>]

	/*KOM   inpa : Parameter,die in init o. bind auftreten duerfen ,z.B.
	/*KOM          a[3..n] , e , c.kla , c[k..t].fel usw. ;

inpa ({alnum}|{inop}|"("|")"|"["|"]"|"."|"&"|","|{SPACE})

	/*KOM   init oder bind haben als Funktion die Form: init(Par.liste);
	/*KOM   oder init3(Parameterliste); oder bind(Parameterliste);
	/*KOM   INHEAD : Musterteil , auf Woerter "init" oder "bind" folgend.

INHEAD {inza}"("({inpa}+)")"

	/*KOM   INITBIND : Gesamtmuster eines init-( oder bind-)Aufrufs.

INITBIND (init|bind){INHEAD}

	/*KOM   FUNAME : Funktionsname.

FUNAME ({iden})

	/*KOM   TYPE : Identifier.

TYPE {FUNAME}

	/*KOM   Separatorzeichen fuer Funktionsaufruf, inclusive "*" vor FUNAME.

SEP1 ([\(\*]|{SPACE})

	/*KOM   Separatoren.

SEP2 ((")"|{SPACE})*)

	/*KOM   Separatoren.

SEP3 (("("|{SPACE})*)

	/*KOM   Separatoren.

ST (("*"|{SPACE})*)

	/*KOM   ENDE : Deklarationsendezeichen ',' oder ';'.

ENDE (","|";")

	/*KOM   FUPOINT : Pointer auf Funktionen als Uebergabeparameter.

FUPOINT ({TYPE}{SE})?({SEP1}*){FUNAME}{SEP2}"("{SE}")"{ENDE}

	/*KOM   FUDEF1 : Funktionsdefinition vom Typ 1 , z.B. "up(a,b)".

FUDEF1 ([\(\*]({SEP1}*))?{FUNAME}{SEP2}"("

	/*KOM   FUDEF2 : Funktionsdefinition vom Typ 2,z.B."int *up ( s,g  )".

FUDEF2 {TYPE}({SEP1}+){FUDEF1}

	/*KOM   UNSIGNEDDEF : Funktionsdefinition mit "unsigned".

UNSIGNEDDEF unsigned{SP}(long({SP}int)?|short({SP}int)?|int|char){SEP1}{FUDEF1}

	/*KOM   HNR : header Nummer

HNR ([1-9])


%%

		    /*KOM   Regelteil.

/*KOM   Bemerkungen :
/*KOM   1)
/*KOM   In jeder Regel taucht die Bedingung "if(!kos && !hks)" auf, d.h.
/*KOM   es wird nur dann etwas ausgefuehrt, wenn diese Schalter auf 0 sind.
/*KOM   Ansonsten "ECHO", d.h. das Muster wird unveraendert ausgegeben.
/*KOM   Die Schalter sind auf 1, wenn Kommentar,string o. printf vorliegt.
/*KOM   2)
/*KOM   Bei Fu.definitionen, z.B.taucht [^;,] auf, und im Muster folgt dann
/*KOM   yyless(yyleng-1); , d.h. es wird ein Zeichen zuviel in die Variable
/*KOM   yytext gelesen, da bei Fu.def. kein ';' o. ',' erwartet wird.
/*KOM   yyless gleicht diesen 'Fehler' wieder aus, indem die ersten
/*KOM   yyleng-1 Zeichen (yyleng=Laenge des erkannten Musters) behandelt
/*KOM   werden, also das letzte Zeichen an den Eingabestrom zurueckgeht.
/*KOM   3)
/*KOM   Die unten aufgefuehrten Muster setzen die genaue Kenntnis der
/*KOM   Syntax-Graphen voraus. Deshalb ist der Kommentar in dieser Hinsicht
/*KOM   sehr spaerlich. !!!!!


/*KOM   Bei Testheadern, z.B. "<_Tarith1.h>, wird der trace-Schalter auf 1
/*KOM   gesetzt und das Muster dann ausgegeben.

\<{SE}_Tsimath.h{SE}\>    |
\<{SE}_Tarith{HNR}\.h{SE}\>   |
\<{SE}_Tlist\.h{SE}\>     |
\<{SE}_Tmatr{HNR}\.h{SE}\>    |
\<{SE}_Tpol{HNR}\.h{SE}\>     { if ( !hks && !kos )
					 trace = 1 ;
					 ECHO ;
			     }

/*KOM #def und #undef sollen ueberlesen werden

"#"([\ \t]*)(def|undef) { char c;  
                        ECHO;
                        while ( (c=input())!='\n' ) putchar(c); 
                        unput( '\n' ); 
                        }

/*KOM   Bei jedem Zeilenendezeichen wird der lfz-Zaehler um 1 erhoeht.
/*KOM   Dieser ist nur wichtig zur Fehlerbehandlung.

"\n" { ++lfz ; ECHO ; }




/*KOM   Muster zur main-Funktionsdefinition. 
/*KOM   Dieses besitzt zwar dieselbe Form wie eine Funktionsdefinition,
/*KOM   muss aber gesondert behandelt werden, um den mainsch zu versorgen.
/*KOM   mainsch bleibt bis zum Ende des main-UP eingeschaltet.
/*KOM   Das Muster hat hoehere Prioritaet, da es zuerst kommt.

main({SEP2}*)"(" {
			if ( !hks && ! kos )
			mainsch = 1;
			ECHO;
		}

/*KOM   Bei Erkennen eines Hochkommas wird der hks, der mit 0 vorbesetzt
/*KOM   ist, nur umgeschaltet, d.h. beim 1.Hochkomma wird er auf 1 und beim
/*KOM   2. wieder auf 0 gesetzt. Im Bereich zwischen den zwei " ist er
/*KOM   also 1, es wird dann nur ueberlesen.

\" {    if ( !kos ) hks = !hks ; ECHO ;  }

/*KOM   '\' dient zwischen zwei Hochkommatas als Fluchtsymbol und deshalb
/*KOM   darf die Kombination \"  keine Aktion veranlassen.

\\\"|\'\"\'  ECHO ;

/*KOM   Bei Kommentarbeginn wird kos auf 1 gesetzt, ausser wenn "/*"
/*KOM   zwischen zwei Hochkommata steht, oder der Schalter bereits an ist.

"/*" {  if ( !hks ) {
	       if ( !kos ) kos = 1 ;
	}
	ECHO ;
     }

/*KOM   Beim Kommentarende wird kos auf 0 gesetzt, falls er an ist.

"*/" {  if ( !hks ) {
		if ( kos ) kos = 0 ;
	}
	ECHO ;
     }

/*KOM   Bei '{' oder '}' muss unterschieden werden zwischen dem Blockbeginn
/*KOM   '{' und den ASCI-Zeichen fuer Klammer-Auf oder Klammer-Zu, wobei die
/*KOM   ASCI-Zeichendie Kombination der Zeichen ''' und '{' und ''' , bzw.
/*KOM   ''' und '}' und ''' bedeutet. der Blockbeginn, also nur das Zeichen
/*KOM   Klammer-Auf, bzw. Blockende muessen erkannt und behandelt werden,
/*KOM   waehrend die ASCI-Zeichen ueberlesen werden.

"'{'"|"'}'" ECHO;




/*KOM   Bei '{' liegt Blockbeginn vor. klz wird zuerst erhoeht.
/*KOM   klz==1 => Unterprogramm
/*KOM   klz>1  => Unterblock

\{    {
	if ( !hks && !kos ) {
	++klz ;
	if ( klz == 1 )  {

/*KOM           Unterprogramm.
/*KOM           Vorinitialisierungen.

		glz = 0 ;
		lz[klz] = 0 ;
		marz = 0 ;
		rtz = 0 ;
		fi[klz] = 0 ;
		fis = 0 ;

/*KOM           mainsch==1 => man ist im Hauptprogramm, d.h. main-Block.
/*KOM           trace==1 => Testheader vorhanden.
/*KOM           !trace   => keine Testheader vorhanden.

		if ( mainsch && !trace )
			fputs(" { SIMATHinit(); ",stdout);
		if ( mainsch && trace ) {
			fputs(" { TSIMATHinit(); ",stdout);
			fputs(" GC_TEST = 1; ",stdout);
			fputs("   TRACE_CC++;  ",stdout);
			fputs(" trace(\"main\"); ",stdout);
		}
		if ( trace && !mainsch ) {
			fputs(" { TRACE_CC++;  ",stdout);
		}
	}
	if ( klz > 1  ) {

/*KOM      Unterblock :
/*KOM      nur lz und fi werden neu initialisiert, da diese lokal in
/*KOM      jedem Block verschieden sind.

		lz[klz] = 0;
		fi[klz] = 0;
	}
	}
	ECHO ;
     }


/*KOM   Bei '}' liegt Ende des Blocks oder UP vor.

\} {
	if ( !hks && !kos ) {

/*KOM         klz==1 => Ende des UP
/*KOM         klz>=2 => Ende des Unterblocks

	if ( lz[klz] != 0 || ( trace && klz == 1 ) || fi[klz] != 0 )

/*KOM   lz[klz]!=0 bedeutet: es wurden in diesem Block einfache init, bind
/*KOM   benutzt, denn der lz wurde irgendwann innerhalb des Blocks erhoeht.
/*KOM   fi[klz]!=0 bedeutet: es wurde Feldinit benutzt.

/*KOM   rtz hat Wert 1, sobald in einem UP return aufgetaucht ist.
/*KOM   Um den ST_INDEX vor '}' herunterzusetzen, muss zuerst eine Marke
/*KOM   kuenstlich vorangestellt werden in diesem Fall, da sonst vom
/*KOM   Compiler eine Warnung kommt.
/*KOM   Um verschiedene Marken zu erzeugen, wurde der Markenzaehler marz
/*KOM   eingefuehrt, der erhoeht wird, sobald eine Marke gesetzt wurde.

		if ( rtz ) {
			printf("J1YSB__3%uZ1987:  ",marz) ;
			++marz;
		}

/*KOM   fi[klz]==1 => Feldinits in diesem Block, und der ST_INDEX muss
/*KOM   zurueckgesetzt werden, in Abhaengigkeit von fis.
/*KOM   Beim 1. Feldinit in einem Block wird eine neue Variable im
/*KOM   Benutzerprogramm kreiert. Feldinitialisierungen koennen auch
/*KOM   verschachtelt auftreten. fis gibt die Schachtelungstiefe solcher
/*KOM   Bloecke an, in denen Feldinitialisierungen sind. Um den Beginn der
/*KOM   Verschachtelung zu erkennen, erhaelt die 1. neue Variable einen
/*KOM   anderen Namen,naemlich : ____J_GLZY_Z . Alle weiteren haben den
/*KOM   Namen : ____J_JXVY_Z . D.h.
/*KOM   fis==1 => der ST_INDEX bei Blockeintritt wurde in ____J_GLZY_Z
/*KOM   gespeichert.
/*KOM   fis>=2 => der ST_INDEX bei Blockeintritt wurde in ____J_JXVY_Z
/*KOM   gespeichert.
/*KOM   Entsprechend wird dann hier am Blockende der ST_INDEX gesetzt,
/*KOM   erhaelt also den Wert der obigen Variable.
/*KOM   Wichtig ist, dass zuerst die Variable uebergeben wird, denn diese
/*KOM   tritt erst in Kraft, wenn Feldinits auftauchen. Da aber vorher
/*KOM   schon einfache inits, binds stehen koennen, muss der lz beachtet
/*KOM   werden, dieser natuerlich danach.
/*KOM   Der lz wurde natuerlich angehalten, sobald ein Feldinit auftrat,
/*KOM   ebenso der glz /. Weiteres siehe unter init und bind.

	if ( fi[klz] ) {
		if ( fis > 1 ) fputs("ST_INDEX=____J_JXVY_Z;}",stdout);
		if ( fis == 1 ) fputs("ST_INDEX=____J_GLZY_Z;}",stdout);
		--fis ;
	}

/*KOM   lz[klz]!=0 => einfache init, bind wurden verwendet, d.h. der
/*KOM   ST_INDEX muss um den Betrag des lokalen Zaehlers erniedrigt
/*KOM   werden, ebenso der globale Zaehler glz des Praeprozessors.

	if ( lz[klz] != 0 ) {
		if( !fis ) glz -= lz[klz] ;
		printf("ST_INDEX -= %u;", lz[klz]) ;
	}

/*KOM   Hier erst wird der klz erniedrigt.

	--klz ;

/*KOM   klz==0 => Ende des UP.
/*KOM   klz>=1 => Ende eines Unterblocks.

	if ( !klz ) {

/*KOM   !klz heisst klz==0.
/*KOM   Dann werden die zusaetzlichen Funktionen lend(), tracemsg() in
/*KOM   Abhaengigkeit der Schalter trace und mainsch uebertragen.

		if ( trace ) {
			fputs(" tracemsg(); ",stdout);
		}
		if ( trace && !mainsch ) {
			fputs(" } ",stdout) ;
		}
		if ( mainsch ) {
			fputs(" } lend(); ",stdout);
			mainsch = 0;
		}
	}
	}
	ECHO ;
    }




/*KOM   Erkennung von return in den moeglichen Variationen.
/*KOM   return muss mit ';' abgeschlossen sein !
/*KOM   return, init, bind haben das gleiche Format wie Fu.definitionen.
/*KOM   Deshalb muessen ihre Muster vor Fu.def. stehen, um nicht als solche
/*KOM   erkannt zu werden, und haben dadurch hoehere Prioritaet.

/*KOM   return braucht  eine Sonderbehandlung in Bezug auf
/*KOM   den ST_INDEX, da an dieser Stelle das UP verlassen wird.
/*KOM   Der ST_INDEX muss also genauso zurueckgesetzt werden, wie bei der
/*KOM   letzten '}'des UP.


/*KOM   Muster fuer return ohne Parameter.
/*KOM   Fuer return ohne Parameter werden 2 Moeglichkeiten betrachtet:
/*KOM           return(); oder return;  mit beliebigen Blanks.

return{SE}\({SE}\){SE}; |
return{SE}; {
		if ( !hks && !kos ) {

/*KOM   Da hier return auftaucht wird rtz bis UP-ende auf 1 gesetzt.

			rtz = 1 ;

/*KOM   Ist der trace-Schalter an, muss tracemsg() aufgerufen werden.
/*KOM   Die '{' steht um einen neuen Block zu kreieren.

			if ( trace ) {
				fputs(" { ",stdout);
				fputs(" tracemsg(); ",stdout);
			 }

/*KOM   fis > 0 => im UP wurde mindestens ein Feldinit benutzt.
/*KOM   glz !=0 => im UP wurde einfaches init oder bind verwendet.
/*KOM   Wenn eines der beiden gilt, wird um das return ein neuer Block
/*KOM   gebildet der Form:
/*KOM           {ST=VAR;ST_INDEX-=glz;return;}
/*KOM   ST=VAR: ST_INDEX=____J_GLZY_Z
/*KOM           Falls man sich in einem (Unter-)Block mit Feldinit befindet,
/*KOM           erhaelt ST_INDEX den Wert, den er hatte vor dem ersten
/*KOM           Feldinit. Sollte fis==0 sein, so faellt dieser Teil weg.
/*KOM   ST-=glz: Der ST_INDEX wird um den Wert des glz erniedrigt, falls
/*KOM            dieser !=0 ist. Ansonsten fehlt auch dieser Teil.
/*KOM   Gilt keine der Bedingungen wird das Muster nur uebergeben (ECHO).

			if ( fis > 0 || glz != 0 ) fputs("{",stdout) ;

			if ( fis > 0 ) fputs("ST_INDEX=____J_GLZY_Z;",stdout);

			if ( glz != 0 )
				printf(" ST_INDEX -= %u;",glz) ;

			ECHO ;

			if ( fis > 0 || glz != 0 ) fputs("}",stdout) ;

			if( trace ) fputs(" } ",stdout);

			 }
		else ECHO ;
	   }



/*KOM   Muster fuer return mit Parameter.
/*KOM   Bei return mit Parametern muss man diese natuerlich beachten.
/*KOM   Wenn man zuerst den ST_INDEX heruntersetzt, und dann die
/*KOM   Komponenten uebergibt, kann es sein, dass benutzte Variablen
/*KOM   nicht gesichert sind. Deshalb braucht man einen neuen Block, in
/*KOM   dem eine Variable RESTORE eingefuehrt wird, an die man den Return-
/*KOM   Term uebergibt. Der Typ von RESTORE ist der der Funktion selbst.
/*KOM   Diesen erhaelt man durch FU.def.erkennung (s.u.), und er wird gemerkt
/*KOM   in der Praeprozessor-Variable futyp[]. Die neue Form ist dann:

/*KOM     {futyp RESTORE;Restore=Returnterm;ST=VAR;ST-=glz;return(RESTORE);}

/*KOM   ST=VAR und ST-=glz stehen, wie oben, nur dann, wenn notwendig.
/*KOM   Sind die Bedingungen glz!=0 und fis > 0 beide nicht erfuellt, sind
/*KOM   die obigen Ueberlegungen irrelevant, und es wird nichts getan.

return[^;\n]+;    {
		if ( !hks && !kos ) {
		int l , m , k , sch ;
		char retterm[1000] ;
		rtz = 1 ;
		if ( trace ) {
			fputs(" { ",stdout);
			fputs(" tracemsg(); ",stdout);
		}
		if ( glz != 0 || fis > 0 ) {
			l = 0 ;
			k = 0 ;
			m = 0 ;
			sch = 0;

/*KOM   Zunaechst wird der gesamte Term nach 'return', inklusive '('o. ')',
/*KOM   an retterm[] uebergeben. Dabei gibt sch an, ob Klammern stehen oder
/*KOM   nicht, denn korrekte return's sind:
/*KOM           return(...);    als auch    return ... ;
/*KOM   Wenn keine '(' steht, wird sch auf 1 gesetzt und kuenstlich werden
/*KOM   Klammern hinzugefuegt.
/*KOM   k ist der Zaehler fuer runde Klammern.
/*KOM   bei '(' : ++k
/*KOM   bei ')' : --k
/*KOM   Nach Abarbeitung des Returnterms wird getestet, ob k==0 ist.
/*KOM   Ist dies nicht der Fall, muss im Returnterm ein Klammerfehler sein.
 
			while ( yytext[l] != 'r' ) l++;
			l+= 6;
			while(yytext[l]==' ' || yytext[l]=='\t' || yytext[l]=='\n' ) l++ ;
			if ( yytext[l] != '(' ) {
				retterm[m++] = '(' ;
				sch = 1;
			}
			while ( yytext[l]!=';' ) {
				if ( yytext[l] == '(' ) ++k ;
				if ( yytext[l] == ')' ) --k ;
				retterm[m++] = yytext[l] ;
				l++;
			}
			if ( sch ) retterm[m++] = ')';
			retterm[m] = '\0' ;
			if ( !k ) {
				fputs("{",stdout) ;
				printf("%sRESTORE ;",futyp) ;
				printf("RESTORE =%s ;",retterm) ;
				if( fis > 0 )
				      fputs("ST_INDEX=____J_GLZY_Z;",stdout);
				if ( glz != 0 )
					printf("ST_INDEX -= %u ; ",glz ) ;
				fputs("return(RESTORE) ;",stdout) ;
				fputs("}",stdout) ;
			 }
		}
		else ECHO ;
		if ( trace ) fputs(" } ",stdout);
	       }
	       else { yyless( 6 ) ; printf("%s",yytext); }
	      }




/*KOM   Muster zur init- und bind-Erkennung.
/*KOM   Der Kommentar beschraenkt sich auf init.
/*KOM   Analoges gilt aber fuer bind, ausser dass ibindex anders ist und
/*KOM   im Benutzerprogramm die Vorbesetzung mit 0 fehlt.
/*KOM   Hier werden nur moeglicherweise korrekte init abgefangen. Alle
/*KOM   anderen Formen von init muessen fehlerhaft sein und werden weiter
/*KOM   unten abgefangen, d.h. man muss natuerlich Praefixe und Sufixe
/*KOM   gesondert behandeln und zu falschen inits unterscheiden.

/*KOM   Ein korrektes init hat die Form: init(.....); oder init3(...);
/*KOM   So wird hier der gesamte Teil des init innerhalb der aeusseren
/*KOM   runden Klammern abgekapselt ( in bistr[] ) und an das Unterprogramm
/*KOM   up() uebergeben.

{INITBIND}{SE};    {
		if ( !hks && !kos ) {
		int neuind ;
		int i = yyleng - 2 ;
		int ende ;
		int anfang;
		int j = 0 ;
		char bistr[200] ;

/*KOM   ibindex ist init-bind-index. Er gibt nur an, ob man ein init oder
/*KOM   bind behandelt.
/*KOM   init => ibindex == 1 .
/*KOM   bind => ibindex == 2 .

		ibindex = 1 ;
		if ( yytext[0] == 'b' ) ibindex++;

/*KOM   Abkapselung des Parameterteils eines init:
/*KOM   Position der 1. '(' im yytext wird in der Variable anfang gespeichert.
/*KOM   Position der letzten ')' wird in der Variable ende gespeichert.
/*KOM   Der Teil zwischen diesen Klammern wird in bistr[] geschrieben.

		while ( yytext[i] != ')' ) --i ;
		ende = i ;
		i = 0 ;

		while ( yytext[i] !='(' ) ++i ;
		anfang = i ;
		++i ;
		while( i > anfang && i < ende ) {
			bistr[j] = yytext[i] ,
			++i ;
			++j ;
		}
		bistr[j] = '\0' ;

/*KOM   Aufruf des Unterprogramms up() mit dem bind-init-string bistr[] als
/*KOM   Parameter. up() wird unter Benutzerfunktionen aufgefuehrt.
/*KOM   Der Rueckgabewert des up() wird an neuind uebergeben.

		neuind = up(bistr) ;

/*KOM   neuind == 0: einfaches init, d.h. ohne Feldinit.
/*KOM   neuind == 1: Feldinit vorhanden, evtl. auch einfache init.
/*KOM   neuind == 2: syntaktischer Fehler aufgetaucht.

/*KOM   In der switch-Anweisung wird neuind verwertet. Im Fall 0 ist alles
/*KOM   einfach. Im Fall 1 wird nur fis behandelt, und zwar wird fis erhoeht,
/*KOM   wenn in dem Block, in dem dieses init auftaucht, bisher kein
/*KOM   Feldinit war, d.h. fi[klz] noch 0 ist. Sollte fi[klz]==1 sein, so
/*KOM   wird nichts weiter getan. Im Fall 2 wurde ein inkorrektes init
/*KOM   im Benutzerprogramm erkannt, und es wird Fehlermeldung auf die
/*KOM   Standardeingabe ausgegeben.

		switch(neuind) {
			case 0 : break ;
			case 1 : if(!fi[klz]) { ++fis ; fi[klz]=1; }; break ;
			case 2 :
				fprintf(stderr,"\nSM-pre : \n") ;
				fprintf(stderr,"%u : [syntax] : ",lfz+1) ;
				fprintf(stderr,"incorrect ") ;
				fprintf(stderr,"< %s - parameter >\n",
					(yytext[0] == 'b') ? "bind" : "init") ;
				exit(1);
		}
		}
		else ECHO ;
	  }




/*KOM   Erkennung von Pointer auf Funktionen als Uebergabeparameter.
/*KOM   Da diese zwischen Funktionsdefinition und Blockeintritt stehen
/*KOM   koennen, muessen sie extra behandelt werden, da sie den Funktionstyp
/*KOM   verfaelschen, d.h. die Variable RESTORE erhaelt sonst den Typ des
/*KOM   Pointers auf die Uebergabefunktion.
/*KOM
/*KOM   up(fkt1,fkt2)
/*KOM   int (*fkt1)(),(*fkt2)();
/*KOM   {
/*KOM    :
/*KOM    :
/*KOM   }
/*KOM
/*KOM  Da eine Funktionsdefinition nie die Form
/*KOM           int (*fkt) ()
/*KOM   haben kann, werden diese einfach ueberlesen.
/*KOM   Dies muss vor der Funktionsdefinitions-Erkennung geschehen.

{FUPOINT} if ( !kos && !hks ) ECHO ;





/*KOM   Muster zur Funktionsdefinitionserkennung vom Typ 2:
/*KOM   <Futyp><Sep><Funame>(<Paralist>) , also z.B. int  fac( ... )
/*KOM   Die Fu.def. wird nur bis zur '(' nach <Funame> erkannt.
/*KOM   Man braucht diese zur Erkennung des Funktionstyps. Der wird in
/*KOM   futyp[] gemerkt und bei Bedarf in der return-Behandlung eingesetzt,
/*KOM   naemlich zur Typgebung von RESTORE. Diese Systemvariable hat dann
/*KOM   in jeder Funktion deren Typ, um die Parameterliste von return auch
/*KOM   korrekt zu verwalten ( siehe return mit Parameter! ).
/*KOM   Wichtig ist, dass auch '*', falls vorhanden, abgekapselt werden.
/*KOM   Insgesamt wird der ganze Teil vor dem Funktionsnamen ausser Klammern
/*KOM   uebergeben.
/*KOM   Genauere Struktur der Funktionsdefinitionen in Syntax-Graphen.
/*KOM   Beachten sollte man auch, dass an bestimmten Stellen '*','(',')'
/*KOM   erlaubt sind.

{FUDEF2}     {
		if ( !hks && !kos ) {

/*KOM   Funktionsdefinitionen duerfen nur ausserhalb von Unterprogrammen
/*KOM   stehen. Da dort klz==0 ist, wird hier nur dann etwas ausgefuehrt.

		if(!klz )
		   {
		    int i=0 , j=0 ;

/*KOM   Zuerst wird alles bis zum ersten Separator uebergeben. Da im Muster
/*KOM   eine '(' angegeben ist, terminiert diese while-Schleife sicherlich.

	while(yytext[i]!=' ' && yytext[i]!='\t' && yytext[i]!='\n' && yytext[i]!='*' && yytext[i]!='(' )
			{
			 futyp[j++]=yytext[i++] ;
			 }

/*KOM   Hier werden Blanks oder evtl. vorhandene '*' gelesen.

	while(yytext[i]==' ' || yytext[i]=='\t' || yytext[i]=='\n' || yytext[i]=='*' || yytext[i]=='(' )
			{
		 	if ( yytext[i]!='(' ) { futyp[j]=yytext[i] ; j++ ; }
			 i++ ;
			 }
		    futyp[j] = '\0' ;
		    }
		  else {
			int i = 1 ;
			while ( isalnum(yytext[i]) || yytext[i]=='_' ) ++i ;
			yyless(i);
		  }
		 }
		 ECHO ;
		}



/*KOM   Muster zur Funktionsdefinition mit unsigned.
/*KOM   Hier kann der Funktionstyp evtl. aus mehreren Woertern, durch
/*KOM   Separator getrennt, bestehen. Deshalb muss dieser Typ gesondert
/*KOM   aufgefuehrt werden. Ausnahme ist die Form: unsigned up(..)
/*KOM   Dieser Typ ist vom Funktionstyp 2 und wird schon vorher korrekt
/*KOM   erfasst. futyp erhaelt dann den string "unsigned ".
/*KOM   Fuer Moeglichkeiten zu unsigned siehe Syntax-Graph.

{UNSIGNEDDEF} {
	if ( !hks && !kos && !klz ) {
		int i = 8 ;
		int uend = 0 ;
		int z = 0 ;

/*KOM   i gibt an, wieviele Komponenten von yytext an futyp uebergeben werden,
/*KOM   d.h. man will strncpy(futyp,yytext,i) ausfuehren.
/*KOM   i erhaelt gleich Wert 8, da in der 0. bis 7. Komponente von yytext
/*KOM   "unsigned" steht. Nachfolgende Blanks werden dann ueberlesen.
/*KOM   Jetzt gibt es vier Moeglichkeiten fuer das folgende Wort, die man
/*KOM   mit einem Lookahead von einem Buchstaben unterscheiden kann ( ein
/*KOM   Fu.name kann nicht folgen, da der Fall schon bei Fudef2 erkannt wird).
/*KOM   1) "char", evtl gefolgt von '*' , dann der Fu.name.
/*KOM   2) "int" , analog.
/*KOM   3) "long" , evtl. gefolgt von char, int, '*' und dann Fu.name.
/*KOM   4) "short" , analog.
/*KOM   In den ersten beiden Faellen hat man den Namen des Fu.typs schon
/*KOM   gegeben, und braucht nur noch nach '*' ueberprueft zu werden.
/*KOM   uend wird auf 1 gesetzt und dies besagt, dass man den Namen schon hat.
/*KOM   uend ==0 => es folgt noch ein Ausdruck.
/*KOM   In den Faellen 3),4) kann noch etwas folgen.

		while( yytext[i]==' ' ) ++i ;
		switch(yytext[i]) {
			case 'c' : i+=4 ; uend = 1 ; break ;
			case 'i' : i+=3 ; uend = 1 ; break ;
			case 'l' : i+=4 ; break ;
			case 's' : i+=5 ; break ;
		}

		if(!uend){
		while( yytext[i]==' ' ) ++i ;
		if(yytext[i]=='i' && yytext[i+1]=='n' && yytext[i+2]=='t' )
			i+=3 ;
		}

/*KOM   Hier wird strncpy ausgefuehrt, wobei bis zum index i alles von
/*KOM   yytext auf futyp kopiert wird. i ist korrekt, da er nur in yytext
/*KOM   weitergezaehlt wurde.

		strncpy(futyp,yytext,i) ;

/*KOM   Zum Schluss wird noch geprueft, ob '*' auftauchen und falls noetig
/*KOM   an futyp angehaengt.

		futyp[i] = ' ' ;
		futyp[i+1] = '\0' ;

	while(yytext[i]==' ' || yytext[i]=='\t' || yytext[i]=='\n' || yytext[i]=='*' || yytext[i]=='(' ){
			if ( yytext[i]=='*' ) ++z ;
			++i ;
		}


		while ( z > 0 ) {
			strcat(futyp,"*");
			--z ;
		}

	}
	ECHO ;
		    }


/*KOM   Muster zur Funktionsdefinitionserkennung vom Typ 1:
/*KOM   <Funame>(<Parameterliste>)   , also z.B.  fac  ( ... )
/*KOM   mit evtl. vorangehenden '*'.
/*KOM   Diese Funktionen haben natuerlich den Typ "int" ( evtl. mit einigen
/*KOM   '*' ).

{FUDEF1}      {
		if ( !hks && !kos ) {
		if(!klz )
		  {
		   int i = 0 , j = 4 ;

/*KOM   Vorbesetzung des futyp mit "int" und einem  Blank als Separator.
/*KOM   Deshalb wird j gleich auf 4 gesetzt.

		   futyp[0] = 'i' ;
		   futyp[1] = 'n' ;
		   futyp[2] = 't' ;
		   futyp[3] = ' ' ;

/*KOM   Nachfolgend wird getestet, ob evtl. '*'e vor dem Funktionsnamen und
/*KOM   dementsprechend werden sie dann an futyp angehaengt.

	while ( yytext[i]=='(' || yytext[i]==' ' || yytext[i]=='\t' || yytext[i]=='\n' || yytext[i]=='*' )
		       {
			if ( yytext[i] == '*' ) futyp[j++] = yytext[i] ;
			i++ ;
			}
		   futyp[j] = '\0' ;
		  }
		}
		ECHO ;
	       }

/*KOM   init oder bind koennen auch als Praefixe oder Suffixe von Variablen-
/*KOM   oder Funktionsnamen oder Sonstigem vorkommen. Hier wird gesichert,
/*KOM   dass solche Vorkommen nicht als das spezielle init ( bind )
/*KOM   erkannt und behandelt, sondern nur ueberlesen werden.

{iden}(init|bind)  ECHO ;

(init|bind){iden} ECHO ;

/*KOM   Sollte init oder bind nicht vorher als Muster, Praefix oder Suffix
/*KOM   erkannt worden sein und hier erst zutreffen, muss ein syntaktischer
/*KOM   Fehler vorliegen.

(init|bind) {
	if ( !kos && !hks ) {
		fprintf(stderr,"\nSM-pre : \n");
		fprintf(stderr,"%u : [syntax] : ",lfz+1);
		fprintf(stderr,"incorrect < %s > \n",
			(yytext[0] == 'b') ? "bind" : "init") ;
		exit(1) ;
	}
	else ECHO ;
     }



/*KOM   Ende des Regelteils !

%%


/*KOM   ALLGEMEINE AUSSAGEN ueber init ( bind ):
/*KOM   EINFACHE init haben die Form ( analog bind ) : init( a,c,v,f);    usw.
/*KOM   Dabei ist erlaubt, auf fruehere Versionen von Simath zurueckgehend :
/*KOM   z.B.    init3(a,b,c);  aber hoechstens bis init6(a,b,c,d,e,f);
/*KOM   FELDinit haben die folgende Struktur ( analog FELDbind) :
/*KOM           init( a[2..19] );               eindimensional mit Konstanten
/*KOM           init( s[2..4][3..6] );          zweidim. mit Konst.
/*KOM           init( a[w..7][e..u][d..15]);    mehrdimensional
/*KOM   auch    init( s,f , r[e..f] , t,w[2..6]);
/*KOM   Erlaubt sind alle Kombinationen von einfachen und Feldinit durch ','
/*KOM   voneinander getrennt. Man darf in Feldinit mehrere Dimensionen
/*KOM   verwenden und die Grenzen variabel lassen, aber (!) verboten sind
/*KOM   Ausdruecke als Feldgrenzen in Initialisierungen Es besteht weiter die
/*KOM   Moeglichkeit in einem mehrdimensionalen Feld nur eine Dimension zu
/*KOM   behandeln, z.B. :
/*KOM   Sei a[][] zweidimensionales Feld. Will man jetzt a[3][1] bis a[3][15]
/*KOM   sichern, so schreibt man    init( a[3][1..15]);
/*KOM   Dies kann man natuerlich auch mit variablen Grenzen machen.

/*KOM   GLOBALER ZAEHLER glz und LOKALER ZAEHLER lz[] :
/*KOM   Der glz zaehlt alle Variablen in einfachen init oder bind im gesamten
/*KOM   Unterprogramm, d.h. taucht ein Feldinit auf, so wird er eingefroren,
/*KOM   und sobald der Block beendet ist, in dem das Feldinit war, wird er
/*KOM   weitergefuehrt. Bei gaschachtelten Bloecken mit Feldinit wird er beim
/*KOM   ersten auftreten gestoppt und bei Beendigung des aeusseren Blocks
/*KOM   erst wieder animiert. Der lokale Zaehler ist als Feld mit Block-
/*KOM   schachtelungstiefe klz angelegt, und addiert nur die Variablen in
/*KOM   einfachen init in einem Block auf. Er gibt dabei an, ob in einem Block
/*KOM   einfache init vorhanden oder nicht. Auch der lokale Zaehler wird
/*KOM   gestoppt, sobald in diesem Block ein Feldinit auftritt. Er wird aber
/*KOM   wieder in Kraft gesetzt, wenn in Bloecken hoeherer Blockschachtelungs-
/*KOM   tiefe ein einfaches init auftaucht.
/*KOM   Deshalb ist fi[] sehr wichtig, der als Feld angelegt ist und anzeigt,
/*KOM   ob ein Feldinit in diesem Block ist oder nicht. Dies ist am Blockende,
/*KOM   also bei '}' bedeutsam.
/*KOM   Dieses allgemeine Schema bildet die Grundlage der init-bind-Behandlung.

		/*KOM Benutzerfunktionen.
/*KOM   Hier treten Funktionen auf, die die Behandlung von init und bind
/*KOM   erleichtern sollen ( Modularisierung ). Es werden zwei Richtungen
/*KOM   verfolgt, und zwar ob mit oder ohne Feldinitialisierungen.
/*KOM   einfache init => das jeweilige UP liefert 0.
/*KOM   Feldinit  => man erhaelt 1 zurueck.
/*KOM   Fehler => 2.
/*KOM   Die allgemeine Modulstruktur sieht dann folgendermassen aus :
/*KOM                                               2
/*KOM                   init-bind-Erkennung  -------------- >  exit
/*KOM                           |
/*KOM                          up
/*KOM                       0/     \1
/*KOM                    up1         up2
/*KOM                    /         0/   \1
/*KOM               vonly         vup2   fup2

/*KOM   up wird im Aktionsteil der init-bind-Erkennung aufgerufen und fuehrt
/*KOM   den wesentlichen Teil der Initialisierungen und des Bindens aus,
/*KOM   mithilfe von Untermodulen. Dabei liefert up() die Werte 0, 1, 2 zurueck
/*KOM   je nachdem, ob einfaches init, Feldinit vorhanden oder Fehler.
/*KOM   Die Methode ist, dass man einfach den gesamten Parameterteil
/*KOM   zwischen der ersten '(' und der letzten ')' an up uebergibt
/*KOM   und dort weiterbehandelt unter dem Namen str[].
/*KOM   In up wird eine Grobunterscheidung gemacht, indem nach der Kombination
/*KOM   ".." ( mit beliebig Blanks ) abgefragt wird, d.h. wenn dies auftaucht,
/*KOM   kann es sich nur um ein Feldinit oder um einen Fehler handeln, wenn
/*KOM   nicht liegen nur einfache init oder Fehler vor.

/*KOM           *****  Beginn up *****

up(str)
char *str;
{
int j ;
int k = 0 ;
int n = 0 ;

/*KOM   Abfrage, ob die Kombination ".." auftaucht.
/*KOM   n ist dabei der Unterscheidungsindex, mit 0 vorbesetzt.
/*KOM   n bleibt 0, wenn ".." ( evtl. mit Blanks ) nicht vorhanden.
/*KOM   n erhaelt den Wert 1, wenn ".." vorhanden.

while( str[k]!='\0' ) {
	if ( str[k]=='.' ){
		++k ;
		while( str[k]==' ') ++k ;
		if( str[k]=='.' ) { n = 1;break;}
	}
	++k ;
}


/*KOM   Hier ist die Schnittstelle zu up1 oder up2. Der Rueckgabewert wird
/*KOM   in beiden Faellen in j gespeichert und an up zurueckgegeben.
/*KOM   Es wird wiederum der ganze string weitergegeben und dann "unten"
/*KOM   behandelt.

switch(n) {
	case 0 :   j = up1(str) ; break ;
	case 1 :   j = up2(str) ; break ;
}


return(j) ;

}

/*KOM           *****  Ende up *****





/*KOM   Beim Eintreten in up1 ist klar, dass man es hoechstens mit einfachen
/*KOM   init zu tun hat, evtl. auch mit einem Fehler. Die Parameterliste ist
/*KOM   an string s[] gegeben.

/*KOM           ***** Beginn up1 *****

up1(s)
char *s ;
{

/*KOM   ind ist hier der Unterscheidungsindex, natuerlich mit 0 vorbesetzt.
/*KOM   vaz ist der Variablenzaehler.
/*KOM   In tst[] werden die einzelnen, abgespaltenen Variablen geschrieben.
/*KOM   Da auch geklammerte Variablen zugelassen sind, z.B. Feldkomponenten,
/*KOM   braucht man zum Syntaxtest einen Klammerzaehler, wobei man runde
/*KOM   Klammern '(',')' und eckige KL. '[',']' zusammen behandeln kann.
/*KOM   Die Klammern zaehlt man fuer jede Variable. Ist der Klammerindex nach
/*KOM   Abarbeitung einer Variablen nicht auf Null, liegt ein Fehler vor. So
/*KOM   braucht man ihn auch nicht immer wieder neu vorzubesetzen.


int i = 0 ;
int l ;
int ind = 0 ;
int vkl = 0 ;
int vaz = 0 ;
char tst[200] ;

/*KOM   Zaehlen der Variablen, zusammen mit einem Syntax-check.

while( s[i]!='\0' ){

/*KOM   Ist das auf '(' oder ',' folgende Zeichen '\0' oder ',' => Fehler.
         
        while( s[i]==' ' ) ++i;
	if( s[i]==',' || s[i]=='\0' ) return(2) ;

/*KOM   Ende einer Variablen ist bei ',' oder Stringendezeichen '\0'.

	while( s[i] !=',' && s[i]!='\0' ){
		if( s[i]=='(' || s[i]=='[' ) ++vkl ;
		if( s[i]==')' || s[i]==']' ) --vkl ;
	++i ;
	}

/*KOM   vkl == 0  => Syntax in Ordnung ( soweit vom Praeprozessor erfassbar )
/*KOM   Ansonsten Fehler.

	if ( vkl!=0 ) return(2) ;

/*KOM   Hochzaehlen des Variablenzaehlers.

	++vaz ;

/*KOM   Ueberlesen des Kommas, falls man nicht schon am Ende ist.

	if ( s[i]==',' ) {
		++i ;
                if( s[i]=='\0' ) return(2);
	}	
}
/*KOM   Ende der aeusseren while-Schleife und damit des Syntax-checks.

/*KOM   fi[klz] == 0 => man ist in einem Block, in dem noch kein Feldinit war.
/*KOM   In vaz steht die Anzahl der Variablen des init und der lz[], der bei
/*KOM   Blockeintritt mit 0 vorbesetzt wurde, wird um vaz erhoeht.
/*KOM   fis == 0  => Auch in einem hoeheren Block wurde kein Feldinit verwand,
/*KOM   d.h. der glz wurde nicht eingefroren, und er wird um vaz erhoeht.

if ( !fi[klz] ) {
	lz[klz]+=vaz ;
	if ( !fis ) glz+=vaz ;
}

/*KOM   Zuerst muss die folgende if-Anweisung ins Benutzerprogramm geschrieben
/*KOM   werden, um abzufragen, ob der ST_INDEX nicht zu gross ist, d.h. ob
/*KOM   noch Platz genug im STACK ist, um diese Variablen zu sichern.
/*KOM   ST_SIZE gibt die Groesse des STACK an und ST_INDEX wieviel schon drin
/*KOM   ist. Ist ST_INDEX + Anzahl der neuen Variablen (==vaz) >= ST_SIZE ,
/*KOM   muss der STACK vergroessert werden. Dies geschieht mit der Funktion
/*KOM   setstack(n), wobei der STACK dann die Groesse n hat.

printf("if(ST_SIZE<=ST_INDEX+%u) setstack(ST_SIZE+125);",vaz);

/*KOM   Dann erst koennen die Variablen einzeln gesichert werden.
/*KOM   Hier wird eine Hilfsfunktion verwendet vonly(), die die eigentliche
/*KOM   Initialisierung uebertraegt.
/*KOM   Die einzelnen Variablen werden abgekapselt und an vonly uebergeben.
/*KOM   Blanks werden dabei weggeworfen.

i = 0 ;
while(s[i]!='\0' ) {
	l=0;
	while(s[i]!=',' && s[i]!='\0'){
		if(s[i]!=' ') { tst[l]=s[i] ;++l;}
		++i;
	}
	tst[l]='\0';


	vonly(tst) ;

	if( s[i]!='\0' ) ++i ;
}

/*KOM   Wird diese Programmstelle erreicht, ist die Syntax, soweit erkennbar
/*KOM   korrekt.

return(0) ;

}

/*KOM                   ***** Ende up1 *****






/*KOM   vonly dient nur zum Uebertragen der Initialisierung einer Variablen
/*KOM   in das Benutzerprogramm.
/*KOM   Hier muss unterschieden werden zwischen init und bind :
/*KOM   ibindex == 1 => init
/*KOM   ibindex == 2 => bind
/*KOM   init(var);  ist nur abkuerzende Schreibweise fuer :

/*KOM   *(STACK+ST_INDEX++)= &var;var=0;

/*KOM   und bind(var); fuer :

/*KOM   *(STACK+ST_INDEX++)= &var;

/*KOM   Bei init ist zusaetzlich also noch eine Vorbesetzung mit 0.


/*KOM                   *****  Beginn vonly *****

vonly(v)
char *v ;
{

printf("*(STACK+ST_INDEX++)= &%s;",v);

if( ibindex==1 ) printf("%s=0;",v) ;

}

/*KOM           ***** Ende vonly *****



/*KOM   Es folgen drei globale Variablen, die nur zur Behandlung des Feldinit
/*KOM   eine Rolle spielen, und deshalb erst hier eingefuehrt werden.
/*KOM   inva zaehlt einfache init-Variablen in Feldinit, falls vorhanden.
/*KOM   In outs[] wird der gesamte Initialisierungsterm fuer die Ausgabe
/*KOM   aus technischen Gruenden zwischengespeichert, einschliesslich den
/*KOM   Termen fuer einfache init-Variablen.
/*KOM   In fva[] wird der Term zur Ueberpruefung des ST_SIZE gemerkt.

int inva;
char outs[10000] ;
char fva[1000] ;


/*KOM   Abarbeitung eines Feldinit, d.h. eines init der Form :
/*KOM           init(V,X,H,a[U1..O1][Un..On],B,d[3..o],f);
/*KOM   Schwierigkeiten bereitet besonders die Abfrage nach ST_SIZE.
/*KOM   Fuer einfache Variablen wurde deshalb der Zaehler inva eingefuehrt,
/*KOM   der alle in einem init vorkommenden einfachen Variablen zaehlt.
/*KOM   Will man nun die Felder behandeln ist folgendes zu beachten :
/*KOM   Ein Feld der Form
/*KOM           a[U1..O1]....[Un..On]
/*KOM   hat die Groesse
/*KOM   Gr(a) == ( O1-U1+1 ) * ( O2-U2+1 ) *....* ( On-Un+1)     .
/*KOM   So berechnet man auch hier die Groesse des Platzbedarfs, indem man
/*KOM   die angegebenen Grenzen als strings dieser Form an fva[] uebergibt.
/*KOM   In fva werden solche strings aneinandergehaengt, natuerlich mit
/*KOM   '+' davor, ausser beim ersten Feld.
/*KOM   Sind m Felder A1-Am in einem init und k Variablen, so steht in fva :
/*KOM           Gr(A1)+Gr(A2)+....+Gr(Am)+( Anzahl von inva )
/*KOM   wobei Gr(Ai) obige Terme bedeutet, und Anzahl von inva einfach die
/*KOM   integer-Zahl in inva ist. Diese wird nur angehaengt, wenn sie von
/*KOM   Null verschieden ist.
/*KOM   Die ins Benutzerprogramm zu schreibende ST_SIZE-Ueberpruefung hat dann
/*KOM   das Aussehen :

/*KOM   if( ST_INDEX+fva[]>=ST_SIZE ) setstack(ST_SIZE+((fva[])/125+1)*125);

/*KOM   Um den STACK sinnvoll zu verwalten bei Feldinit, wird beim ersten
/*KOM   Auftreten eines solchen in einem neuen Block jeweils ein neuer Block
/*KOM   kreiert, d.h. '{' ins Benutzerprogramm geschrieben. Dann wird der
/*KOM   ST_INDEX in einer neuen Variablen gemerkt. Diese hat den Namen
/*KOM   ____J_GLZY_Z . Treten in einem Unterblock wieder ein oder mehrere
/*KOM   Feldinit auf, so erhaelt die Variable im Unterblock den Namen
/*KOM   ____J_JXVY_Z . Dies ist bedeutsam fuer die return-Behandlung, weil das
/*KOM   gesamte UP verlassen wird. Ist bei return vorher ein Feldinit gewesen,
/*KOM   so erhaelt der ST_INDEX zuerst den Wert von ____J_GLZY_Z , also den
/*KOM   Wert vor Eintritt in den aeussersten kreierten Feldinit-Block.
/*KOM   Dann wird der STACK um den Wert des glz erniedrigt.
/*KOM   Ein kuenstlich erzeugter Feldinit-Block hat dann die Form :
/*KOM   {int ____J_GLZY_Z=ST_INDEX;
/*KOM    ST_SIZE-Test; ( siehe oben )
/*KOM    Initialisierungsblock;         ( weiter unten exakt beschrieben )
/*KOM    .
/*KOM    .
/*KOM    .
/*KOM    ST_INDEX=____J_GLZY_Z;}

/*KOM   Im Falle, dass der Block tiefer liegt, steht dann anstelle von
/*KOM   ____J_GLZY_Z die Variable ____J_JVXY_Z .
/*KOM   Der gesamte Initialisierungsblock wird in outs[] geschrieben.
/*KOM   Dies geschieht jeweils in den UP vup2 und fup2.



/*KOM   Bei Eintritt in up2 ist klar, dass mindestens eine Variable in init
/*KOM   eine Feldinit-Variable ist. Wenn nur eine Variable vorhanden,
/*KOM   so kann es sich nur um Feldinit handeln, falls kein Fehler vorliegt.
/*KOM   Bei mehreren Variablen wird wieder explizit unterschieden, d.h. jede
/*KOM   Variable ueberprueft.

/*KOM           ***** Beginn up2 *****

up2(s)
char *s ;
{
/*KOM   An tst[] wird die jeweils abgekapselte Variable uebergeben.

char tst[200];
int j,l;
int i = 0 ;
int vkl = 0 ;
char hilfst[50] ;
int vind ;


/*KOM   Vorbesetzung der globalen Variablen outs[], fva, inva.

outs[0] = '\0' ;
fva[0] = '\0'  ;
inva = 0 ;


/*KOM   Aeussere while-Schleife ueber den ganzen string s.


while(s[i]!='\0' ) {
	l=0;

/*KOM   Variablenabkapselung bis Komma oder stringendezeichen.
/*KOM   Blanks werden weggeworfen.

	while(s[i]!=',' && s[i]!='\0'){
		if(s[i]!=' ') { tst[l]=s[i] ;++l;}
		++i;
	}
	tst[l]='\0';

/*KOM   Nun steht in tst entweder eine Variable , z.B. 'a' oder "zaehler" ,
/*KOM   oder eine Feldinit-Variable , z.B. "duck[3..9][4..65]" .
/*KOM   Es kann auch ein inkorrekter Ausdruck sein ( hoffentlich nicht ) .


/*KOM   Es folgt ein Syntaxcheck mit Variablenunterscheidung .
/*KOM   Falls die Kombination ".." auftaucht , liegt Feldinit-Variable vor,
/*KOM   natuerlich wenn kein Fehler zu finden ist.
/*KOM   vkl ist der Klammerzaehler fuer runde und eckige Klammern gemeinsam.
/*KOM   Ist dieser bei Ende der Ueberpruefung nicht 0, liegt Fehler vor.
/*KOM   vind ist hier Index, der fuer jede Variable angibt, ob Feldinit oder
/*KOM   einfaches init. Er wird vorbesetzt mit 0 und bei moeglicher Feldinit-
/*KOM   Variable auf 1 gesetzt.
/*KOM   Beachte : vind wird fuer jede Variable neu berechnet.

	if ( tst[0] ==',' || tst[0] =='\0' ) return(2);
	vind = 0 ;
	l = 0 ;
	while( tst[l] != '\0' ) {
		if ( tst[l]=='(' || tst[l]=='[' ) ++vkl ;
		if ( tst[l]==')' ||tst[l]==']' ) --vkl ;
		if ( tst[l]=='.' && tst[l+1]=='.') vind = 1 ;
		++l;
		}
	if ( vkl!=0 ) return(2) ;

/*KOM   Hier ist die Schnittstelle zu den UP, und zwar wird vup2 fuer nur
/*KOM   Variable also einfache init-Variable aufgerufen und fup2 fuer
/*KOM   ( moegliche ) Feldinit-Variable.

	switch(vind) {
		case 0 : vup2(tst)   ;   break ;
		case 1 : if( fva[0]!='\0' ) strcat(fva,"+") ;
			 vind = fup2(tst) ; break ;
		case 2 : break ;
	}


/*KOM   Liefert fup2 den Wert 2 zurueck, liegt Fehler vor.

	if ( vind == 2 ) return( 2 ) ;

        if ( s[i]==',' ) {
		++i ;
                if( s[i]=='\0' ) return(2);
	}


}

/*KOM   Ende der aeusseren while-Schleife.

/*KOM   An dieser Stelle hat man bei Korrektheit alle Variablen bearbeitet
/*KOM   und kann die Ausgabe durchfuehren.
/*KOM   In Abhaengigkeit von fi[] und fis wird der ST_INDEX in einer der
/*KOM   Variablen gemerkt.
/*KOM   fi[klz]==0 und fis == 0 bedeutet : in diesem Block ist bisher kein
/*KOM   Feldinit aufgetaucht, und es ist das erste ( aeussere ) Auftreten.
/*KOM   fi[klz]==0 und fis>0 bedeutet : in diesem Block ist noch kein Feldinit
/*KOM   aufgetreten, und in einem aeusseren Block war schon eines.

if ( !fi[klz] && fis == 0 ) fputs("{int ____J_GLZY_Z=ST_INDEX;",stdout);
if ( !fi[klz] && fis > 0 ) fputs("{int ____J_JXVY_Z=ST_INDEX;",stdout);

/*KOM   Jetzt wird noch fva[] vollstaendig aufgefuellt. In fup2 wird nur die
/*KOM   Feldgroesse einer Feldvariablen in string-Form anfva[] uebergeben.
/*KOM   Falls inva > 0 ist, wird noch der Wert von inva an fva[] angehaengt,
/*KOM   mithilfe des Hilfsstrings hilfst[].

if( inva ) {
	sprintf(hilfst,"+%u",inva);
	strcat(fva,hilfst);
}

/*KOM   Da man fva[] nun korrekt hat, d.h. die Anzahl der zu bindenden Var.,
/*KOM   kann man die ST_SIZE-Abfrage ins Benutzerprogramm uebertragen.

printf("if(ST_SIZE<=ST_INDEX+(%s)) setstack(ST_SIZE+((%s)/125+1)*125);",fva,fva);

/*KOM   Dann wird der gesamte Initialisierungsblock ausgegeben.

printf("%s",outs);


return(1) ;

}


/*KOM           ***** Ende up2 *****






/*KOM   vup2 ist aehnlich zu vonly. Es wird eine Variable uebergeben in *ts
/*KOM   und abgearbeitet. Hier wird die Initialisierung nicht direkt ins
/*KOM   Benutzerprogramm geschrieben, sondern in outs[] zwischengelagert.
/*KOM   Dabei wird inva hochgezaehlt.
/*KOM   Die Ausfuehrung wurde in vonly schon notiert. Hier ist dies analog.


/*KOM           ***** Begin vup2  *****

vup2(ts)
char *ts ;
{


++inva ;

strcat(outs,"*(STACK+ST_INDEX++)= &");

strcat(outs,ts);

strcat(outs,";");

if( ibindex==1 ) {
	strcat(outs,ts);
	strcat(outs,"=0;");
}


/*KOM strcat ist die Konkatenation von strings .


}

/*KOM           ***** Ende vup2 *****





/*KOM   An fup2 wird eine Feldinit-Variable uebergeben und in *fs gemerkt.
/*KOM   Dir Initialisierungsblock fuer eine Feldinit-Variable
/*KOM           Fname[U1..O1][U2..O2]....[Um..Om]
/*KOM   hat die Form :
/*KOM   {int lauf1;int lauf2;.....;int laufm;
/*KOM           for(lauf1=U1;lauf1<=O1;lauf1++)
/*KOM           for(lauf2=U2;lauf2<=O2;lauf2++)
/*KOM                   .
/*KOM                   .
/*KOM           for(laufm=Um;laufm<=Om;laufm++)
/*KOM                   {
/*KOM                           *(STACK+ST_INDEX++)= &Fname[lauf1]...[laufm];
/*KOM                           Fname[lauf1]..[laufm]=0;
/*KOM                   }
/*KOM   }

/*KOM   Der Term
/*KOM            Fname[lauf1]..[laufm]=0;
/*KOM   entfaellt natuerlich, wenn man in einem bind ist.


/*KOM           ***** Beginn fup2 *****

fup2(fs)
char *fs ;
{

/*KOM   dim ist der Dimensionszaehler.
/*KOM   IN o[] wird der Term fuer die obere Grenze in jeder Dimension kopiert.
/*KOM   Analog in u[] die untere Grenze.
/*KOM   In funa[] wird der Funktionsname gemerkt.
/*KOM   fh[], hilf[], save[] sind Hilfstrings.

int dim = 0 ;
char o[200] ;
char u[200] ;
int i = 0 ;
char funa[200] ;
char fh[200] ;
char hilf[2000] ;
int j ;
int sch ;
char save[50] ;


funa[0] = '\0' ;
hilf[0] = '\0' ;
save[0] = '\0' ;

/*KOM   Syntaxueberpruefung der Feldvariablen.
/*KOM   Folgende Kriterien sind massgebend:
/*KOM   1) Der Funktionsnamen darf nur aus alphanumerischen Zeichen oder
/*KOM      Underscore bestehen, d.h. Underscore, Buchstaben oder Ziffern.
/*KOM   2) Als obere und untere Grenzen wie bei Funktionsnamen, und auf
/*KOM      jeden Fall keine '[' , ']' .
/*KOM   3) Nach dem Funktionsnamen muss '[' folgen ( Blanks schon weggesiebt ).
/*KOM   4) Es besteht die Moeglichkeit, Komponenten festzuhalten, d.h.
/*KOM      erlaubt ist : c[5][3..n] .
/*KOM      Dies entspricht : c[5..5][3..n] .
/*KOM      Der Praeprozessor blaeht dies deshalb auf die Art kuenstlich auf.

if ( !isalpha( fs[i] ) && fs[i]!='_' ) return(2) ;

++i ;

/*KOM   Zuerst wird der Funktionsname abgekapselt und auf funa[] kopiert.

while( i<strlen(fs) && (isalnum(fs[i]) || fs[i]=='_' || fs[i]=='.' ) ) ++i ;

if( i == strlen(fs) || fs[i]!='[' ) return(2) ;
else  { strncpy(funa,fs,i) ; funa[i] = '\0' ; }

/*KOM   Die aeussere while-Schleife wird bei einer neuen Dimension wiederholt.
/*KOM   Die einzelnen Dimensionskomponenten werden behandelt.

while( i < strlen(fs) ) {

	if( fs[i] =='[' ) {  ++dim ; ++i ; }
	else return(2) ;

	j = 0 ;

	while((isalnum(fs[i]) || fs[i]=='_' ) && i < strlen(fs) ) {
		u[j] = fs[i] ;
		++i ; ++j ;
	}
	if ( i==strlen(fs) ) return(2) ;
	u[j] = '\0' ;

	if( u[0] =='\0' ) return(2) ;

/*KOM   sch dient zur Unterscheidung, ob Bereichskomponente oder festgehaltene
/*KOM   Komponente vorliegt, d.h. wenn ']' folgt, wird sch auf 1 gesetzt und
/*KOM   die Aufblaehung durchgefuehrt, indem o=u gesetzt wird.

	sch = 0 ;

	if ( fs[i] =='.' && fs[i+1] =='.' ) i+=2 ;
	else if ( fs[i]==']' ) sch = 1 ;
	else return(2) ;

	if ( !sch ) {

		j = 0 ;

		while( ( isalnum(fs[i]) || fs[i]=='_' ) && i < strlen(fs) ) {
			o[j] = fs[i] ;
			++i ; ++j ;
		}
		if( i==strlen(fs) ) return(2) ;

	       o[j] = '\0' ;

		if( o[0] == '\0' ) return(2) ;

	}
	else strcpy(o,u) ;


	if ( fs[i] ==']' )  ++i ;
	else return(2) ;

/*KOM   An dieser Stelle ist die Komponente abgearbeitet und in o,u,dim
/*KOM   hat man die wichtigsten Werte gelagert.
/*KOM   So gross die Gesamtdimension der Feldkomp. ist, so oft muss die for-
/*KOM   Schleife uebertragen werden, jeweils mit einer anderen Laufvariable.
/*KOM   dim wird durchgezaehlt und hat hier jeweils den benoetigten Wert fuer
/*KOM   Indizierung der Laufvariable. fh[] speichert fuer jede Dimension als
/*KOM   Hilfsvariable den for-Term ( s.o. ). Der gesamte For-Term, d.h. die
/*KOM   for-Schleife mit verschiedenen Indizes wird |dim| oft benoetigt, wird
/*KOM   auf hilf[] geschrieben, bzw. immer angehaengt.

	sprintf(fh,"for(lauf%d=%s;lauf%d<=%s;lauf%d++) ",dim,u,dim,o,dim);

	strcat(hilf,fh);

/*KOM   Nun folgt die Uebergabe der Groesse der Komponenten an die hier
/*KOM   globale Variable fva[], d.h. der string (o-u+1) mit evtl. '*' davor
/*KOM   wird an fva[] angehaengt. Der '*' fehlt nur beim ersten Mal (logo ).
/*KOM   Beachte : o,u sind in jeder Komponente neu besetzt.

	if( dim==1) sprintf(fh,"(%s-%s+1)",o,u);
	else sprintf(fh,"*(%s-%s+1)",o,u);

	strcat(fva,fh);

/*KOM   Der folgende Teil gilt nur fuer spezielle Strukturtypen, denn erlaubt
/*KOM   ist auch :  a[3..7][f..z].ende
/*KOM   D.h. nach den Feldkomponenten darf noch ein '.' folgen als strukt.Typ.
/*KOM   Wenn dieser Punkt steht, darf kein Feldbereich mehr kommen. Der ganze
/*KOM   Restterm wird in save[] gemerkt und am Schluss an den Funktionsnamen
/*KOM   angehaengt.

	if ( fs[i] =='.' ){
		j = 0 ;
		while( i < strlen( fs ) ) {
			save[j] = fs[i] ;
			++i ;
			++j ;
		}
		save[j] = '\0' ;
	}

}

/*KOM   Ende der while-Schleife und damit Bearbeitung der Feldkomponenten.


/*KOM   Zuerst wird der vollstaendige Funktionsname
/*KOM   in 'funa' geschrieben , z.B.
/*KOM          c[lauf1][lauf2]

i = 1 ;
while( i <= dim ) {
	sprintf(fh,"[lauf%d]",i);
	strcat(funa,fh);
	++i ;
}

/*KOM   Liegt strukt. Typ vor, wird funa[] ergaenzt.

if ( save[0]!='\0' ) strcat(funa,save) ;


/*KOM   Nun wird der gesamte Initialisierungsblock in outs[] kopiert, bzw.
/*KOM   angehaengt, in oben beschriebener Weise.

strcat(outs,"{") ;

/*KOM   Hier werden |dim| Deklarationen fuer Laufvariablen kopiert.

i = 1 ;
while( i <= dim ) {
	sprintf(fh,"int lauf%d;",i);
	strcat(outs,fh);
	++i;
}


/*KOM   Die for-Schleifen, die in hilf[] gemerkt wurden, werden kopiert.

strcat(outs,hilf) ;


/*KOM   Nun wird die explizite Initialisierung in Abhaengigkeit von ibindex
/*KOM   angehaengt.

strcat(outs,"{*(STACK+ST_INDEX++)= &");

strcat(outs,funa);

strcat(outs,";");

if ( ibindex==1) {
	strcat(outs,funa);
	strcat(outs,"=0;");
}

strcat(outs,"}}");


return(1) ;

}

/*KOM           ***** Ende fup2 *****
 
#include <stdio.h>
main(argc, argv)
int argc;
char *argv[];
{
	FILE *freopen();

	if (argc > 1)
		if (freopen(argv[1], "r", stdin) == NULL) {
			perror(argv[1]);
			exit(1);
		}
	if (argc > 2)
		if (freopen(argv[2], "w", stdout) == NULL) {
			perror(argv[2]);
			exit(1);
		}
	yylex();
	exit(0);
}


/*KOM                   ***** Ende Praeprozessor *****
