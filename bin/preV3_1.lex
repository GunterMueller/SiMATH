/*KOM 
/*KOM 	preV3_1.c
/*KOM	
/*KOM
/*KOM 	Quellprogramm fuer Praeprozessor preV3.1.x
/*KOM
/*KOM 	preV3.1.x faengt Funktionsnamen ab, die in der aktuellen
/*KOM 	SIMATH-Version nicht mehr existieren oder deren Parameteranzahl
/*KOM	sich geaendert hat.
/*KOM
/*KOM 	Genauer faengt der Praeprozessor die beiden folgenden Faelle
/*KOM	ab:
/*KOM	1. Ein Funktionsname war in einer frueheren SIMATH-Version
/*KOM      definiert, existiert aber in der aktuellen Version nicht
/*KOM      mehr.
/*KOM	2. Die Anzahl der Uebergabeparameter einer SIMATH-Funkion hat
/*KOM	   sich geaendert.
/*KOM 
/*KOM 	Eine wichtige Bemerkung: /usr/bin/lex scheint nicht mehr in der
/*KOM	Lage zu sein, die Quellen des Praeprozessors zu verarbeiten.
/*KOM	Stattdessen kann aber der GNU-Ersatz /usr/local/bin/flex
/*KOM 	benutzt werden. preV3_1.x kann durch das Makefile in
/*KOM	/usr/simath/sources0 uebersetzt werden.
/*KOM
/*KOM	Zum ersten Fall: Solche Funktionsnamen werden in den Listen
/*KOM	NAME0 ... NAME9 eingetragen, die dann unter NAME
/*KOM	zusammengefasst werden.
/*KOM	a) In der Definition (vor dem ersten %%) einer der Listen
/*KOM	   NAME0, ..., NAME10  muss der alte Name eingetragen werden, also
/*KOM	   beispielsweise
/*KOM	        NAME2 (OLDNAME|...)
/*KOM	   (das Zeichen `|' steht fuer das logische `oder'). Beachte,
/*KOM	   dass in der Klammer keine Leerzeichen zulaessig sind.
/*KOM 	b) Im Anweisungsteil (nach dem ersten %%) bei
/*KOM        	{NAME}{NOALNUM} {...
/*KOM	muss in der if-else-Abfrage ein neues if-else eingefuegt werden
/*KOM 	in der Form (wo ist egal)
/*KOM	  	...
/*KOM		else if( !strcmp(name,"discqnf") ) strcpy(newname,"qnfdisc");
/*KOM		...
/*KOM	wobei hier z.B. discqnf der alte Name ist und qnfdisc der
/*KOM	neue. Genaueres kann man leicht dem Programmtext entnehmen
/*KOM
/*KOM 	Zum zweiten Fall: Die Parameterzahl hat sich veraendert. Dafuer
/*KOM	dienen die Definitionen der Form PARmNEWn. Der Eintrag
/*KOM	eines Namens in der Liste PARmNEWn bedeutet, dass die
/*KOM	Funktion, in einer alten SIMATH-Version m Parameter hatte, in
/*KOM	der aktuellen Version aber n Parameter hat. Gegebenenfalls
/*KOM	muessen die Listen der Funktionsnamen durch neue Listen
/*KOM	ergaenzt werden, falls die entsprechende Liste PARmNEWn noch
/*KOM	nicht exitiert.
/*KOM	Falls eine neue Liste PARmNEWn eingefuehrt wird, so muessen
/*KOM	auch zwei Zeilen der Form
/*KOM		{ALNUM}{PARnNEWm}{PARHEAD} {ECHO;}
/*KOM	und
/*KOM		{PARnNEWm}{PARHEAD} {parnrcomp(yytext, m-1); ECHO; yyless(yyleng);}
/*KOM	an den entsprechenden Stellen eingefuehrt werden. (Die
/*KOM	entsprechenden Stellen sind kaum zu uebersehen.) Dabei zaehlt
/*KOM	"parnrcomp" nur die auftretenden Kommata.
/*KOM
/*KOM 	************************************************************************

%{
#include <ctype.h>
int lfz = 0 ;
int hks = 0 ;
int kos = 0 ;
char ARG1[20];
%}

%e 5000
%p 10000
%n 1000
%a 5000
%o 10000

SPACE [\ \t]
SEP2 ((")"|{SPACE})*)
ALNUM [_A-Za-z0-9]
inop [\-\+\*\=\/\>]
inpa ({ALNUM}|{inop}|"("|")"|"["|"]"|"."|"&"|","|{SPACE})
NOALNUM [^_A-Za-z0-9]

NAME0 (cisinball|conjqnf|degrescfqnf|discecnfsnf|discecnf|discecrsnf|discecr|discqnf|ecibrt|ecicond|ecidif|ecidouble)
NAME1 (eciminimod|ecimrtmp|ecimul|ecinetahe|ecinetapa|ecireg|ecirkbsd|ecirperiod|ecisnflpi|ecisnfmotor|ecisnfmuli)
NAME2 (ecisnfnegi|ecisnfotor|ecisnfspred|ecisnfsumi|ecisnftgtor|ecisnftor|ecispred|ecisrppi|ecmpnp|ecnflpsnf)
NAME3 (ecnfmulsnf|ecnfnegsnf|ecnfsumsnf|ecrbtps|ecrdheights|ecrdisc|ecrlhaav|ecrlhnaav|ecrlpsnf|ecrlp|ecrlserhds)
NAME4 (ecrminimod|ecrmrtmp|ecrmulsnf|ecrmul|ecrnegsnf|ecrneg|ecrnetahe|ecrsnfdisc|ecrsnfjinv|ecrsnflp|ecrsnfmul)
NAME5 (ecrsnfneg|ecrsnfrl|ecrsnfrt|ecrsnfspred|ecrsnfsum|ecrsnftoic|ecrspred|ecrsrpp|ecrsumsnf|ecrsum|ecrtavb6)
NAME6 (ecrtavb8|ecrtavc6|ecrtoic|ecrtosnf|egstepcol|egsteprow|evmaiifcp|evmai|evmamspifcp|evmamsp|evmarifcp)
NAME7 (evmar|ifurqnf|infelprod|intbasqnf|iselecrsnf|iselecr|isppecreq|isppecrpai|isppiecieq|isppiecipai|jinvecnfsnf)
NAME8 (jinvecnf|jinvecrsnf|jinvecr|normqnf|qffdcns1|qffdcns2|qffdcns3|qffdcn|qfffununit|qffreg|ramindqnf|rnfelprod)
NAME9 (rqnfifu|tatealg|traceqnf|upmspegsc|upmspegsr|upregstepcol|upregsteprow|eciminmwgbase|ecisnfmwgbase|ecracmwgbase)
NAME10 (qnfielpifacts|ecractoecimin|eciminpcompmt|eciminplunion|eciminredtype|ecimintatealg|ecqnfacfndisc)

NAME ({NAME0}|{NAME1}|{NAME2}|{NAME3}|{NAME4}|{NAME5}|{NAME6}|{NAME7}|{NAME8}|{NAME9}|{NAME10})

PAR1NEW2 (nfneg|qnfconj|qnftrace|udpmstbc|manfcons1|manfscons1)
PAR1NEW3 (magfscons1)
PAR2NEW3 (ecrbtlistp|nfdif|nfeliprod|nfelmodi|nfelrprod|nfsum|pnfneg|putnfel|putonfel)
PAR3NEW4 (fputnfel|fputonfel|pnfdif|pnfsum|eciminreg|eciminplunion)
PAR4NEW3 (ecrlserfds|ecrlsers)
PAR5NEW1 (ecrjinv|ecrmaninalg|ecrrl)
PAR5NEW6 (ecgf2cssa)
PAR6NEW2 (ecrbtp|ecrrt)
PAR6NEW4 (ifactcfe)
PAR6NEW7 (qffmsrspidrd)
PAR9NEW2 (ecrbtco)

PARHEAD {SEP2}"("({inpa}*)")"

%%



"\n"	{++lfz; ECHO;}
\\\"  	ECHO;
\" 	{if (!kos) hks = !hks; ECHO;}
"/*" 	{if (!hks)
		{if (!kos) kos = 1;}
	ECHO;}
"*/" 	{if (!hks)
		{if (kos) kos = 0;}
	ECHO;}




{ALNUM}{PAR1NEW2}{PARHEAD}  	{ECHO;}
{ALNUM}{PAR1NEW3}{PARHEAD}  	{ECHO;}
{ALNUM}{PAR2NEW3}{PARHEAD}  	{ECHO;}
{ALNUM}{PAR3NEW4}{PARHEAD}  	{ECHO;}
{ALNUM}{PAR4NEW3}{PARHEAD}  	{ECHO;}
{ALNUM}{PAR5NEW1}{PARHEAD}      {ECHO;}
{ALNUM}{PAR5NEW6}{PARHEAD}      {ECHO;}
{ALNUM}{PAR6NEW2}{PARHEAD}  	{ECHO;}
{ALNUM}{PAR6NEW4}{PARHEAD}  	{ECHO;}
{ALNUM}{PAR6NEW7}{PARHEAD}  	{ECHO;}
{ALNUM}{PAR9NEW2}{PARHEAD}  	{ECHO;}

{ALNUM}{NAME}{NOALNUM}      	{ECHO;}

{PAR1NEW2}{PARHEAD}  		{parnrcomp(yytext, 1); ECHO; yyless(yyleng);}
{PAR1NEW3}{PARHEAD}  		{parnrcomp(yytext, 2); ECHO; yyless(yyleng);}
{PAR2NEW3}{PARHEAD}  		{parnrcomp(yytext, 2); ECHO; yyless(yyleng);}
{PAR3NEW4}{PARHEAD}  		{parnrcomp(yytext, 3); ECHO; yyless(yyleng);}
{PAR4NEW3}{PARHEAD}  		{parnrcomp(yytext, 2); ECHO; yyless(yyleng);}
{PAR5NEW1}{PARHEAD}             {parnrcomp(yytext, 0); ECHO; yyless(yyleng);}
{PAR5NEW6}{PARHEAD}             {parnrcomp(yytext, 5); ECHO; yyless(yyleng);}
{PAR6NEW2}{PARHEAD}             {parnrcomp(yytext, 1); ECHO; yyless(yyleng);}
{PAR6NEW4}{PARHEAD}  		{parnrcomp(yytext, 3); ECHO; yyless(yyleng);}
{PAR6NEW7}{PARHEAD}  		{parnrcomp(yytext, 6); ECHO; yyless(yyleng);}
{PAR9NEW2}{PARHEAD}  		{parnrcomp(yytext, 1); ECHO; yyless(yyleng);}

{NAME}{NOALNUM}    	{
	char name[32];
	char newname[256];

	yyless(yyleng-1);
	strcpy(name,yytext);

        if (!strcmp(name, "cisinball"))          strcpy(newname, "\"iscinball\"");
        else if (!strcmp(name, "conjqnf"))       strcpy(newname, "\"qnfconj\"");
        else if (!strcmp(name, "degrescfqnf"))   strcpy(newname, "\"qnfdegrescf\"");
        else if (!strcmp(name, "discecnf"))      strcpy(newname, "\"ecnfdisc\"");
        else if (!strcmp(name, "discecnfsnf"))   strcpy(newname, "\"ecnfsnfdisc\"");
        else if (!strcmp(name, "discecr"))       strcpy(newname, "\"ecimindisc\", \"ecisnfdisc\" or \"ecracdisc\"");
        else if (!strcmp(name, "discecrsnf"))    strcpy(newname, "\"ecimindisc\", \"ecisnfdisc\" or \"ecracdisc\"");
        else if (!strcmp(name, "discqnf"))       strcpy(newname, "\"qnfdisc\"");
        else if (!strcmp(name, "ecibrt"))        strcpy(newname, "\"eciminbrtmp\"");
        else if (!strcmp(name, "ecicond"))       strcpy(newname, "\"ecrcond\"");
        else if (!strcmp(name, "ecidif"))        strcpy(newname, "\"ecimindif\", \"ecisnfdif\" or \"ecracdif\"");
        else if (!strcmp(name, "ecimindouble"))  strcpy(newname, "\"ecimindouble\", \"ecisnfdouble\" or \"ecracdouble\"");
        else if (!strcmp(name, "eciminimod"))    strcpy(newname, "\"ecractoecmin\"");
        else if (!strcmp(name, "ecimrtmp"))      strcpy(newname, "\"eciminmrtmp\"");
        else if (!strcmp(name, "ecimul"))        strcpy(newname, "\"eciminmul\", \"ecisnfmul\" or \"ecracmul\"");
        else if (!strcmp(name, "ecineg"))        strcpy(newname, "\"eciminneg\", \"ecisnfneg\" or \"ecracneg\"");
        else if (!strcmp(name, "ecinetahe"))     strcpy(newname, "\"eciminnetahe\"");
        else if (!strcmp(name, "ecinetapa"))     strcpy(newname, "\"eciminnetapa\"");
        else if (!strcmp(name, "ecireg"))        strcpy(newname, "\"ecrregulator\"");
        else if (!strcmp(name, "ecirkbsd"))      strcpy(newname, "\"ecrrank\"");
        else if (!strcmp(name, "ecirperiod"))    strcpy(newname, "\"ecrrperiod\"");
        else if (!strcmp(name, "ecisnflpi"))     strcpy(newname, "");
        else if (!strcmp(name, "ecisnfmotor"))   strcpy(newname, "");
        else if (!strcmp(name, "ecisnfmuli"))    strcpy(newname, "\"eciminmul\", \"ecisnfmul\" or \"ecracmul\"");
        else if (!strcmp(name, "ecisnfnegi"))    strcpy(newname, "\"eciminneg\", \"ecisnfneg\" or \"ecracneg\"");
        else if (!strcmp(name, "ecisnfotor"))    strcpy(newname, "\"ecrordtor\"");
        else if (!strcmp(name, "ecisnfspred"))   strcpy(newname, "");
        else if (!strcmp(name, "ecisnfsumi"))    strcpy(newname, "\"eciminsum\", \"ecisnfsum\" or \"ecracsum\"");
        else if (!strcmp(name, "ecisnftgtor"))   strcpy(newname, "\"ecimingentor\", \"ecisnfgentor\", \"ecracgentor\" or \"ecrstrtor\"");
        else if (!strcmp(name, "ecisnftor"))     strcpy(newname, "\"ecimintorgr\", \"ecisnftorgr\", \"ecractorgr\"");
        else if (!strcmp(name, "ecispred"))      strcpy(newname, "");
        else if (!strcmp(name, "ecisrppi"))      strcpy(newname, "");
        else if (!strcmp(name, "ecisum"))        strcpy(newname, "\"eciminsum\", \"ecisnfsum\" or \"ecracsum\"");
        else if (!strcmp(name, "ecmpnp"))        strcpy(newname, "\"ecmspnp\"");
        else if (!strcmp(name, "ecnflpsnf"))     strcpy(newname, "\"ecnfsnflp\"");
        else if (!strcmp(name, "ecnfmulsnf"))    strcpy(newname, "\"ecnfsnfmul\"");
        else if (!strcmp(name, "ecnfnegsnf"))    strcpy(newname, "\"ecnfsnfneg\"");
        else if (!strcmp(name, "ecnfsumsnf"))    strcpy(newname, "\"ecnfsnfsum\"");
        else if (!strcmp(name, "ecrbtps"))       strcpy(newname, "\"ecrbtp\"");
        else if (!strcmp(name, "ecrdheights"))   strcpy(newname, "\"ecimindwhnth\"");
        else if (!strcmp(name, "ecrdisc"))       strcpy(newname, "\"ecimindisc\", \"ecisnfdisc\" or \"ecracdisc\"");
        else if (!strcmp(name, "ecrlhaav"))      strcpy(newname, "\"eciminlhaav\"");
        else if (!strcmp(name, "ecrlhnaav"))     strcpy(newname, "\"eciminlhnaav\"");
        else if (!strcmp(name, "ecrlp"))         strcpy(newname, "");
        else if (!strcmp(name, "ecrlpsnf"))      strcpy(newname, "");
        else if (!strcmp(name, "ecrlserhds"))    strcpy(newname, "");
        else if (!strcmp(name, "ecrminimod"))    strcpy(newname, "\"ecractoecmin\"");
        else if (!strcmp(name, "ecrmrtmp"))      strcpy(newname, "\"eciminmrtmp\"");
        else if (!strcmp(name, "ecrmul"))        strcpy(newname, "\"eciminmul\", \"ecisnfmul\" or \"ecracmul\"");
        else if (!strcmp(name, "ecrmulsnf"))     strcpy(newname, "\"eciminmul\", \"ecisnfmul\" or \"ecracmul\"");
        else if (!strcmp(name, "ecrneg"))        strcpy(newname, "\"eciminneg\", \"ecisnfneg\" or \"ecracneg\"");
        else if (!strcmp(name, "ecrnegsnf"))     strcpy(newname, "\"eciminneg\", \"ecisnfneg\" or \"ecracneg\"");
        else if (!strcmp(name, "ecrnetahe"))     strcpy(newname, "\"eciminnetahe\"");
        else if (!strcmp(name, "ecrsnfdisc"))    strcpy(newname, "\"ecimindisc\", \"ecisnfdisc\" or \"ecracdisc\"");
        else if (!strcmp(name, "ecrsnfjinv"))    strcpy(newname, "\"ecrjinv\"");
        else if (!strcmp(name, "ecrsnflp"))      strcpy(newname, "");
        else if (!strcmp(name, "ecrsnfmul"))     strcpy(newname, "\"eciminmul\", \"ecisnfmul\" or \"ecracmul\"");
        else if (!strcmp(name, "ecrsnfneg"))     strcpy(newname, "\"eciminneg\", \"ecisnfneg\" or \"ecracneg\"");
        else if (!strcmp(name, "ecrsnfrl"))      strcpy(newname, "\"ecrrl\"");
        else if (!strcmp(name, "ecrsnfrt"))      strcpy(newname, "\"ecrrt\"");
        else if (!strcmp(name, "ecrsnfspred"))   strcpy(newname, "");
        else if (!strcmp(name, "ecrsnfsum"))     strcpy(newname, "\"eciminsum\", \"ecisnfsum\" or \"ecracsum\"");
        else if (!strcmp(name, "ecrsnftoic"))    strcpy(newname, "");
        else if (!strcmp(name, "ecrspred"))      strcpy(newname, "");
        else if (!strcmp(name, "ecrsrpp"))       strcpy(newname, "");
        else if (!strcmp(name, "ecrsum"))        strcpy(newname, "\"eciminsum\", \"ecisnfsum\" or \"ecracsum\"");
        else if (!strcmp(name, "ecrsumsnf"))     strcpy(newname, "\"eciminsum\", \"ecisnfsum\" or \"ecracsum\"");
        else if (!strcmp(name, "ecrtavb6"))      strcpy(newname, "\"ecitavlb\" or \"ecrtavlb\"");
        else if (!strcmp(name, "ecrtavb8"))      strcpy(newname, "\"ecitavlb\" or \"ecrtavlb\"");
        else if (!strcmp(name, "ecrtavc6"))      strcpy(newname, "\"ecitavlc\" or \"ecrtavlc\"");
        else if (!strcmp(name, "ecrtoic"))       strcpy(newname, "");
        else if (!strcmp(name, "ecrtosnf"))      strcpy(newname, "");
        else if (!strcmp(name, "egstepcol"))     strcpy(newname, "\"maiegsc\"");
        else if (!strcmp(name, "egsteprow"))     strcpy(newname, "\"maiegsr\"");
        else if (!strcmp(name, "evmai"))         strcpy(newname, "\"maiev\"");
        else if (!strcmp(name, "evmaiifcp"))     strcpy(newname, "\"maievifcp\"");
        else if (!strcmp(name, "evmamsp"))       strcpy(newname, "\"mamsev\"");
        else if (!strcmp(name, "evmamspifcp"))   strcpy(newname, "\"mamsevifcp\"");
        else if (!strcmp(name, "evmar"))         strcpy(newname, "\"marev\"");
        else if (!strcmp(name, "evmarifcp"))     strcpy(newname, "\"marevifcp\"");
        else if (!strcmp(name, "ifurqnf"))       strcpy(newname, "\"rqnffu\"");
        else if (!strcmp(name, "infelprod"))     strcpy(newname, "\"nfeliprod\"");
        else if (!strcmp(name, "intbasqnf"))     strcpy(newname, "\"qnfintbas\"");
        else if (!strcmp(name, "iselecr"))       strcpy(newname, "\"isponecimin\", \"isponecisnf\" or \"isponecrac\"");
        else if (!strcmp(name, "iselecrsnf"))    strcpy(newname, "\"isponecimin\", \"isponecisnf\" or \"isponecrac\"");
        else if (!strcmp(name, "isppecreq"))     strcpy(newname, "\"ecrpcomp\"");
        else if (!strcmp(name, "isppecrpai"))    strcpy(newname, "\"ispecrpai\"");
        else if (!strcmp(name, "isppiecieq"))    strcpy(newname, "\"ecrpcomp\"");
        else if (!strcmp(name, "isppiecipai"))   strcpy(newname, "\"ispecrpai\"");
        else if (!strcmp(name, "jinvecnf"))      strcpy(newname, "\"ecnfjinv\"");
        else if (!strcmp(name, "jinvecnfsnf"))   strcpy(newname, "\"ecnfsnfjinv\"");
        else if (!strcmp(name, "jinvecr"))       strcpy(newname, "\"ecrjinv\"");
        else if (!strcmp(name, "jinvecrsnf"))    strcpy(newname, "\"ecrjinv\"");
        else if (!strcmp(name, "normqnf"))       strcpy(newname, "\"qnfnorm\"");
        else if (!strcmp(name, "qffdcn"))        strcpy(newname, "\"qffmsdcn\"");
        else if (!strcmp(name, "qffdcns1"))      strcpy(newname, "\"qffmsdcns1\"");
        else if (!strcmp(name, "qffdcns2"))      strcpy(newname, "\"qffmsdcns2\"");
        else if (!strcmp(name, "qffdcns3"))      strcpy(newname, "\"qffmsdcns3\"");
        else if (!strcmp(name, "qfffununit"))    strcpy(newname, "\"qffmsfubs\"");
        else if (!strcmp(name, "qffreg"))        strcpy(newname, "\"qffmsreg\"");
        else if (!strcmp(name, "ramindqnf"))     strcpy(newname, "\"qnframind\"");
        else if (!strcmp(name, "rnfelprod"))     strcpy(newname, "\"nfelrprod\"");
        else if (!strcmp(name, "rqnfifu"))       strcpy(newname, "\"rqnffu\"");
        else if (!strcmp(name, "tatealg"))       strcpy(newname, "\"ecimintatealg\"");
        else if (!strcmp(name, "traceqnf"))      strcpy(newname, "\"qnftrace\"");
        else if (!strcmp(name, "upmspegsc"))     strcpy(newname, "\"maupmspegsc\"");
        else if (!strcmp(name, "upmspegsr"))     strcpy(newname, "\"maupmspegsr\"");
        else if (!strcmp(name, "upregstepcol"))  strcpy(newname, "\"maupregsc\"");
        else if (!strcmp(name, "upregsteprow"))  strcpy(newname, "\"maupregsr\"");
        else if (!strcmp(name, "eciminmwgbase")) strcpy(newname, "\"eciminbwmg\"");
        else if (!strcmp(name, "ecisnfmwgbase")) strcpy(newname, "\"ecisnfbmwg\"");
        else if (!strcmp(name, "ecracmwgbase"))  strcpy(newname, "\"ecracbmwg\"");
	else if (!strcmp(name, "qnfielpifacts")) strcpy(newname, "\"qnfielpifact\"");
	else if (!strcmp(name, "ecractoecimin")) strcpy(newname, "\"ecractoimin\"");
	else if (!strcmp(name, "eciminpcompmt")) strcpy(newname, "\"eciminpcmt\"");
	else if (!strcmp(name, "eciminplunion")) strcpy(newname, "\"eciminplu\"");
	else if (!strcmp(name, "eciminredtype")) strcpy(newname, "\"eciminrt\"");
	else if (!strcmp(name, "ecimintatealg")) strcpy(newname, "\"ecimintate\"");
	else if (!strcmp(name, "ecqnfacfndisc")) strcpy(newname, "\"ecqnfacfnd\"");

	fprintf(stderr, "\"%s\", line %d: Warning: %s: no such function in current version.", ARG1, lfz, name);

	if (strcmp(newname, ""))
	{
	    fprintf(stderr, " Use %s\n", newname);
	}
	else
	{
	    fprintf(stderr, "\n");
	}
	
	ECHO;

/*
	if (!kos && !hks)
	{
	    fprintf(stderr, "\n\tFEHLER in \"%s\" in Zeile %d :", ARG1, lfz);
	    fprintf(stderr, "\n\tDie ehemalige SIMATH-Funktion %s", name);
	    fprintf(stderr, "\n\that jetzt den Namen %s !!!!!\n", newname);

	    ECHO;
	}

	else
	{
	    fprintf(stderr, "\n\tWARNUNG in \"%s\" in Zeile %d (Kommentar oder String) : ", ARG1, lfz);
	    fprintf(stderr, "\n\tDie ehemalige SIMATH-Funktion %s", name);
	    fprintf(stderr, "\n\that jetzt den Namen %s !!!!!\n", newname);

	    ECHO;
	}
*/

     }

%%

int             parnrcomp(ps, n)
    char           *ps;
    int             n;
{
    extern int      ERROR_INDEX;
    int             i = 0, j = 0, rklz = 1, kommaz = 0;
    char            name[20];

    while (isalnum(ps[i]) || ps[i] == '_')
	name[j++] = ps[i++];
    name[j] = '\0';
    while (ps[i] != '(')
	++i;
    ++i;
    j = i;

    while (ps[i] != '\0' && rklz)
    {
	switch (ps[i])
	{
	case '(':
	    ++rklz;
	    break;
	case ')':
	    --rklz;
	    break;
	case ',':
	    if (rklz == 1)
		++kommaz;
	    break;
	}
	++i;
    }
    if (kommaz != n)
    {
	if (!kos && !hks)
	{
	    if (n == 0)
	    {
		fprintf(stderr,
			"\"%s\", line %d: Error: \"%s\" has %d parameter in current version\n",
			ARG1, lfz, name, n + 1);
	    }
	    else
	    {
		fprintf(stderr,
			"\"%s\", line %d: Error: \"%s\" has %d parameters in current version\n",
			ARG1, lfz, name, n + 1);
	    }
	    ERROR_INDEX = 1;
	}

	else
	{
	    if (n == 0)
	    {
		fprintf(stderr,
			"\"%s\", line %d: Warning (in comment or string): \"%s\" has %d parameter in current version\n",
			ARG1, lfz, name, n + 1);
	    }
	    else
	    {
		fprintf(stderr,
			"\"%s\", line %d: Warning (in comment or string): \"%s\" has %d parameters in current version\n",
			ARG1, lfz, name, n + 1);
	    }
	}
/*
	if (!kos && !hks)
	{
	    fprintf(stderr, "\n\tFEHLER in \"%s\" in Zeile %d :", ARG1, lfz);
	    fprintf(stderr, "\n\tDie SIMATH-Funktion %s hat jetzt %d Parameter !!!!\n", name, n + 1);
	    ECHO;
	}
	else
	{
	    fprintf(stderr, "\n\tWARNUNG in \"%s\" in Zeile %d (Kommentar oder String) : ", ARG1, lfz);
	    fprintf(stderr, "\n\tDie SIMATH-Funktion %s hat jetzt %d Parameter !!!!\n", name, n + 1);
	    ECHO;
	}
*/
    }
/*
    yyless(j);
*/
}

#include <stdio.h>

int             ERROR_INDEX = 0;

main(argc, argv)
    int             argc;
    char           *argv[];
{
    FILE           *freopen();

    if (argc > 1)
	if (freopen(argv[1], "r", stdin) == NULL)
	{
	    perror(argv[1]);
	    exit(1);
	}
    if (argc > 2)
	if (freopen(argv[2], "w", stdout) == NULL)
	{
	    perror(argv[2]);
	    exit(1);
	}

    strcpy(ARG1, *++argv);
    ARG1[(strlen(ARG1) - 1)] = 'S';
    yylex();

    if (ERROR_INDEX == 0)
    {
	exit(0);
    }
    else
    {
	exit(1);
    }
}
