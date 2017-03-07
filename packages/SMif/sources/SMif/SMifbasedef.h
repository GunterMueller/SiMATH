/*******************************************************************/
/*      SMifbasedef.h : Definition der Datenstrukturen             */
/*                      SMif_chartable und SMif_wordtable          */
/*      Funktionsdefinition  : SMifbasedef.c                       */
/*******************************************************************/

#ifndef _SMifbasedef_h
#define _SMifbasedef_h

#include <stdio.h>
  
/*  Datenstrukturen  */
struct SMif_charlistitem {
   char SMifchar;
   struct SMif_charlistitem * next;  
}; 

struct SMif_wordlistitem {
   char * SMifword;
   struct SMif_wordlistitem * next;
};

typedef struct SMif_charlistitem * SMif_chartable;
typedef struct SMif_wordlistitem * SMif_wordtable;

/* Funktiondeklarationen fuer die Bearbeitung obenstehender
   Datenstrukturen */
   
/* chartable */
int  isinchartable (char,SMif_chartable);  
void addchar      (char,SMif_chartable*);
void delchar      (char,SMif_chartable*);
void delchartable (SMif_chartable*);
SMif_chartable copychartable (SMif_chartable);

/* wordtable */
int  isinwordtable (char*,SMif_wordtable);
void addword      (char*,SMif_wordtable*);
void delword      (char*,SMif_wordtable*);
void delwordtable (SMif_wordtable*);
int  wordcount (SMif_wordtable);
SMif_wordtable copywordtable (SMif_wordtable);


/* Interger in Word */
struct SMif_intinfoitem {
   int pos;
   int length;
   struct SMif_intinfoitem * next;
};

struct SMif_intinwordinfo {
   int count;
   struct SMif_intinfoitem * intinfo;
};

void SMif_findintinword (char*, struct SMif_intinwordinfo *);

#define NEGATIV 1
#define POSITIV 2

struct SMif_polinfoitem {
   int from;
   int to;
   int negorpos;
   int locmaxlevel;
   struct SMif_polinfoitem * next;
};

struct SMif_polstruct {
   int maxlevel;
   struct SMif_polinfoitem * polinfo;
};

void  SMif_getpolstruct (char*, struct SMif_polstruct*);
#endif
