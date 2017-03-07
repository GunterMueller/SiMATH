/************************************************************/
/*  SMif.h  : Difinition der SMif workspace Datenstruktur   */
/*  C File  : SMif.c                                        */
/************************************************************/

#ifndef _SMif_h
#define _SMif_h

/* Include files */
#include <tcl.h>
#include <ctype.h>
#include "SMifbasedef.h"
#include "SMifpowerstring.h"

#define MAXLINESIZE 200

#ifndef SEEK_SET
#define SEEK_SET 0 
#endif
  
/* LineBuffer & FileBuffer: Buffer der zu bearbeitenden ASCII-Datei */

typedef struct {
   int length;
   int curpos;
   char * line;
} LineBuffer;

typedef struct {
   int        eof;
   int        linecount;
   int        curline;
   LineBuffer *lines;
} FileBuffer;

/* SMif_table : benutzt von LINESKIP REPEAT IGNORE STOPGET */
/* ---> SMifbasedef.h  */

typedef struct {
   SMif_chartable chartable;
   SMif_wordtable wordtable;
} SMif_table;

/* ItemInfo: benutzt von SETITEM */      
typedef struct {
   int itemsize;
   char *pattern;
} ItemInfo;

#define MODIFYTABLE_ADD 0
#define MODIFYTABLE_DEL 1

#define UNDEFINED      0
#define SMif_GETSINGLE   1
#define SMif_GETLIST   2
#define SMif_GETPOL    3
#define SMif_GETINT    4

#define LINENEXT  1
#define ITEMNEXT  2

#define NOERROR    0
#define TYPEERR    1
#define SUBTYPEERR 2
#define SKIPERR    3
#define ITEMERR    4

#define DIGITONLY  1
#define ALLCHAR    2

typedef struct {
   int type;
   int subtype;
   int err;
   int count;
   int getcount;
} GetInfo;

struct NPNLTrackItem {
   int   seeeof;
   int   line;   /* 0: current line, 1: next line ... */
   int   curlen; /* current length */
   char* word;
   struct NPNLTrackItem * next;
   struct NPNLTrackItem * last;
};

typedef struct NPNLTrackItem * NPNLTrack;

/* Umgebungsinformation , interpretiert als STACK */
/* level 0: Default Umgebung . Fuer jeden aktiven GET Befehl wird
   eine eigene Umgebung definiert, fuer die Initialisierung werden
   dieselbe Werte aus Vaterumgebung uebernommen. Beim Beenden eines
   GET Befehls wird die zugehoerige Umgebung wieder aus der oberen
   Zelle des Stacks entfernt.  */
   
struct EnvInfoItem {
   int  envlevel;
   SMif_table ignotable;           /* IGNORE  */
   SMif_table stoptable;           /* STOPGET */
   SMif_table npnltable;           /* NOPOWER NEWLINE */
   SMif_table repeattable;         /* REPEAT  */
   GetInfo    getinfo;             /* Get ... FOR NEXT */
   ItemInfo   iteminfo;            /* SETITEM */
   struct EnvInfoItem *next;       /* stack */
};
typedef struct EnvInfoItem * EnvInfo;

typedef struct {
   Tcl_Interp   *interp;     /* Tcl-Interpreter */
   EnvInfo      envinfo;     /* Umgebungsstack  */
   FileBuffer   fbuffer;     /* Eingabedatei Puffer */  
   Tcl_DString  result;      /* result (Dynamic String) */ 
} SMifinfo;


/* function declaration */

int SMif_Init (SMifinfo *, char*);
void DeleteAll      (SMifinfo*);
static char* GetNextWord (FileBuffer*, SMif_table*, int*);
static char* GetNextWord_NPNL (FileBuffer*, SMif_table*, 
							   SMif_table*, NPNLTrack*, int*);
static void  SetNewFbptr (FileBuffer*, NPNLTrack, int);		
static int   GetItemWord (SMifinfo*,  int*, int);				
static int   MakeSMPol (const char*, Tcl_DString *);	   
static void  InitEnvinfo (EnvInfo , EnvInfo);
static int   ModifySMif_table (char*, SMif_table*, int);
static int   IsValidPattern (const char*, int, Tcl_Interp*);
static int   IsNPNLString   (char*, SMif_table*);
static int   IsObjInTab (char*, int*, SMif_table*, int);
static int   SKIPCmd (ClientData, Tcl_Interp*, int, char**);
static int   IFCmd   (ClientData, Tcl_Interp*, int, char**);
static int   SWITCHCmd (ClientData,Tcl_Interp*,int, char**);
static int   GETCmd      (ClientData, Tcl_Interp*, int, char**);
static int   REPEATCmd   (ClientData, Tcl_Interp*, int, char**);
static int   IGNORECmd   (ClientData, Tcl_Interp*, int, char**);
static int   SETITEMCmd  (ClientData, Tcl_Interp*, int, char**);
static int   NOPOWERCmd  (ClientData, Tcl_Interp*, int, char**);
static int   STOPGETCmd  (ClientData, Tcl_Interp*, int, char**);

#endif

