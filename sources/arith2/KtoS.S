/*M
.SH NAME
KtoS - Kant to SIMATH

.SH SYNOPSIS
.nf
#include<_arith2.h>

obj KtoS(a)  
t_handle struc, data; 
single type;

.SH DESCRIPTION
.TP 4
.B struc, data
contain a Kant object, say D, which will be converted to a SIMATH object.
.TP 4
.B type:
If D should become an element of type matrix, type has value 32 and 0 else.
.PP
KtoS returns the converted object D.

.SH NOTES
In order to convert D, KtoS needs a string (s. KstrtoS), whose length is determined by the global variable KS_MEM_MAX. When using large D, the value of KS_MEM_MAX should be raised.
.PP
The usage of this function assumes the installation of the computer algebra system Kant. 

.SH SEE ALSO
 KstrtoS
 StoKstr
 StoK

M*/
        
/*H
	Version  1      14.06.1993	Marc Conrad
   DATE KtoS          : 931130
H*/

/* ACHTUNG ! Dieses File enthaelt ZWEI Funktionen: KtoS und StoK. */


#include <_arith1.h>

/*   # include "kant.h"   */
typedef int t_handle; 
/* Dies ist alles, was von kant.h benoetigt wird. */


extern single KS_MEM_MAX; 

single KS_MEM_MAX = 16383;

obj KtoS(struc, data, type)
	t_handle struc;
	t_handle data;
	int type;


{

	char *str;
	obj L;

	init(L);

	if ((str = (char *) malloc(KS_MEM_MAX * sizeof(char))) == NULL) {
		fprintf(stderr, "\n\n*** not enough memory in KtoS: ***\n\n");
		exit(1);
	}
	kant_to_str(struc, data, str, type);
	L = KstrtoS(str);

	free(str);
	return (L);
}






/*c
		StoK(D, struc, data, type, digits )
  
	"SIMATH to Kant"
	Quellbibliothek: srclib.arith2
	Include-Datei:   _arith2.h
	single StoK(D, struc, data, type, digits)  
		obj D; t_handle *struc, *data;  single type, digits; 
	s = StoK(D, struc, data, type, digits); 
	D ist ein SIMATH-Objekt und wird in das entsprechende 
	Kant-Objekt umgewandelt. digits ist die Kant-Praezision,  
	falls type einen floating-point repraesentiert, sonst beliebig.      
	Der Wert von type kann anhand folgender Tabelle ermittelt 
	werden. (Alternativ kann der Header str_to_kant.h benutzt
	werden, der mit Kant ausgeliefert wird):

	   type       	|   D wird interpretiert als
	    1  		|   Integer
	    2	   	|   Floating-point mit Kant-prezision prec
	    3           |   rationale Zahl    
	   16 + x       |   Polynom ueber den in x kodierten Typ 
			|   ( x = 1, 2 oder 3 )      
	   32 + x	|   Matrix ueber den in x kodierten Typ
			|   ( x = 1, 2 oder 3 )      

	Zur Umwandlung wird ein String benoetigt (siehe StoKstr),
	dessen Groesse durch die globale (veraenderbare) Variable 
	KS_MEM_MAX festgelegt ist. Bei sehr grossen Objekten D sollte 
	gegebenenfalls der Wert von KS_MEM_MAX heraufgesetzt werden. 
	Hinweis: Der Gebrauch dieser Funktion setzt die Installation des
	Computeralgebrasystems Kant auf Ihrem Rechner voraus!         
	s = 0. 
c*/
/*H
	Version  1      14.06.1993	Marc Conrad
   DATE StoK          : 931130 
H*/


single StoK(L, struc, data, type, digits)
	t_handle *struc;
	t_handle *data;
	int type;
	obj L;
	single digits;

{

	char *str;

	bind(L);

	if ((str = (char *) malloc(KS_MEM_MAX * sizeof(char))) == NULL) {
		fprintf(stderr, "\n\n*** not enough memory in KtoS: ***\n\n");

		exit(1);
	}
	StoKstr(str, L, type, digits);
	str_to_kant(str, struc, data);

	free(str);
	return (0);
}

