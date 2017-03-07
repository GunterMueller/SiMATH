/*M
.SH NAME
Earith - Essen arithmetic package

.\ .SH
.\ #include
.\
.\ Earith ()

.PP	
.USAGE
This file provides the use of the so-called Essen arithmetic package
within SIMATH programs. The package itself is described afterwards.
To use these function from within SIMATH,
their name has to be preceeded with an "E".
Original function call in the Essen arithmetic package:
.PP
        <function name>( parameter ); 
.PP
Embedded function call in SIMATH:
.PP
        E<function name>( parameter ); 
.PP
For instance the call of the Essen function
.PP
        mult( a, b, c );
.PP
has to be turned into 
.PP
        Emult( a, b, c );
.PP
in a SIMATH source.

Alternatively the header _essen.h may be included. It contains macro definitions like "#define mult Emult".
.PP
.B Caution:
The function "quad" has to be explicitly named "Equad" since there is a type-declaration of "quad" in /usr/include/sys/types.h!

The SIMATH functions itoE and Etoi offer type-conversion of numbers in Essen representation to SIMATH representation and the other way round.  

In order to use Essen arithmetic within SIMATH programs, the additional
header _Earith.h has to be included instead of the Essen-header arith.h. 

For more detailed information, please refer to the Essen-arithmetic manual.
The brief original description of the module and the copyright of the author follow now.

.SH MODULE
Package for calculations with long numbers, version 2.1

A long number, say a, is of type LONG a[LAENGE], where LAENGE = 500
in SIMATH. The maximum LAENGE can be modified in the file _Earith.h,
but then SIMATH has to be re-compiled.
The real length of a is contained in a[0].
.PP
For example a[0] = 3  a[1] = 1  a[2] = 2  a[3] = 3
represents the integer 1 + 2*2^32 + 3*(2^32)^2.

.SH SYNOPSIS
.nf

The following functions are defined on this kind of long numbers:

.B ARITHMETIC

Addition:               Eadd(num1,num2,result)

Increment:              Eincr(num)
                        num := num + 1

Subtraction:            Esub(num1,num2,result)
                        returns 0  if the subtraction was successful,
                        or     -1  if num2 > num1; in this case the
                                   value of result is undefined

Decrement:              Edecr(num)
                        num := num - 1
                        returns 0  if the decrement was successful
                        or     -1  if num == 0

Multiplication:         Emult(num1,num2,result)
                        result = num1 * num2
                        Emulteq(result, num)
                        result = result * num

Square:                 Equad(num,result)
                        result = num * num
                        Equadeq(num)
                        num = num * num

Shift:                  Eshift(num,num_shifts,result)
                        Here num_shifts is of type LONGINT!

Division:               Ediv(dividend,divisor,quotient,remainder)
                        returns 0  if the division was successful,
                               -1  if division by 0 occurred.
                        quotient = dividend / divisor 
                        remainder = dividend / divisor 
Reduction:              Emod(num1,result,module)
                        result = num1 % module 
Reduction:              Emodeq(result,module)
                        result = result % module
                        return -1 if module == 0 or overflow else 0;

Exponentiation:         Eexpo(num1,num2,result)
                        Here num2 if of type unsigned!
                        result = num1 ^ num2

Square root:            Ewurzel(num,result)
                        returns  1,  if num is not a square; in this case 
                                     result equals the next biggest integer
                                     of the square root of num.
                        or       0,  if num is a square; in this case 
                                     result equals the square root of num.

n-th Root:              En_wurzel(num,n,result)
                        Here n if of type unsigned !
                        returns  1,  if num is no n-th power; in this case
                                     result equals the next biggest integer
                                     of the n-th root of num.
                        or       0,  if num is a n-th power; in this case 
                                     result equals the n-th root of num.

Logarithm:              LONGINT Elb(num)
                        returns log2(num)
                        or      -1 ,  if num is 0

Sum of digits:          LONGINT Equersumme(num)
                        returns the sum of digits of num to base 2^SHORTBITS

Alternating sum of digits:
                        LONGINT Ealt_quersumme(num)
                        returns num[0]-num[1]+num[2]-+...

Jacobi-symbol:          Ejacobi(arg,modul)
                        returns  1,  if arg has Jacobi-symbol  1 mod modul,
                        or      -1,  if arg has Jacobi-symbol -1 mod modul,
                        or       0,  if gcd(arg,modul) != 1 .
                        The value of modul has to be odd!
                        If modul is prime, the result equals
                        the Legendre-symbol.

Comparison:             Ecomp(num1,num2)
                        returns -1,  if num1 > num2
                        or       0,  if num1 = num2
                        or      +1,  if num1 < num2

Copying:                Etrans(num1,num2)

Assignment:             Ezuweis(num1,num2)
                        Here num1 is of type SHORT, num2 is long.
                        Performs the assignment num2 := num1
                        Ezuweis_int(num1,num2)
                        Here num1 is long, num2 is of type long unsigned.
                        Performs the assignment num2 := num1
                        returns  0,  if the assignment was successful
                        or      -1,  if num1 is too large; in this case
                                     the value of num2 is undefined.

Even:                   Eeven(num)
                        returns  1,  if num is even
                        or       0,  if num is odd

Modulo4:                Emod4(num)
                        returns num mod 4

Modulo8:                Emod8(num)
                        returns num mod 8

Random numbers:         Ezufall(num,num_bits)
                        Here num_bits is of type LONGINT and defines the
                        number of random bits for the long number num


.B MODULO-ARITHMETIC

Modulo-addition:        Emadd(num1,num2,result,modul)

Modulo-subtraction:     Emsub(num1,num2,result,modul)

Modulo-multiplication:  Emmult(num1,num2,result,modul)
                        Emmulteq(result,num1,modul)

Modulo-square:          Emquad(num,result,modul)
                        Emquadeq(result,modul)

Modulo-division:        Emdiv(num1,num2,result,modul)
                        returns  0,  if gcd(num2,modul) is a factor of num1
                        or      -1,  if division not possible

Modulo-exponentiation:  Emexp(num1,num2,result,modul)

GCD:                    EGGT(num1,modul,result,inverse)
                        calculates result = gcd(num1,modul)
                        and inverse (mod modul)
                        with num1*inverse = result mod modul


.B INPUT/OUTPUT (decimal)

Input:                  Ereadue(text,num)
                        Evreadue(text,num)
                        Ereaduefile(inputfile,num)

Output:                 Ewriteue(text,num)
                        Evwriteue(text,num)
                        Ewriteuefile(outputfile,text,num)


.B INPUT/OUTPUT (hexadecimal)

Input:                  Ereadx(text,num)
                        Ereadxfile(inputfile,num)
                        Eread_long(inputfile,num)  in internal representation!

Output:                 Ewritex(text,num)
                        Ewritexfile(outputfile,text,num)
                        Ewrite_long(outputfile,num) in internal representation


.B INPUT/OUTPUT (binary)

Input:                  Ereadb(text,num)

Output:                 Ewriteb(text,num)


.SH AUTHOR
Program development and copyright
.nf
Reiner Staszewski
Institut fuer Experimentelle Mathematik
Universitaet Gesamthochschule Essen
Ellernstr. 29
4300 Essen 12
Tel.: (0201) 32064-44
         
M*/                  
/*H
	Version  1      24.12.1991      Marc Conrad (Anpassung fuer SIMATH)
	Version  2	06.12.1993	Anpassung fuer SIMATH auf HP.  MC
	Version  3	21.10.1998      Neue Funktionen fuer mult, quad, mod 
                                        etc. fuer Acryl  MC
   DATE Earith        : 920331.940315
H*/                                                             
                                                                       

/* 
Hinweis (06.12.1993): 
	Auf HP funktioniert folgendes nicht: 
		p = q - n; 
	mit p und q Pointer auf irgendetwas und n vom Typ 
	unsigned. 
	Der Compiler reklamiert das nicht. Das Programm liefert 
	aber Mist.  
	Man muss in diesem Fall 
		p = q - (int) n; 
	schreiben. 
	Ich habe "sicherheitshalber" auch Zuweisungen der Form 
		p = q + n; 
	in  
		p = q + (int) n; 
	umgeschrieben.
	Marc Conrad.
*/
	
	

#include <_arith1.h>
#include <_essen.h>
#include <_Earith.h>     
                                                                 
#ifdef __GNUC__
#define E_USE_LONGLONG
#endif

/* Definitionen aus Acryl (AA_ durch E_ ersetzt):  */
#ifdef E_USE_LONGLONG
/* Achtung: unsigned long long ist kein Ansi-C. */
typedef unsigned long long E_LONGLONG;
#endif
#define E_LONG LONG
#define E_SHORT SHORT 
#define E_SHORTBITS SHORTBITS 
#define E_LONGBITS LONGBITS 
#define E_LAENGE LAENGE 

/* Diese sind alle in SIMATH umdefiniert... */
#ifdef USE_NOT_SIMATH_PRINTF
#undef printf
#undef fprintf
#undef fgetc
#undef getc
#undef getchar
#endif

/* Beginn von "arith.aix", im Original wird dieses mit include eingebunden. */

#if DREIVIERTEL
/* Das folgende Makro benutzt die Variablen 			*/
/* SHORT A01, A00, A_DIF, B01, B00, B_DIF;			*/
/* LONG  E1, E0, E_DIF;						*/
/* und berechnet damit 						*/
/* E1 * 2^32 + E0 := (A01 * 2^16 + A00) * (B01 * 2^16 + B00);	*/

#define LONG_MULTIPLIKATION_FALL1 \
E0 = A00 * B00;\
E1 = A01 * B01;\
if (B00 >= B01) {\
	B_DIF = B00 - B01;\
	E_DIF = A_DIF * B_DIF;\
	E_DIF = E0 - E_DIF;\
}\
else {\
	B_DIF = B01 - B00;\
	E_DIF = A_DIF * B_DIF;\
	if ( (E_DIF += E0) < E0 )\
		E1 += (1L << SHORTBITS);\
}\
if ( (E_DIF += E1) < E1 )\
	E1 += (1L << SHORTBITS);\
if ( (E0 += (E_DIF << SHORTBITS)) < (E_DIF << SHORTBITS) )\
	E1++;\
E1 += (E_DIF >> SHORTBITS)\
/* Ende des Makros LONG_MULTIPLIKATION_FALL1.	*/

#define LONG_MULTIPLIKATION_FALL2 \
E0 = A00 * B00;\
E1 = A01 * B01;\
if (B00 <= B01) {\
	B_DIF = B01 - B00;\
	E_DIF = A_DIF * B_DIF;\
	E_DIF = E1 - E_DIF;\
}\
else {\
	B_DIF = B00 - B01;\
	E_DIF = A_DIF * B_DIF;\
	if ( (E_DIF += E1) < E1 )\
		E1 += (1L << SHORTBITS);\
}\
if ( (E_DIF += E0) < E0 )\
	E1 += (1L << SHORTBITS);\
if ( (E0 += (E_DIF << SHORTBITS)) < (E_DIF << SHORTBITS) )\
	E1++;\
E1 += (E_DIF >> SHORTBITS)\
/* Ende des Makros LONG_MULTIPLIKATION_FALL2.	*/

#define LONG_MULTIPLIKATION \
if (A00 >= A01) {\
A_DIF = A00 - A01;\
LONG_MULTIPLIKATION_FALL1;\
}\
else\
{\
A_DIF = A01 - A00;\
LONG_MULTIPLIKATION_FALL2;\
}\
/* Ende des Makros LONG_MULTIPLIKATION.	*/

#else
/* Das folgende Makro benutzt die Variablen 			*/
/* SHORT A01, A00, B01, B00;					*/
/* LONG  E1, E0, H01, H10;					*/
/* und berechnet damit 						*/
/* E1 * 2^32 + E0 := (A01 * 2^16 + A00) * (B01 * 2^16 + B00);	*/

#define LONG_MULTIPLIKATION \
E0 = A00 * B00;\
H01 = A00 * B01;\
H10 = A01 * B00;\
E1 = A01 * B01;\
if ( (E0 += (H01 << SHORTBITS)) < (H01 << SHORTBITS) )\
	E1++;\
if ( (E0 += (H10 << SHORTBITS)) < (H10 << SHORTBITS) )\
	E1++;\
E1 += (H01 >> SHORTBITS) + (H10 >> SHORTBITS);\
/* Ende des Makros LONG_MULTIPLIKATION.	*/
#endif      

#if DREIVIERTEL
/* Das folgende Makro benutzt die Variablen 	*/
/* SHORT A01, A00, A_DIF;			*/
/* LONG  E1, E0, E_DIF;				*/
/* und berechnet damit 				*/
/* E1 * 2^32 + E0 := (A01 * 2^16 + A00)^2;	*/

#define LONG_QUADRAT \
E0 = A00 * A00;\
E1 = A01 * A01;\
if (A00 >= A01) {\
	A_DIF = A00 - A01;\
	E_DIF = A_DIF * A_DIF;\
	E_DIF = E0 - E_DIF;\
	if ( (E_DIF += E1) < E1 )\
		E1 += (1L << SHORTBITS);\
}\
else {\
	A_DIF = A01 - A00;\
	E_DIF = A_DIF * A_DIF;\
	E_DIF = E1 - E_DIF;\
	if ( (E_DIF += E0) < E0 )\
		E1 += (1L << SHORTBITS);\
}\
if ( (E0 += (E_DIF << SHORTBITS)) < (E_DIF << SHORTBITS) )\
	E1++;\
E1 += (E_DIF >> SHORTBITS)\
/* Ende des Makros LONG_QUADRAT.	*/
#else
/* Das folgende Makro benutzt die Variablen 			*/
/* SHORT A01, A00, B01, B00;					*/
/* LONG  E1, E0, H01;						*/
/* und berechnet damit 						*/
/* E1 * 2^32 + E0 := (A01 * 2^16 + A00) * (B01 * 2^16 + B00);	*/

#define LONG_QUADRAT \
E0 = A00 * A00;\
H01 = A00 * A01;\
E1 = A01 * A01;\
if ( (E0 += (H01 << SHORTBITS)) < (H01 << SHORTBITS) )\
	E1++;\
if ( (E0 += (H01 << SHORTBITS)) < (H01 << SHORTBITS) )\
	E1++;\
E1 += ( (H01 >> SHORTBITS) << 1);\
/* Ende des Makros LONG_QUADRAT.	*/
#endif
/* Das folgende Makro benutzt die Variablen		*/
/* SHORT Z11, Z10, Z01, Z00, N01, N00, E01, E00;	*/
/* LONG  Z1, Z0, N0, E0, R0;				*/
/* und berechnet damit 					*/
/* E0 := (Z1 * 2^LONGBITS + Z0) / N0;			*/
/* R0 := (Z1 * 2^LONGBITS + Z0) % N0;			*/
/* In den folgenden Kommentaren wird anstelle von	*/
/* LONGBITS die Zahl 32 und anstelle von SHORTBITS die	*/
/* Zahl 16 benutzt.					*/

#define LONG_DIVISION \
Z11 = (SHORT)(Z1 >> SHORTBITS);\
Z10 = (SHORT) Z1;\
Z01 = (SHORT)(Z0 >> SHORTBITS);\
Z00 = (SHORT) Z0;\
N01 = (SHORT)(N0 >> SHORTBITS);\
N00 = (SHORT) N0;\
/* Es gilt 			*/\
/* Z1 = Z11 * 2^SHORTBITS + Z10 ,	*/\
/* Z0 = Z01 * 2^SHORTBITS + Z00 ,	*/\
/* N0 = N01 * 2^SHORTBITS + N00 .	*/\
\
/* Wir berechnen zunaechst	 					*/\
/* E01 = ( Z11 * 2^32 + Z10 * 2^16 + Z01 ) / (N01 * 2^16 + N00) .	*/\
\
if (N01 + 1)\
	E01 = (SHORT) (Z1/(N01 + 1));	/*   Es gilt  N01 + 1 <= 2^16	*/\
else\
	E01 = Z11;\
\
/*   Es gilt auf Grund der Voraussetzungen  E01 < 2^16 .  Ferner ist E01 definiert durch			*/\
/*   E01 * (N01 + 1) <= Z1 < (E01 + 1) * (N01 + 1) .								*/\
/*   Es folgt													*/\
/*   E01 * (N01 * 2^16 + N00) <= E01 * (N01 + 1) * 2^16 <= Z1 * 2^16 <= Z11 * 2^32 + Z10 * 2^16 + Z01 .		*/\
/*   Andererseits gilt wegen  E01 < 2^16  und  2^31 <= N0 , also  2^15 <= N01					*/\
/*   (E01 + 3) * N01 = (E01 + 1) * N01 + 2 * N01 >= (E01 + 1) * N01 + 2^16 >= (E01 + 1) * (N01 + 1) > Z1 .	*/\
/*   Es folgt 													*/\
/*   (E01 + 3) * N01 >= Z1 + 1											*/\
/*   und somit													*/\
/*   (E01 + 3) * N0 = (E00 + 3) * (N01 * 2^16 + N00) >= (Z1 + 1) * 2^16 > Z11 * 2^32 + Z10 * 2^16 + Z01 .	*/\
/*   Insgesamt ist deshalb der gesuchte Wert zwischen E01 und E01 + 2 .						*/\
/* Wir subtrahieren jetzt E01 * (N01 * 2^16 + N00) von Z11 * 2^32 + Z10 * 2^16 + Z01 .				*/\
help = E01 * N00;					/* help <= (2^16 - 1)^2 .			*/\
if (Z01 < (SHORT)(help)) {\
	Z01 -= (SHORT)(help);\
	help = (help >> SHORTBITS) + (E01 * N01) + 1L;	/* help <= (2^16 - 1)^2 + 2^16 < 2^32 .		*/\
}\
else {\
	Z01 -= (SHORT)(help);\
	help = (help >> SHORTBITS) + (E01 * N01); 	/* help <= (2^16 - 1)^2 + 2^16 - 1 < 2^32 .	*/\
}\
if (Z10 < (SHORT)(help))\
	Z11 -= (SHORT)(help >> SHORTBITS) + 1;\
else\
	Z11 -= (SHORT)(help >> SHORTBITS);\
Z10 -= (SHORT)(help);\
/* Die Subtraktion ist nun beendet. Es gilt Z11 in {0,1,2}.							*/\
/* Wir muessen nun feststellen, wie oft wir noch								*/\
/* (N01 * 2^16 + N00) von (Z11 * 2^32 + Z10 * 2^16 + Z01) subtrahieren koennen.					*/\
/* Wenn dies nicht mehr moeglich ist, ist E01 bereits richtig berechnet.					*/\
/* Wenn dies ein  mal moeglich ist, muss noch 1 auf E01 addiert werden.						*/\
/* Wenn dies zwei mal moeglich ist, muss noch 2 auf E01 addiert werden.						*/\
\
Z_MID = ( (Z10) << SHORTBITS ) | (Z01);			/* Z_MID = Z10 * 2^16 + Z01 .			*/\
switch (Z11) {\
	case 0: if (N0 <= Z_MID) {\
			E01++;\
			Z_MID -= N0;\
			Z10 = (SHORT)(Z_MID >> SHORTBITS);\
			Z01 = (SHORT)Z_MID;\
		}\
		break;\
	case 1: if ( (N0 << 1) <= Z_MID ) {\
			E01 += 2;\
			Z_MID -= (N0 << 1);\
		}\
		else {\
			E01++;\
			Z_MID -= N0;\
		}\
		Z10 = (SHORT)(Z_MID >> SHORTBITS);\
		Z01 = (SHORT)Z_MID;\
		break;\
	case 2: E01 += 2;\
		Z_MID -= (N0 << 1);\
		Z10 = (SHORT)(Z_MID >> SHORTBITS);\
		Z01 = (SHORT)Z_MID;\
}\
/* Nun ist E01 richtig berechnet.	*/\
/* Wir berechnen nun				 						*/\
/* E00 = (Z_MID * 2^16 + Z00) / N0 == ( Z10 * 2^32 + Z01 * 2^16 + Z00 ) / (N01 * 2^16 + N00) .	*/\
\
if (N01 + 1)\
	E00 = (SHORT) (Z_MID/(N01 + 1));	/*   Es gilt  N01 + 1 <= 2^16	*/\
else\
	E00 = Z10;\
\
/*   Es gilt auf Grund der Voraussetzungen  E00 < 2^16 .  Ferner ist E00 definiert durch			*/\
/*   E00 * (N01 + 1) <= Z_MID < (E00 + 1) * (N01 + 1) .								*/\
/*   Es folgt													*/\
/*   E00 * (N01 * 2^16 + N00) <= E00 * (N01 + 1) * 2^16 <= Z_MID * 2^16 <= Z10 * 2^32 + Z01 * 2^16 + Z00 .	*/\
/*   Andererseits gilt wegen  E00 < 2^16  und  2^31 <= N0 , also  2^15 <= N01					*/\
/*   (E00 + 3) * N01 = (E00 + 1) * N01 + 2 * N01 >= (E00 + 1) * N01 + 2^16 >= (E00 + 1) * (N01 + 1) > Z_MID .	*/\
/*   Es folgt 													*/\
/*   (E00 + 3) * N01 >= Z_MID + 1										*/\
/*   und somit													*/\
/*   (E00 + 3) * N0 = (E00 + 3) * (N01 * 2^16 + N00) >= (Z_MID + 1) * 2^16 > Z10 * 2^32 + Z01 * 2^16 + Z0 .	*/\
/*   Insgesamt ist deshalb der gesuchte Wert zwischen E00 und E00 + 2 .						*/\
\
/* Wir subtrahieren jetzt E00 * (N01 * 2^16 + N00) von Z10 * 2^32 + Z01 * 2^16 + Z00 .				*/\
help = E00 * N00;					/* help <= (2^16 - 1)^2 .			*/\
if (Z00 < (SHORT)(help)) {\
	Z00 -= (SHORT)(help);\
	help = (help >> SHORTBITS) + (E00 * N01) + 1L;	/* help <= (2^16 - 1)^2 + 2^16 < 2^32 .	 	*/\
}\
else {\
	Z00 -= (SHORT)(help);\
	help = (help >> SHORTBITS) + (E00 * N01); 	/* help <= (2^16 - 1)^2 + 2^16 - 1 < 2^32 .	*/\
}\
if (Z01 < (SHORT)(help))\
	Z10 -= (SHORT)(help >> SHORTBITS) + 1;\
else\
	Z10 -= (SHORT)(help >> SHORTBITS);\
Z01 -= (SHORT)(help);\
/* Die Subtraktion ist nun beendet. Es gilt Z10 in {0,1,2} .	*/\
\
/* Wir muessen nun feststellen, wie oft wir noch								*/\
/* (N01 * 2^16 + N00) von (Z10 * 2^32 + Z01 * 2^16 + Z00) subtrahieren koennen.					*/\
/* Wenn dies nicht mehr moeglich ist, ist E00 bereits richtig berechnet.					*/\
/* Wenn dies ein  mal moeglich ist, muss noch 1 auf E00 addiert werden.						*/\
/* Wenn dies zwei mal moeglich ist, muss noch 2 auf E00 addiert werden.						*/\
Z_MID = ( (Z01) << SHORTBITS ) | (Z00);			/* Z_MID = Z01 * 2^16 + Z00 .			*/\
switch (Z10) {\
	case 0: if (N0 <= Z_MID) {\
			E00++;\
			Z_MID -= N0;\
			Z01 = (SHORT)(Z_MID >> SHORTBITS);\
			Z00 = (SHORT)Z_MID;\
		}\
		break;\
	case 1: if ( (N0 << 1) <= Z_MID ) {\
			E00 += 2;\
			Z_MID -= (N0 << 1);\
		}\
		else {\
			E00++;\
			Z_MID -= N0;\
		}\
		Z01 = (SHORT)(Z_MID >> SHORTBITS);\
		Z00 = (SHORT)Z_MID;\
		break;\
	case 2: E00 += 2;\
		Z_MID -= (N0 << 1);\
		Z01 = (SHORT)(Z_MID >> SHORTBITS);\
		Z00 = (SHORT)Z_MID;\
}\
/* Nun ist E00 richtig berechnet.	*/\
E0 = (E01 << SHORTBITS) | (E00);\
R0 = (Z01 << SHORTBITS) | (Z00);\
/* Ende des Makros LONG_DIVISION.	*/
#define TRANS(ZAHL,ERGEBNIS,E_ZAHL) \
E_ZAHL = ZAHL + *ZAHL;\
do\
	*ERGEBNIS++ = *ZAHL++;\
while (ZAHL <= E_ZAHL);

#define ZWEI_ANTEIL(Z_ZA,V) \
while (!(HELP & TEST)) {\
	V++;\
	if (!(TEST <<= 1)) {\
		HELP = *(++Z_ZA);\
		TEST = 1L;\
	}\
}



/* Ende von arith.aix        					*/

/* Folgende Variablen sind fuer statistische Auswertungen.	*/
/* Statistische Auswertungen werden nur dann gemacht,		*/
/* wenn mit der Compileroption -DSTAT compiliert wird.		*/

#ifdef STAT
	LONG ANZ_ADD = 0;
	LONG ANZ_SUB = 0;
	LONG ANZ_MULT = 0;
	LONG ANZ_QUAD = 0;
	LONG ANZ_SHIFT = 0;
	LONG ANZ_DIV = 0;
	LONG ANZ_COMP = 0;
	LONG ANZ_TRANS = 0;
#endif

/* Definition einiger Konstanten :	*/

LONG ZERO[1] = {0L};
LONG ONE[2] = {1L,1L};
LONG TWO[2] = {1L,2L};
LONG THREE[2] = {1L,3L};
LONG FOUR[2] = {1L,4L};
LONG FIVE[2] = {1L,5L};
LONG SIX[2] = {1L,6L};
LONG TEN[2] = {1L,10L};
LONG TWELVE[2] = {1L,12L};
LONG THIRTEEN[2] = {1L,13L};
LONG TWENTYSEVEN[2] = {1L,27L};
LONG HUNDRED[2] = {1L,100L};
LONG THOUSAND[2] = {1L,1000L};
LONG TWOTHOUSAND[2] = {1L,2000L};
LONG FIVETHOUSAND[2] = {1L,5000L};
LONG FIFTEENTHOUSANDFIFTEEN[2] = {1L,15015L};
/**/
add(zahl1,zahl2,ergebnis)
LONG  zahl1[], zahl2[], ergebnis[];
/* Eingabeparameter : zahl1, zahl2;							*/
/* Ausgabeparameter : ergebnis;								*/
/* Wirkung :          ergebnis := zahl1 + zahl2;					*/
/* Returncode :       Keiner.								*/
/* Overflow :         falls anzahl_bits(zahl1 + zahl2) > LONGBITS * (LAENGE - 1) .	*/
{
	LONG  *z_zahl1, *z_za1, *e_za1, *z_za2, *e_za2, *z_erg;
	LONG  stellen1, stellen2, carry = 0L, help ;

#ifdef STAT
	++ANZ_ADD;
#endif		

	z_erg = ergebnis + 1;
	if (*zahl1 >= *zahl2) {
		z_zahl1 = z_za1 = zahl1;
		z_za2 = zahl2;
	}
	else {
		z_zahl1 = z_za1 = zahl2;
		z_za2 = zahl1;
	}
	/* z_za1 zeigt auf die laengere der beiden Zahlen.	*/

	stellen1 = *z_za1++;
	stellen2 = *z_za2++;
	/* Nun zeigt z_za1 auf das erste LONG des laengeren Summanden,	*/
	/* z_za2 auf das erste LONG des kuerzeren Summanden.		*/
	/* Es ist stellen1 >= stellen2 .				*/

	if (!stellen2) { /* Die kleinere der beiden Zahlen ist 0.	*/
		if (z_zahl1 != ergebnis)
			trans(z_zahl1,ergebnis);
		return;
	}
/**/
	e_za1 = z_za1 + (int) stellen1;
	e_za2 = z_za2 + (int) stellen2;
	/* Addiere zunaechst bis e_za2.	*/
	do {
		/* Addiere die LONG, auf die z_za1 bzw. z_za2 zeigen und den carry.	*/
		/* Inkrementiere den Zeiger z_za2; der Zeiger z_za1 wird im 		*/
		/* naechsten Statement erhoeht. 					*/
		help = *z_za2++ + carry;
		if ((!help) && (carry)) /* Dies ist genau dann der Fall, wenn help == 0  und  carry == 1 .	*/
			*z_erg++ = *z_za1++;
		else {
			*z_erg++ = carry = *z_za1++ + help;
			carry = (carry < help);
			/* carry = 1  falls carry < help,	*/
			/* carry = 0  sonst.			*/
		}
	} while (z_za2 < e_za2);
	/* z_za2 ist hier erschoepft.	*/

	/* Es gilt : carry == 0 oder carry == 1 .	*/
	if (stellen1 == stellen2) { /* z_za1 ist ebenfalls erschoepft.	*/
		if (carry) {
			if ((*ergebnis = stellen1 + 1L) >= LAENGE)
				overflow("add : Overflow!");
			*z_erg = 1L;
		}
		else
			*ergebnis = stellen1;
		return;
	}

	/* z_za1 ist noch nicht erschoepft.	*/
	while ( (z_za1 < e_za1) && (carry) ) {
		*z_erg++ = carry += *z_za1++;
		carry = !carry;
	}
	/* Nach Verlassen dieser Schleife ist carry == 0 oder z_za1 == e_za1.	*/

	if (carry) { /* dann ist carry == 1 und somit z_za1 == e_za1 .		*/
		if ((*ergebnis = stellen1 + 1L) >= LAENGE)
			overflow("add : Overflow!");
		*z_erg = 1L;
		return;
	}

	/* Es gilt carry == 0 .							*/
	/* Falls z_zahl1 != ergebnis ist, muss der Rest noch kopiert werden.	*/
	if (z_zahl1 != ergebnis) {
		if (z_za1 < e_za1) {
			do 
				*z_erg++ = *z_za1++;
			while (z_za1 < e_za1);
		}
		*ergebnis = stellen1;
	}
}
/**/
sub(zahl1,zahl2,ergebnis)
LONG  zahl1[], zahl2[], ergebnis[];
/* Eingabeparameter : zahl1, zahl2;					*/
/* Ausgabeparameter : ergebnis;						*/
/* Wirkung :          ergebnis := zahl1 - zahl2;  falls zahl1 >= zahl2,	*/
/*                    ergebnis := undefiniert;    sonst.		*/
/* Returncode :       -1  falls zahl1 < zahl2,				*/
/*                     0  sonst.					*/
/* Overflow :         Keiner.						*/
{
	LONG  *z_za1, *e_za1, *z_za2, *e_za2, *z_erg;
	LONG  stellen1, stellen2, carry = 0L, help ;

#ifdef STAT
	++ANZ_SUB;
#endif		

	if ( (stellen1 = *zahl1) < (stellen2 = *zahl2) )
		return(-1); /* Ergebnis waere negativ.	*/
	/* Nun gilt stellen1 >= stellen2.	*/

	if ( (stellen1 == stellen2) && (*(zahl1+stellen1) < *(zahl2+stellen2)) )
		return(-1);  /* Ergebnis waere negativ.	*/

	z_za1 = zahl1 + 1;
	z_za2 = zahl2 + 1;
	z_erg = ergebnis + 1;
	/* Nun zeigt z_za1 auf das erste LONG von zahl1	*/
	/* und z_za2 auf das erste LONG von zahl2.	*/
	/* Es ist stellen1 >= stellen2.			*/

	if (!stellen2) { /* zahl2 ist 0.	*/
		if (zahl1 != ergebnis)
			trans(zahl1,ergebnis);
		return(0);
	}
	e_za1 = z_za1 + (int) stellen1;
	e_za2 = z_za2 + (int) stellen2;
	/* Subtrahiere zunaechst bis e_za2.	*/
	do {
		help = *z_za2++ + carry;
		if ((!help) && (carry)) /* Dies ist genau dann der Fall, wenn help == 0  und  carry == 1.	*/
			*z_erg++ = *z_za1++;
		else {
			carry = (*z_za1 < help);
			/* carry = 1  falls *z_za1 < help,					*/
			/* carry = 0  sonst. 							*/
			/* Man beachte, dass der neue carry bestimmt werden muss, bevor		*/
			/* man *z_erg setzt, fuer den Fall, dass zahl1 == ergebnis ist.		*/
			*z_erg++ = *z_za1++ - help;
		}
	} while (z_za2 < e_za2);
	/* z_za2 ist hier erschoepft.	*/
/**/
	/* Es gilt : carry == 0 oder carry == 1 .	*/
	if (stellen1 == stellen2) { /* z_za1 ist ebenfalls erschoepft.	*/
		if (!carry) { /* carry == 0 .	*/
			while ((!(*--z_erg)) && (stellen1))
				--stellen1;
			*ergebnis = stellen1;
			return(0);
		}
		else
			return(-1);
	}

	/* z_za1 ist noch nicht erschoepft.	*/
	while ( (z_za1 < e_za1) && (carry) ) {
		carry = *z_za1++ - carry;
		*z_erg++ = carry;
		carry = (carry == (LONG)(-1L));
	}
	/* Nach Verlassen dieser Schleife ist carry == 0 oder z_s1 == e_za1 .	*/

/* Diese Schleife laesst sich vielleicht besser formulieren :
Man weiss, dass carry nur 0 oder 1 ist.
Die Schleife laeuft nur so lange, bis *z_za1 > 0.
while ( (i <= stellen)  && (!*s1) ) {
	*diff++ = -1;
	i++;
	s1++;
}
*/
		
	if (carry) /* dann ist carry == 1 und somit z_s1 == e_za1 .	*/
		return(-1);
	
	/* Es gilt carry == 0.	*/
	/* Falls zahl1 != ergebnis ist, muss der Rest noch kopiert werden.	*/
	if (zahl1 != ergebnis) {
		if (z_za1 < e_za1) {
			do 
				*z_erg++ = *z_za1++;
			while (z_za1 < e_za1);
		}
		else { /* z_za1 == e_za1 .	*/
			while ((!(*--z_erg)) && (stellen1))
				--stellen1;
		}
		*ergebnis = stellen1;
		return(0);
	}

	/* Es gilt zahl1 == ergebnis.	*/
	if (z_za1 == e_za1) {
		while ((!(*--z_erg)) && (stellen1))
			--stellen1;
	}
	*ergebnis = stellen1;
	return(0);
}
/**/
incr(zahl)
LONG  zahl[];
/* Eingabeparameter : zahl;					*/
/* Ausgabeparameter : zahl;					*/
/* Wirkung :          zahl := zahl + 1;				*/
/* Returncode :       Keiner.					*/
/* Overflow :         falls zahl == (2^LONGBITS)^LAENGE - 1 .	*/
{
	LONG  *z_zahl;
	LONG  i;

	z_zahl = zahl + 1;
	for (i = 0L; i < *zahl; i++) {
		if (!(++(*z_zahl)))
			++z_zahl;
		else
			return;
	}
	++(*zahl);
	if (*zahl >= LAENGE)
		overflow("incr : Overflow!");
	*z_zahl = 1L;
}

decr(zahl)
LONG  zahl[];
/* Eingabeparameter : zahl;					*/
/* Ausgabeparameter : zahl;					*/
/* Wirkung :          zahl := zahl - 1;     falls zahl >= 1,	*/
/*                    zahl := undefiniert;  falls zahl <  1.	*/
/* Returncode :       -1  falls zahl < 1,			*/
/*                     0  sonst.				*/
/* Overflow :         Keiner.					*/
{
	LONG  *z_zahl;
	LONG  i;

	z_zahl = zahl + 1;
	for (i = 1L; i <= *zahl; i++) {
		if (!(*z_zahl)) {
			--(*z_zahl);
			++z_zahl;
		}
		else {
			--(*z_zahl);
			if (!(*z_zahl)) 
				if (i == *zahl)
					--(*zahl);
			return(0);
		}
	}
	return(-1);
}
/**/
/* mult(zahl1,zahl2,ergebnis) */
/* LONG  zahl1[], zahl2[], ergebnis[]; */
/* Eingabeparameter : zahl1, zahl2;				*/
/* Ausgabeparameter : ergebnis;					*/
/* Wirkung :          ergebnis := zahl1 * zahl2;		*/
/* Returncode :       Keiner.					*/
/* Overflow :         falls lb(zahl1) + lb(zahl2) >= LONGBITS * (LAENGE - 1),*/
/*                    denn lb(zahl1 * zahl2) >= lb(zahl1) + lb(zahl2) .	*/
/* Marc Conrad, 201098: Einbau beschleunigter neuer Funktionen: 
	Dieses File enthaelt die folgenden Funktionen: 
	Ezmult(a,b,e): e = a * b; es muss gelten: e zeigt 
		auf anderen Speicherbereich als a und b.
	Ezmulteq(a,b): a = a * b; es muss gelten: a und 
		b zeigen auf verschiedene Speicherbereiche.
	Achtung: Kein Test auf Overflow!
	Emult(a,b,e):  e = a * b; 
	Emulteq(a,b):  a = a * b; 
	Rueckgabewert -1 bei Overflow, sonst 0. 
*/
/* Die Uebereinstimmungen von Ezmult mit E_LONGLONG und ohne 
E_LONGLONG sind gering, daher werden beide Versionen komplett 
getrennt. */
#ifdef E_USE_LONGLONG
#define llprod(A,B) (((E_LONGLONG) (A)) * ((E_LONGLONG) (B)))

static int Ezmult(E_LONG *a, E_LONG *b, E_LONG *e)
{
	E_LONG A;
	E_LONG *pee, *pe, *pb;
	E_LONG  lb,  lbb, la;
	E_LONGLONG  prod; 
        
	if( !(lb = lbb = *b++)) { *e = 0; return(0); } 
	if( (la = *a) ) {
		*(pe = pee = (e + 1)) = 
		    ((E_LONG) (prod = llprod((A = *++a),*(pb = b)))); 
		prod >>= E_LONGBITS; 
		while (--lb) {
			*++pe = (E_LONG) (prod += llprod(A,*++pb)); 
			prod >>= E_LONGBITS; 
			}
	} else { *e = 0; return(0); } 

	while (--la) {
		*++pe = (E_LONG) prod;  
                pe = ++pee;
		*pe = (E_LONG) (prod = 
			llprod((A = *++a),*(pb = b)) + 
					(E_LONGLONG) (*pe)); 
		prod >>= E_LONGBITS; 
		lb = lbb; 
		while (--lb) {
                        ++pe;
			*pe = (E_LONG) ( 
			  prod += (llprod(A,*++pb) + (E_LONGLONG) (*pe))); 
			prod >>= E_LONGBITS; 
			}
		}
	if (prod) { *++pe = (E_LONG) prod; } 
	*e = pe - e; 
	return(0);
/* Ezmult() */ }
#else 
#define LMULT1(A00, A01,B00, B01,E0, E1, E_DIF) \
E0 = A00 * B00; E1 = A01 * B01;\
if (B00 >= B01) {\
	E_DIF = E0 - ((A00 - A01) * (B00 - B01));\
}\
else { E_DIF = (A00 - A01) * (B01 - B00);\
	if ( (E_DIF += E0) < E0 )\
		E1 += (1L << E_SHORTBITS);\
}\
if ( (E_DIF += E1) < E1 )\
	E1 += (1L << E_SHORTBITS);\
if ( (E0 += (E_DIF << E_SHORTBITS)) < (E_DIF << E_SHORTBITS) )\
	E1++;\
E1 += (E_DIF >> E_SHORTBITS)

#define LMULT2(A00,A01,B00,B01,E0,E1,E_DIF) \
E0 = A00 * B00; E1 = A01 * B01;\
if (B00 <= B01) { E_DIF = E1 - ((A01 - A00) * (B01 - B00));\
}\
else {\
	E_DIF = (A01 - A00) * (B00 - B01);\
	if ( (E_DIF += E1) < E1 )\
		E1 += (1L << E_SHORTBITS);\
}\
if ( (E_DIF += E0) < E0 )\
	E1 += (1L << E_SHORTBITS);\
if ( (E0 += (E_DIF << E_SHORTBITS)) < (E_DIF << E_SHORTBITS) )\
	E1++;\
E1 += (E_DIF >> E_SHORTBITS)

static int Ezmult(E_LONG *a, E_LONG *b, E_LONG *e)
{
	E_SHORT A00, A01, B00, B01;
	E_LONG  E0, E1, E_DIF;
	
	E_LONG *pee, *pe, *pb;
	E_LONG  lb, carry, lbb, la;
        
	if( !(lbb = *b++)) { *e = 0; return(0); } 
	if((la = *a)) {
		B00 = (E_SHORT)(E0 = *(pb = b));
		B01 = (E_SHORT)(E0 >> E_SHORTBITS);
		lb = lbb; 
		if( (A00 = (E_SHORT) (E0 = *++a)       ) >= 
		    (A01 = (E_SHORT)((E0) >> E_SHORTBITS)) ){ 
			LMULT1(A00,A01,B00,B01,E0,carry,E_DIF);
			*(pe = pee = (e + 1)) = E0; 
			while (--lb) {
				B00 = (E_SHORT)(E0 = *++pb);
				B01 = (E_SHORT)(E0 >> E_SHORTBITS);
				LMULT1(A00,A01,B00,B01,E0,E1,E_DIF);
				if ( (E0 += carry) < carry ) E1++;
				*++pe = E0; carry = E1;
			}
		}
		else {
			LMULT2(A00,A01,B00,B01,E0,carry,E_DIF);
			*(pe = pee = (e + 1)) = E0; 
			while (--lb) {
				B00 = (E_SHORT)(E0 =  *++pb);
				B01 = (E_SHORT)(E0 >> E_SHORTBITS);
				LMULT2(A00,A01,B00,B01,E0,E1,E_DIF); 
				if ( (E0 += carry) < carry ) E1++;
				*++pe = E0; carry = E1;
			}
		}
	} else { *e = 0; return(0); } 
	
	while (--la) {
		B00 = (E_SHORT)(E0 = *(pb = b));
		B01 = (E_SHORT)(E0 >> E_SHORTBITS);
		lb = lbb; 
		if( (A00 = (E_SHORT) (E0 = *++a)       ) >= 
		    (A01 = (E_SHORT)((E0) >> E_SHORTBITS)) ){ 
			*++pe = carry;  
			LMULT1(A00,A01,B00,B01,E0,carry,E_DIF);
			if ( (*(pe = ++pee) += E0) < E0 ) carry++;
			while (--lb) {
				B00 = (E_SHORT)(E0 = *++pb);
				B01 = (E_SHORT)(E0 >> E_SHORTBITS);
				LMULT1(A00,A01,B00,B01,E0,E1,E_DIF); 
				if ( (E0 += carry) < carry ) E1++;
				if ( (*++pe += E0) < E0 ) E1++;
				carry = E1;
			}
		}
		else {
			*++pe = carry;  
			LMULT2(A00,A01,B00,B01,E0,carry,E_DIF);
			if ( (*(pe = ++pee) += E0) < E0 ) carry++;
			while (--lb) {
				B00 = (E_SHORT)(E0 =  *++pb);
				B01 = (E_SHORT)(E0 >> E_SHORTBITS);
				LMULT2(A00,A01,B00,B01,E0,E1,E_DIF); 
				if ( (E0 += carry) < carry ) E1++;
				if ( (*++pe += E0) < E0 ) E1++;
				carry = E1;
			}
		}
	}
	if (carry) { *++pe = carry; } 
	*e = pe - e; 
	return( 0 );
/* Ezmult() */ }
#endif

/* a = a * b */
static int Ezmulteq(E_LONG *a,E_LONG *b) 
{
	E_LONG *aa;
	E_LONG la; 

	a +=  (la = *a); 
	aa = a + (*b);		

	*aa = *a; 
	while(la--) { *--aa = *--a; }
	return(Ezmult(aa,b,a)); 
/* Ezmulteq() */ }

int Emult(E_LONG *a,E_LONG *b,E_LONG *e) 
{
	E_LONG h[E_LAENGE];

	if( a == b ) { return(Equad(a,e)); } 
	if (  (*a + *b >= E_LAENGE - 1L)  && 
	      ((Elb(a) + Elb(b))       >= 
	      (E_LONGBITS*(E_LAENGE - 1L)) )){ return(-1); }

	Ezmult(a,b,h);
	Etrans(h,e);
	return 0; 
/* Emult() */ } 

int Emulteq(E_LONG *a,E_LONG *b) 
{
	E_LONG h[E_LAENGE];

	if( a == b ) { return(Equad(b,a)); } 
	if (  (*a + *b >= E_LAENGE - 1L)  && 
	      ((Elb(a) + Elb(b))       >= 
	      (E_LONGBITS*(E_LAENGE - 1L)) )){ return(-1); }

	Ezmult(a,b,h);
	Etrans(h,a);
	return 0; 
/* Emulteq() */ } 
/**/
/*
Equad(zahl,ergebnis)
LONG  zahl[], ergebnis[];
*/
/* Eingabeparameter : zahl;						*/
/* Ausgabeparameter : ergebnis;						*/
/* Wirkung :          ergebnis := zahl^2;				*/
/* Returncode :       Keiner.						*/
/* Overflow :         falls 2 * lb(zahl) >= LONGBITS * (LAENGE - 1) ,	*/
/*                    denn lb(zahl^2) >= 2 * lb(zahl) .			*/
/* Marc Conrad, 201098: Einbau beschleunigter neuer Funktionen (aus Acryl):*/
/* 
	Dieses File enthaelt folgende Funktionen:
	static int Ezquad(a,e): Berechnet e = a * a. Dabei muss 
		gelten, dass  a und e auf verschiedene
		Speicherbereiche zeigen. Kein Test auf Overflow.
	static int Ezquadeq(a): Berechnet a = a * a. Kein Test auf 
		Overflow. (Rueckgabewert 0)
	int Equad(a,e): Berechnet e = a * a. 
	int Equadeq(a): Berechnet a = a * a.
	Rueckgabe -1 falls Overflow auftritt, 0 sonst. 
*/
/* Zunaechst fuer unsigned long long */
#ifdef E_USE_LONGLONG
/* Quadrieren nach folgendem Algorithmus: Zunaechst werden alle
gemischten Terme ausgerechnet, anschliessend ein Linksshift, 
das heisst Multiplikation mit 2, dann die Quadrate dazuaddiert. */

static int Ezquad(E_LONG *a, E_LONG *e)
{
	E_LONGLONG prod;
	E_LONG *pee, *pe, *pb, *aa;

	E_LONG  A, AX;
	E_LONG  lb, lbb, la;
        
	la = *a++; 
	/* triviale Faelle, a == 0 oder a nur ein Wort */
	if( !(la--)) { *e = 0L; return(0); } 
	if(!(lbb = la--)) {
		A = *a;
		pe = e+1; 
		*pe++ = (E_LONG) (prod = llprod(A,A));
		if( (prod >>= E_LONGBITS) ) {
			*pe = (E_LONG) prod; *e = 2L;
		} else { *e = 1L; } 
		return(0); 
		}
	/* Ausrechnen der gemischten Terme */
	aa = a; 
	A = *a++; 
	*(pe = e+2) = (E_LONG) (prod = llprod(A,(AX = *a)));
	prod >>= E_LONGBITS;
	if((lb = la)) {
		*++pe = (E_LONG) (prod += llprod(A,*(pb = a+1)));
		prod >>= E_LONGBITS;
	        while (--lb) {
		    *++pe = (E_LONG) (prod += llprod(A,*++pb));
		    prod >>= E_LONGBITS;
		}
            }	
	    pee = e + 4; 
	    while (la-- ) {
	        *++pe = (E_LONG) prod;
		A = AX; 
                pe = pee; 
		*pe = (E_LONG) (prod = 
			llprod(A,(AX = *(pb = ++a))) 
					+ (E_LONGLONG) (*pe));
		pee += 2; 
		prod >>= E_LONGBITS;
		if( (lb = la) ){ 
                    ++pe;
		    *pe = (E_LONG) ( prod += 
			(llprod(A,*++pb) + (E_LONGLONG) (*pe)));
		    prod >>= E_LONGBITS;
		    while (--lb) {
                        ++pe;
			*pe = (E_LONG) ( prod += 
				(llprod(A,*++pb) + (E_LONGLONG) (*pe)));
			prod >>= E_LONGBITS;
			} 
		    }
	} 
	if( prod ) { *++pe = (E_LONG) prod; } 

	pee = e + 2; 	/* Beginn Linksshift, AX, la, lb Hilfsvariablen */

	la = (((*pee) & (1L << (E_LONGBITS -1)) ) != 0L); 
	*pee <<= 1; 
	while(pee != pe ) { 
		 lb = ((AX = *++pee) & (1L << (E_LONGBITS-1))); 
		*pee = ((AX << 1) | la); 
		 la = (lb != 0L); 
		} 
	if( la ) { *++pee = 1L; } /* Ende Linksshift */
	/* Jetzt werden die Quadrate ausgerechnet, und dazuaddiert. */
	A = *aa;
	*(pe = e+1) = (E_LONG) (prod = llprod(A,A));
	prod >>= E_LONGBITS;
        ++pe;
	*pe = (E_LONG) (prod += (E_LONGLONG) *pe);
	prod >>= E_LONGBITS;

	if( lbb-- ) {  
	    while(lbb--) { 
		A = *++aa;
		prod += llprod(A,A);
		prod += ((E_LONGLONG) *++pe);
		*pe = (E_LONG) prod;
		prod >>= E_LONGBITS;

		prod += (E_LONGLONG) *++pe;
		*pe = (E_LONG) prod;
		prod >>= E_LONGBITS;
		} 
	    A = *++aa;
	    prod += llprod(A,A);
            if( pee != pe ) {
		prod += (E_LONGLONG) *++pe; 
		*pe = (E_LONG) prod; 
                }
            else { *++pe = (E_LONG) prod; ++pee; }
	    prod >>= E_LONGBITS;

            if( pee != pe ) { *++pe += (E_LONG) prod; } 
            else if( prod )  { *++pe  = (E_LONG) prod; }
	     } 
	*e = pe - e; 
	return(0);
/* Ezquad() */ }

#else 	/* E_USE_LONGLONG */

/* Ansi-Version (keine Verwendung von unsigned long long);
hier werden 32bit x 32bit Multiplikationen in den folgenden 
Makros untergebracht. Der verwendete Algorithmus ist der gleiche
wie oben. */ 
/* Das folgende Makro berechnet		 	*/
/* E1 * 2^32 + E0 := (A01 * 2^16 + A00)^2;	*/

#define LQUAD(A00,A01,E0,E1,E_DIF) \
E0 = A00 * A00;\
E1 = A01 * A01;\
if (A00 >= A01) {\
	E_DIF = E0 - ((A00 - A01) * (A00 - A01));\
	if ( (E_DIF += E1) < E1 )\
		E1 += (1L << E_SHORTBITS);\
}\
else {\
	E_DIF = E1 - ((A01 - A00) * (A01 - A00));\
	if ( (E_DIF += E0) < E0 )\
		E1 += (1L << E_SHORTBITS);\
}\
if ( (E0 += (E_DIF << E_SHORTBITS)) < (E_DIF << E_SHORTBITS) )\
	E1++;\
E1 += (E_DIF >> E_SHORTBITS)

static int Ezquad(a, e)
E_LONG  *a, *e;
{
	E_SHORT A00, A01, B00, B01, AX00, AX01;
	E_LONG  E0, E1, E_DIF;
	
	E_LONG *pee, *pe, *pb, *aa;
	E_LONG  llb, carry, lbb, la;
        
	la = *a; 
	if( la > ((E_LAENGE - 2) >> 1)) { 
    		if ( ((Elb(a) << 1) >= (E_LAENGE - 1L) * E_LONGBITS)) {
			return( -1 ); 
			}
		} 
	if( !(la--)) { *e = 0L; return(0); } 
	aa = ++a; 
	if((lbb = la--)) {
		pe = e + 2; 
		A00 = (E_SHORT) (E0 = *a++);
		A01 = (E_SHORT)((E0) >> E_SHORTBITS);
		llb = la; pb = a; 
		AX00 = B00 = (E_SHORT)(E0 = *pb);
		AX01 = B01 = (E_SHORT)(E0 >> E_SHORTBITS);
		if (A00 >= A01) {
			LMULT1(A00,A01,B00,B01,E0,carry,E_DIF);
			*pe = E0; 
			while (llb--) {
				B00 = (E_SHORT)(E0 = *++pb);
				B01 = (E_SHORT)(E0 >> E_SHORTBITS);
				LMULT1(A00,A01,B00,B01,E0,E1,E_DIF); 
				if ( (E0 += carry) < carry ) E1++;
				*++pe = E0; carry = E1;
			}
		}
		else {
			LMULT2(A00,A01,B00,B01,E0,carry,E_DIF);
			*pe = E0; 
			while (llb--) {
				B00 = (E_SHORT)(E0 =  *++pb);
				B01 = (E_SHORT)(E0 >> E_SHORTBITS);
				LMULT2(A00,A01,B00,B01,E0,E1,E_DIF); 
				if ( (E0 += carry) < carry ) E1++;
				*++pe = E0; carry = E1;
			}
		}

	    pee = e + 4; 
	    while (la-- ) {
	        *++pe = carry; 
		pe = pee; pee += 2; 
		llb = la; 
		pb = ++a; 
		A00 = AX00; A01 = AX01; 
		AX00 = B00 = (E_SHORT)(E0 = *pb);
		AX01 = B01 = (E_SHORT)(E0 >> E_SHORTBITS);
		if (A00 >= A01) {
			LMULT1(A00,A01,B00,B01,E0,carry,E_DIF);
			if ( (*pe += E0) < E0 ) carry++;
		    	while (llb--) {
				B00 = (E_SHORT)(E0 = *++pb);
				B01 = (E_SHORT)(E0 >> E_SHORTBITS);
				LMULT1(A00,A01,B00,B01,E0,E1,E_DIF); 
				if ( (E0 += carry) < carry ) E1++;
				if ( (*++pe += E0) < E0 ) E1++;
				carry = E1;
				} 
		}
		else {
			LMULT2(A00,A01,B00,B01,E0,carry,E_DIF);
			if ( (*pe += E0) < E0 ) carry++;
			while (llb--) {
				B00 = (E_SHORT)(E0 =  *++pb);
				B01 = (E_SHORT)(E0 >> E_SHORTBITS);
				LMULT2(A00,A01,B00,B01,E0,E1,E_DIF); 
				if ( (E0 += carry) < carry ) E1++;
				if ( (*++pe += E0) < E0 ) E1++;
				carry = E1;
				} 
		}
	   } 
	} else { 
		A00 = (E_SHORT) (E0 = *aa);
		if( (A01 = (E_SHORT)((E0) >> E_SHORTBITS)) ) { 
			LQUAD(A00,A01, E0, E1, E_DIF); 
			*e++ = 2; *e++ = E0; *e = E1; 
			} 
		else { *e++ = 1; *e = A00 * A00; } 
		return(0); 
		} 
	if( carry ) { *++pe = carry; } 
	pee = e + 2; 	/* Beginn Linksshift */
	carry = (((*pee) & (1L << (E_LONGBITS -1))) != 0L); 
	*pee <<= 1; 
	while(pee != pe ) { 
		 E1 = ((E0 = *++pee) & (1L << (E_LONGBITS -1))); 
		*pee = ((E0 << 1) | carry); 
		carry = (E1 != 0L); 
		} 
	if( carry ) { *++pee = 1L; } /* Ende Linksshift */

	pe = e+1; 
	A00 = (E_SHORT) (E0 = *aa);
	A01 = (E_SHORT)((E0) >> E_SHORTBITS);
	LQUAD(A00,A01, E0, E1, E_DIF); 
	*pe = E0; 
	carry  = ((*++pe += E1) < E1 ); 

	if( lbb-- ) {  
	    while(lbb--) { 
		A00 = (E_SHORT) (E0 = *++aa);
		A01 = (E_SHORT)((E0) >> E_SHORTBITS);
		LQUAD(A00,A01, E0, E1, E_DIF); 
		if( carry && !++E0 ) E1++; 
		if ( (*++pe += E0) < E0 ) E1++;
		carry = ((*++pe += E1) < E1 ); 
		} 
	    LQUAD(B00,B01, E0, E1, E_DIF); 
	    if( carry && !++E0 ) E1++; 
            if( pee != pe ) {
                if ( (*++pe += E0) < E0 ) E1++;
                }
            else { *++pe = E0; ++pee; }

            if( pee != pe ) { *++pe += E1; } 
            else if( E1 )  { *++pe  = E1; }

	     } 
	*e = pe - e; 
	return(0);
/* Ezquad() */ }
#endif 	/* E_USE_LONGLONG */

static int Ezquadeq(E_LONG *e) { 
	E_LONG h[E_LAENGE]; 
	Etrans(e,h);
	return(Ezquad(h,e));
/* Ezquadeq() */ }

int Equad(E_LONG *a, E_LONG *e) {
/* Testen auf Overflow */
  	if (((*a) << 1) >= E_LAENGE - 1L) {
    		if (((*a) << 1) >= E_LAENGE || (Elb(a) << 1)
            			>= (E_LAENGE - 1L) * E_LONGBITS)
      		return(-1); 
		}
	Etrans(a,e);	
	return(Ezquadeq(e));
/* Equad() */ } 

int Equadeq(E_LONG *e) 
{
/* Testen auf Overflow */
	E_LONG h[E_LAENGE]; 
  	if (((*e) << 1) >= E_LAENGE - 1L) {
    		if (((*e) << 1) >= E_LAENGE || (Elb(e) << 1)
            			>= (E_LAENGE - 1L) * E_LONGBITS)
      		return(-1); 
  		}
	Etrans(e,h);
	return(Ezquad(h,e));
/* Equadeq() */ } 
/**/
shift(zahl,anzahl_shifts,ergebnis)
LONG  zahl[], ergebnis[];
long anzahl_shifts;
/* Eingabeparameter : zahl, anzahl_shifts;							*/
/* Ausgabeparameter : ergebnis;									*/
/* Wirkung :          ergebnis := zahl << anzahl_shifts;					*/
/* Returncode :       Keiner.									*/
/* Overflow :         falls anzahl_bits(zahl)/LONGBITS + anzahl_shifts/LONGBITS >= LAENGE - 1 .	*/
{
	SHORT rest, longbitsminusrest;
	LONG  *z_zahl, *a_zahl, *z_ergebnis, *e_ergebnis, *a_ergebnis;
	LONG  anzahl_woerter, stellen, help;

#ifdef STAT
	++ANZ_SHIFT;
#endif		

	if (*zahl) { /* zahl != 0 .	*/
		if (anzahl_shifts < 0) { /* Dies bedeuted einen Rechtsshift.	*/
			anzahl_shifts = -anzahl_shifts;
			anzahl_woerter = anzahl_shifts / LONGBITS;
			if (*zahl <= anzahl_woerter) {  /* ergebnis == 0 .	*/
				*ergebnis = 0L;
				return;
			}		

			rest = (SHORT)(anzahl_shifts % LONGBITS);
			stellen = *zahl - anzahl_woerter;

			z_zahl = zahl + anzahl_woerter + 1;
			z_ergebnis = ergebnis + 1;
			e_ergebnis = ergebnis + (int) stellen;
			if (!rest) { /* Es wird um Vielfaches eines LONG geshiftet.	*/
				do 
					*z_ergebnis = *z_zahl++;
				while (z_ergebnis++ <= e_ergebnis);
				*ergebnis = stellen;
				return;
			}

			/* Es verbleibt der Fall rest != 0 .	*/
			longbitsminusrest = (SHORT)(LONGBITS - rest);
			if (stellen > 1L) {
				do {
					help = *z_zahl++ >> rest;		
					*z_ergebnis = help | (*z_zahl << longbitsminusrest);
				} while (++z_ergebnis < e_ergebnis);
			}
			if (!( *(e_ergebnis) = (*z_zahl >> rest) )) 
				--stellen;
			*ergebnis = stellen;
		}
/**/
		else { /* Dies bedeuted einen Linkssshift, eventuell aber um 0 .	*/
			anzahl_woerter = anzahl_shifts / LONGBITS;
			if ((stellen = anzahl_woerter + *zahl + 1L) >= LAENGE)
				overflow("Links-Shift : Overflow!");
			rest = (SHORT)(anzahl_shifts % LONGBITS);

			z_zahl = zahl + *zahl;
			z_ergebnis = ergebnis + (int) stellen;
			
			if (!rest) { /* Es wird um Vielfaches eines LONG geshiftet, eventuell aber um 0 .	*/
				*ergebnis = stellen - 1L;
				do
					*--z_ergebnis = *z_zahl;
				while (--z_zahl > zahl);

				/* setze uebersprungene Woerter auf 0.	*/
				if (--z_ergebnis > ergebnis) {
					/* Wenn um 0 geshiftet wird, wird diese Schleife nicht durchlaufen.	*/
					do
						*z_ergebnis = 0L;
					while (--z_ergebnis > ergebnis);
				}
				return;
			}

			/* Es verbleibt der Fall rest != 0.	*/
			longbitsminusrest = (SHORT)(LONGBITS - rest);
			if ( *z_ergebnis = (*z_zahl >> longbitsminusrest) ) 
				*ergebnis = stellen;
			else
				*ergebnis = stellen - 1L;

			if ( z_zahl > (a_zahl = zahl + 1) ) {
				do {
					help = *z_zahl << rest;
					*--z_ergebnis = help | (*--z_zahl >> longbitsminusrest);
				} while ( z_zahl > a_zahl );
			}
			*--z_ergebnis = *z_zahl << rest;
			if ( z_ergebnis > (a_ergebnis = ergebnis + 1) ) {
				do
					*--z_ergebnis = 0L;
				while (z_ergebnis > a_ergebnis);
			}
		}
	}
	else /* zahl == 0 .	*/
		*ergebnis = 0L;
}
/**/
div(divident,divisor,quotient,rest)
LONG  divident[],divisor[],quotient[],rest[];
/* Eingabeparameter : divident, divisor;					*/
/* Ausgabeparameter : quotient, rest;						*/
/* Wirkung :          quotient := divident / divisor;				*/
/*                    rest := divident % divisor;				*/
/* Returncode :       -1  falls divisor == 0,					*/
/*                     0  sonst.						*/
/* Overflow :         falls anzahl_bits(divident) > LONGBITS * (LAENGE - 2) .	*/
{
	SHORT Z11, Z10, Z01, Z00, N01, N00, A01, A00, A_DIF, B01, B00, B_DIF, E01, E00;
	LONG  Z1, Z_MID, Z0, N0, N1, E1, E0, E_DIF, R0;
	LONG  zaehler[LAENGE], nenner[LAENGE], zwischen[LAENGE];
	LONG  *z_zaehler, *zz_zaehler, *e_zaehler, *z_nenner, *z_zwischen, *z_quotient, *z_rest;
	LONG  zaehler_stellen, nenner_stellen, quotient_stellen, q_dach, carry, help, i, j; 
	LONG  zw_mult1, zw_mult0, vergleich1, vergleich0, zus_vergleich1;
	long  normal_shifts;

#if !DREIVIERTEL
LONG  H01, H10;
#endif

#ifdef STAT
	++ANZ_DIV;
#endif		
	nenner_stellen = *divisor;
	if (!nenner_stellen)
		return(-1); /* Division durch 0.	*/

	if (comp(divident,divisor) == 1) { /* divident < divisor, also quotient == 0 .	*/
		if (rest != divident) { /* Nur in diesem Fall muss man divident nach rest kopieren.	*/
			z_rest = rest;
			z_zaehler = divident;
			e_zaehler = divident + *divident;
			do
				*z_rest++ = *z_zaehler++;
			while (z_zaehler <= e_zaehler);
		}
		if (quotient != rest)
			*quotient = 0L;
		return(0);
	}

	/* Wir fuehren zunaechst eine Normalisierung des Quotienten durch.	*/
	/* Diese wird so vorgenommen, dass das erste Bit des			*/
	/* fuehrenden LONGS des Divisors gleich 1 ist.				*/

	/* Wir berechnen zunaechst den Normalisierungsfaktor.			*/
	normal_shifts = (long)LONGBITS;
	N0 = *(divisor + (int) nenner_stellen);
	do {
		--normal_shifts;
		N0 >>= 1;
	} while (N0);

	zaehler_stellen = *divident + 1L;
	if (zaehler_stellen >= LAENGE)
		overflow("div : Overflow bei Normalisierung!");
	
	/* Es gilt zaehler_stellen >= 2 .	*/
	zaehler[zaehler_stellen] = 0L;
	shift(divident,normal_shifts,zaehler);
	shift(divisor,normal_shifts,nenner);
	/* divident und divisor werden nun nicht mehr benoetigt.					*/
	/* Also darf quotient beschrieben werden.							*/
	/* zaehler[zaehler_stellen] ist auf jeden Fall wohldefiniert !!					*/
	/* Eventuell steht dort eine fuehrende 0.							*/
	/* Ferner ist die genaue Laenge des Quotienten gleich zaehler_stellen - nenner_stellen .	*/

	quotient_stellen = zaehler_stellen - nenner_stellen;
	z_quotient = quotient + (int) quotient_stellen;
/**/
	if (nenner_stellen == 1L) {
		/* Spezieller Algorithmus.	*/
		N0 = *(nenner + 1); 
		z_zaehler = zaehler + (int) zaehler_stellen;
		Z1 = *z_zaehler--;
		do {
			Z0 = *z_zaehler--;
			LONG_DIVISION;
			*z_quotient-- = E0;
			Z1 = R0;
		} while (z_quotient > quotient);
		*quotient = (*(quotient + (int) quotient_stellen)) ? (quotient_stellen) : (quotient_stellen - 1L) ;
		
		if (Z1) {
			*rest++ = 1L;
			*rest = Z1 >> normal_shifts;
		}
		else
			*rest = 0L;
		return(0);		
	}

	/* Ab jetzt gilt nenner_stellen >= 2 .	*/
	N0 = *(nenner + (int) nenner_stellen);
	N1 = *(nenner + (int) nenner_stellen - 1);
	z_zaehler = zaehler + (int) zaehler_stellen;

	for (j = 1L; j <= quotient_stellen; j++) {
		/* Wir berechnen zunaechst q_dach.	*/

		/* Berechnung der ersten Naeherung von q_dach.	*/
		Z1 = *z_zaehler;
		Z0 = *(z_zaehler - 1);
		if (Z1 == N0)
			q_dach = (LONG)(-1L);
		else {
			LONG_DIVISION;
			q_dach = E0;
		}
		/* Die erste Naeherung von q_dach ist berechnet worden.	*/
		/* Nun wird die erste Naeherung von q_dach kontrolliert	*/
		/* und gegebenenfalls eine zweite Naeherung berechnet.	*/
		A01 = (SHORT)(N1 >> SHORTBITS);
		A00 = (SHORT)(N1);
		B01 = (SHORT)(q_dach >> SHORTBITS);
		B00 = (SHORT)(q_dach);
		LONG_MULTIPLIKATION;
		zw_mult1 = E1;
		zw_mult0 = E0;
		A01 = (SHORT)(N0 >> SHORTBITS);
		A00 = (SHORT)(N0);
		LONG_MULTIPLIKATION;
		/* Es gilt (E1 * 2^32 + E0) == (q_dach * N0) <= (Z1*2^32 + Z0) ,	*/
		/* also 0 <= (Z1 * 2^32 + Z0) - (E1 * 2^32 + E0) .			*/
		vergleich0 = Z0 - E0;
		if (Z0 < E0) 
			vergleich1 = Z1 - E1 - 1L;
		else
			vergleich1 = Z1 - E1;
/**/
		if (!vergleich1) { /* (Z1 *2^32 + Z0) - (E1 * 2^32 + E0) < 2^32 .	*/
			vergleich1 = vergleich0;
			vergleich0 = *(z_zaehler - 2);
			while ( (zw_mult1 > vergleich1) || ( (zw_mult1 == vergleich1) && (zw_mult0 > vergleich0) ) ) {
				--q_dach; /* q_dach war zu gross.	*/	
				if (zw_mult0 < N1) 
					--zw_mult1;
				zw_mult0 -= N1;
				zus_vergleich1 = vergleich1 + N0;
				if (zus_vergleich1 < vergleich1) /* bei der Addition fand ein Ueberlauf statt.	*/
					/* In diesem Fall ist q_dach bezueglich dieses Tests richtig gewaehlt,	*/
					/* denn (zw_mult1 * 2^32 + zw_mult0) < 2^64 .				*/
					break;
				else
					vergleich1 = zus_vergleich1;
			}
		}

		/* Nun ist die zweite Naeherung von q_dach berechnet.	*/
		/* Der Fehler zum korrekten Wert ist hoechstens 1 .	*/
		if (q_dach) {
			/* Multipliziere nun den nenner mit q_dach und speichere nach zwischen.	*/
			carry = 0L;
			z_nenner = nenner + 1;
			z_zwischen = zwischen + 1;
			A01 = (SHORT)(q_dach >> SHORTBITS);
			A00 = (SHORT)(q_dach);
#if DREIVIERTEL
			if (A00 >= A01) {
				A_DIF = A00 - A01;
				for (i = 1L; i <= nenner_stellen; i++) {
					B01 = (SHORT)(*z_nenner >> SHORTBITS);
					B00 = (SHORT)(*z_nenner++);
					LONG_MULTIPLIKATION_FALL1;
					if ( (E0 += carry) < carry )
						E1++;
					*z_zwischen++ = E0;
					carry = E1;
				}
			}
			else {
				A_DIF = A01 - A00;
				for (i = 1L; i <= nenner_stellen; i++) {
					B01 = (SHORT)(*z_nenner >> SHORTBITS);
					B00 = (SHORT)(*z_nenner++);
					LONG_MULTIPLIKATION_FALL2;
					if ( (E0 += carry) < carry )
						E1++;
					*z_zwischen++ = E0;
					carry = E1;
				}
			}
#else
			for (i = 1L; i <= nenner_stellen; i++) {
				B01 = (SHORT)(*z_nenner >> SHORTBITS);
				B00 = (SHORT)(*z_nenner++);
				LONG_MULTIPLIKATION;

				if ( (E0 += carry) < carry )
					E1++;
				*z_zwischen++ = E0;
				carry = E1;
			}
#endif
			*z_zwischen = carry;
/**/
			/* Es gilt nun zwischen == q_dach * nenner .					*/
			/* Die Laenge von zwischen ist nenner_stellen + 1; ggf. mit fuehrender 0.	*/

			/* Nun subtrahieren wir zwischen von zaehler,		*/
			/* wobei wir natuerlich die Stellen beruecksichtigen.	*/
			zz_zaehler = z_zaehler - (int) nenner_stellen;
			z_zwischen = zwischen + 1;
			carry = 0L;
			for (i = 0L; i <= nenner_stellen; i++) {
				help = *z_zwischen++ + carry;
				if ((!help) && (carry)) /* Dies ist genau dann der Fall, wenn help == 0  und  carry == 1.	*/
					zz_zaehler++;
				else {
					carry = (*zz_zaehler < help);
					/* carry = 1  falls *zz_zaehler < help,	*/
					/* carry = 0  sonst. 			*/
					*zz_zaehler++ -= help;
				}
			}
			if (carry) { /* Das Ergebnis ist negativ und somit ist q_dach immer noch zu gross.	*/
				--q_dach;
				/* Wir addieren nun nenner auf das vorherige Ergebnis.	*/
				carry = 0L;
				z_nenner = nenner + 1;
				zz_zaehler = z_zaehler - (int) nenner_stellen;
				for (i = 0L; i <= nenner_stellen; i++) {
					help = *z_nenner++ + carry;
					if ((!help) && (carry)) /* Dies ist genau dann der Fall, wenn help == 0  und  carry == 1 .	*/
						zz_zaehler++;
					else {
						carry = ( (*zz_zaehler + help) < help );
						*zz_zaehler++ += help;
					}
				}
			}
			*zz_zaehler += carry;
		}
		/* Nun ist q_dach exakt bestimmt.	*/
		*z_quotient-- = q_dach;
		--z_zaehler;
	}
	/* Nun muessen wir noch eine Laengenanpassung vornehmen.	*/
	while (!(*(quotient + (int) quotient_stellen)))
		--quotient_stellen;  /* quotient_stellen > 0 wegen zaehler > nenner.	*/
	*quotient = quotient_stellen;
	/* Der Quotient ist nun korrekt berechnet.	*/

	/* Wir berechnen nun den Rest. 					*/
	/* Die Laenge des Restes ist kleiner gleich nenner_stellen.	*/
	z_zaehler = zaehler + (int) nenner_stellen;
	while (!(*z_zaehler--))
		--nenner_stellen;
	*zaehler = nenner_stellen;
	shift(zaehler,-normal_shifts,rest);
	return(0);
}
/**/
/* 
        Marc Conrad, 201098 neu eingebaut.
	Dieses File enthaelt die folgenden Funktionen: 
	static int Ezmodeq(e,m): Berechnet e := e % m.
		- Es muss gelten: a und m zeigen auf verschiedene 
		  Speicherbereiche. 
		- Beim Shiften von a kann Overflow auftreten. Dann 
		  Rueckgabewert -1.
		- Ebenfalls Rueckgabewert -1 fuer m = 0.
	int Emodeq(a,m): Berechnet a := a % m. 
		  Rueckgabewert wie oben.
	static int Ezmod(a,e,m): Berechnet e := a % m. 
		  Rueckgabewert wie oben.
		  Es muss gelten: a und m und e und m zeigen auf 
		  verschiedene Speicherbereiche. (a und e egal.)
	int Emod(a,e,m):  Berechnet e := a % m. 
		  Rueckgabewert wie oben. 
	Alle Funktionen sind optimiert fuer *(m + (*m)) & (1 << 31) != 0, 
	d.h. hoechstes Bit des hoechsten Wortes gleich 1.
*/
static E_LONG VMODQC2_n = 0, VMODQC2_c2;
/* Berechnet den Parameter 'c2', den Ezmodeq braucht. */
/* c2 ist so definiert, dass B * B / N0 = B + c2  + B^-1 c3 + ....
   gilt. N0 sollte groesser (1 << 31) sein, wenn nicht, dann 
   wird  c2 = (unsigned) (-1) gesetzt */

static void compute_c2(E_LONG n)
{
        E_LONG a, h, k;
	VMODQC2_n = n;
        k = (E_LONG) (1 << (E_LONGBITS-1));
        a = 0L - (n << 1);
        VMODQC2_c2 = 0L; h = 0;
        while(k) {
            if( h || a > n ) { VMODQC2_c2 |= k; a -= n; }
            h = a & (1 << (E_LONGBITS -1)); /* E_LONGBITS -1 == 31 */
            k >>= 1; a <<= 1;
            }
	if(!VMODQC2_c2) { VMODQC2_c2 = (E_LONG)(-1); } 	
/* compute_c2() */ }

static int Vmodcomp(E_LONG *a, E_LONG *b, E_LONG lm)
{
	while(lm--) { 
		if( *a < *b ) { return 0; } 
		else if( *a > *b ) { return 1; } 
		a--; b--; 
		} 
	return 1; 
/* Vmodcomp() */ }

#ifdef E_USE_LONGLONG
#define llprod(A,B) \
(((E_LONGLONG) (A)) * ((E_LONGLONG) (B)))

#define MODLMULT(A,B,E0,E1) \
E0 = (E_LONG) (PROD = llprod(A,B)); \
E1 = PROD >> E_LONGBITS;


#else 
/* Es gilt. E1 * 2^32 + E0 := (A01 * 2^16 + A00) * (B01 * 2^16 + B00);*/
#define MODLMULT1(A_DIF,E0,E1) \
E0 = A00 * B00; E1 = A01 * B01;\
if (B00 >= B01) { E_DIF = E0 - ((A_DIF) * (B00 - B01)); }\
else {\
	if ( (E_DIF = E0 + ((A_DIF) * (B01 - B00))) < E0 )\
		E1 += (1L << E_SHORTBITS);\
}\
if ( (E_DIF += E1) < E1 ){ E1 += (1L << E_SHORTBITS); } \
E1 += (E_DIF >> E_SHORTBITS);\
if ( (E0 += (E_DIF <<= E_SHORTBITS)) < (E_DIF) ) { E1++; } 
/* Ende des Makros MODLMULT1.	*/

#define MODLMULT2(A_DIF,E0,E1) \
E0 = A00 * B00; E1 = A01 * B01;\
if (B00 <= B01) {\
	E_DIF = E1 - ((A_DIF) * (B01 - B00));\
}\
else {\
	if ( (E_DIF = E1 + ((A_DIF) * (B00 - B01))) < E1 )\
		E1 += (1L << E_SHORTBITS);\
}\
if ( (E_DIF += E0) < E0 )\
	E1 += (1L << E_SHORTBITS);\
E1 += (E_DIF >> E_SHORTBITS);\
if ( (E0 += (E_DIF <<= E_SHORTBITS)) < (E_DIF)) { E1++; } 
/* Ende des Makros MODLMULT2.	*/

#define MODLMULT(A, B, E0,E1) \
A00 = (E_SHORT) (A); A01 = (E_SHORT) ((A) >> E_SHORTBITS); \
B00 = (E_SHORT) (B); B01 = (E_SHORT) ((B) >> E_SHORTBITS); \
if (A00 >= A01) { MODLMULT1(A00 - A01,E0,E1) }\
else { MODLMULT2(A01 - A00, E0, E1) } 
#endif

/* Rueckgabe -1 falls div. durch Null, Null sonst */

int Ezmodeq(E_LONG *a,E_LONG *m)
{
#ifdef E_USE_LONGLONG
	E_LONGLONG PROD;
#else 
	E_SHORT A01, A00, A_DIF, B01, B00;
	#endif
	E_LONG  Z1, Z0, N0, N1, E1, E0, E_DIF, R1;
	E_LONG  *pm, *pa, *paa;
	E_LONG  lm, qd; 
	E_LONG E0a, E1a, E0b, E1b; 
	unsigned long j;
	int k, s; 

	if( !(lm = *m) ) { return(-1); } /* Division durch 0. */
	if (Ecomp(a,m) == 1) { return(0); }  /* a < m */
	if( lm == 1 ) { s = 0; } else { s = 1; }

	N0 = *(m + (int) lm);
	if( N0 & (1 << 31) ) { k = 0L; } 
	else {  k = 32; 
		do { k--; N0 >>= 1; } while (N0);
		if( Eshift(a,k,a) == -1 ) { return( -1 ); }
		Eshift(m,k,m);
		N0 = *(m + (int) lm);
		}
	

	if( s ) { N1 = *(m + (int) (lm - 1)); }
	else { N1 = 0L; } 

	pa = a + (int) (*a);

/* Falls die ersten lm Stellen von a groesser oder gleich m
   sind, werden diese zuerst wegsubtrahiert. */

	if( Vmodcomp(pa,m + (int) lm, lm) ) { 
		paa = pa - ((int) lm - 1); 
		pm = m + 1; qd = 0L; 
		for(Z1 = lm; Z1; Z1--) { 
			E0 = *pm++ + qd; 
			qd = ( (E0 > *paa || (!E0  && qd)) ? 1L : 0L); 
			*paa++ -= E0; 
			    } 	
	} 
	if( VMODQC2_n != N0 ) { compute_c2(N0); } 
	for (j = *a - lm; j ; j--) {
	  Z1 = *pa;
	  Z0 = *(pa - 1);
 	  if( Z1 == N0 ) { 
		E1a = N0 - 1; E0a = 0L - N0; 
		qd = (E_LONG) (-1); } 
	  else { 
/* Division, simuliert durch Multiplikation mit c2. */
            MODLMULT(Z1, VMODQC2_c2, E0,E1)

	    qd = Z1 + E1; 
	    if( qd < Z1 ) { 
		E1a = N0 - 1; E0a = 0L - N0; 
		qd = (E_LONG) (-1); 
		} 
	    else { 
              MODLMULT(N0, qd, E0a,E1a)

	      R1 = Z1 - E1a; 
	      if( E0a > Z0 ) R1--; 
	      E_DIF = Z0 - E0a; 
	      while( R1 ) { qd++; 
		if( E_DIF < N0 ) R1--; 
		E0a += N0; if( E0a < N0 ) E1a++; 
		E_DIF = E_DIF - N0;  
		} 
	      if(E_DIF >= N0) { 
		E0a += N0; if( E0a < N0 ) E1a++; 
		qd++; 
		} 
              }
	} 
/* Jetzt ist qd aproximiert, in E1a * BASIS + E0a steht qd * N0 */

	R1 = Z0 - E0a;
	if( s ) { 
	    MODLMULT(N1, qd, E0b, E1b) 
/* In E1b * BASIS + E0a steht qd * N1. Falls qd zu gross, so wird
   das jetzt festgestellt und angepasst */
	    if ((Z0 >= E0a && Z1 == E1a     ) ||
                (Z0 <  E0a && Z1 == E1a + 1L) ){ 
		while ( (E1b > R1) || ( (E1b == R1) && (E0b > *(pa - 2)) ) ) {
			--qd; 
			if( E0a < N0 ) E1a--; 
			E0a -= N0;  
			if( E0b < N1 ) E1b--; 
			E0b -= N1;  
			R1 += N0;
			if (R1 < N0) break;
			}
		}
	} else { E0b = 0L; E1b = 0L; } 
/* Jetzt stimmt qd (bzw. s. u.). Es wird qd * m von den ersten lm 
   Stellen von a subtrahiert */
	if (qd) {
		paa = pa - (int) lm;
		pm = m + 1;
		R1 = 0L;
		Z0 = 0L; /* Z0 ist jetzt Carry, Z1 Laufvariable */
		if( s ) { 
#ifdef E_USE_LONGLONG
                     for (Z1 = lm-2; Z1; Z1--) {
			PROD = llprod(*pm++,qd);
			PROD += (E_LONGLONG) R1;
	    		E0 = (E_LONG) PROD;
			if( Z0 ) { E0++; }
     			if ((!E0) && (Z0)) { paa++; }
		 	else {
		 		Z0 = (*paa < E0);
		 		*paa++ -= E0;
	 			}
     			R1 = (E_LONG) (PROD >> E_LONGBITS);
     			}
#else 
		    A01 = (E_SHORT)(qd >> E_SHORTBITS);
		    A00 = (E_SHORT)(qd);
		    if (A00 >= A01) {
			A_DIF = A00 - A01;
			for (Z1 = lm-2; Z1; Z1--) {
				B01 = (E_SHORT)(*pm >> E_SHORTBITS);
				B00 = (E_SHORT)(*pm++);
				MODLMULT1(A_DIF,E0,E1)
				if ( (E0 += R1) < R1 ) E1++;
				E0 += Z0; 
				if ((!E0) && (Z0)) { paa++; } 
				else { Z0 = (*paa < E0); *paa++ -= E0; } 
				R1 = E1;
				}
		    } else {
			A_DIF = A01 - A00;
			for (Z1 = lm - 2;Z1; Z1--) {
				B01 = (E_SHORT)(*pm >> E_SHORTBITS);
				B00 = (E_SHORT)(*pm++);
				MODLMULT2(A_DIF,E0,E1)
				if ( (E0 += R1) < R1 ) E1++;
				E0 += Z0; 
				if ((!E0) && (Z0)) { paa++; } 
				else { Z0 = (*paa < E0); *paa++ -= E0; } 
				R1 = E1;
			}
		    }
#endif
		if ( (E0b += R1) < R1 ) E1b++;
		E0b += Z0; 
		if ((!E0b) && (Z0)) { paa++; } 
		else { Z0 = (*paa < E0b); *paa++ -= E0b; } 
		R1 = E1b; 
		}

		if ( (E0a += R1) < R1 ) E1a++;
		E0a += Z0; 
		if ((!E0a) && (Z0)) { paa++; } 
		else { Z0 = (*paa < E0a); *paa++ -= E0a; } 
		R1 = E1a;

		E0 = R1 + Z0; 
		if ((!E0) && (Z0)) { paa++; } 
		else { Z0 = (*paa < E0); *paa++ -= E0; } 
/* Falls noch ein Carry (Z0) da ist, wurde zuviel abgezogen, das heisst
   qd war doch zu gross. Also wieder abziehen */
		if (Z0) { 
			Z0 = 0L;
			pm = m + 1;
			paa = pa - (int) lm;
			for (Z1 = lm; Z1; Z1--) {
			    E0 = *pm++ + Z0;
			    if ((!E0) && (Z0)) { paa++;}
			    else { Z0 = ( (*paa + E0) < E0 ); *paa++ += E0; }
			    }
			}
		*paa += Z0;
		}
		--pa;
	}

	pa = a + (int) lm;
	while (!(*pa--))
		--lm;
	*a = lm;
	if( k ) { 
		Eshift(a,-k,a);
		Eshift(m,-k,m);
		}
	return(0);
/* Ezmodeq() */ }

int Ezmod(E_LONG *a, E_LONG *e, E_LONG *m) 
{
	if( a != e) { Etrans(a,e); }
	return( Ezmodeq(e,m) );
/* Ezmod() */ } 

int Emod(E_LONG *a, E_LONG *e, E_LONG *m) 
{ /* e = a % m */
	E_LONG h[E_LAENGE];
	Etrans(m,h);
	Etrans(a,e);
	return( Ezmodeq(e,h) );
/* Emod() */ }

int Emodeq(E_LONG *e, E_LONG *m) 
{
	E_LONG h[E_LAENGE];
	Etrans(m,h);
	return(Ezmodeq(e,h));
/* Emodeq() */ } 
/**/
fak(zahl,ergebnis)
LONG zahl, ergebnis[];
/* Eingabeparameter : zahl;						*/
/* Ausgabeparameter : ergebnis;						*/
/* Wirkung :          ergebnis := zahl!;				*/
/* Returncode :       Keiner.						*/
/* Overflow :         falls lb(zahl!) >= LONGBITS * (LAENGE - 1) .	*/
{
	LONG i, operand[2];

	zuweis(1L,ergebnis);
	zuweis(1L,operand);
	for (i = 2; i <= zahl; i++) {
		incr(operand);
		mult(operand,ergebnis,ergebnis);
	}
}

choose(zahl1,zahl2,ergebnis)
LONG zahl1, zahl2, *ergebnis;
/* Eingabeparameter : zahl1, zahl2;						*/
/* Ausgabeparameter : ergebnis;							*/
/* Wirkung :          ergebnis := zahl1 ueber zahl2;				*/
/* Returncode :       Keiner.							*/
/* Overflow :         falls lb(zahl1 ueber zahl2) >= LONGBITS * (LAENGE - 1) .	*/
{
	LONG i, operand1[2],operand2[2], dummy[LAENGE];

	zuweis(1L,ergebnis);
	zuweis(zahl1,operand1);
	zuweis(1L,operand2);
	for (i = 1; i <= zahl2; i++) {
		mult(operand1,ergebnis,ergebnis);
		div(ergebnis,operand2,ergebnis,dummy);
		decr(operand1);
		incr(operand2);
	}
}

expo(zahl,exponent,ergebnis)
LONG  zahl[], exponent, ergebnis[];
/* Eingabeparameter : zahl, exponent;						*/
/* Ausgabeparameter : ergebnis;							*/
/* Wirkung :          ergebnis := zahl^exponent;				*/
/* Returncode :       Keiner.							*/
/* Overflow :         falls lb(zahl^exponent) >= LONGBITS * (LAENGE - 1) .	*/
{
	SHORT i;
	LONG  shifts, potenzen[LAENGE];

	trans(zahl,potenzen);
	zuweis(1L,ergebnis);
	shifts = 1L;
	for (i = (SHORT)LONGBITS; i; i--) {
		if (shifts & exponent) 
			mult(ergebnis,potenzen,ergebnis);
		shifts <<= 1;
		if (shifts > exponent)
			return;
		Equad(potenzen,potenzen);
	}
}

wurzel(zahl,ergebnis)
LONG  zahl[],ergebnis[];
/* Eingabeparameter : zahl;							*/
/* Ausgabeparameter : ergebnis;							*/
/* Wirkung :          ergebnis := [zahl^1/2];					*/
/* Returncode :       0  falls zahl ein Quadrat ist,				*/
/*                    1  sonst.							*/
/* Overflow :         tritt beim Aufruf von div auf,				*/
/*			falls anzahl_bits(zahl) > LONGBITS * (LAENGE - 2) ;	*/
{
	LONG  speicher[LAENGE], w[LAENGE], quot[LAENGE], rest[LAENGE];

	/* Berechnung einer ersten Naeherung der Wurzel :	*/
	shift(ONE,(long)( (lb(zahl) >> 1) + 1L ),speicher);
	
	do {
		trans(speicher,w);
		div(zahl,w,quot,rest);
		add(w,quot,speicher);
		shift(speicher,-1L,speicher);
	} while (comp(speicher,w) == 1);
	trans(w,ergebnis);
	return((*rest) || comp(quot,w));		
}  
/**/
n_wurzel(zahl,n,ergebnis)
LONG  zahl[], n, ergebnis[];
/* Eingabeparameter : zahl;								*/
/* Ausgabeparameter : ergebnis;								*/
/* Wirkung :          ergebnis := [zahl^1/n];						*/
/* Returncode :       0  falls zahl eine n-te Potenz ist,				*/
/*                    1  sonst.								*/
/* Overflow :         kann beim Aufruf von div auftreten,				*/
/*			falls n + lb(n-1) + lb(zahl) + 1 >= LONGBITS * (LAENGE - 2) ;	*/
/*                    in einigen weiteren Faellen, die schwer zu beschreiben sind.	*/
{
	LONG  speicher[LAENGE], w[LAENGE], quot[LAENGE], n_long[LAENGE], n_minus_1_long[LAENGE],  rest[LAENGE];
	LONG  n_minus_1;
	/* Berechnung einer ersten Naeherung der Wurzel :	*/
	if (!n)
		overflow("n_wurzel : n == 0!");
	if (EQUAL0(zahl)) { /* zahl == 0 .	*/
		*ergebnis = 0L;
		return(0);
	}
	
	shift(ONE,(long)( (lb(zahl)/n) + 1L ),speicher);
	n_minus_1 = n - 1L;
	if (!n_minus_1) { /* n == 1 .	*/
		trans(zahl,ergebnis);
		return(0);
	}
	zuweis(n,n_long);
	zuweis(n_minus_1,n_minus_1_long);
	do {
		trans(speicher,w);
		expo(speicher,n_minus_1,quot);
		mult(speicher,quot,speicher);
		mult(quot,n_long,quot);
		mult(n_minus_1_long,speicher,speicher);
		add(zahl,speicher,speicher);
		div(speicher,quot,speicher,rest);
	} while (comp(speicher,w) == 1);
	trans(w,ergebnis);
	return((*rest) || comp(speicher,w));
}
/**/
lb(zahl)
LONG  zahl[];
/* Eingabeparameter : zahl;										*/
/* Ausgabeparameter : Keine;										*/
/* Wirkung :          Keine;										*/
/* Returncode :       -1,       falls zahl == 0,							*/
/*                    lb(zahl)  sonst.									*/
/* Bemerkung :        Es gilt lb(zahl) == anzahl der Bits von zahl - 1 .				*/
/*                    und lb(zahl1) + lb(zahl2) + 1 >= lb(zahl1 * zahl2) >= lb(zahl1) + lb(zahl2) .	*/
{
	int   returncode;
	LONG  vorderste_stelle;

	if (!(*zahl))
		return(-1);

	returncode = (*zahl - 1L) * LONGBITS;
	vorderste_stelle = *(zahl + *zahl) >> 1;
	while (vorderste_stelle) {
		++returncode;
		vorderste_stelle >>= 1;
	}
	return(returncode);
}

quersumme(zahl,ergebnis)
LONG  zahl[], ergebnis[];
/* Eingabeparameter : zahl;								*/
/* Ausgabeparameter : ergebnis;								*/
/* Wirkung :          ergebnis := Quersumme von zahl, dargestellt zur Basis 2^LONGBITS;	*/
/* Returncode :       1  falls ergebnis >= 2^LONGBITS,					*/
/*                    0  sonst.								*/
{
	LONG  erg[LAENGE], help[2];
	LONG  *z_zahl, *e_zahl;

	zuweis(*(zahl+1),erg);
	if (*zahl > 1L) {
		e_zahl = zahl + *zahl;
		z_zahl = zahl + 1;
		do {
			zuweis(*z_zahl++,help);
			add(erg,help,erg);
		} while (z_zahl <= e_zahl);
		trans(erg,ergebnis);
		return(*erg > 1L);
	}
	trans(erg,ergebnis);
	return(0);
}
/**/
jacobi(arg,modul)
LONG  arg[], modul[];
/* Eingabeparameter : arg, modul;					*/
/* Ausgabeparameter : Keine;						*/
/* Wirkung :          Keine;						*/
/* Returncode :        0,  falls ggt(arg,modul) != 1,			*/
/*                     1,  falls arg has Jacobi-symbol  1 modulo modul,	*/
/*                    -1,  falls arg has Jacobi-symbol -1 modulo modul.	*/
/* Das Programm endet mit einer Fehlermeldung, falls modul gerade ist.	*/
{
	int   returncode, test ;
  	LONG  b[LAENGE], n[LAENGE], rest[LAENGE];
	LONG  *z_b, *z_n;
    	LONG  i;

	if ( !( (*modul) && (*(modul+1)&1L) ) )
		overflow("jacobi : Der Modul ist gerade!");
	if (!(test = comp(arg,ONE))) /* arg == 1.	*/
		return(1);
	if (test == 1) 
		return(0);
	/* Nun gilt arg >= 2.	*/
    	returncode = 1;
	z_n = n + 1;
	z_b = b + 1;
	trans(modul,n);
	trans(arg,b);
	while ( (test = comp(b,ONE)) == -1 ) { /* b > 1.	*/
		if (!(*z_b & 1L)) { /* b gerade.	*/
		   	if ( ( (i = (*z_n & 7L)) == 3L) || (i == 5L) ) 
				returncode = -returncode;
		    	shift(b,-1L,b);
		}
		else { /* b != 0, b != 1 und b ungerade.	*/
		   	if ( ((*z_b & 3L) == 3L) && ((*z_n & 3L) == 3L) ) 
				returncode = -returncode;
		    	div(n,b,rest,rest);
		    	trans(b,n);
		    	trans(rest,b);
		}
	}
	return (test? 0 : returncode);
}
/**/
comp(zahl1,zahl2)
LONG  zahl1[],zahl2[];
/* Eingabeparameter : zahl1, zahl2;		*/
/* Ausgabeparameter : Keine;			*/
/* Wirkung :          Keine;			*/
/* Returncode :       -1  falls zahl1 > zahl2,	*/
/*                     0  falls zahl1 = zahl2,	*/
/*                    +1  falls zahl1 < zahl2.	*/
{
	int  null = 1;
	LONG  stellen, i;

#ifdef STAT
	++ANZ_COMP;
#endif		

	if (*zahl1 < *zahl2)  /* zahl1 < zahl2 */
		return(1);
	if (*zahl1 > *zahl2)  /* zahl1 > zahl2 */
		return(-1);
	stellen = *zahl2;
	zahl1 += (int) stellen;
	zahl2 += (int) stellen;
	for (i = 0L; (i < stellen) && (null); i++) {
		/* Teste, wann das erste Mal  null == 0 ist nach folgender Zuweisung.	*/
		null = (*zahl1 == *zahl2);
		if (null) {
			zahl1--;
			zahl2--;
		}
		else {
			if (*zahl1 < *zahl2)
				return(1);
			else return(-1);
		}
	}
	return(0);
}
trans(zahl,ergebnis)
LONG  zahl[],ergebnis[];
/* Eingabeparameter : zahl;		*/
/* Ausgabeparameter : ergebnis;		*/
/* Wirkung :          ergebnis := zahl;	*/
/* Returncode :       Keiner.		*/

/* Die Schleife wird immer durchlaufen,	*/
/* auch wenn die Adresse von zahl und	*/
/* ergebnis uebereinstimmen.		*/
{
        memcpy((unsigned char *) ergebnis, (unsigned char *) zahl, ((*zahl) +1) << 2);
        } 
#ifdef XXXXXXXXXXXXXKAJAS

	LONG  *e_zahl;

#ifdef STAT
	++ANZ_TRANS;
#endif		

	e_zahl = zahl + *zahl;
	do
		*ergebnis++ = *zahl++;
	while (zahl <= e_zahl);
}
#endif
/**/
zuweis(zahl,ergebnis)
LONG  zahl;
LONG  ergebnis[];
/* Eingabeparameter : zahl;		*/
/* Ausgabeparameter : ergebnis;		*/
/* Wirkung :          ergebnis := zahl;	*/
/* Returncode :       Keiner.		*/
{
	if (zahl) { /* zahl != 0 */
		*ergebnis = 1L;
		*(ergebnis+1) = zahl;
	}
	else
		*ergebnis = 0L;
}

zuweis_int(zahl,ergebnis)
LONG  zahl[];
LONG  *ergebnis;
/* Eingabeparameter : zahl;					*/
/* Ausgabeparameter : ergebnis;					*/
/* Wirkung :          ergebnis := zahl;				*/
/* Returncode :        0  falls die Zuweisung gelungen ist,	*/
/*                    -1  sonst.				*/
{
	if (*zahl == 1L) {
		*ergebnis = *(zahl+1);
		return(0);
	}
	else {
		if (*zahl) 
			return(-1);
		else {
			*ergebnis = 0L;
			return(0);
		}
	}
}

even(zahl)
LONG  zahl[];
/* Eingabeparameter : zahl;			*/
/* Ausgabeparameter : Keine;			*/
/* Wirkung :          Keine;			*/
/* Returncode :       1  falls zahl1 gerade,	*/
/*                    0  sonst.			*/
{
	if (*zahl++)
		return(!(*zahl & 1L));
	return(1);
}		

mod4(zahl)
LONG  zahl[];
/* Eingabeparameter : zahl;	*/
/* Ausgabeparameter : Keine;	*/
/* Wirkung :          Keine;	*/
/* Returncode :       zahl % 4.	*/
{
	if (*zahl++)
		return (*zahl & 3L);
     	else 
		return(0);
}

mod8(zahl)
LONG  zahl[];
/* Eingabeparameter : zahl;	*/
/* Ausgabeparameter : Keine;	*/
/* Wirkung :          Keine;	*/
/* Returncode :       zahl % 8.	*/
{
	if (*zahl++) 
		return(*zahl & 7L);
     	else 
		return(0);
}
/**/
zufall(zahl,anzahl_bits)
LONG  zahl[];
LONG  anzahl_bits;
/* Eingabeparameter : anzahl_bits;						*/
/* Ausgabeparameter : zahl;							*/
/* Wirkung :          zahl := zufaellige Zahl mit genau anzahl_bits bits;	*/
/* Returncode :       Keiner.							*/
/* Overflow :         falls anzahl_bits(zahl) > LONGBITS * (LAENGE - 1) .	*/
{
	LONG  *z_zahl;
	LONG  stellen, rest, help, i, j;
	if (anzahl_bits) {
		if (anzahl_bits > LONGBITS * (LAENGE - 1L)) {
			printf("Fehler in Prozedur zufall : anzahl_bits = %lu",anzahl_bits);
			printf(" > LONGBITS * (LAENGE - 1) = %lu\n",LONGBITS * (LAENGE - 1L));
			exit(2);
		}
		z_zahl = zahl;
		stellen = anzahl_bits / LONGBITS;
		if (rest = (anzahl_bits % LONGBITS) ) {
			*z_zahl++ = ++stellen;
			for (i = 1L; i < stellen; i++) {
				help = rand() & 255L;
				for (j = 1L; j < (LONGBITS >> 3); j++)
					help = (help << 8) | (rand() & 255L);
				*z_zahl++ = help;
			}
			help = rand() & 255L;
			for (j = 1L; j < (LONGBITS >> 3); j++)
				help = (help << 8) | (rand() & 255L);
			help %= (1L << rest);
			*z_zahl = help | (1L << (rest - 1));
		}
		else {
			*z_zahl++ = stellen;
			for (i = 1L; i < stellen; i++) {
				help = rand() & 255L;
				for (j = 1L; j < (LONGBITS >> 3); j++)
					help = (help << 8) | (rand() & 255L);
				*z_zahl++ = help;
			}
			help = rand() & 255L;
			for (j = 1L; j < (LONGBITS >> 3); j++)
				help = (help << 8) | (rand() & 255L);
			*z_zahl = help | (1L << (LONGBITS - 1L));
		}		
	}
	else
		*zahl = 0L;
}
/**/	
compute_ggt(zahl1,zahl2,ergebnis)
LONG  zahl1[], zahl2[], ergebnis[];
/* Eingabeparameter : zahl1, zahl2;			*/
/* Ausgabeparameter : ergebnis;				*/
/* Wirkung :          ergebnis := ggt(zahl1,zahl2);	*/
/* Returncode :       0  falls der ggt gleich 1 ist,	*/
/*                    1  sonst.				*/
{
	LONG  TEST = 1L,  HELP;
	LONG  za1[LAENGE], za2[LAENGE];
	LONG  *z_za1, *z_za2;
	long  v = 0L, v1, v2;

	if (!*zahl1) { /* zahl1 == 0 .	*/
		if (zahl2 != ergebnis)
			trans(zahl2,ergebnis);
		if ((*ergebnis == 1L) && (*(ergebnis+1) == 1L))
			return(0);
		else return(1);
	}
	if (!*zahl2) { /* zahl2 == 0 .	*/
		if (zahl1 != ergebnis)
			trans(zahl1,ergebnis);
		if ((*ergebnis == 1L) && (*(ergebnis+1) == 1L))
			return(0);
		else return(1);
	}

	/* Zunaechst wird der Zwei-anteil v des ggt's berechnet. */
	z_za1 = zahl1 + 1;
	z_za2 = zahl2 + 1;
	HELP = *z_za1 | *z_za2;
	while (!(HELP & TEST)) {
		v++;
		if (!(TEST <<= 1)) {
			HELP = *(++z_za1) | *(++z_za2);
			TEST = 1L;
		}
	}
	/* v ist der gesuchte Zwei-anteil. */

	v1 = v;
	v2 = v;
	HELP = *z_za1;
	if (!(HELP & TEST)) {
		v1++;
		if (!(TEST <<= 1)) {
			HELP = *(++z_za1);
			TEST = 1L;
		}
		ZWEI_ANTEIL(z_za1,v1);
	}
	else {
		HELP = *z_za2;
		ZWEI_ANTEIL(z_za2,v2);
	}
	shift(zahl1,-v1,za1);
	shift(zahl2,-v2,za2);

	if (comp(za1,za2) >= 0) /* za1 <= za2 .	*/
		div(za2,za1,za2,za2);
	else
		div(za1,za2,za1,za1);
/**/
	while (*za1 && *za2) { /* za1 != 0  &&  za2 != 0 .	*/
		/* Hoechstens einer der beiden za's ist gerade.	*/
		z_za1 = za1 + 1;
		TEST = 1L;
		HELP = *z_za1;
		if (!(HELP & TEST)) {
			v1 = 1L;
			TEST = 2L;
			ZWEI_ANTEIL(z_za1,v1);
			shift(za1,-v1,za1);
		}
		else {
			z_za2 = za2 + 1;
			HELP = *z_za2;
			if (!(HELP & TEST)) {
				v2 = 1L;
				TEST = 2L;
				ZWEI_ANTEIL(z_za2,v2);
				shift(za2,-v2,za2);
			}
		}
		/* Nun sind za1 und za2 beide ungerade.	*/

		if (comp(za1,za2) == 1) /* za1 < za2 .	*/
			sub(za2,za1,za2);
		else 
			sub(za1,za2,za1);
	}
	if (!*za1) 
		shift(za2,v,ergebnis);
	else
		shift(za1,v,ergebnis);
	if ((*ergebnis == 1L) && (*(ergebnis+1) == 1L))
		return(0);
	else 
		return(1);
}
/**/
madd(zahl1,zahl2,ergebnis,modul)
LONG  zahl1[],zahl2[],ergebnis[],modul[];
/* Eingabeparameter : zahl1, zahl2, modul;			*/
/* Ausgabeparameter : ergebnis;					*/
/* Wirkung :          ergebnis := (zahl1 + zahl2) % modul;	*/
/* Returncode :       Keiner.					*/
{
	LONG  erg[LAENGE];

	if ((comp(zahl1,modul) <= 0) || (comp(zahl2,modul) <= 0)) {
		/* zahl1 >= modul oder zahl2 >= modul.					*/
		/* Also ist eine Division notwendig.					*/
		/* Wir addieren aber zuerst die Summanden und dividieren anschliessend.	*/
		add(zahl1,zahl2,erg);	
		if (div(erg,modul,ergebnis,ergebnis))
			overflow("madd : modul == 0!");
	}
	else { /* zahl1 < modul und zahl2 < modul.					*/
		/* Also ist die Summen kleiner als 2*modul und somit kann hier		*/
		/* die Division durch eine Subtraktion ersetzt werden.			*/
		
		add(zahl1,zahl2,erg);
		if (comp(erg,modul) <= 0) /* ergebnis >= modul.	*/
			sub(erg,modul,ergebnis);
		else
			trans(erg,ergebnis);
	}
}		

msub(zahl1,zahl2,ergebnis,modul)
LONG  zahl1[],zahl2[],ergebnis[],modul[];
/* Eingabeparameter : zahl1, zahl2, modul;			*/
/* Ausgabeparameter : ergebnis;					*/
/* Wirkung :          ergebnis := (zahl1 - zahl2) % modul;	*/
/* Returncode :       Keiner.					*/
{
	LONG  erg[LAENGE];

	if (comp(zahl1,zahl2) <= 0) { /* zahl1 >= zahl2 .	*/
		sub(zahl1,zahl2,erg);
		if (comp(erg,modul) <= 0) { /* erg >= modul .	*/
			if (div(erg,modul,ergebnis,ergebnis)) 
			overflow("msub : Modul == 0!");
		}
		else
			trans(erg,ergebnis);
	}			
	else { /* zahl2 > zahl1 .	*/
		sub(zahl2,zahl1,erg);
		if (comp(erg,modul) < 0) { /* erg > modul .	*/
			if (div(erg,modul,erg,erg))
				overflow("msub : Modul == 0!");
		}
		/* Es gilt 0 <= erg <= modul .	*/
		if (!*erg) /* erg == 0 .	*/
			*ergebnis = 0L;
		else
			sub(modul,erg,ergebnis);
	}
}		
/**/
/*
mmult(zahl1,zahl2,ergebnis,modul)
LONG  zahl1[],zahl2[],ergebnis[],modul[];
*/
/* Eingabeparameter : zahl1, zahl2, modul;			*/
/* Ausgabeparameter : ergebnis;					*/
/* Wirkung :          ergebnis := (zahl1 * zahl2) % modul;	*/
/* Returncode :       Keiner.					*/
/* Marc Conrad, 201098: Einbau beschleunigter neuer Funktionen (aus Acryl):  */
/* 
	Dieses File enthaelt die folgenden Funktionen: 
	Ezmmult(a,b,e,m): Berechnet e = a * b mod m;
	Ezmmulteq(a,b,m): Berechnet a = a * b mod m;
		Dabei muessen a, b, e und m auf verschiedene 
		Speicherbereiche zeigen. Overflow wird nicht 
		in allen Faellen ueberprueft. Optimalerweise 
		sollte a < m und b < m sein. (a und b werden
		vor dem Multiplizieren nicht reduziert!)
	Emmult(a,b,e,m): e = a * b mod m;
	Emmulteq(a,b,e,m): a = a * b mod m;
		Rueckgabewert -1 bei Overflow, 0 sonst.
*/

int Ezmmult(E_LONG *a, E_LONG *b, E_LONG *e, E_LONG *m) {
	Ezmult(a,b,e);
	return( Ezmodeq(e,m) );
/* Ezmmult() */ } 

int Ezmmulteq(E_LONG *a, E_LONG *b, E_LONG *m) {
	Ezmulteq(a,b);
	return( Ezmodeq(a,m) );
/* Ezmmulteq() */ } 

int Emmult(E_LONG *a, E_LONG *b, E_LONG *e, E_LONG *m)
{
E_LONG h[E_LAENGE];
	if (*a <= *m) {
		if (*b <= *m) {
			if( Emult(a,b,h) ) return( -1);
			return(Emod(h,e,m)); 
		}
		else { 
			if( Emod(b,h,m) ) return(-1);
			if( Emulteq(h,a) ) return(-1);
			return(Emod(h,e,m));
		} 
	}
	if( Emod(a,h,m) ) return(-1);
	if (*b <= *m) {
		if( Emulteq(h,b) ) return(-1);
		return(Emod(h,e,m));
		} 
	else { 
		if( Emod(b,e,m) ) return(-1);
		if( Emulteq(h,e) ) return(-1);
		return(Emod(h,e,m));
		} 
	return(0);
/* Emmult() */ }

int Emmulteq(E_LONG *a, E_LONG *b, E_LONG *m)
{
	E_LONG h[E_LAENGE];
	if( *a > *m ) { if( Emodeq(a,m) ) return(-1); }
	if (*b <= *m) {
		if( Emult(a,b,h) ) return( -1);
		return(Emod(h,a,m)); 
		}
	else { 
		if( Emod(b,h,m) ) return(-1);
		if( Emulteq(h,a) ) return(-1);
		return( Emod(h,a,m) );
	} 
	return(0);
/* Emmulteq() */ }
/**/
/* 
mquad(zahl,ergebnis,modul)
LONG  zahl[], ergebnis[], modul[];
*/
/* Eingabeparameter : zahl, modul;			*/
/* Ausgabeparameter : ergebnis;				*/
/* Wirkung :          ergebnis := (zahl^2) % modul;	*/
/* Returncode :       Keiner.				*/
/* Marc Conrad, 201098: Einbau beschleunigter neuer Funktionen (aus Acryl):  */
/* 
	Dieses File enthaelt die folgenden Funktionen:
	Ezmquad(a,e,m): Berechnet e = a * a mod m. 
		Es muss gelten: m, a und e zeigen auf verschiedene
		Speicherbereiche. Optimalerweise sollte a < m sein,
		da erst a^2 berechnet wird, dann mod m. In e muss 
		der Wert von a^2 hineinpassen. Dies wird aber nicht
		abgeprueft! Rueckgabewert -1 falls beim Shiften von a^2 
		ein Overflow auftritt, sonst 0.
	Ezmquadeq(a,m): a = a * a mod m. 
		Es gelten die Bemerkungen wie oben. 
	Emquad(a,e,m): Berechnet e = a * a mod m.
	Emquadeq(a,m): Berechnet a = a * a mod m.
		Rueckgabewert -1 falls Overflow, sonst 0.
*/

int Ezmquad( E_LONG *a, E_LONG *e, E_LONG *m) {
	Ezquad(a,e);
	return( Ezmodeq(e,m) );
/* Ezmquad() */ } 

int Ezmquadeq( E_LONG *a, E_LONG *m) {
	Equadeq(a); 
	return( Ezmodeq(a,m) );
/* Ezmquadeq() */ } 

int Emquadeq( E_LONG *a, E_LONG *m) {
	E_LONG h[E_LAENGE];
	Etrans(a,h);
	if( *h > *m ) { if( Ezmodeq(h,m) ) return(-1); } 
	if( Equadeq(h) ) { return(-1);}
	if( Ezmodeq(h,m) ) { return(-1); }  
	Etrans(h,a);
	return(0);
/* Emquadeq() */ }
	
int Emquad( E_LONG	*a, E_LONG *e, E_LONG	*m) {
	E_LONG h[E_LAENGE];
	Etrans(a,h);
	if( *h > *m ) { if( Ezmodeq(h,m) ) return(-1); } 
	if( Equadeq(h) ) { return(-1);}
	return( Emod(h,e,m) );
/* Emquad() */ }
/**/
#if GGTSHIFT
GGT(zahl,modul,ergebnis,invers)
LONG  zahl[], modul[], ergebnis[], invers[];
/* Eingabeparameter : zahl, modul;									*/
/* Ausgabeparameter : ergebnis, invers;									*/
/* Wirkung :          ergebnis := ggt(zahl,modul);							*/
/*                    invers wird definiert durch : (invers * zahl) % modul == ergebnis;		*/
/* Returncode :       -1  falls (zahl % modul) == 0,							*/
/*                     0  falls der ggt gleich 1 ist,							*/
/*                     1  sonst.									*/
/* Overflow :         falls anzahl_bits(zahl) > LONGBITS * (LAENGE - 2) ;				*/
/*                    kann beim Aufruf von shift auftreten,						*/
/*                    	falls anzahl_bits(modul) >  LONGBITS * (LAENGE - 2) ;				*/
/*                    kann beim Aufruf von mult auftreten,						*/
/*                    	falls lb(zahl % modul) + lb(modul) >= LONGBITS * (LAENGE - 1) ;			*/
/*                    kann beim Aufruf von div auftreten,						*/
/*                    	falls lb(zahl % modul) + lb(modul) >= LONGBITS * (LAENGE - 2) .			*/
/*                    Es ist gesichert, dass kein Overflow auftritt,					*/
/*                    	falls anzahl_bits(zahl) + anzahl_bits(modul) <= LONGBITS * (LAENGE - 2) .	*/
{
	LONG  TEST = 1L, HELP, i;
	LONG  zahl_modulo[LAENGE], ggt1[LAENGE], ggt2[LAENGE], inv1[LAENGE], inv2[LAENGE], neuer_modul[LAENGE];
	LONG  *z_ggt1, *z_ggt2;
	long  v = 0L, v1 = 0L, v2 = 0L;
	int   returncode;

	if (div(zahl,modul,zahl_modulo,zahl_modulo)) /* zahl_modulo = zahl % modul .	*/
		overflow("GGT : modul == 0!");
	if (!*zahl_modulo) { /* zahl_modulo == 0 .	*/
		trans(modul,ergebnis);
		*invers = 1L;
		*(invers + 1) = 1L;
		return(-1);
	}

	inv1[0] = 0L; /* inv1 := 0;	*/
	inv2[0] = 1L;
	inv2[1] = 1L; /* inv2 := 1;	*/

	/* Zunaechst wird der Zwei-anteil v des ggt's berechnet. */
	z_ggt1 = modul + 1;
	z_ggt2 = zahl_modulo + 1;
	HELP = *z_ggt1 | *z_ggt2;
	while (!(HELP & TEST)) {
		v++;
		if (!(TEST <<= 1)) {
			HELP = *(++z_ggt1) | *(++z_ggt2);
			TEST = 1L;
		}
	}
	/* v ist der gesuchte Zwei-anteil. */

	HELP = *z_ggt1;
	if (!(HELP & TEST)) 
		v1 = 1L;
	else {
		HELP = *z_ggt2;
		ZWEI_ANTEIL(z_ggt2,v2);
	}

	/* Division beider Operanden durch eine gemeinsame Zweipotenz aendert das Inverse nicht. 		*/
	/* Also wird zunaechst der groesste gemeinsame Zwei-anteil von zahl und modul herausdividiert.		*/
	/* Ist anschliessend zahl ungerade und modul gerade, dann ersetzt man modul durch modul - zahl .	*/
	/* Am Ende muss dann aber eine Ruecktransformation stattfinden.						*/

	/* Division von zahl1 durch eine Zweipotenz aendert das Inverse, wenn modul ungerade ist. 		*/

	shift(modul,-v,neuer_modul);
	shift(zahl_modulo,-v,zahl_modulo);
	trans(zahl_modulo,ggt2);
/**/
	if (v1) { /* neuer_modul ist gerade, also zahl_modulo ungerade. */
		sub(neuer_modul,ggt2,neuer_modul);
		/* Nun ist eventuell wieder ggt2 >= neuer_modul .	*/
		if (comp(neuer_modul,ggt2) >= 0) { /* ggt2 >= neuer_modul .	*/
			div(ggt2,neuer_modul,ggt1,ggt1);
			/* Da ggt2 eventuell spaeter noch gebraucht wird, speichere ich es zunaechst in ggt1 ab.	*/
			/* Nun ist eventuell wieder "ggt2" gerade. Also muss v2 neu berechnet werden.			*/
			/* Es kann sogar "ggt2" == 0 sein.								*/
			if (!*ggt1) { /* "ggt2" == 0 .	*/
				/* Also ist der ggt = neuer_modul und das Inverse muss noch ruecktransformiert werden.	*/
				sub(ggt2,neuer_modul,ggt2);
				shift(neuer_modul,v,ergebnis);
				div(ggt2,neuer_modul,ggt2,ggt1);
				madd(ggt2,ONE,invers,modul);
				return( !( (*neuer_modul == 1L) && (*(neuer_modul+1) == 1L)  && (!v) ) );
			}
			trans(ggt1,ggt2);
		}
		TEST = 1L;
		z_ggt2 = ggt2 + 1;
		HELP = *z_ggt2;
		ZWEI_ANTEIL(z_ggt2,v2);
	}

	trans(neuer_modul,ggt1);
	if (v2) shift(ggt2,-v2,ggt2);

	for (i = 0L; i < v2; i++) {
		if (inv2[1] & 1L)  /* inv2 ungerade.	*/
			add(inv2,neuer_modul,inv2);
		shift(inv2,-1L,inv2);
	}
	/* Nun sind ggt1 und ggt2 ungerade.	*/
	while (*ggt1 && *ggt2) {
		/* Hoechstens einer der beiden ggt's ist gerade.	*/
		TEST = 1L;
		z_ggt1 = ggt1 + 1;
		HELP = *z_ggt1;
		if (!(HELP & TEST)) {
			TEST = 2L;
			v2 = 1L;
			ZWEI_ANTEIL(z_ggt1,v2);
			shift(ggt1,-v2,ggt1);
			/* Wir muessen jetzt noch inv1 v2 mal halbieren.	*/
			for (i = 0L; i < v2; i++) {
				if (inv1[1] & 1L)  /* inv1 ungerade.	*/
					add(inv1,neuer_modul,inv1);
				shift(inv1,-1L,inv1);
			}	
		}
		else {
			z_ggt2 = ggt2 + 1;
			HELP = *z_ggt2;
			if (!(HELP & TEST)) {
				TEST = 2L;
				v2 = 1L;
				ZWEI_ANTEIL(z_ggt2,v2);
				shift(ggt2,-v2,ggt2);
				/* Wir muessen jetzt noch inv2 v2 mal halbieren. */
				for (i = 0L; i < v2; i++) {
					if (inv2[1] & 1L)  /* inv2 ungerade */
						add(inv2,neuer_modul,inv2);
					shift(inv2,-1L,inv2);
				}
			}
		}
		/* Nun sind ggt1 und ggt2 beide ungerade.	*/
/**/
		if (comp(ggt1,ggt2) == 1) { /* ggt1 < ggt2 .	*/
			sub(ggt2,ggt1,ggt2);
			msub(inv2,inv1,inv2,neuer_modul);
		}
		else {
			sub(ggt1,ggt2,ggt1);
			msub(inv1,inv2,inv1,neuer_modul);
		}
	}

	if (!*ggt1) { /* ggt1 == 0 .	*/
		if (v1) { /* In diesem Fall muss noch die Ruecktransformation fuer das Inverse gemacht werden.	*/
			mult(zahl_modulo,inv2,ggt1);
			sub(ggt1,ggt2,ggt1);
			if (ergebnis != invers) {
				shift(ggt2,v,ergebnis);
				returncode = !( (*ergebnis == 1L) && (*(ergebnis+1) == 1L) );
			}
			else
				returncode = !( (*ggt2 == 1L) && (*(ggt2+1) == 1L)  && (!v) );
			div(ggt1,neuer_modul,ggt1,ggt2);
			madd(inv2,ggt1,invers,modul);

		}
		else {
			if (ergebnis != invers) {
				shift(ggt2,v,ergebnis);
				returncode = !( (*ergebnis == 1L) && (*(ergebnis+1) == 1L) );
			}
			else
				returncode = !( (*ggt2 == 1L) && (*(ggt2+1) == 1L)  && (!v) );
			trans(inv2,invers);
		}
	}
	else { /* ggt2 == 0 .	*/
		if (v1) { /* In diesem Fall muss noch die Ruecktransformation fuer das Inverse gemacht werden.	*/
			mult(zahl_modulo,inv1,ggt2);
			sub(ggt2,ggt1,ggt2);
			if (ergebnis != invers) {
				shift(ggt1,v,ergebnis);
				returncode = !( (*ergebnis == 1L) && (*(ergebnis+1) == 1L) );
			}
			else
				returncode = !( (*ggt1 == 1L) && (*(ggt1+1) == 1L)  && (!v) );
			div(ggt2,neuer_modul,ggt2,ggt1);
			madd(inv1,ggt2,invers,modul);
		}
		else {
			if (ergebnis != invers) {
				shift(ggt1,v,ergebnis);
				returncode = !( (*ergebnis == 1L) && (*(ergebnis+1) == 1L) );
			}
			else
				returncode = !( (*ggt1 == 1L) && (*(ggt1+1) == 1L)  && (!v) );
			trans(inv1,invers);
		}
	}
	return(returncode);
}
/**/
#else
GGT(zahl,modul,ergebnis,invers)
LONG zahl[], modul[], ergebnis[], invers[];
/* Eingabeparameter : zahl, modul;									*/
/* Ausgabeparameter : ergebnis, invers;									*/
/* Wirkung :          ergebnis := ggt(zahl,modul);							*/
/*                    invers wird definiert durch : (invers * zahl) % modul == ergebnis;		*/
/* Returncode :       -1  falls (zahl % modul) == 0,							*/
/*                     0  falls der ggt gleich 1 ist,							*/
/*                     1  sonst.									*/
/* Overflow :        											*/
{
	LONG ggt1[LAENGE], ggt2[LAENGE], invers1[LAENGE], invers2[LAENGE];
	LONG faktor[LAENGE], zwischen[LAENGE];
	int  welcher = 0;


	if (div(zahl,modul,ggt2,ggt2)) /* ggt2 = zahl % modul .	*/
		overflow("GGT : modul == 0!");
	if (!*ggt2) { /* ggt2 == 0 .	*/
		trans(modul,ergebnis);
		*invers = 1L;
		*(invers + 1) = 1L;
		return(-1);
	}
			
	trans(modul,ggt1);
	*invers1 = 0L;
	*invers2 = 1L;
	*(invers2 + 1) = 1L;

	while (!welcher) {
		div(ggt1,ggt2,faktor,ggt1);
		if (!*ggt1) {
			welcher = 2;
			break;
		}
		mmult(faktor,invers2,zwischen,modul);
		msub(invers1,zwischen,invers1,modul);
		div(ggt2,ggt1,faktor,ggt2);
		if (!*ggt2) 
			welcher = 1;
		else {
			mmult(faktor,invers1,zwischen,modul);
			msub(invers2,zwischen,invers2,modul);
		}
	}
	switch (welcher) {
		case 1 : 
			if (ergebnis != invers)
				trans(ggt1,ergebnis);
			trans(invers1,invers);
			return(!( (*ggt1 == 1L) && (*(ggt1+1) == 1L) ) );
		case 2 : 
			if (ergebnis != invers)
				trans(ggt2,ergebnis);
			trans(invers2,invers);
			return(!( (*ggt2 == 1L) && (*(ggt2+1) == 1L) ) );
	}
}
#endif
/**/
mdiv(zahl1,zahl2,ergebnis,modul)
LONG  zahl1[],zahl2[],ergebnis[],modul[];
/* Eingabeparameter : zahl1, zahl2, modul;				*/
/* Ausgabeparameter : ergebnis;						*/
/* Wirkung :          ergebnis := zahl1 * zahl2^-1  mod modul.		*/
/* Returncode :       -1  falls (zahl2 % modul) == 0,			*/
/*                        oder  ggt(zahl2,modul) teilt nicht zahl1.	*/
/*                     0  sonst.					*/
{
	LONG  ggt[LAENGE], invers[LAENGE], quotient[LAENGE], rest[LAENGE];

	/* Berechne zunaechst den ggt von zahl2 und modul.	*/
	if (GGT(zahl2,modul,ggt,invers) == -1) /* (zahl2 % modul) == 0 .	*/
		return(-1);
	div(zahl1,ggt,quotient,rest);
	if (rest[0]) /* rest != 0 .	*/
		return(-1);
	else {
		mmult(quotient,invers,ergebnis,modul);
		return(0);
	}
}
/**/
LONG MODUL[LAENGE];
LONG MODUL_STRICH[LAENGE];
LONG EXPONENT = 0L;

trans_mod_basispotenz(zahl,ergebnis)
LONG  zahl[], ergebnis[];
/* Eingabeparameter : zahl;						*/
/* Ausgabeparameter : ergebnis;						*/
/* Wirkung :          ergebnis := zahl % ((2^LONGBITS)^EXPONENT);	*/
/* Returncode :       Keiner.						*/

/* Die Schleife wird immer durchlaufen, auch wenn die Adresse		*/
/* von zahl und	ergebnis uebereinstimmen.				*/
{
	LONG  *z_zahl, *z_ergebnis;
	LONG  exp;

	if (*zahl) {
		if (EXPONENT < *zahl)
			exp = EXPONENT;
		else
			exp = *zahl;
		z_zahl = zahl + exp;
		while (!*z_zahl && exp) {
			z_zahl--;
			exp--;
		}
		z_ergebnis = ergebnis + exp;
		while (z_zahl > zahl) 
			*z_ergebnis-- = *z_zahl--;
		*z_ergebnis = exp;
	}
	else 
		*ergebnis = 0L;
}
/**/
mult_mod_basispotenz(zahl1,zahl2,ergebnis)
LONG  zahl1[], zahl2[], ergebnis[];
/* Eingabeparameter : zahl1, zahl2;						*/
/*                    Die globale Variable : EXPONENT;				*/
/* Ausgabeparameter : ergebnis;							*/
/* Wirkung :          ergebnis := (zahl1 * zahl2) % ((2^LONGBITS)^EXPONENT);	*/
/* Returncode :       Keiner.							*/
{
	SHORT A00, A01, A_DIF, B00, B01, B_DIF;
	LONG  E0, E1, E_DIF;
	LONG  za1[LAENGE], za2[LAENGE], erg[LAENGE];
	LONG  *z_faktor1, *z_f1, *e_f1, *z_faktor2, *z_f2, *e_f2, *z_ergebnis, *e_ergebnis, *z_e;
	LONG  stellen, stellen1, stellen2, faktor, carry; 

#if !DREIVIERTEL
LONG  H01, H10;
#endif

	if (EXPONENT > LAENGE) 
		overflow("mult_mod_basispotenz : Overflow!");
	if (*zahl1 >= *zahl2) {
		trans_mod_basispotenz(zahl1,za1);
		trans_mod_basispotenz(zahl2,za2);
	}
	else {
		trans_mod_basispotenz(zahl1,za2);
		trans_mod_basispotenz(zahl2,za1);
	}
	stellen1 = *za1; /* Nun gilt stellen1 <= EXPONENT .	*/
	stellen2 = *za2; /* Nun gilt stellen2 <= EXPONENT .	*/
	if (stellen1 < stellen2) {
		z_faktor1 = za2 + 1;
		z_faktor2 = za1 + 1;
		stellen  = stellen1;
		stellen1 = stellen2;
		stellen2 = stellen;
	}
	else {
		z_faktor1 = za1 + 1;
		z_faktor2 = za2 + 1;
	}
	/* Nun gilt stellen1 >= stellen2 >= 0 .	*/

	/* Falls einer der beiden Faktoren oder der Exponent gleich 0 ist, so auch das Produkt */
	if (!stellen2 || !EXPONENT) {
		*ergebnis = 0L;
		return;
	}

	/* Nun ist stellen1 >= stellen2 >= 1 .	*/

	if (stellen2 == 1L) { /* falls faktor2 nur eine Stelle hat, wird sofort in ergebnis abgespeichert.	*/
		e_f1 = z_faktor1 + (int) stellen1; /* e_f1 zeigt auf das erste LONG, das nicht zu z_faktor1 gehoert.	*/
		z_f1 = z_faktor1;
		z_ergebnis = ergebnis + 1;
		faktor = *(z_faktor2);
		A00 = (SHORT)faktor;
		A01 = (SHORT)(faktor >> SHORTBITS);
		carry = 0L;
/**/
#if DREIVIERTEL
		if (A00 >= A01) {
			A_DIF = A00 - A01;
			while (z_f1 < e_f1) {
				/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_ergebnis++ .	*/
				B00 = (SHORT)(*z_f1);
				B01 = (SHORT)((*z_f1++) >> SHORTBITS);
				LONG_MULTIPLIKATION_FALL1;
				if ( (E0 += carry) < carry )
					E1++;
				*z_ergebnis++ = E0;
				carry = E1;
			}
		}
		else {
			A_DIF = A01 - A00;
			while (z_f1 < e_f1) {
				/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_ergebnis++ .	*/
				B00 = (SHORT)(*z_f1);
				B01 = (SHORT)((*z_f1++) >> SHORTBITS);
				LONG_MULTIPLIKATION_FALL2;
				if ( (E0 += carry) < carry )
					E1++;
				*z_ergebnis++ = E0;
				carry = E1;
			}
		}
#else
		while (z_f1 < e_f1) {
			/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_ergebnis++ .	*/
			B00 = (SHORT)(*z_f1);
			B01 = (SHORT)((*z_f1++) >> SHORTBITS);
			LONG_MULTIPLIKATION;
			if ( (E0 += carry) < carry )
				E1++;
			*z_ergebnis++ = E0;
			carry = E1;
		}
#endif
		if (carry) {
			*z_ergebnis = carry;
			*ergebnis = (int) stellen1 + 1L;
			trans_mod_basispotenz(ergebnis,ergebnis);
		}		
		else
			*ergebnis = stellen1;
		return;
	} /* Ende des Falls stellen2 == 1.	*/
/**/
	/* Ab jetzt gilt stellen2 >= 2 .	*/

	e_f2 = z_faktor2 + stellen2; /* e_f2 zeigt auf das erste LONG, das nicht zu z_faktor2 gehoert.	*/

	/* Multiplikation von faktor1 mit faktor2[2].	*/
	z_f2 = z_faktor2 + 1;
	z_f1 = z_faktor1;
	if (stellen1 < EXPONENT - 1L) 
		e_f1 = z_faktor1 + (int) stellen1;
	else
		e_f1 = z_faktor1 + EXPONENT - 1L; /* e_f1 zeigt auf das erste LONG, das nicht zu z_faktor1 gehoert.	*/
	z_e = erg + 2;
	faktor = *z_f2++;
	A00 = (SHORT)faktor;
	A01 = (SHORT)(faktor >> SHORTBITS);
	carry = 0L;
#if DREIVIERTEL
	if (A00 >= A01) {
		A_DIF = A00 - A01;
		while (z_f1 < e_f1) {
			/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
			B00 = (SHORT)(*z_f1);
			B01 = (SHORT)((*z_f1++) >> SHORTBITS);
			LONG_MULTIPLIKATION_FALL1;
			if ( (E0 += carry) < carry )
				E1++;
			*z_e++ = E0;
			carry = E1;
		}
	}
	else {
		A_DIF = A01 - A00;
		while (z_f1 < e_f1) {
			/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
			B00 = (SHORT)(*z_f1);
			B01 = (SHORT)((*z_f1++) >> SHORTBITS);
			LONG_MULTIPLIKATION_FALL2;
			if ( (E0 += carry) < carry )
				E1++;
			*z_e++ = E0;
			carry = E1;
		}
	}
#else
	while (z_f1 < e_f1) {
		/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
		B00 = (SHORT)(*z_f1);
		B01 = (SHORT)((*z_f1++) >> SHORTBITS);
		LONG_MULTIPLIKATION;
		if ( (E0 += carry) < carry )
			E1++;
		*z_e++ = E0;
		carry = E1;
	}
#endif
	*z_e = carry;
	/* Ende der Multiplikation von faktor1 mit faktor2[2].	*/
/**/
	while (z_f2 < e_f2) {
		/* Multiplikation von faktor1 mit faktor2[j].	*/
		z_f1 = z_faktor1;
		if (stellen1 < EXPONENT + 1L - (z_f2 - za2))
			e_f1 = z_faktor1 + (int) stellen1;
		else
			e_f1 = z_faktor1 + EXPONENT + 1L - (z_f2 - za2);
		z_e = erg + (z_f2 - za2);
		faktor = *z_f2++;
		A00 = (SHORT)faktor;
		A01 = (SHORT)(faktor >> SHORTBITS);
		carry = 0L;
#if DREIVIERTEL
		if (A00 >= A01) {
			A_DIF = A00 - A01;
			while (z_f1 < e_f1) {
				/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
				B00 = (SHORT)(*z_f1);
				B01 = (SHORT)((*z_f1++) >> SHORTBITS);
				LONG_MULTIPLIKATION_FALL1;
				if ( (E0 += carry) < carry )
					E1++;
				if ( (*z_e++ += E0) < E0 )
					E1++;
				carry = E1;
			}
		}
		else {
			A_DIF = A01 - A00;
			while (z_f1 < e_f1) {
				/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
				B00 = (SHORT)(*z_f1);
				B01 = (SHORT)((*z_f1++) >> SHORTBITS);
				LONG_MULTIPLIKATION_FALL2;
				if ( (E0 += carry) < carry )
					E1++;
				if ( (*z_e++ += E0) < E0 )
					E1++;
				carry = E1;
			}
		}
#else
		while (z_f1 < e_f1) {
			/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
			B00 = (SHORT)(*z_f1);
			B01 = (SHORT)((*z_f1++) >> SHORTBITS);
			LONG_MULTIPLIKATION;
			if ( (E0 += carry) < carry )
				E1++;
			if ( (*z_e++ += E0) < E0 )
				E1++;
			carry = E1;
		}
#endif
		*z_e = carry;
	} /* Es fehlt nun nur noch die Multiplikation von faktor1 mit faktor2[1].	*/
/**/

	/* Multiplikation von z_faktor1 mit z_faktor2[1].	*/
	z_ergebnis = ergebnis + 1;
	faktor = *(z_faktor2);
	A00 = (SHORT)faktor;
	A01 = (SHORT)(faktor >> SHORTBITS);
	B00 = (SHORT)(*z_faktor1);
	B01 = (SHORT)((*z_faktor1) >> SHORTBITS);
	LONG_MULTIPLIKATION;
	*z_ergebnis++ = E0;
	carry = E1;
	z_f1 = z_faktor1 + 1;
	e_f1 = z_faktor1 + (int) stellen1;
	z_e = erg + 2;
#if DREIVIERTEL
	if (A00 >= A01) {
		while (z_f1 < e_f1) {
			/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
			B00 = (SHORT)(*z_f1);
			B01 = (SHORT)((*z_f1++) >> SHORTBITS);
			LONG_MULTIPLIKATION_FALL1;
			if ( (E0 += carry) < carry )
				E1++;
			if ( (*z_ergebnis++ = *z_e++ + E0) < E0 )
				E1++;;
			carry = E1;
		} /* Ende der Multiplikation von faktor1 mit faktor2[1].	*/
	}
	else {
		while (z_f1 < e_f1) {
			/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
			B00 = (SHORT)(*z_f1);
			B01 = (SHORT)((*z_f1++) >> SHORTBITS);
			LONG_MULTIPLIKATION_FALL2;
			if ( (E0 += carry) < carry )
				E1++;
			if ( (*z_ergebnis++ = *z_e++ + E0) < E0 )
				E1++;;
			carry = E1;
		} /* Ende der Multiplikation von faktor1 mit faktor2[1].	*/
	}
#else
	while (z_f1 < e_f1) {
		/* Wir berechnen jetzt *z_f1++ * faktor + carry =: carry * 2^32 + z_e++ .	*/
		B00 = (SHORT)(*z_f1);
		B01 = (SHORT)((*z_f1++) >> SHORTBITS);
		LONG_MULTIPLIKATION;
		if ( (E0 += carry) < carry )
			E1++;
		if ( (*z_ergebnis++ = *z_e++ + E0) < E0 )
			E1++;;
		carry = E1;
	} /* Ende der Multiplikation von faktor1 mit faktor2[1].	*/
#endif
	/* Wir muessen jetzt gegebenenfalls noch den carry aufaddieren.	*/
	carry = ( (*z_ergebnis++ = *z_e++ + carry) < carry );
	while (carry) { /* Solange der carry noch 1 ist, ist *z_e bereits definiert worden ist.	*/
		*z_ergebnis++ = carry += *z_e++;
		carry = !carry;
	}
/**/
	/* Nun gilt carry == 0 und der Rest muss nur noch kopiert werden.	*/
	stellen = stellen1 + stellen2;
	if (stellen <= EXPONENT) {
		e_ergebnis = ergebnis + (int) stellen; /* e_ergebnis zeigt auf das letzte LONG, das noch zu ergebnis gehoert.	*/
		while (z_ergebnis <= e_ergebnis)
			*z_ergebnis++ = *z_e++;
		/* z_ergebnis zeigt nun zu weit vor erg; daher predekrement */
		*ergebnis = (*--z_ergebnis) ? (stellen) : (stellen - 1L);	
	}
	else {
		e_ergebnis = ergebnis + EXPONENT; /* e_ergebnis zeigt auf das letzte LONG, das noch zu ergebnis gehoert.	*/
		while (z_ergebnis <= e_ergebnis)
			*z_ergebnis++ = *z_e++;
		z_ergebnis = ergebnis + EXPONENT;
		stellen = EXPONENT;
		while (!(*z_ergebnis--))
			stellen--;
		*ergebnis = stellen;
	}
}
/**/
mont_init(modul)
LONG  modul[];
/* Eingabeparameter : modul;												*/
/* Ausgabeparameter : Die globalen Variablen : EXPONENT, MODUL, MODUL_STRICH;						*/
/* Wirkung :          MODUL := modul;											*/
/*                    EXPONENT wird definiert durch : (2^LONGBITS)^EXPONENT > MODUL > (2^LONGBITS)^(EXPONENT-1);	*/
/*                    MODUL_STRICH wird definiert durch : MODUL * MODUL_STRICH == -1 mod (2^LONGBITS)^EXPONENT;		*/
/* Returncode :       Keiner.												*/
/* Voraussetzungen :  modul ist ungerade.										*/
/* Overflow :         kann beim Aufruf von mult auftreten,								*/
/*                    	falls 2 * anzahl_bits(modul) > LONGBITS * (LAENGE - 2) ;					*/
/*                    kann beim Aufruf von div auftreten,								*/
/*                    	falls 2 * anzahl_bits(modul) > LONGBITS * (LAENGE - 2) ;					*/
/*                    Es ist gesichert, dass kein Overflow auftritt,							*/
/*                    	falls 2 * anzahl_bits(modul) <= LONGBITS * (LAENGE - 2) .					*/
{
	LONG  TEST = 1L, HELP;
	LONG  n_modul[LAENGE], neuer_modul[LAENGE], quotient[LAENGE], ggt1[LAENGE], ggt2[LAENGE], inv1[LAENGE], inv2[LAENGE];
	LONG  *z_n_modul, *e_n_modul, *z_ggt1, *z_ggt2;
	long  v = 0L, i;

	trans(modul,MODUL);
	EXPONENT = *modul;
	*n_modul = EXPONENT + 1L;
	z_n_modul = n_modul + 1;
	e_n_modul = z_n_modul + EXPONENT;
	while (z_n_modul < e_n_modul)
		*z_n_modul++ = 0L;
	*z_n_modul = 1L;
	/* Nun ist EXPONENT bereits richtig berechnet und es gilt n_modul = (2^LONGBITS)^EXPONENT.	*/
	/* Diese Voraussetzungen benutzend, wird MODUL_STRICH berechnet,				*/
	/* und zwar aehnlich wie das Inverse mod n_modul mittels shiften.				*/

	if (EQUAL1(modul)) { /* modul == 1 .	*/
		sub(n_modul,ONE,MODUL_STRICH);
		return;
	}

	*inv1 = 0L;		 /* inv1 := 0;	*/
	*inv2 = 1L;
	*(inv2 + 1) = 1L;	/* inv2 := 1;	*/

	/* Da n_modul gerade und modul ungerade ist, ersetzt man n_modul durch n_modul % modul.	*/
	/* Am Ende muss dann aber eine Ruecktransformation stattfinden.				*/

	div(n_modul,modul,quotient,neuer_modul);
	if ( !(*(neuer_modul+1) & 1L) ) { /* neuer_modul gerade .	*/ 
		add(neuer_modul,modul,neuer_modul);
		decr(quotient);
	}
	else { /* neuer_modul ungerade.	*/
		if (EQUAL1(neuer_modul)) { /* neuer_modul == 1 .	*/
			trans(quotient,MODUL_STRICH);
			return;
		}	
		if (comp(TWO,quotient) >= 0) {
			shift(modul,1L,MODUL_STRICH);
			add(neuer_modul,MODUL_STRICH,neuer_modul);
			sub(quotient,TWO,quotient);
		}
	}

	/* Nun ist eventuell wieder neuer_modul <= modul . */
	if (comp(neuer_modul,modul) >= 0) { /* neuer_modul <= modul .	*/
		div(modul,neuer_modul,ggt2,ggt2);
		/* Nun ist sicher ggt2 < neuer_modul. Eventuell ist aber nun ggt2 gerade.	*/
		/* Wir berechnen den Zwei-anteil von ggt2.					*/
		/* Da ggt2 == 0  <==> neuer_modul == 1 ist, gilt hier ggt2 != 0 .		*/
		z_ggt2 = ggt2 + 1;
		HELP = *z_ggt2;
		ZWEI_ANTEIL(z_ggt2,v);
	}
	else
		trans(modul,ggt2);
/**/
	trans(neuer_modul,ggt1);
	if (v) shift(ggt2,-v,ggt2);
	for (i = 0L; i < v; i++) {
		if (inv2[1] & 1L)  /* inv2 ungerade.	*/
			add(inv2,neuer_modul,inv2);
		shift(inv2,-1L,inv2);
	}
	/* Nun sind ggt1 und ggt2 ungerade.	*/
	while (*ggt1 && *ggt2) {
		/* Hoechstens einer der beiden ggt's ist gerade.	*/
		TEST = 1L;
		z_ggt1 = ggt1 + 1;
		HELP = *z_ggt1;
		if (!(HELP & TEST)) {
			v = 1L;
			TEST = 2L;
			ZWEI_ANTEIL(z_ggt1,v);
			shift(ggt1,-v,ggt1);
			/* Wir muessen jetzt noch inv1 v mal halbieren.	*/
			for (i = 0L; i < v; i++) {
				if (inv1[1] & 1L)  /* inv1 ungerade.	*/
					add(inv1,neuer_modul,inv1);
				shift(inv1,-1L,inv1);
			}	
		}
		else {
			z_ggt2 = ggt2 + 1;
			HELP = *z_ggt2;
			if (!(HELP & TEST)) {
				v = 1L;
				TEST = 2L;
				ZWEI_ANTEIL(z_ggt2,v);
				shift(ggt2,-v,ggt2);
				/* Wir muessen jetzt noch inv2 v mal halbieren. */
				for (i = 0L; i < v; i++) {
					if (inv2[1] & 1L)  /* inv2 ungerade */
						add(inv2,neuer_modul,inv2);
					shift(inv2,-1L,inv2);
				}
			}
		}
		/* Nun sind ggt1 und ggt2 beide ungerade.	*/

		if (comp(ggt1,ggt2) == 1) { /* ggt1 < ggt2 .	*/
			sub(ggt2,ggt1,ggt2);
			msub(inv2,inv1,inv2,neuer_modul);
		}
		else { /* ggt1 >= ggt2 .	*/
			sub(ggt1,ggt2,ggt1);
			msub(inv1,inv2,inv1,neuer_modul);
		}
	}

	/* Da n_modul gerade und modul ungerade ist, muss immer eine Ruecktransformation gemacht werden.	*/
	if (!*ggt1) { /* ggt1 == 0 .	*/
		mult(modul,inv2,ggt1);
		sub(ggt1,ggt2,ggt1);
		div(ggt1,neuer_modul,ggt1,ggt2);
		mult(ggt1,quotient,ggt1);
		madd(inv2,ggt1,MODUL_STRICH,n_modul);
	}
	else { /* ggt2 == 0 .	*/
		mult(modul,inv1,ggt2);
		sub(ggt2,ggt1,ggt2);
		div(ggt2,neuer_modul,ggt2,ggt1);
		mult(ggt2,quotient,ggt2);
		madd(inv1,ggt2,MODUL_STRICH,n_modul);
	}
	sub(n_modul,MODUL_STRICH,MODUL_STRICH);
}
/**/
mont_redc(zahl,ergebnis)
LONG  zahl[],ergebnis[];
/* Eingabeparameter : zahl;							*/
/*                    Die globalen Variablen : EXPONENT, MODUL, MODUL_STRICH;	*/
/* Ausgabeparameter : ergebnis;							*/
/* Wirkung :          ergebnis := zahl * ((2^LONGBITS)^EXPONENT)^-1 mod MODUL;	*/
/*                    Zum Beweis dieser Tatsache siehe :			*/
/*                    Peter L. Montgomery					*/
/*                    Modular Multiplication Without Trial Division.		*/
/*                    Mathematics of Computation				*/
/*                    Volume 44, Number 170, April 1985, 519 - 521.		*/
/* Returncode :       Keiner.							*/
/* Voraussetzungen :  zahl < MODUL * (2^LONGBITS)^EXPONENT , MODUL ungerade.	*/
{
	LONG  m[LAENGE], t[LAENGE];
	LONG  *z1_t, *z2_t, *e_t;
	LONG  stellen;

	stellen = *zahl;
	if (stellen > EXPONENT) {
		*zahl = EXPONENT;
		while ((!zahl[*zahl]) && *zahl)
			--(*zahl);
	}
	mult_mod_basispotenz(zahl,MODUL_STRICH,m);
	*zahl = stellen;
	
	mult(m,MODUL,t);
	add(t,zahl,t);
	/* Dies kann wohl noch stark beschleunigt werden.	*/
	/* Nun shiften wir t um EXPONENT Woerter nach rechts.	*/
	e_t = t + *t;
	if ((LONGINT)(*t -= EXPONENT) < 0L) 
		*t = 0L;
	else {
		z1_t = t + EXPONENT + 1;
		z2_t = t + 1;
		do 
			*z2_t++ = *z1_t++;
		while (z1_t <= e_t);
	}
	if (comp(t,MODUL) <= 0)
		sub(t,MODUL,ergebnis);
	else
		trans(t,ergebnis);
	if (comp(t,MODUL) <= 0)
		sub(t,MODUL,ergebnis);
}
/**/
mont_mexp(zahl1,zahl2,ergebnis)
LONG  zahl1[],zahl2[],ergebnis[];
/* Eingabeparameter : zahl1, zahl2;						*/
/*                    Die globalen Variablen : EXPONENT, MODUL, MODUL_STRICH;	*/
/* Ausgabeparameter : ergebnis;							*/
/* Wirkung :          ergebnis := (zahl1^zahl2) % modul;			*/
/*                    Zum Beweis dieser Tatsache siehe :			*/
/*                    Peter L. Montgomery					*/
/*                    Modular Multiplication Without Trial Division.		*/
/*                    Mathematics of Computation				*/
/*                    Volume 44, Number 170, April 1985, 519 - 521.		*/
/* Returncode :       Keiner.							*/
/* Voraussetzungen :  zahl1 < MODUL , MODUL ungerade.				*/
{
	short shifts;
	SHORT vier_bits = 0;
	LONG  potenzen[16][LAENGE];
	LONG  *z_zahl2;
	LONG  stellen, test, i;
	
	/* Initialisierungen von Potenzen[i].		*/
	/* Dies sollte ohne Schleife gemacht werden.	*/
	trans(zahl1,potenzen[1]);
	Equad(potenzen[1],potenzen[2]);
	mont_redc(potenzen[2],potenzen[2]);
	mult(potenzen[1],potenzen[2],potenzen[3]);
	mont_redc(potenzen[3],potenzen[3]);
	Equad(potenzen[2],potenzen[4]);
	mont_redc(potenzen[4],potenzen[4]);
	mult(potenzen[1],potenzen[4],potenzen[5]);
	mont_redc(potenzen[5],potenzen[5]);
	Equad(potenzen[3],potenzen[6]);
	mont_redc(potenzen[6],potenzen[6]);
	mult(potenzen[1],potenzen[6],potenzen[7]);
	mont_redc(potenzen[7],potenzen[7]);
	Equad(potenzen[4],potenzen[8]);
	mont_redc(potenzen[8],potenzen[8]);
	mult(potenzen[1],potenzen[8],potenzen[9]);
	mont_redc(potenzen[9],potenzen[9]);
	Equad(potenzen[5],potenzen[10]);
	mont_redc(potenzen[10],potenzen[10]);
	mult(potenzen[1],potenzen[10],potenzen[11]);
	mont_redc(potenzen[11],potenzen[11]);
	Equad(potenzen[6],potenzen[12]);
	mont_redc(potenzen[12],potenzen[12]);
	mult(potenzen[1],potenzen[12],potenzen[13]);
	mont_redc(potenzen[13],potenzen[13]);
	Equad(potenzen[7],potenzen[14]);
	mont_redc(potenzen[14],potenzen[14]);
	mult(potenzen[1],potenzen[14],potenzen[15]);
	mont_redc(potenzen[15],potenzen[15]);
/**/	
	/* Ueberspringen fuehrender Nullen; Initialisierung von ergebnis.	*/
	stellen = *zahl2;
	z_zahl2 = zahl2 + (int) stellen;
	test = *z_zahl2;
	for (shifts = (short)(LONGBITS - 4); !vier_bits; shifts -= 4) 
		vier_bits = (SHORT)( (test >> shifts) & 15L );
	trans(potenzen[vier_bits],ergebnis);
	
	for (; shifts >= 0; shifts -= 4) {
		Equad(ergebnis,ergebnis);
		mont_redc(ergebnis,ergebnis);
		Equad(ergebnis,ergebnis);
		mont_redc(ergebnis,ergebnis);
		Equad(ergebnis,ergebnis);
		mont_redc(ergebnis,ergebnis);
		Equad(ergebnis,ergebnis);
		mont_redc(ergebnis,ergebnis);
		if (vier_bits = (SHORT)( (test >> shifts) & 15L) ) {
			mult(potenzen[vier_bits],ergebnis,ergebnis);
			mont_redc(ergebnis,ergebnis);
		}
	}		
	for (i = 1L; i < stellen; i++) {
		test = *--z_zahl2;
		for (shifts = (short)(LONGBITS - 4); shifts >= 0; shifts -= 4) {
			Equad(ergebnis,ergebnis);
			mont_redc(ergebnis,ergebnis);
			Equad(ergebnis,ergebnis);
			mont_redc(ergebnis,ergebnis);
			Equad(ergebnis,ergebnis);
			mont_redc(ergebnis,ergebnis);
			Equad(ergebnis,ergebnis);
			mont_redc(ergebnis,ergebnis);
			if (vier_bits = (SHORT)( (test >> shifts) & 15L) ) {
				mult(potenzen[vier_bits],ergebnis,ergebnis);
				mont_redc(ergebnis,ergebnis);
			}
		}
	}
}
/**/
/*
mexp(zahl1,zahl2,ergebnis,modul)
LONG  zahl1[],zahl2[],ergebnis[],modul[];
*/
/* Marc Conrad, 201098: Einbau beschleunigter neuer Funktionen (aus Acryl): 
/* Eingabeparameter : zahl1, zahl2, modul;			*/
/* Ausgabeparameter : ergebnis;					*/
/* Wirkung :          ergebnis := (zahl1^zahl2) % modul;	*/
/* Returncode :       Keiner.					*/
/* Overflow :         kann beim Aufruf von mont_init auftreten,								*/
/*                    	falls 2 * anzahl_bits(modul) > LONGBITS * (LAENGE - 2) ;					*/
/*
 * Purpose:
 *	Computes "(zahl1 ^ zahl2) mod modul" and stores the result
 *	in "ergebnis". *modul (i.e. the number of 32bit-words of 
 *	modul) must be smaller then (E_LAENGE-1)/2.  
 *
 * Return value:
 *	0 if successful, -1, if the modul is 0. 
 */
int Emexp(
E_LONG			*zahl1,
E_LONG			*zahl2,
E_LONG			*ergebnis,
E_LONG			*modul
) {
short			shifts;
E_SHORT		vier_bits;
E_LONG			*z_zahl2;
E_LONG			stellen, test, i;
int 			k; 
E_LONG		erg[E_LAENGE]; /* shifted modul */
E_LONG		smodul[E_LAENGE]; /* shifted modul */
E_LONG		potenzen[16][E_LAENGE];

	if (!modul[0])			/* modul == 0 */
		return(-1);		/* OVERFLOW !! */

	if (!zahl2[0]) {
		/*
		 * zahl2 == 0 , also ergebnis = zahl1^0 = 1
		 * (auch falls zahl1 == 0).
		 */
		*ergebnis++ = 1L;
		*ergebnis = 1L;
		return(0);
	}
	Emod(zahl1, potenzen[1], modul);
/*  	potenzen[1] = zahl1 mod modul.  */
	if (!potenzen[1][0]) {			/* zahl1 = 0 mod modul.	*/
		*ergebnis = 0L;
		return(0);
	}

/* Der Modul wird soweit nach links geshiftet, bis das hoechste Bit
des hoechsten Worts gleich 1 ist. Zunaechst wird der Shiftfaktor k
berechnet. */

	i = *(modul + (int) (*modul));
	if( i & (1 << (E_LONGBITS -1) ) ) { k = 0; }
	else { k = E_LONGBITS; do { k--; i >>= 1; } while (i); }
	Eshift(modul,k,smodul);

	
/*  
    Initialisierungen von Potenzen[i]: Es ist potenzen[i] = 
    zahl1^i mod modul. Eventuell lohnt es sich hier auch mehr als 16 
    abzuspeichern. Ueberschlaegig gerechnet sind 2^d potenzen optimal
    fuer : 96-320 bits: d = 4, 321-960 bits: d = 5, 961-2688 bits: d = 6.
*/
	for(i=2;i<16;i++) {
	    if( i & 1 ) { 
		Ezmmult(potenzen[1],potenzen[i-1],potenzen[i],smodul);
	    } else { 
		Ezmquad(potenzen[i>>1], potenzen[i], smodul);
		} 
	    }

	vier_bits = 0;

	/*
	 * Ueberspringen fuehrender Nullen; Initialisierung von erg.
	 */
	stellen = *zahl2;
	z_zahl2 = zahl2 + stellen;
	test = *z_zahl2;
	for (shifts = (short)(E_LONGBITS - 4); !vier_bits; shifts -= 4) 
		vier_bits = (E_SHORT)((test >> shifts) & 15L);
	Etrans(potenzen[vier_bits], erg);
	
	for (; shifts >= 0; shifts -= 4) {
		/*
		 * erg = (erg^16 ) % smodul:
		 */
		Ezmquadeq(erg, smodul);
		Ezmquadeq(erg, smodul);
		Ezmquadeq(erg, smodul);
		Ezmquadeq(erg, smodul);
		if ((vier_bits = (E_SHORT)((test >> shifts) & 15L)) != 0)
			Ezmmulteq(erg, potenzen[vier_bits], smodul);
	}		
	
	for (i = 1L; i < stellen; i++) {
		test = *--z_zahl2;
		for (shifts = (short)(E_LONGBITS - 4); shifts >= 0; shifts -= 4) {
			/*
			 * erg = (erg^16 ) % smodul:
			 */
			Ezmquadeq(erg, smodul);
			Ezmquadeq(erg, smodul);
			Ezmquadeq(erg, smodul);
			Ezmquadeq(erg, smodul);
			if ((vier_bits = (E_SHORT)((test >> shifts) & 15L)) != 0)
				Ezmmulteq(erg,potenzen[vier_bits], smodul);
		}
	}
	if( k ) {
		Eshift(erg,k,erg); 
		Ezmodeq(erg,smodul);
		}
	Eshift(erg,-k,ergebnis);
	return(0);

/* Emexp() */ }
/**/
mexp_zwei(zahl2,ergebnis,modul)
LONG  zahl2[],ergebnis[],modul[];
/* Eingabeparameter : zahl2, modul;				*/
/* Ausgabeparameter : ergebnis;					*/
/* Wirkung :          ergebnis := (2^zahl2) % modul;		*/
/* Returncode :       Keiner.					*/
/* Overflow :         						*/
/*                    	falls 2 * anzahl_bits(modul) > LONGBITS * (LAENGE - 2) ;	*/
{
	short shifts;
	long  vier_bits;
	LONG  erg[LAENGE];
	LONG  *z_zahl2;
	LONG  stellen, test, i;

	if (!(*modul)) /* modul == 0 .	*/
		overflow("mexp : modul == 0!");
	if (!(*zahl2)) { /* zahl2 == 0 , also ergebnis = zahl1^0 = 1 (auch falls zahl1 == 0) .	*/
		*ergebnis = 1L;
		*(ergebnis+1) = 1L;
		return;
	}

	if ( (*modul == 1) && ((*(modul + 1) == 1) || (*(modul + 1) == 2)) ) { /* modul == 1  oder  modul == 2 .	*/
		*ergebnis = 0L;
		return;
	}

	vier_bits = 0L;

	/* Ueberspringen fuehrender Nullen; Initialisierung von erg.	*/
	stellen = *zahl2;
	z_zahl2 = zahl2 + (int) stellen;
	test = *z_zahl2;
	for (shifts = (short)(LONGBITS - 4); !vier_bits; shifts -= 4) 
		vier_bits = (test >> shifts) & 15L;
	zuweis(1L << vier_bits,erg);
	div(erg,modul,erg,erg);
	
	for (; shifts >= 0; shifts -= 4) {
		mquad(erg,erg,modul);
		mquad(erg,erg,modul);
		mquad(erg,erg,modul);
		mquad(erg,erg,modul); /* erg = (erg^16 ) % modul;	*/
		if (vier_bits = ( (test >> shifts) & 15L ) ) {
			shift(erg,vier_bits,erg);
			div(erg,modul,erg,erg);
		}
	}		
	
	for (i = 1L; i < stellen; i++) {
		test = *--z_zahl2;
		for (shifts = (short)(LONGBITS - 4); shifts >= 0; shifts -= 4) {
			mquad(erg,erg,modul);
			mquad(erg,erg,modul);
			mquad(erg,erg,modul);
			mquad(erg,erg,modul); /* erg = (erg^16 ) % modul;	*/
			if (vier_bits = ( (test >> shifts) & 15L ) ) {
				shift(erg,vier_bits,erg);
				div(erg,modul,erg,erg);
			}
		}
	}
	trans(erg,ergebnis);
}
/**/
mexp_zwei_8bit(zahl2,ergebnis,modul)
LONG  zahl2[],ergebnis[],modul[];
/* Eingabeparameter : zahl2, modul;				*/
/* Ausgabeparameter : ergebnis;					*/
/* Wirkung :          ergebnis := (2^zahl2) % modul;		*/
/* Returncode :       Keiner.					*/
/* Overflow :         						*/
/*                    	falls 2 * anzahl_bits(modul) > LONGBITS * (LAENGE - 2) ;	*/
{
	short shifts;
	long  acht_bits;
	LONG  erg[LAENGE];
	LONG  *z_zahl2;
	LONG  stellen, test, i;

	if (!(*modul)) /* modul == 0 .	*/
		overflow("mexp : modul == 0!");
	if (!(*zahl2)) { /* zahl2 == 0 , also ergebnis = zahl1^0 = 1 (auch falls zahl1 == 0) .	*/
		*ergebnis = 1L;
		*(ergebnis+1) = 1L;
		return;
	}

	if ( (*modul == 1) && ((*(modul + 1) == 1) || (*(modul + 1) == 2)) ) { /* modul == 1  oder  modul == 2 .	*/
		*ergebnis = 0L;
		return;
	}

	acht_bits = 0L;

	/* Ueberspringen fuehrender Nullen; Initialisierung von erg.	*/
	stellen = *zahl2;
	z_zahl2 = zahl2 + (int) stellen;
	test = *z_zahl2;
	for (shifts = (short)(LONGBITS - 8); !acht_bits; shifts -= 8) 
		acht_bits = (test >> shifts) & 255L;
	zuweis(1L,erg);
	shift(erg,acht_bits,erg);
	div(erg,modul,erg,erg);
	
	for (; shifts >= 0; shifts -= 8) {
		mquad(erg,erg,modul);
		mquad(erg,erg,modul);
		mquad(erg,erg,modul);
		mquad(erg,erg,modul);
		mquad(erg,erg,modul);
		mquad(erg,erg,modul);
		mquad(erg,erg,modul);
		mquad(erg,erg,modul); /* erg = (erg^256 ) % modul;	*/
		if (acht_bits = ( (test >> shifts) & 255L ) ) {
			shift(erg,acht_bits,erg);
			div(erg,modul,erg,erg);
		}
	}		
	
	for (i = 1L; i < stellen; i++) {
		test = *--z_zahl2;
		for (shifts = (short)(LONGBITS - 8); shifts >= 0; shifts -= 8) {
			mquad(erg,erg,modul);
			mquad(erg,erg,modul);
			mquad(erg,erg,modul);
			mquad(erg,erg,modul);
			mquad(erg,erg,modul);
			mquad(erg,erg,modul);
			mquad(erg,erg,modul);
			mquad(erg,erg,modul); /* erg = (erg^256 ) % modul;	*/
			if (acht_bits = ( (test >> shifts) & 255L ) ) {
				shift(erg,acht_bits,erg);
				div(erg,modul,erg,erg);
			}
		}
	}
	trans(erg,ergebnis);
}
/**/
mlucas(P,r,ergebnis,modul)
LONG P[], r[], ergebnis[], modul[];
/* Diese Prozedur berechnet die r-te Lucas-zahl V_r(P,1) mod modul,		*/
/* falls modul kein Quadrat ist. Andernfalls ist das Ergebnis undefiniert.	*/
{
	LONG  *z_r, V0[LAENGE], V1[LAENGE], W0[LAENGE], W1[LAENGE];
	long  i;

	if (EQUAL0(r)) {
		zuweis(2L,ergebnis);
		return(0);
	}

	if (EQUAL1(r)) {
		div(P,modul,ergebnis,ergebnis);
		return(0);
	}
	
	z_r = r + *r;
	zuweis(2L,V0);
	div(P,modul,V1,V1);

	i = LONGBITS - 1L;
	while (!(*z_r & (1L << i))) i--;
	for (i--; i >= 0L; i--) {
		mmult(V1,V0,V0,modul);	/* V0 = V0 * V1 .	*/
		mquad(V1,V1,modul);
		decr(V1);		/* V1 = v1^2 - 1 .	*/

		if (*z_r & (1L << i)) {
			mmult(P,V1,W1,modul);
			msub(W1,V0,W1,modul);	/* W1 = P * (V1^2 - 1) - V0 * V1 .	*/
			msub(V1,ONE,W0,modul);	/* W0 = V1^2 - 2 .			*/
		}
		else {
			msub(V0,P,W0,modul);	/* W0 = V0 * V1 - P .			*/
			msub(V1,ONE,W1,modul);	/* W1 = V1^2 - 2 .			*/
		}
		trans(W0,V0);
		trans(W1,V1);
	}

	for (z_r--; z_r > r; z_r--) {
		for (i = LONGBITS - 1L; i >= 0L; i--) {
			mmult(V1,V0,V0,modul);	/* V0 = V0 * V1 .	*/
			mquad(V1,V1,modul);
			decr(V1);		/* V1 = v1^2 - 1 .	*/
			if (*z_r & (1L << i)) {
				mmult(P,V1,W1,modul);
				msub(W1,V0,W1,modul);	/* W1 = P * (V1^2 - 1) - V0 * V1 .	*/
				msub(V1,ONE,W0,modul);	/* W0 = V1^2 - 2 .			*/
			}
			else {
				msub(V0,P,W0,modul);	/* W0 = V0 * V1 - P .			*/
				msub(V1,ONE,W1,modul);	/* W1 = V1^2 - 2 .			*/
			}
			trans(W0,V0);
			trans(W1,V1);
		}
	}

	trans(V1,ergebnis);
}
/**/
readparameter(text,zahl)
char  text[];
LONG  zahl[];
/* Eingabeparameter : text;		*/
/* Ausgabeparameter : zahl;		*/
/* Wirkung :          zahl := text;	*/
/* Returncode :       Keiner.		*/
{
	LONG  zwischen[LAENGE], a[2];
	char  eingabe;
	char  *z_text;

	*a = 1L;
	z_text = text;
	eingabe = *z_text++;
	if (eingabe == '0')
		*zahl = 0L;
	else 
		if ( (eingabe >= '1') && (eingabe <= '9') ) { /* eingabe in {0, 1, ..., 9} .	*/
			*zahl = 1L;
			*(zahl + 1) = (LONG)(eingabe - '0');
		}
		else 
			overflow("readparameter : Falsches Zeichen im Eingabetext!");

	/* Umwandlung von Zahlen zur Basis 10 in Zahlen zur Basis 2^LONGBITS.	*/
	eingabe = *z_text++;
	while (eingabe != STRING_ENDE) {
		if ( (eingabe >= '0') && (eingabe <= '9') ) { /* eingabe in {0, 1, ..., 9} .	*/
			shift(zahl,1L,zwischen);
			shift(zahl,3L,zahl);
			add(zahl,zwischen,zahl);
			if (*(a + 1) = (LONG)(eingabe - '0'))
				add(zahl,a,zahl);
		}
		else
			overflow("readparameter : Falsches Zeichen im Eingabetext!");
		eingabe = *z_text++;
	}
}
/**/
readue(text,zahl)
char  text[];
LONG  zahl[];
/* Eingabeparameter : text;								*/
/* Ausgabeparameter : zahl;								*/
/* Wirkung :          text wird nach stdout ausgegeben;					*/
/*                    zahl := in Dezimalschreibweise vom stdin aus eingegebener Text;	*/
/* Returncode :       Keiner.								*/
{
	LONG  zwischen[LAENGE], a[2];
	int   eingabe;

	printf(text);   
      
	/* Zunaechst werden alle Blanks ueberlesen.	*/
	do {
		eingabe = getchar();
	} while (eingabe == ' ');
	ungetc(eingabe,stdin);

	*a = 1L;
	eingabe = getchar();
	if (eingabe == '0')
		*zahl = 0L;
	else 
		if ( (eingabe >= '1') && (eingabe <= '9') ) { /* eingabe in {1, 2, ..., 9} .	*/
			*zahl = 1L;
			*(zahl + 1) = (LONG)(eingabe - '0');
		}
		else 
			overflow("readue : Falsches Zeichen im Eingabetext!");

	/* Umwandlung von Zahlen zur Basis 10 in Zahlen zur Basis 2^LONGBITS.	*/
	eingabe = getchar();
	while (eingabe != RETURN) {
		if ( (eingabe >= '0') && (eingabe <= '9') ) { /* eingabe in {0, 1, ..., 9} .	*/
			shift(zahl,1L,zwischen);
			shift(zahl,3L,zahl);
			add(zahl,zwischen,zahl);
			if (*(a + 1) = (LONG)(eingabe - '0'))
				add(zahl,a,zahl);
		}
		else
			overflow("readue : Falsches Zeichen im Eingabetext!");
		eingabe = getchar();
	}
}
/**/
readuefile(eingabefile,zahl)
FILE  *eingabefile;
LONG  zahl[];
/* Eingabeparameter : text;									*/
/* Ausgabeparameter : zahl;									*/
/* Wirkung :          zahl := in Dezimalschreibweise vom eingabefile aus eingelesener Text;	*/
/* Returncode :       Keiner.									*/
{
	LONG  zwischen[LAENGE], a[2];
	int   eingabe;        

/* Zunaechst werden alle Blanks ueberlesen.	*/
	do {
		eingabe = getc(eingabefile);
	} while (eingabe == ' ');
	ungetc(eingabe,eingabefile);



	*a = 1L;
	eingabe = getc(eingabefile);
	if (eingabe == '0')
		*zahl = 0L;
	else 
		if ( (eingabe >= '1') && (eingabe <= '9') ) { /* eingabe in {0, 1, ..., 9} .	*/
			*zahl = 1L;
			*(zahl + 1) = (LONG)(eingabe - '0');
		}
		else 
			overflow("readue : Falsches Zeichen im Eingabetext!");

	/* Umwandlung von Zahlen zur Basis 10 in Zahlen zur Basis 2^LONGBITS.	*/
	eingabe = getc(eingabefile);
	while (eingabe != RETURN) {
		if ( (eingabe >= '0') && (eingabe <= '9') ) { /* eingabe in {0, 1, ..., 9} .	*/
			shift(zahl,1L,zwischen);
			shift(zahl,3L,zahl);
			add(zahl,zwischen,zahl);
			if (*(a + 1) = (LONG)(eingabe - '0'))
				add(zahl,a,zahl);
		}
		else
			overflow("readuefile : Falsches Zeichen im Eingabetext!");
		eingabe = getc(eingabefile);
	}
}

read_long(eingabefile,zahl)
FILE  *eingabefile;
LONG  zahl[];
/* Eingabeparameter : eingabefile;										*/
/* Ausgabeparameter : zahl;											*/
/* Wirkung :          zahl := in darstellungsabhaengiger Schreibweise vom eingabefile aus eingelesene Zahl;	*/
/* Returncode :       Keiner.											*/
{
	LONG stellen, i;

	fscanf(eingabefile,"%08lx",&stellen);
	*zahl++ = stellen;
	for (i = 1L; i <= stellen; i++) 
		fscanf(eingabefile,"%08lx",zahl++);
	fscanf(eingabefile,"\n");
}
/**/
write_nur_zahl(zahl)
LONG  zahl[];
/* Eingabeparameter : zahl;							*/
/* Ausgabeparameter : Keine;							*/
/* Wirkung :          zahl wird in Dezimalschreibweise nach stdout ausgegeben;	*/
/* Returncode :       Keiner.							*/
{
	LONG  quot[LAENGE], rest[LAENGE], aus[AUSGABE_LAENGE];
	LONG  *z_aus;
	LONG  aus_stellen = 0L;

	if (!*zahl) { /* Zahl == 0 .	*/
		printf("0");
		return;
	}

	/* Umwandlung von Zahlen zur Basis 2^LONGBITS in Zahlen zur Basis 10.	*/
	div(zahl,TEN,quot,rest);
	/* rest wird in den Ausgabestring kopiert; mit quot wird weitergerechnet.	*/
	z_aus = aus;
	if (*rest) /* rest != 0 .	*/
		*z_aus++ = *(rest + 1);
	else
		*z_aus++ = 0L;
	while (*quot) { /* quot != 0 .	*/
		if (++aus_stellen == AUSGABE_LAENGE)
			overflow("write_nur_zahl : zahl zu gross!");
		div(quot,TEN,quot,rest);
		if (*rest)
			*z_aus++ = *(rest + 1);
		else
			*z_aus++ = 0L;
	}

	/* Nun wird die Ausgabe ausgefuehrt.	*/
	z_aus = aus + (int) aus_stellen;
	do 
		printf("%01u",*z_aus);
	while (--z_aus >= aus);
}

writeue(text,zahl)
char  text[];
LONG  zahl[];
/* Eingabeparameter : text, zahl;						*/
/* Ausgabeparameter : Keine;							*/
/* Wirkung :          text wird nach stdout ausgegeben;				*/
/*                    zahl wird in Dezimalschreibweise nach stdout ausgegeben;	*/
/*                    ein Zeilenvorschub wird nach stdout ausgegeben;			*/
/* Returncode :       Keiner.							*/
{
	printf(text);
	write_nur_zahl(zahl);
	printf("\n");
	fflush(stdout);
}
/**/
writeuefile(ausgabefile,text,zahl)
FILE  *ausgabefile;
char  text[];
LONG  zahl[];
/* Eingabeparameter : ausgabefile, text, zahl;						*/
/* Ausgabeparameter : Keine;								*/
/* Wirkung :          text wird nach ausgabefile ausgegeben;				*/
/*                    zahl wird in Dezimalschreibweise nach ausgabefile ausgegeben;	*/
/*                    ein Zeilenvorschub wird nach ausgabefile ausgegeben;		*/
/* Returncode :       Keiner.								*/
{
	LONG  quot[LAENGE], rest[LAENGE], aus[AUSGABE_LAENGE];
	LONG  *z_aus;
	LONG  aus_stellen = 0L;

	fprintf(ausgabefile,text);
	if (!*zahl) { /* Zahl == 0 .	*/
         	fprintf(ausgabefile,"0\n");
		fflush(ausgabefile);
		return;
	}

	/* Umwandlung von Zahlen zur Basis 2^LONGBITS in Zahlen zur Basis 10.	*/
	div(zahl,TEN,quot,rest);
	/* rest wird in den Ausgabestring kopiert; mit quot wird weitergerechnet.	*/
	z_aus = aus;
	if (*rest) /* rest != 0 .	*/
		*z_aus++ = *(rest + 1);
	else
		*z_aus++ = 0L;
	while (*quot) { /* quot != 0 .	*/
		aus_stellen++;
		if (aus_stellen == AUSGABE_LAENGE)
			overflow("writeuefile : zahl zu gross!");
		div(quot,TEN,quot,rest);
		if (*rest)
			*z_aus++ = *(rest + 1);
		else
			*z_aus++ = 0L;
	}

	/* Nun wird die Ausgabe ausgefuehrt.	*/
	z_aus = aus + (int) aus_stellen;
	do 
		fprintf(ausgabefile,"%01u",*z_aus);
	while (--z_aus >= aus);
	fprintf(ausgabefile,"\n");
	fflush(ausgabefile);
}

writex(text,zahl)
char  text[];
LONG  zahl[];
/* Eingabeparameter : text, zahl;							*/
/* Ausgabeparameter : Keine;								*/
/* Wirkung :          text wird nach stdout ausgegeben;					*/
/*                    zahl wird in Hexadezimalschreibweise nach stdout ausgegeben;	*/
/* Returncode :       Keiner.								*/
{
	LONG stellen, i;

	printf(text);
	if (!*zahl) { /* Zahl = 0 .	*/
		printf("0\n");
		fflush(stdout);
		return;
	}
	stellen = *zahl;
	zahl += (int) stellen;
	printf("%08lx ",*zahl--);
	for (i = 1L; i < stellen; i++) 
		printf("%08lx ",*zahl--);
	printf("\n");
}
/**/
write_long(ausgabefile,zahl)
FILE  *ausgabefile;
LONG  zahl[];
/* Eingabeparameter : ausgabefile, zahl;								*/
/* Ausgabeparameter : Keine;										*/
/* Wirkung :          zahl wird in darstellungsabhaengiger Schreibweise nach ausgabefile ausgegeben;	*/
/* Returncode :       Keiner.										*/
{
	LONG stellen, i;

	stellen = *zahl++;
	fprintf(ausgabefile,"%08lx",stellen);
	for (i = 1L; i <= stellen; i++) 
		fprintf(ausgabefile,"%08lx",*zahl++);
	fprintf(ausgabefile,"\n");
}

overflow(text)
char  text[];
{
	printf("Fehler in Prozedur ");
	printf(text);
	printf("\n");
	exit(2);
}

#ifdef STAT
STATISTIK()
{
	printf("\nS T A T I S T I K\n\n");
	printf("%10lu Additionen\n",ANZ_ADD);        
	printf("%10lu Subtraktionen\n",ANZ_SUB);
	printf("%10lu Multiplikationen\n",ANZ_MULT);
	printf("%10lu Quadrierungen\n",ANZ_QUAD);
	printf("%10lu Shift-Operationen\n",ANZ_SHIFT);
	printf("%10lu Divisionen\n",ANZ_DIV);
	printf("%10lu Vergleiche\n",ANZ_COMP);
	printf("%10lu Kopieen\n",ANZ_TRANS);
}
#endif
/**/
/* GGT-Routinen */

mggt_2(zuinv,modul,ggt,inv)
LONG *zuinv;
LONG modul[LAENGE];
LONG ggt[LAENGE];
LONG *inv;
{
	LONG produkt[LAENGE], prod_inv[LAENGE];
	/* Berechne das Produkt der zu invertierenden Elemente */
	mmult(zuinv,zuinv+LAENGE,produkt,modul);
	/* invertiere das Produkt */
	GGT(produkt,modul,ggt,prod_inv);
	/* multipliziere zurueck, um die einzelnen Inversen zu bekommen (falls ggt != 1) */
	if (EQUAL1(ggt)) { /* ggt == 1 */
		mmult(prod_inv,zuinv,inv+LAENGE,modul);
		mmult(prod_inv,zuinv+LAENGE,inv,modul);
	}
}

mggt_4(zuinv,modul,ggt,inv)
LONG *zuinv;
LONG modul[LAENGE];
LONG ggt[LAENGE];
LONG *inv;
{
	LONG produkt[3][LAENGE], prod_inv[3][LAENGE];
	mmult(zuinv,zuinv+LAENGE,produkt[0],modul);
	zuinv += (LAENGE << 1);
	mmult(zuinv,zuinv+LAENGE,produkt[1],modul);
	mmult(produkt[0],produkt[1],produkt[2],modul);
	GGT(produkt[2],modul,ggt,prod_inv[2]);
	if (EQUAL1(ggt)) { /* ggt == 1 */
		mmult(produkt[0],prod_inv[2],prod_inv[1],modul);
		mmult(produkt[1],prod_inv[2],prod_inv[0],modul);
		inv += (LAENGE << 1);
		mmult(prod_inv[1],zuinv,inv+LAENGE,modul);
		mmult(prod_inv[1],zuinv+LAENGE,inv,modul);
		inv -= (LAENGE << 1);
		zuinv -= (LAENGE << 1);
		mmult(prod_inv[0],zuinv,inv+LAENGE,modul);
		mmult(prod_inv[0],zuinv+LAENGE,inv,modul);
	}
}
/**/
mggt_8(zuinv,modul,ggt,inv)
LONG *zuinv;
LONG modul[LAENGE];
LONG ggt[LAENGE];
LONG *inv;
{
	LONG produkt[7][LAENGE], prod_inv[7][LAENGE];
	mmult(zuinv,zuinv+LAENGE,produkt[0],modul);
	zuinv += (LAENGE << 1);
	mmult(zuinv,zuinv+LAENGE,produkt[1],modul);
	zuinv += (LAENGE << 1);
	mmult(zuinv,zuinv+LAENGE,produkt[2],modul);
	zuinv += (LAENGE << 1);
	mmult(zuinv,zuinv+LAENGE,produkt[3],modul);
	
	mmult(produkt[0],produkt[1],produkt[4],modul);
	mmult(produkt[2],produkt[3],produkt[5],modul);

	mmult(produkt[4],produkt[5],produkt[6],modul);
	
	GGT(produkt[6],modul,ggt,prod_inv[6]);
	
	if (EQUAL1(ggt)) { /* ggt == 1 */
		mmult(produkt[4],prod_inv[6],prod_inv[5],modul);
		mmult(produkt[5],prod_inv[6],prod_inv[4],modul);

		mmult(produkt[0],prod_inv[4],prod_inv[1],modul);
		mmult(produkt[1],prod_inv[4],prod_inv[0],modul);
		mmult(produkt[2],prod_inv[5],prod_inv[3],modul);
		mmult(produkt[3],prod_inv[5],prod_inv[2],modul);

		inv += (LAENGE << 2);
		inv += (LAENGE << 1);
		mmult(prod_inv[3],zuinv,inv+LAENGE,modul);
		mmult(prod_inv[3],zuinv+LAENGE,inv,modul);

		inv -= (LAENGE << 1);
		zuinv -= (LAENGE << 1);
		mmult(prod_inv[2],zuinv,inv+LAENGE,modul);
		mmult(prod_inv[2],zuinv+LAENGE,inv,modul);

		inv -= (LAENGE << 1);
		zuinv -= (LAENGE << 1);
		mmult(prod_inv[1],zuinv,inv+LAENGE,modul);
		mmult(prod_inv[1],zuinv+LAENGE,inv,modul);
		
		inv -= (LAENGE << 1);
		zuinv -= (LAENGE << 1);
		mmult(prod_inv[0],zuinv,inv+LAENGE,modul);
		mmult(prod_inv[0],zuinv+LAENGE,inv,modul);
	}
}
/**/
mnurggt_2(zuinv,modul,ggt)
LONG *zuinv;
LONG modul[LAENGE];
LONG ggt[LAENGE];
{
	LONG produkt[LAENGE];
	/* Berechne das Produkt der zu invertierenden Elemente */
	mmult(zuinv,zuinv+LAENGE,produkt,modul);
	/* invertiere das Produkt */
	compute_ggt(produkt,modul,ggt);
}

mnurggt_4(zuinv,modul,ggt)
LONG *zuinv;
LONG modul[LAENGE];
LONG ggt[LAENGE];
{
	LONG produkt[3][LAENGE];
	mmult(zuinv,zuinv+LAENGE,produkt[0],modul);
	zuinv += (LAENGE << 1);
	mmult(zuinv,zuinv+LAENGE,produkt[1],modul);
	mmult(produkt[0],produkt[1],produkt[2],modul);
	compute_ggt(produkt[2],modul,ggt);
}

mnurggt_8(zuinv,modul,ggt)
LONG *zuinv;
LONG modul[LAENGE];
LONG ggt[LAENGE];
{
	LONG produkt[7][LAENGE];
	mmult(zuinv,zuinv+LAENGE,produkt[0],modul);
	zuinv += (LAENGE << 1);
	mmult(zuinv,zuinv+LAENGE,produkt[1],modul);
	zuinv += (LAENGE << 1);
	mmult(zuinv,zuinv+LAENGE,produkt[2],modul);
	zuinv += (LAENGE << 1);
	mmult(zuinv,zuinv+LAENGE,produkt[3],modul);
	
	mmult(produkt[0],produkt[1],produkt[4],modul);
	mmult(produkt[2],produkt[3],produkt[5],modul);

	mmult(produkt[4],produkt[5],produkt[6],modul);
	
	compute_ggt(produkt[6],modul,ggt);
}

/*
(*mggt_funktion[9])() = {NULL,GGT,mggt_2,NULL,mggt_4,NULL,NULL,NULL,mggt_8};
(*mnurggt_funktion[9])() = {NULL,compute_ggt,mnurggt_2,NULL,mnurggt_4,NULL,NULL,NULL,mnurggt_8};
*/
