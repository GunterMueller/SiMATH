/* #include <stdio.h> */
/* entfernt, weil stdio.h im SIMATH-System sowieso eingebunden wird */

#define LONG      unsigned long
#define LONGINT   long
#define SHORT     unsigned short
#define PRIM_TYPE unsigned short

#define LONGBITS  32L
#define SHORTBITS 16L

#define LAENGE         500L
#define VLAENGE        (LAENGE + 1)
#define RAT_LAENGE     (LAENGE + VLAENGE)

#define EINGABE_LAENGE (11L * LAENGE)
#define AUSGABE_LAENGE (11L * LAENGE)
#define STRING_ENDE    0
#define RETURN         10

#define MS_DOS      0
#define PC_TYPE     0

#define DREIVIERTEL 1
#define MONTMMULT   1
#define MONTMEXP    1
#define GGTSHIFT    1
#define ANZAHL_PRIM               6542 
#define ANZAHL_PRIM_POT           6634 
#define ANZAHL_DATEI_PRIM_POT     34
#define ANZAHL_TEILERFREMD_ZU_210 48

#define MULT_GGT(p1,p2,p3,p4,p5) mggt_funktion[p5](p1,p2,p3,p4) 
#define MULT_NUR_GGT(p1,p2,p3,p4) mnurggt_funktion[p4](p1,p2,p3) 

#define EQUAL0(ZAHL)\
(!(*(ZAHL)))

#define NOTEQUAL0(ZAHL)\
(*(ZAHL))

#define EQUAL1(ZAHL)\
( (*(ZAHL) == 1L) && (*((ZAHL) + 1) == 1L) )

#define NOTEQUAL1(ZAHL)\
( (*(ZAHL) != 1L) || (*((ZAHL) + 1) != 1L) )
