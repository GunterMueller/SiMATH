/*C
			varls( L, zahl, zkstr )

	"variables from list to string".
	single varls(L, zahl,zkstr); list L; single zahl; char *zkstr;
	sch = varls( L, zahl, zkstr );

	Die Liste L wird in einen string umgewandelt.
	Falls der so erhaltene string ein i-elementiger ( i=1,2 )
	Funktionsaufruf ist, so ist sch = i. Andernfalls
	ist sch = 0. Handelt es sich bei diesem string um ein Poly-
	nom, eine rationale Funktion oder eine Matrix oder ein Vektor
	darueber, so ergibt sich sch zur Position dieses Elements in
	der Variablenliste. Ist string eine benutzerdefinierte 
	Funktion, so ist sch = -Position des Elements in der
	Variablenliste.
	Falls zahl=-1, hat man kein Array, sonst gibt die Zahl zahl
	den Index des Arrays an.
	Der include-file <_calc.h> wird benoetigt.

	Rueckgabe:
	sch	| Bedeutung
	========+=================================================
	1	| Funktionsaufrufe mit 1 Parameter / return
	2	| Funktionsaufrufe mit mehreren Parametern
	3	| Funktionsaufrufe, bei denen sich die Anzahl der 
		| Parameter aendern kann (1 oder mehrere)
	4	| Funktionsaufrufe ohne Parameter
	5	| curnf
	6	| curgf
	7	| Sonderfaelle Schleifen
	8	| decl
	9	| GF2bit
	10 	| curgf2bit
	11 	| getb
	12	| gethex
	13	| getoct
	14      | 0 oder 1 Parameter
C*/
/*H
	Version  1   02.06.1987         H.Stroeher/M.Mang
	Version  2   30.10.1989         C.Hollinger/U.Schneiders
	Version  3   03.12.1990         U.Schneiders
	Version  4   28.09.1992         U.Schneiders
H*/
 
#include <_calc.h>

single varls( L, zahl, zkstr )
list L;
single zahl;
char *zkstr;

{
	/*** Deklarationen und Vorbesetzungen ***/

	single ken, i=0, k, sch=0, sch1=0;
	bind( L );

	/*** Umwandlung Liste zu string ***/
                          
	k = MXNUM;
	if ( llength( L ) > 20 )
	{       mistake( 7 );
		return( -1 );
	}
	while ( L != _0  && i<=19 ) {
		*( zkstr + i ) = lfirst( L );
		L = lred( L );
		++i;
	}
	if(zahl>=0)
	{	*(zkstr + i) = '[';
		i++;
		sputi(zahl,zkstr+i); i++;
		if(zahl>=10) i++;
		if(zahl>=100) i++;
		if(zahl>=1000) i++;
		*(zkstr+i) = ']'; i++;
	}
	*( zkstr + i ) = '\0';         

	/*** zkstr Funktionsaufruf ***/

	if(zahl==(-1)){
	if( !strcmp( zkstr, "decl" ) ) sch = 8;
	else if( !strcmp( zkstr, "np" )  || !strcmp(zkstr, "froot") 
	      || !strcmp( zkstr, "ord" ) || !strcmp(zkstr, "deg") 
	      || !strcmp( zkstr, "rk" )  || !strcmp(zkstr, "reg")
	      || !strcmp( zkstr, "rk2d") || !strcmp(zkstr, "rkg2d")
	      || !strcmp( zkstr, "f1root") || !strcmp(zkstr, "ecnpscf"))
		sch = 3;
	else if( !strcmp( zkstr, "curnf" ) ) sch = 5;
	else if( !strcmp( zkstr, "curgf" ) ) sch = 6;
	else if( !strcmp( zkstr, "GF2bit" ) ) sch = 9;
	else if( !strcmp( zkstr, "curgf2bit" ) ) sch = 10;
	else if( !strcmp( zkstr, "getb" ) ) sch = 11;
	else if( !strcmp( zkstr, "gethex" ) ) sch = 12;
	else if( !strcmp( zkstr, "getoct" ) ) sch = 13;
	else if( !strcmp( zkstr, "proot" ) || !strcmp( zkstr, "classnum" )) 
		sch = 14;
	else if( !strcmp( zkstr, "if" ) || !strcmp( zkstr, "while" ) 
	     || !strcmp( zkstr, "dowhile" ) || !strcmp( zkstr, "forstep" )
             || !strcmp( zkstr, "forprime" ) || !strcmp( zkstr, "for" ) 
	     || !strcmp( zkstr, "print" )  || !strcmp( zkstr, "sum" )
	     || !strcmp( zkstr, "prod" )) 
		sch = 7;

	else if ( !strcmp( zkstr, "gcd" ) || !strcmp( zkstr, "lcm" )
	     || !strcmp( zkstr, "jacsym" ) || !strcmp( zkstr, "resul" )
	     || !strcmp( zkstr, "disc" ) || !strcmp( zkstr, "sort" )
	     || !strcmp( zkstr, "pfact" ) || !strcmp( zkstr, "deriv" )
	     || !strcmp( zkstr, "prfunc" ) || !strcmp( zkstr, "mex" )
	     || !strcmp( zkstr, "aval" ) || !strcmp( zkstr, "mval" )
	     || !strcmp( zkstr, "binom" ) || !strcmp( zkstr, "integr" )
	     || !strcmp( zkstr, "linequ" )|| !strcmp( zkstr,"scalar" )
	     || !strcmp( zkstr, "herm" ) || !strcmp( zkstr,"pgen" )
	     || !strcmp( zkstr, "eival" )|| !strcmp( zkstr,"elsubst" )
	     || !strcmp( zkstr, "chpol" ) || !strcmp( zkstr, "elform" )
	     || !strcmp( zkstr, "coef" ) || !strcmp( zkstr, "chcoef" )
	     || !strcmp( zkstr, "EC" ) || !strcmp( zkstr, "PT" )
	     || !strcmp( zkstr, "isptec" ) || !strcmp( zkstr, "swnf" )
	     || !strcmp( zkstr, "derivL" ) || !strcmp( zkstr, "bitrans" )
	     || !strcmp( zkstr, "minim" ) || !strcmp( zkstr, "taalg" )
	     || !strcmp( zkstr, "chinrem" ) || !strcmp( zkstr, "red" )
	     || !strcmp( zkstr, "root" ) || !strcmp( zkstr, "tors" )
	     || !strcmp( zkstr, "pconstr" ) || !strcmp( zkstr, "npfe" )
             || !strcmp( zkstr, "ecgnp" )  || !strcmp( zkstr, "irpgen")
	     || !strcmp( zkstr, "minor" ) || !strcmp(zkstr,"dmconstr")
	     || !strcmp( zkstr, "ntpair" ) || !strcmp(zkstr,"egcd")
	     || !strcmp( zkstr, "relcln") || !strcmp(zkstr,"zmconstr")
	     || !strcmp( zkstr, "mcoef") || !strcmp(zkstr, "vcoef")
	     || !strcmp( zkstr, "areptsli") || !strcmp(zkstr, "eccoef") 
	     || !strcmp( zkstr, "ptcoef") || !strcmp(zkstr, "intcoef" ) 
	     || !strcmp( zkstr, "mam2") || !strcmp(zkstr, "cont")
	     || !strcmp( zkstr, "prim") || !strcmp(zkstr, "pripgen") 
	     || !strcmp( zkstr, "ppconstr") || !strcmp( zkstr, "max") 
	     || !strcmp( zkstr, "min") )
		sch = 2;
	else if ( !strcmp( zkstr, "log2" ) || !strcmp( zkstr, "sgn" )
	     || !strcmp( zkstr, "tofl" )  || !strcmp( zkstr, "phi" )
	     || !strcmp( zkstr, "fact" ) || !strcmp( zkstr, "sqrt" )
	     || !strcmp( zkstr, "det" ) || !strcmp( zkstr, "transp" )
	     || !strcmp( zkstr, "floor" ) || !strcmp( zkstr, "sfp" )
	     || !strcmp( zkstr, "curec" ) || !strcmp( zkstr, "cond" )
	     || !strcmp( zkstr, "discec" ) || !strcmp( zkstr, "jinv" )
	     || !strcmp( zkstr, "tavb2" ) || !strcmp( zkstr, "tavb4" )
	     || !strcmp( zkstr, "tavb6" ) || !strcmp( zkstr, "tavb8" )
	     || !strcmp( zkstr, "tavc4" ) || !strcmp( zkstr, "tavc6" )
	     || !strcmp( zkstr, "prtoaf" ) || !strcmp( zkstr, "aftopr" )
	     || !strcmp( zkstr, "ecinf" )
	     || !strcmp( zkstr, "exp" ) || !strcmp( zkstr, "ln" )
	     || !strcmp( zkstr, "num" ) || !strcmp( zkstr, "denom" )
             || !strcmp( zkstr, "MOD" ) || !strcmp( zkstr, "curmod" ) 
             || !strcmp( zkstr, "NF" ) || !strcmp( zkstr, "GF" )
	     || !strcmp( zkstr, "nftopol" ) || !strcmp( zkstr, "norm" )
             || !strcmp( zkstr, "trace" ) || !strcmp( zkstr, "puto" ) 
             || !strcmp( zkstr, "putbits" ) || !strcmp( zkstr, "declaw" ) 
	     || !strcmp( zkstr, "nthei" ) || !strcmp( zkstr, "mtoi" ) 
	     || !strcmp( zkstr, "isprime" ) || !strcmp( zkstr, "sgnfeq" ) 
	     || !strcmp( zkstr, "rper" ) || !strcmp( zkstr, "basismwg" ) 
	     || !strcmp( zkstr, "ordtsg" ) || !strcmp( zkstr, "gftopol" ) 
	     || !strcmp( zkstr, "fp" ) || !strcmp( zkstr, "conjug") 
	     || !strcmp( zkstr, "imag" ) || !strcmp( zkstr, "real") 
	     || !strcmp( zkstr, "cper" ) || !strcmp( zkstr, "sin")
   	     || !strcmp( zkstr, "cos" ) || !strcmp( zkstr, "tan" )
	     || !strcmp( zkstr, "cot" ) || !strcmp( zkstr, "sinh" )
	     || !strcmp( zkstr, "cosh" ) || !strcmp( zkstr, "tanh" )
	     || !strcmp( zkstr, "coth" ) || !strcmp( zkstr, "arcsin" )
	     || !strcmp( zkstr, "arccos" ) || !strcmp( zkstr, "arctan" )
	     || !strcmp( zkstr, "arccot" ) || !strcmp( zkstr, "arsinh" )
	     || !strcmp( zkstr, "arcosh" ) || !strcmp( zkstr, "artanh" )
	     || !strcmp( zkstr, "arcoth" ) || !strcmp( zkstr, "log10" )
	     || !strcmp( zkstr, "whei") || !strcmp( zkstr, "faintp" ) 
	     || !strcmp( zkstr, "zvconstr" ) || !strcmp( zkstr, "fltoi" ) 
	     || !strcmp( zkstr, "putGF2bit" ) || !strcmp( zkstr, "putb" ) 
	     || !strcmp( zkstr, "puthex" ) || !strcmp( zkstr, "putoct" ) 
	     || !strcmp( zkstr, "rkbsd" ) || !strcmp( zkstr, "elog" )
	     || !strcmp( zkstr, "ceil" ) || !strcmp( zkstr, "isqrt" )
	     || !strcmp( zkstr, "ispprime" ) )
	     sch = 1;
	else if( !strcmp( zkstr, "discnf" ) || !strcmp( zkstr, "unit" )
             || !strcmp( zkstr, "intbas" ) ) sch = 4;
	else if( !strcmp(zkstr, "local"))
	{	mistake(318);
		return(-1);
	}
	else if( !strcmp( zkstr, "return" ))
	{	if(funktion) sch=1;
		else 
		{	mistake(319);
			return(-1);
		}
	}
	}

	if ( !sch )
	{       while ( !sch1 && k<MX && strlen( varlist[k].varname ) )
		{
		      if ( !strcmp( zkstr,varlist[k].varname ) )      sch1 = 1;
		      k++;
		}        
		if ( sch1 && varlist[k-1].typ != 2 && varlist[k-1].typ != -3 && varlist[k-1].varwert != -BASIS )
		{       ken = lsecond( varlist[k-1].varwert );
			if ( ( ken > 1 && ken < 5 ) 
			|| ( ken > 6 && ken < 10 ) 
			|| ( ken > 11 && ken < 15 ) 
			|| ken == 18 || ken == 20 || ken == 22 
		        || ken == 25 || ken == 27 || ken == 29 
			|| ken == 32 || ken == 34 || ken == 36 
			|| ken == 38 || ken == 39 )  sch = k-1;
		}
		else if(sch1 && (varlist[k-1].typ == 2 || varlist[k-1].typ == -3 ) && varlist[k-1].varwert != -BASIS )
			sch = -k+1;
	}
	return( sch );
}
