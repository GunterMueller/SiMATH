/******************************************************************/
/*                  SMifpowerstring.h                             */
/*   Deklaration der erweiterten Stringbearbeitungsfunktionen.    */
/*      1: Trim Funktionen bzgl. einer Igno-Tabelle               */
/*      2. Word Funktionen bzgl. einer Igno-Tabelle               */
/*      3. Substr Funktionen                                      */
/*      4. Stringtransformation: clearwaste                       */
/*   C Code: SMifpowerstring.c                                    */
/******************************************************************/
 
#ifndef _SMifpowerstring_h_
#define _SMifpowerstring_h_ 

#include <string.h>
#include "SMifbasedef.h" 

typedef SMif_chartable SMif_ignotable;
#define isignoredc(ch,table) isinchartable(ch,table)

/* ltrim, rtrim, alltrim :: cut off the irgored chars. */
extern int SMif_ltrim (char*, SMif_ignotable);
extern int SMif_rtrim (char*, SMif_ignotable);
extern int SMif_alltrim (char*, SMif_ignotable);

/* word in string */
extern int   SMif_wordcount (const char*, SMif_ignotable);
extern int   SMif_wordpos (const char*, const char*, SMif_ignotable, int);
extern char* SMif_substrwords (const char*, SMif_ignotable, int, int);
extern char* SMif_getword (const char*, int, SMif_ignotable); 

#define SMif_fwordpos(string, tofind, table)  \
		SMif_wordpos(string, tofind, table, 1)
#define SMif_rightwords(string, table, pos) \
		SMif_substrwords(string, table, pos, 0)

/* substr */
extern int   SMif_occour (const char*, const char*);
extern int   SMif_at (const char*, const char*, int);
extern char* SMif_substr (const char*, int, int);
extern char* SMif_strtran(const char*, const char*, const char*);

/* delete waste */
extern char* SMif_clearignoredc (char*, SMif_ignotable, char);
extern int   SMif_lwastecount (char*, SMif_ignotable);
#define SMif_clearwaste(string, table) SMif_clearignoredc(string,table,' ')

#define SMif_fat(string, tofind) SMif_at(string,tofind,1)
#define SMif_rightstr(string, pos) SMif_substr(string,pos,0)   
#endif
